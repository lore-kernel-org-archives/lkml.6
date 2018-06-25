Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EAAC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 01:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6E9253B3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 01:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFBJ2viu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6E9253B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752539AbeFYBrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 21:47:15 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40463 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752292AbeFYBrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 21:47:14 -0400
Received: by mail-pf0-f193.google.com with SMTP id z24-v6so5682039pfe.7;
        Sun, 24 Jun 2018 18:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3uli2r0xUx/EB/KoMZuesay78n7DU10rCbRa9I9HZ/k=;
        b=WFBJ2viuu+yYB6XWSethO9lPmY2kL8WLVK/vMP1tUvUak0AmNWtOoVorma3H5QLfJx
         4QjYroOJu7Mdc/CjC1Qhb+O9G89u7w3z1k29F+R1AQ4LDNvFQWePh72UrExRMGqyd42V
         nJsEXJfA/nD2Mj3eVsbKxlehDmjSOzXnyiT04ig7tYmx4gF0co9s5XBDOZBw/Fx4mxQu
         VVjc7zDsBkpowZF413TsPZJhtfmVhUtKA5i5fMsnLRB90LLD40vwySRw4xmoIm93Su0r
         7rR5NhQVFA9fU2sZR2ujz+xK/ULMGm/kpUp+etHuUAHPkzQxMRxFV9PBSmxXDLoVWkrY
         301A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3uli2r0xUx/EB/KoMZuesay78n7DU10rCbRa9I9HZ/k=;
        b=Rcr6w4cn7fMmV8/6e282HoG9gs4Ls+yNYa0SNcz9vWUZr7YGd2+DGyyu8pv9H62XGx
         89PjMBB/BcRSqJwUNZOIY3JLjMkckFqDv0cwtls/JIisv0qAN9Vpzb0SH9ZoxtXLjnWP
         tGwU1kwuCGrUHGB4KOPCrua0ZB1nIeRor3NgMmoI+mxf4vZRdTrz5xgpqhKYQNuBdasm
         wYltsy/uYctowotuw/19wweyQ8nDcNYYvmAE8jyVsQQwHHDTtjn5+h1FPihjNsTe3oTc
         GPEAOGR7tzoDuI1OPzdyoYUVbnPYqtBSsT+bbv9z1zc8e8s3Lo5UmDWJSzJaPvEfu4o6
         NKww==
X-Gm-Message-State: APt69E2XeAoGoIvSSx9nxHKS9tb7snW5wN5q1235+87jH4mCZNn7WqNr
        M+P3j+Fx8gC1UdojwytMb8A=
X-Google-Smtp-Source: ADUXVKLTah3G5CTMZaSOEhrogFlreIS4sq0HDmWrEjnfS9+Ks2YIYOzSNtIu6Ex8B7VALmRNXSNJNQ==
X-Received: by 2002:a62:4282:: with SMTP id h2-v6mr10949308pfd.242.1529891233596;
        Sun, 24 Jun 2018 18:47:13 -0700 (PDT)
Received: from localhost ([39.7.19.250])
        by smtp.gmail.com with ESMTPSA id e24-v6sm19285871pfi.70.2018.06.24.18.47.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Jun 2018 18:47:12 -0700 (PDT)
Date:   Mon, 25 Jun 2018 10:47:09 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-mm@kvack.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/zsmalloc: make several functions and a struct static
Message-ID: <20180625014709.GC557@jagdpanzerIV>
References: <20180624213322.13776-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180624213322.13776-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/24/18 22:33), Colin King wrote:
> The functions zs_page_isolate, zs_page_migrate, zs_page_putback,
> lock_zspage, trylock_zspage and structure zsmalloc_aops are local to
> source and do not need to be in global scope, so make them static.
> 
> Cleans up sparse warnings:
> symbol 'zs_page_isolate' was not declared. Should it be static?
> symbol 'zs_page_migrate' was not declared. Should it be static?
> symbol 'zs_page_putback' was not declared. Should it be static?
> symbol 'zsmalloc_aops' was not declared. Should it be static?
> symbol 'lock_zspage' was not declared. Should it be static?
> symbol 'trylock_zspage' was not declared. Should it be static?
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
