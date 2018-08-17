Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F178DC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 05:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B64D21528
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 05:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2AWEpCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B64D21528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbeHQIkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 04:40:37 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43478 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeHQIkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 04:40:37 -0400
Received: by mail-pg1-f196.google.com with SMTP id v66-v6so1758218pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 22:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=leLGEr0CtGQxVw1Yv3Mt01wkg0+wqjQoHTQD6EoC7oQ=;
        b=D2AWEpCHpWbXbbddiaGxj2S/PsUsZwJyp7XxxEFMNRmOJvBxEkaY2Wyl0rFKo2NxlV
         5Jg9lQwE90qvq48TtA5feR/bi8B6/K+NBEfMBJQFV0tR+7AK/XGtsO0r9hoeNAkA+o4G
         XJH/DllDbDWmkuN/yPKAqeNfH0rctk+2m2iK1OOzREBUM0i2SzysYVtZx9S5wf4wM5no
         iLWMuyxSQjfs4kCEM1D4hmniCMWdMi/7NmgzV92e6HvU1nqjagjZ/lkdmRW3/zCr8vcF
         DrBtvzlMDRn+lqFQViBQBpTQfsWox4hA2sxvBwdwh6omYcKmxfxhAPPuk48mh5qgT9N9
         xxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=leLGEr0CtGQxVw1Yv3Mt01wkg0+wqjQoHTQD6EoC7oQ=;
        b=jgVcBEa959j0Y31ZJ2HagQIjq9N36PNlmrpbOmcMhrhXnvy66AaWlEeKKTk7JBzALr
         1lQb7EMAGQOzuLyPGDy/a1JxGc+w7KYKSaD/vWH38MSEt7X7wtob7Nnb67BUDH3FIUZv
         dl7Cp0JLZz1kh2vxSeyLQ+BEkhVSWYV71y3wmspPhkODk9oZv2jO0IinOcf+n0YUEtv3
         0DNpWVvOo+VvZFab3k2zYh+xZBWUmxu+y13c9shCboBFiI6CLLopHB7Sb05h5nQidEDC
         IINt1l+twtxgrbyuYljZWHmcSN8QppYG6bXe2hNrpP43ye2VTyi4YQP6Q+hPnXqR+Ren
         2EFg==
X-Gm-Message-State: AOUpUlFHok8mDs4HDGIZoedhrLT7W8n3brkGpDWsAQkL3bRg9kIkZcHu
        Ljn6DaeJOGcunYrOsoqPlwA=
X-Google-Smtp-Source: AA+uWPwrKFYil4ittiFQ6LlO7dBfnXBS7k3xl+/CpOXkwEXxygtRPZNpExglgePyGWw/Im6EnfDc0w==
X-Received: by 2002:a62:4fd9:: with SMTP id f86-v6mr34918146pfj.110.1534484317720;
        Thu, 16 Aug 2018 22:38:37 -0700 (PDT)
Received: from [0.0.0.0] (96.45.178.72.16clouds.com. [96.45.178.72])
        by smtp.gmail.com with ESMTPSA id 203-v6sm991319pgb.14.2018.08.16.22.38.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 22:38:36 -0700 (PDT)
Subject: Re: [RESEND PATCH v10 6/6] mm: page_alloc: reduce unnecessary binary
 search in early_pfn_valid()
To:     Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Philip Derrin <philip@cog.systems>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kemi Wang <kemi.wang@intel.com>,
        Petr Tesarik <ptesarik@suse.com>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Daniel Vacek <neelx@redhat.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jia He <jia.he@hxt-semitech.com>
References: <1530867675-9018-1-git-send-email-hejianet@gmail.com>
 <1530867675-9018-7-git-send-email-hejianet@gmail.com>
 <c6ed43ee-b09e-1f75-43b3-6cd2808d13f3@microsoft.com>
From:   Jia He <hejianet@gmail.com>
Message-ID: <f69a37b8-3e19-e12b-a51b-2cb62a326bcc@gmail.com>
Date:   Fri, 17 Aug 2018 13:38:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c6ed43ee-b09e-1f75-43b3-6cd2808d13f3@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pasha
Thanks for the comments

On 8/17/2018 9:35 AM, Pasha Tatashin Wrote:
> 
> 
> On 7/6/18 5:01 AM, Jia He wrote:
>> Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
>> where possible") optimized the loop in memmap_init_zone(). But there is
>> still some room for improvement. E.g. in early_pfn_valid(), if pfn and
>> pfn+1 are in the same memblock region, we can record the last returned
>> memblock region index and check whether pfn++ is still in the same
>> region.
>>
>> Currently it only improve the performance on arm/arm64 and will have no
>> impact on other arches.
>>
>> For the performance improvement, after this set, I can see the time
>> overhead of memmap_init() is reduced from 27956us to 13537us in my
>> armv8a server(QDF2400 with 96G memory, pagesize 64k).
> 
> This series would be a lot simpler if patches 4, 5, and 6 were dropped.
> The extra complexity does not make sense to save 0.0001s/T during not.
> 
> Patches 1-3, look OK, but without patches 4-5 __init_memblock should be
> made local static as I suggested earlier.
> 
> So, I think Jia should re-spin this series with only 3 patches. Or,
> Andrew could remove the from linux-next before merge.
> 
I will respin it with #1-#3 patch if no more comments

Cheers,
Jia
> Thank you,
> Pavel
> 
