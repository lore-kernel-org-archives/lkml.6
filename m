Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175FEC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5DD82086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JGYnQQQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5DD82086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbeLKSwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:52:08 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:53793 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbeLKSwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 13:52:08 -0500
Received: by mail-it1-f194.google.com with SMTP id g85so5191158ita.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 10:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u1BmhFV3jFYCpG9ky256q4G6ZKdW4+xMfLqBXcaHRnw=;
        b=JGYnQQQGazlSIGRZIyID6hDBIoQeXJBgvPhrBnJXAQ3ZslGXRS8va2j3GmK9NL7QOC
         GAnlT3QmoYZMI1AouEOi2fCx3hBDX2CHzuq3uFC1ieiQLMO3YtzeDX8uZod32uCFwpIM
         jbbQ5pPbPcq07yOEFHxxXQ5dmRhsrbNauLoOTq3nf7c/BA45HAP2L5vzT5f/KrN9goNi
         4Efhly3eY68GcI5zsLOt61p2Nf9FzRHExmEMyFhp/kOeNDXewFyRdlM6xNAbJm1qg2lu
         MycEy/+VIuoe/PWu0mX+tI79f6bWiZRAyucBq9unHN65Z4uBzIuKT42D/V/pGBUmklv8
         2wuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u1BmhFV3jFYCpG9ky256q4G6ZKdW4+xMfLqBXcaHRnw=;
        b=EFL868DNRbj1KxNvNQtfRZEvIkVUFfaZShAgjtnRmjKAY6YXAbzx5BThlGo5xX6m+j
         3gaQ5fdrYBJGFSoo5IyGP45LQocJ4OLTUcy3jQfo2j1F6N8bzVlGev8uSBh3++EE5KgS
         Xv9jLUG4Aygq4tAT3Y6LjcwTGsTFQMOMRzAcfNXVs2kAKLkncNXCRIws/7rZU5iP0yWR
         Ekz7ndwYmhcKaAl7BYQ9C5vtyQT4EhwXI79DGHSKFFkupBbToWQCEGdJyKZkszLWdXgY
         ZBtdpEtK4tyyk+Sfrk0sEkQ9jNGkST0zn3gzgp7vo4NiJpV5yNZGJ4mM9GGK3QGAXW6/
         bsZw==
X-Gm-Message-State: AA+aEWYtKRh5G/gBYLS7SvoEVuBF2YQ50tUVkrAlxkhwtXM56Xog67WP
        iAmFagaWyeDoUS5zUbgYchornA==
X-Google-Smtp-Source: AFSGD/WRCYDqGTQUr5BBbhu6Z7zWltEd0lMQnUtyKMVM58oijQE0n5w8zGHNu4ZI9alamJLlbK3Z0w==
X-Received: by 2002:a24:a3c7:: with SMTP id p190mr1995834ite.39.1544554327286;
        Tue, 11 Dec 2018 10:52:07 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m45sm1503376iti.10.2018.12.11.10.52.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 10:52:06 -0800 (PST)
Subject: Re: [PATCH] aio: Convert ioctx_table to XArray
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jeff Moyer <jmoyer@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kent.overstreet@gmail.com
References: <20181128183531.5139-1-willy@infradead.org>
 <x49va46e1p0.fsf@segfault.boston.devel.redhat.com>
 <x49pnuee1gm.fsf@segfault.boston.devel.redhat.com>
 <x49mupcm11r.fsf@segfault.boston.devel.redhat.com>
 <20181211175156.GF6830@bombadil.infradead.org>
 <x495zw0lz68.fsf@segfault.boston.devel.redhat.com>
 <0f77a532-0d88-78bc-b9cc-06bb203a0405@kernel.dk>
 <6b9a45c4-47a2-4c44-aa7e-6e5e90eff9df@kernel.dk>
 <20181211185105.GI6830@bombadil.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d45b92ea-ee57-0228-a23f-419b5b72ed59@kernel.dk>
Date:   Tue, 11 Dec 2018 11:52:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181211185105.GI6830@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/18 11:51 AM, Matthew Wilcox wrote:
> On Tue, Dec 11, 2018 at 11:32:54AM -0700, Jens Axboe wrote:
>> Don't see any regressions. But if we're fiddling with it anyway, can't
>> we do something smarter? Make the fast path just index a table, and put
>> all the big hammers in setup/destroy. We're spending a non-substantial
>> amount of time doing lookups, that's really no different before and
>> after the patch.
> 
> Thanks for checking it out.
> 
> I think the fast path does just index a table.  Until you have more than
> 64 pointers in the XArray, it's just xa->head->slots[i].  And then up
> to 4096 pointers, it's xa->head->slots[i >> 6]->slots[i].  It has the
> advantage that if you only have one kioctx (which is surely many programs
> using AIO), it's just xa->head, so even better than a table lookup.
> 
> It'll start to deteriorate after 4096 kioctxs, with one extra indirection
> for every 6 bits, but by that point, we'd've been straining the memory
> allocator to allocate a large table anyway.

I agree, and nobody cares about 4k kioctxs, you're way into the weeds
at that point anyway.

So as the followup said, I think we're fine as-is for this particular
case.

-- 
Jens Axboe

