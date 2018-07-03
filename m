Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FB9C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3BF24346
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrQbiXct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B3BF24346
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753663AbeGCBzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 21:55:39 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41163 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752771AbeGCBzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 21:55:38 -0400
Received: by mail-pl0-f68.google.com with SMTP id w8-v6so195750ply.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 18:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=UdTqGxUorRG6RjeT7eMF3thgzx/46dO66eUVOcxuF7M=;
        b=WrQbiXct5JjGiQRmaXfTMgMIcFXfdtf0oajdry8RdJXrcrZsxKzp0/WzbiSbvJui96
         CjVg1+cnXNNt8ieO0mnwk68+TIzVwILFylknOYDRfu4AaWA+bgfXh2TiyqtyqM5Id7u2
         V/NLIXFg1b1sb/Ocf3BXeVeuWW0JIxQQahoGGG4zAaJNZf6xgg/lPNq5behcLi6DJKjO
         AOpo4Ax7kQ4P+/A5iZKjuRg1tf2Kajh5jXvAEjmI893fZeCwG0/DB8ANqHKuK/FyYgyQ
         d35iAZbkqRiXWnBfYEwdFwTFcjHDa0SbQSrCzSlBoVdnBEG2i9Tzo48qY22Gynhc1tEx
         Nvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=UdTqGxUorRG6RjeT7eMF3thgzx/46dO66eUVOcxuF7M=;
        b=XvVIx6uwhQRLHUExoEXIPlVe0X4OFTZ1GiPu9n6jkfAjJhoZFvh3ZonBq9qV23qP3o
         IJMIU+ru+krfOAI15FaOEAJdQpJ7dxfZzNAczZPZPKJbkBqsx4R/DW2hpxsDWrl7+b7n
         LlX5WRbe6ccAJb9W8EkZNDnn25h2jgAyHyCiQov8X6uTDJPSwzpW6BiPHere6gwM6IVb
         QA5kMKzYjx0+Fi5fKifdNAJhYudcpNNGbKNbKarbJVqGFGoppDjbZlz5sjVn8lIhHVhb
         1XnGV7n83zPzNvR61GYqlZQraT1O84CFPK40MdlWtUc4tHXJCNMc3NTcfIrKxt2EQM3G
         ajvA==
X-Gm-Message-State: APt69E1pgzY5TephR/fTB2cO5wCdWyuz2Dq8GDJzRP+bJjlAh7W6nQHe
        Wc68EUVDUvPCjBZ+qQyRWaw=
X-Google-Smtp-Source: AAOMgpf/KuGxrs2TdQgTow6z7+V0nijJNQwcBInYaCUH7Yngh0vQzxqr6E950cQiC4+fpLqhN+nkFg==
X-Received: by 2002:a17:902:1e6:: with SMTP id b93-v6mr15745895plb.149.1530582938061;
        Mon, 02 Jul 2018 18:55:38 -0700 (PDT)
Received: from [0.0.0.0] (65.49.234.56.16clouds.com. [65.49.234.56])
        by smtp.gmail.com with ESMTPSA id d9-v6sm71253pge.68.2018.07.02.18.55.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 18:55:37 -0700 (PDT)
Subject: Re: [PATCH v9 2/6] mm: page_alloc: remain memblock_next_valid_pfn()
 on arm/arm64
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     linux@armlinux.org.uk, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mel Gorman <mgorman@suse.de>, will.deacon@arm.com,
        mark.rutland@arm.com, hpa@zytor.com,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Steven Sistare <steven.sistare@oracle.com>, neelx@redhat.com,
        erosca@de.adit-jv.com, Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        james.morse@arm.com, ard.biesheuvel@linaro.org,
        steve.capper@arm.com, tglx@linutronix.de, mingo@redhat.com,
        gregkh@linuxfoundation.org, kstewart@linuxfoundation.org,
        pombredanne@nexb.com, Johannes Weiner <hannes@cmpxchg.org>,
        kemi.wang@intel.com, ptesarik@suse.com, yasu.isimatu@gmail.com,
        aryabinin@virtuozzo.com, nborisov@suse.com,
        Wei Yang <richard.weiyang@gmail.com>, jia.he@hxt-semitech.com
References: <1530239363-2356-1-git-send-email-hejianet@gmail.com>
 <1530239363-2356-3-git-send-email-hejianet@gmail.com>
 <CAGM2reYn3ZbdjhcZze8Zt1eLNSdWghy0KwEXfd5xW+1Ba_SMbw@mail.gmail.com>
From:   Jia He <hejianet@gmail.com>
Message-ID: <bfe24a3b-c982-9532-c05b-f42ebb77bbba@gmail.com>
Date:   Tue, 3 Jul 2018 09:55:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAGM2reYn3ZbdjhcZze8Zt1eLNSdWghy0KwEXfd5xW+1Ba_SMbw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Pavel
Thanks for the comments.

On 6/30/2018 2:13 AM, Pavel Tatashin Wrote:
>> +++ b/include/linux/early_pfn.h
>> @@ -0,0 +1,34 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (C) 2018 HXT-semitech Corp. */
>> +#ifndef __EARLY_PFN_H
>> +#define __EARLY_PFN_H
>> +#ifdef CONFIG_HAVE_MEMBLOCK_PFN_VALID
>> +ulong __init_memblock memblock_next_valid_pfn(ulong pfn)
>> +{
>> +       struct memblock_type *type = &memblock.memory;
> 
> Why put it in a header file and not in some C file? In my opinion it
> is confusing to have non-line functions in header files. Basically,
> you can include this header file in exactly one C file without
> breaking compilation.
> 
My original intent is to make this helper memblock_next_valid_pfn
a common api between arm64 and arm arches since both arches will
use enable CONFIG_HAVE_MEMBLOCK_PFN_VALID by default.

Do you think it looks ok if I add the inline prefix?

-- 
Cheers,
Jia
