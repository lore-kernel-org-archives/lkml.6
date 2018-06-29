Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D32EC6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE3EB24D68
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b2WtA+n9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE3EB24D68
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965680AbeF2SNu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:13:50 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57750 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753527AbeF2SNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:13:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5TIDk1g122325
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 18:13:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=4XXgRCRrgzdcKmkaYb1mGuJl2YegIbEI5i/G1KFvf94=;
 b=b2WtA+n9n/uXSNtKUyGJMy6MfKB8JUCXT9nyKJuMW2aGKWSlrESBiOf4lR/p00l3r0K6
 3MXumNJX/IHtkjCCYRSMxN5reP3UY4imJZfFTwAC1HaFD0OrHzAEKFyvKcFEL7Q7xkgM
 R4QevChbK2M1MmQ6Inyp48YH5ipRPWDrj00Fh1GRXG2yqFjcu2I6iq1Tb4w2Y+KRlEh0
 Q3u7HnPc14ZAZFNCoLSou3eiyMAsX61zCstgvatVgONbBIy0HsNshkaGLd3frI6JUOi/
 VcvYb6IvEx7WFv7cJsaejk8S55odKfUODzcp0n/dTrQs5ML+SEYprgjOtpXn7o1/c1+r wA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2jukhsqmw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 18:13:46 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5TIDjVw009238
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 18:13:45 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5TIDjwQ012526
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 18:13:45 GMT
Received: from mail-ot0-f172.google.com (/74.125.82.172)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Jun 2018 11:13:45 -0700
Received: by mail-ot0-f172.google.com with SMTP id c15-v6so10865673otl.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 11:13:44 -0700 (PDT)
X-Gm-Message-State: APt69E1wtLPsweS8Ig4Bor25WVc9Wcm0ohAYy0mFgQeJOisgQwB7Tj3p
        FpY6mcwMY223Lv64A2UjF2ksMJMkKtlOI9yac1g=
X-Google-Smtp-Source: AAOMgpcrXQ+sq7Ck7CAR3+8inToLgQqjrmoVzHjVuYdKn4f6DbZmaTBAGQE7XwKkSj9KLY9ViMXLq4emGBrmW2Ecfxs=
X-Received: by 2002:a9d:72c6:: with SMTP id d6-v6mr8613278otk.345.1530296024516;
 Fri, 29 Jun 2018 11:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <1530239363-2356-1-git-send-email-hejianet@gmail.com> <1530239363-2356-3-git-send-email-hejianet@gmail.com>
In-Reply-To: <1530239363-2356-3-git-send-email-hejianet@gmail.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Fri, 29 Jun 2018 14:13:08 -0400
X-Gmail-Original-Message-ID: <CAGM2reYn3ZbdjhcZze8Zt1eLNSdWghy0KwEXfd5xW+1Ba_SMbw@mail.gmail.com>
Message-ID: <CAGM2reYn3ZbdjhcZze8Zt1eLNSdWghy0KwEXfd5xW+1Ba_SMbw@mail.gmail.com>
Subject: Re: [PATCH v9 2/6] mm: page_alloc: remain memblock_next_valid_pfn()
 on arm/arm64
To:     hejianet@gmail.com
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
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8939 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=480
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806290194
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +++ b/include/linux/early_pfn.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2018 HXT-semitech Corp. */
> +#ifndef __EARLY_PFN_H
> +#define __EARLY_PFN_H
> +#ifdef CONFIG_HAVE_MEMBLOCK_PFN_VALID
> +ulong __init_memblock memblock_next_valid_pfn(ulong pfn)
> +{
> +       struct memblock_type *type = &memblock.memory;

Why put it in a header file and not in some C file? In my opinion it
is confusing to have non-line functions in header files. Basically,
you can include this header file in exactly one C file without
breaking compilation.
