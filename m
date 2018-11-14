Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C18C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 19:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FEB422419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 19:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="dvTaKoGN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FEB422419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbeKOFZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 00:25:02 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39928 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725756AbeKOFZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 00:25:01 -0500
Received: by mail-qk1-f193.google.com with SMTP id q70so10331070qkh.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 11:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VpccehreRbynPyYoQXkUkdRG5p13Pp2tvO16OLu/t7g=;
        b=dvTaKoGNbMfWeJYvLx15uF2frs3KaXl/c8YD2AmhgMDlgbVPTGxkZLEEq+ENiqLx+y
         X2xtQK6xfrxknVPtGABAQtMjUxwW6Gl0dYhaK495hyGKSROHmJiPrCR5O7DfrES2mB/U
         bGNygcfj644i6+Lt0khbFwOUI558uohHK6G6ybJ4vJOuPEyiq268zhhn8pktvK6+FFE1
         pGjEUVYP+7j9dUTArJVpxuJZ/9aCiVS1LdnV251GZRMP75lQ7LHauHthx1W2upx8ROOU
         RUuxPl0RhRIo+1lLAhrVDa/+t21JuVUufhWQNVrgUe7XTucPUgyfGd7X9io4CYCRuYhv
         GT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VpccehreRbynPyYoQXkUkdRG5p13Pp2tvO16OLu/t7g=;
        b=PK1UKyydO+NVJArLapv71Rb3VodTHcKFQ4JctubRvv6flLVZMR6rLZJET4b8xOApjb
         jH7O/H6Y3bvlboIhoDalLQi/AUqggeqUqAOPxtSoklCJH1ILK2l4x30tfCHueE/1YKqI
         +7/n2iz5ddQFq3ma2PZnfYvT+YQW2Vvs5JOK1W1GzC3Y4NjIJBeRig6VrruYdPau1liJ
         +ijrDJx1I4QQcyLX/Sbe7+4B5PAxsT8q0xV5FGkFt6QiXuZOKMGMnA/jqEhFjr/si6pa
         hVSfDX24MkWZXQ7/jJGnOITEQ4koMZ+b/8jqb999ijmBj0KZpiCxJ39kBhpe6Y4UoknC
         kvYA==
X-Gm-Message-State: AGRZ1gKNt6u+OOjXc5OxSKGrcYewRckARiXnbhv+z/tDshBTPzxMsDox
        RvtKURdIAehuM3Uq8elymrdYcQ==
X-Google-Smtp-Source: AJdET5cZJyCREbnbdmZTCuLmLUjhtMLJACFmtpwYVeGzBT48nP+I88AnKZC4FoRuTusyoyuYYZaGYQ==
X-Received: by 2002:a37:1fc8:: with SMTP id n69mr3086958qkh.175.1542223233167;
        Wed, 14 Nov 2018 11:20:33 -0800 (PST)
Received: from soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net ([40.117.208.181])
        by smtp.gmail.com with ESMTPSA id l13sm15678718qkh.45.2018.11.14.11.20.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 11:20:32 -0800 (PST)
Date:   Wed, 14 Nov 2018 19:20:30 +0000
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     Arun KS <arunks@codeaurora.org>
Cc:     keescook@chromium.org, khlebnikov@yandex-team.ru,
        minchan@kernel.org, getarunks@gmail.com,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        mhocko@kernel.org, vbabka@suse.cz, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vatsa@codeaurora.org, willy@infradead.org
Subject: Re: [PATCH v5 1/4] mm: reference totalram_pages and managed_pages
 once per function
Message-ID: <20181114192030.2iz3vrlppob73uio@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
References: <1542090790-21750-1-git-send-email-arunks@codeaurora.org>
 <1542090790-21750-2-git-send-email-arunks@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542090790-21750-2-git-send-email-arunks@codeaurora.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-11-13 12:03:07, Arun KS wrote:
> This patch is in preparation to a later patch which converts totalram_pages
> and zone->managed_pages to atomic variables. Please note that re-reading
> the value might lead to a different value and as such it could lead to
> unexpected behavior. There are no known bugs as a result of the current code
> but it is better to prevent from them in principle.
> 
> Signed-off-by: Arun KS <arunks@codeaurora.org>
> Reviewed-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
