Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B31C43142
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 01:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9176620894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 01:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxmo9Rpz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9176620894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732963AbeHADUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 23:20:15 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41813 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732855AbeHADUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 23:20:15 -0400
Received: by mail-pl0-f67.google.com with SMTP id w8-v6so7969607ply.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 18:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=hjP4cZ4lFUElEFcorr5fEhhlbyPyB38GZF2k/Y+v/ko=;
        b=dxmo9RpzgLvGCIp+m61FCzbd+AqN/knm7HeQtsmCF9YdG77+uxx+6gg6/QpAl5NPxr
         662hCCJAqfwCOPswBLFtAoB9ApnH76F7NpRGDYSeOlWNyTrkPh6qnP4Cu/dHpCna7cYj
         VOuhet2mIgYEycmi9UIueKz7kB6/bdY8drVY4VKqVvBTwp3Apajrz9SsYKYCTALwzMDt
         qOL+VrXlqU/8ELL843NeCwWrd7VsekZPgTt/sl46oxfG1fx5YuNQH9g5NUUMyoflTe4Z
         cHBbTJTeTH6u0QdPhhx6bIyCDJ+7BynJYQeg3bKMT8/DkNQafq5NTjFfK3Arv0x+NxJq
         +Ctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hjP4cZ4lFUElEFcorr5fEhhlbyPyB38GZF2k/Y+v/ko=;
        b=KLIGnH4PCD9A5ngEY9IlbCltDl25c0qbZNCO+PYFlZ57KdeBo7WWXuKMAetgfA/YxA
         N7fX63IP+QoLLxZjMzW+Y/aoyATAe9ozBRJftgEKt2dqbd1bP7xp4zQZFKEPEgacfevh
         5Hsvsy95GFwmn4y1TtoHxVEbWMQMaLJN08z78yXDUaGcK3yt6WvR8Vjua6y7x7fPYe3J
         MwKLBQmsNZ8JazmNC0W+h779CT6VMqsEZ2JOXLYU8lQfJKkcHrXfDz9WbmZnGDKY+hUe
         XFKW8IJb7g130/Zx8kgmnkoHYKC3dvf7+V6vqpFD1k1qdSdup1LaRo1MZdDYDQwuqJid
         LP0Q==
X-Gm-Message-State: AOUpUlEGnkI7nuO/Luabfr4LZ2Um/lOJxAFN8/aEr8jplm4xFV17OT6v
        iO8P2hMgIoqxzaAJctDcsC4=
X-Google-Smtp-Source: AAOMgpcnaUNiUkpFHOxd951It49lI+f/ipu7ft8w+Q0g1xpDJsdu/KWszt/yCtkh1ejNGwDjCwLYYQ==
X-Received: by 2002:a17:902:76c7:: with SMTP id j7-v6mr17752732plt.275.1533087431545;
        Tue, 31 Jul 2018 18:37:11 -0700 (PDT)
Received: from [10.61.2.228] ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id y20-v6sm3069036pgv.31.2018.07.31.18.37.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 18:37:10 -0700 (PDT)
Subject: Re: Infinite looping observed in __offline_pages
To:     John Allen <jallen@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     mhocko@suse.cz, n-horiguchi@ah.jp.nec.com,
        kamezawa.hiroyu@jp.fujitsu.com, mgorman@suse.de
References: <20180725181115.hmlyd3tmnu3mn3sf@p50.austin.ibm.com>
From:   Rashmica <rashmica.g@gmail.com>
Message-ID: <b79a4cc4-34d4-a9ca-4d17-367be7d7cc1d@gmail.com>
Date:   Wed, 1 Aug 2018 11:37:05 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180725181115.hmlyd3tmnu3mn3sf@p50.austin.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/07/18 04:11, John Allen wrote:
> Hi All,
>
> Under heavy stress and constant memory hot add/remove, I have observed
> the following loop to occasionally loop infinitely:
>
> mm/memory_hotplug.c:__offline_pages
>
> repeat:
>        /* start memory hot removal */
>        ret = -EINTR;
>        if (signal_pending(current))
>                goto failed_removal;
>
>        cond_resched();
>        lru_add_drain_all();
>        drain_all_pages(zone);
>
>        pfn = scan_movable_pages(start_pfn, end_pfn);
>        if (pfn) { /* We have movable pages */
>                ret = do_migrate_range(pfn, end_pfn);
>                goto repeat;
>        }
>

What is CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE set to for you?

I have also observed this when hot removing and adding memory. However I
only have only seen this when my kernel has
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=n (when it is set to online
automatically I do not have this issue) so I assumed that I wasn't
onlining the memory properly...

> What appears to be happening in this case is that do_migrate_range
> returns a failure code which is being ignored. The failure is stemming
> from migrate_pages returning "1" which I'm guessing is the result of
> us hitting the following case:
>
> mm/migrate.c: migrate_pages
>
>     default:
>         /*
>          * Permanent failure (-EBUSY, -ENOSYS, etc.):
>          * unlike -EAGAIN case, the failed page is
>          * removed from migration page list and not
>          * retried in the next outer loop.
>          */
>         nr_failed++;
>         break;
>     }
>
> Does a failure in do_migrate_range indicate that the range is
> unmigratable and the loop in __offline_pages should terminate and goto
> failed_removal? Or should we allow a certain number of retrys before we
> give up on migrating the range?
>
> This issue was observed on a ppc64le lpar on a 4.18-rc6 kernel.
>
> -John
>

