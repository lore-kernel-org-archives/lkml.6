Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F53C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 19:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E100C22360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 19:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="GRQZYCa9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E100C22360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbeKOF03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 00:26:29 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43302 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725756AbeKOF03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 00:26:29 -0500
Received: by mail-qk1-f195.google.com with SMTP id r71so27819032qkr.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 11:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TwXLRXW1McRoBW58WPePaegdLlE/EQnLmr9bDSfz/kk=;
        b=GRQZYCa9Tj7Lhpuu7fte6kI4upKHOGdLBRXlAmqgeLEZ5LfPfdKvnhJq96u3YFy5MJ
         8QPKUEuIsYBw2+F3vNLpmgV9rVih82vSnQvjrJvdSCbnDUoutoOBBsQa0SQ8ZdJnXIxG
         WD7M1Cx0KXYJ5wm31ttAaWRjKi+qwfCuettspcPhKN40Rsc8FHGYomceUxzI/ZazTYiK
         5pM1i5i4quItrZoMPAkBMKsNqJxaqjQLgN6wwGxMTjJzSBXccZf4g+OPdO8yBXpV/CXf
         dQoJDYu3r5oGde/3BpY2lBYF9vlOWaSJ6xu8jluSF64/zbKFd2NAP8RBtHw/WuGkU5TG
         mhwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TwXLRXW1McRoBW58WPePaegdLlE/EQnLmr9bDSfz/kk=;
        b=MtGVo6lU3usnGOOrF+NA9K36Z3H2GGlJf8vIJsf5d3o52YXNdHZtXNbSfhYFUy+k81
         anFN/IITZeAWoDpNTDtYuusuaqJhEnBuW+U2TauPzAp+/qL5E4+kkXRYvlwkPnZS4YjG
         8bXG2szIU73mF9HcF7Gc6UrwGK4Lc4T5rxqvBzvlkGMAfC+aZWzq/uJLggdi+Cm9h9WV
         LAfobLtw9lslLwTWyPfuGTrCgKrA/WdLsj8cJtT54/xoZs1UNKSPBaxDKiKzel97V9TM
         meH4/06IeFcpiwBEsmMObEFO8Dz9dSrsZfpczr13Uz+fuonEvZX8aT5uXTGcip0yNMC1
         Kw2g==
X-Gm-Message-State: AGRZ1gK3e6eT1euukmbSq4YnMXFxoX1Bu0TcpJ4Q2t+vWw2ajd9eZfMr
        wVXX5Xu43Hd++UxSjoCKrQeBOQ==
X-Google-Smtp-Source: AJdET5c+O4T14ZcDrhEDT0nhZcoPD8zKePu38ZuiPBlBoAiCKGmobaOSzm6hE+KqXLSWOJBL6AdkoA==
X-Received: by 2002:a37:a24b:: with SMTP id l72mr3100590qke.302.1542223319236;
        Wed, 14 Nov 2018 11:21:59 -0800 (PST)
Received: from soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net ([40.117.208.181])
        by smtp.gmail.com with ESMTPSA id z8sm16730462qth.34.2018.11.14.11.21.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 11:21:57 -0800 (PST)
Date:   Wed, 14 Nov 2018 19:21:54 +0000
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     Arun KS <arunks@codeaurora.org>
Cc:     keescook@chromium.org, khlebnikov@yandex-team.ru,
        minchan@kernel.org, getarunks@gmail.com,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        mhocko@kernel.org, vbabka@suse.cz, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vatsa@codeaurora.org, willy@infradead.org
Subject: Re: [PATCH v5 2/4] mm: convert zone->managed_pages to atomic variable
Message-ID: <20181114192154.cf2kz5pqcokpzpyt@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
References: <1542090790-21750-1-git-send-email-arunks@codeaurora.org>
 <1542090790-21750-3-git-send-email-arunks@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542090790-21750-3-git-send-email-arunks@codeaurora.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-11-13 12:03:08, Arun KS wrote:
> totalram_pages, zone->managed_pages and totalhigh_pages updates
> are protected by managed_page_count_lock, but readers never care
> about it. Convert these variables to atomic to avoid readers
> potentially seeing a store tear.
> 
> This patch converts zone->managed_pages. Subsequent patches will
> convert totalram_panges, totalhigh_pages and eventually
> managed_page_count_lock will be removed.
> 
> Main motivation was that managed_page_count_lock handling was
> complicating things. It was discussed in length here,
> https://lore.kernel.org/patchwork/patch/995739/#1181785
> So it seemes better to remove the lock and convert variables
> to atomic, with preventing poteintial store-to-read tearing as
> a bonus.
> 
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Arun KS <arunks@codeaurora.org>
> Reviewed-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
