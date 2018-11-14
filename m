Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4EBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 19:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED952245E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 19:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ng+nwCBk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED952245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbeKOF1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 00:27:43 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43616 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725757AbeKOF1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 00:27:43 -0500
Received: by mail-qk1-f195.google.com with SMTP id r71so27826094qkr.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 11:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LFYYdKHWHi+EPe9Uk5KC5mUVO42vTydqmfnvlknZ67o=;
        b=ng+nwCBk/nQpv0TIg6fmdPSpwhWi9QHRDnyGByhowxwQ9gcFPWKbHJuMxQrP6JlWpP
         0JMS9BDAIqnpQWcyLj2uFVBJOVadgW6Qe7Ery2jS95OnRAP/jpjifp4KsxM5RDARSYKD
         cuekHLCkkeLnMQlADdO67hrqqe/2bqDPNMnNw5kyMGbEoOD0LdH8qdQ1KztfMjvNRQiq
         WTbgGMYHClMR0/7JwcF7DPub9CE4of3jfQSeONlfmXqiqPMDMbD+nXTrafu/Fmz7R5ND
         gJU0pN3CwqXlhU//z09Wree83z2FNuOOsEZMELnFP7Xtzn000ONF4tUMJxpMfTVBMdly
         +Viw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LFYYdKHWHi+EPe9Uk5KC5mUVO42vTydqmfnvlknZ67o=;
        b=mvOfUwoZcTW/stC26Bdt37Qy2anLA/u5/qPggab7DdWo2OZBIeKXUgPrNDJR5PRJW0
         LrHsltJgmd2ePeRMy1/u6+uXA4pc1ZbSJCc2jCEaj5eOuuMUpwnr5dkNQ7AvY/aW2mpS
         cYNXuw9g9gTJ0IVRyr9HEyMPleUg+kBdR+qocB/onXIwbyRIJyLZMgxnBiemu1CGjDLk
         Rqs5trAG2J/azpOJkBbhWCUAl6Ix03GYv2F5Snix0br2T6PlZMFJ3jpBYx1uqOjtD+lq
         otB2jVVnKqNtYSefE48chcy86/RZfY/I1zgyYVmLL6DXVZFN6QaB0fFKFVHDATKAKV8e
         u39g==
X-Gm-Message-State: AGRZ1gI7w8JYUMP6Hg6pZrgKawF4Rzql7L4xv+Hv9RDe0SQ1alFUwq3+
        Y7ekCT22MuZmufAULmzx6IKC2w==
X-Google-Smtp-Source: AJdET5d7/drzUMqxOH2haWu9JxUSj4t+1CiNjbQ7G2DkKL4vOzKBJOX7RTi/X8MkZgqNO7RNoRF5/A==
X-Received: by 2002:a0c:985d:: with SMTP id e29mr3219245qvd.16.1542223393957;
        Wed, 14 Nov 2018 11:23:13 -0800 (PST)
Received: from soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net ([40.117.208.181])
        by smtp.gmail.com with ESMTPSA id z23sm7069081qkg.50.2018.11.14.11.23.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 11:23:12 -0800 (PST)
Date:   Wed, 14 Nov 2018 19:23:10 +0000
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     Arun KS <arunks@codeaurora.org>
Cc:     keescook@chromium.org, khlebnikov@yandex-team.ru,
        minchan@kernel.org, getarunks@gmail.com,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        mhocko@kernel.org, vbabka@suse.cz, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vatsa@codeaurora.org, willy@infradead.org
Subject: Re: [PATCH v5 3/4] mm: convert totalram_pages and totalhigh_pages
 variables to atomic
Message-ID: <20181114192310.mleekpniomfrbibf@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
References: <1542090790-21750-1-git-send-email-arunks@codeaurora.org>
 <1542090790-21750-4-git-send-email-arunks@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542090790-21750-4-git-send-email-arunks@codeaurora.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-11-13 12:03:09, Arun KS wrote:
> totalram_pages and totalhigh_pages are made static inline function.
> 
> Main motivation was that managed_page_count_lock handling was
> complicating things. It was discussed in lenght here,
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
