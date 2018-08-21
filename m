Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D4EC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCEC2172C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y113vv7i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DCEC2172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbeHUJdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:33:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44009 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbeHUJdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:33:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id j26-v6so7972374pfi.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 23:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=unQ+pnnxANGHld+IlR5H9wWUpJ24FvE5ObGs1mxr09k=;
        b=Y113vv7ilmGejea2cODmbZ2YTdwbskS3nuguyiMUXWNELZGMsTvjAa/L37Z/FX0gSO
         5Ynr0Ca2W63YKhSaTG0c7EvI8kQgZNkb/aJIJfyIgDH/crlTpX6Lh9NR9KYhoJQ1dC3Q
         3jG8PdQiAs9lXNrtRVPjaKE9vHcjOo1dOvm5ftOr04PSUhUyZF1hZ7dQCmYRRy6kfblM
         ur1FiONnnz+68pgd0NVtuQlHRM5aQ6EllpP/Bl5uZWq7/2aC2r4M5pJ1CVEw/BOxlYlt
         JkBGcinw/bMD03HZwB8xQyNcSXYulh1UmS8o7RfOYj4pDfE18QBjpAagVWs2/r+mRjRY
         1PlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=unQ+pnnxANGHld+IlR5H9wWUpJ24FvE5ObGs1mxr09k=;
        b=EkkNcwbzQoPDeWuzwJTWFAJ+TFyFeKVcsTkjqFuf+NQIRwbjEIEWuI3TnovEXEKFTk
         gRtA/9OSryYylW0ljsLFzvPrmDLS8AO1Zfmnn/Ww6gGrfAo5Wuujt6raCmOpVmIi4IBx
         /kI3D/vn+dvtR1+09j4eHbUaoYQIJyTKO4mlTF5Ett/axwzQgez9vTJv2ob8DNzfZMV9
         O1Kvo7ImbAfs+KYrR0JRUdPipt1e1gowYx4AIhdkGu0+Mg+5nzD+pxo5cyy0aThnJjo1
         7WUj9HlwMzEsWBU4I8fyQIzRVEgP6LCoq0qFWPuC42i8nKHl/jj5jkUEwRA5U3ABJt81
         OTUA==
X-Gm-Message-State: AOUpUlF8cc9WNIx8fKBkaDdpFhqY2RmhtvXb9vBIEWQ0grhO4E++L4ON
        rKO7azt0Z3nM2WZoph3xbDA=
X-Google-Smtp-Source: AA+uWPy7CQHTN7aX0k2kbmNR0mwO2M02YHWnCNX0udVDQ54W+LEhyuyFqgr/X5dbhJg1Vxw+h1OqqQ==
X-Received: by 2002:a63:6343:: with SMTP id x64-v6mr15872460pgb.173.1534832093593;
        Mon, 20 Aug 2018 23:14:53 -0700 (PDT)
Received: from [0.0.0.0] (96.45.178.72.16clouds.com. [96.45.178.72])
        by smtp.gmail.com with ESMTPSA id x24-v6sm15261745pfh.67.2018.08.20.23.14.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 23:14:52 -0700 (PDT)
Subject: Re: [RESEND PATCH v10 3/6] mm: page_alloc: reduce unnecessary binary
 search in memblock_next_valid_pfn()
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
 <1530867675-9018-4-git-send-email-hejianet@gmail.com>
 <61ca29b9-a985-cce0-03e9-d216791c802c@microsoft.com>
From:   Jia He <hejianet@gmail.com>
Message-ID: <334337ca-811e-4a2e-09ff-65ebe37ef6df@gmail.com>
Date:   Tue, 21 Aug 2018 14:14:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <61ca29b9-a985-cce0-03e9-d216791c802c@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pasha

On 8/17/2018 9:08 AM, Pasha Tatashin Wrote:
> 
>> Signed-off-by: Jia He <jia.he@hxt-semitech.com>
>> ---
>>  mm/memblock.c | 37 +++++++++++++++++++++++++++++--------
>>  1 file changed, 29 insertions(+), 8 deletions(-)
>>
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index ccad225..84f7fa7 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -1140,31 +1140,52 @@ int __init_memblock memblock_set_node(phys_addr_t base, phys_addr_t size,
>>  #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
>>  
>>  #ifdef CONFIG_HAVE_MEMBLOCK_PFN_VALID
>> +static int early_region_idx __init_memblock = -1;
> 
> One comment:
> 
> This should be __initdata, but even better bring it inside the function
> as local static variable.
> 
Seems it should be __initdata_memblock instead of __initdata?

-- 
Cheers,
Jia
>>  ulong __init_memblock memblock_next_valid_pfn(ulong pfn)
>>  {
> 
> Otherwise looks good:
> 
> Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
> 
