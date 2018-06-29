Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC622C6778B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70ED827899
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r4GONVjx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70ED827899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935830AbeF2RHp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 13:07:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43660 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932446AbeF2RHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 13:07:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5TH40xv030249
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 17:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=pItollnNKjkcDrxUTog7rPhfMiAZpLz8QKlQzUTDN1Q=;
 b=r4GONVjxyLFmMfq6GUUeP5lQlzE03Y/gJzuCdwzrBaHycJph90TP1VfzRzoZ8Kinrf1H
 wdIFGxq0MKv8bL6+duBAzQx6p+FpSij2SmNm4QHfQykTBhiDIAc75NbxnENGzIXu09u+
 wtg1duuMrf5Za+rBJHvEWJ1ZlRUj4yCsI+I+ZP8lCBYzRLmXGJZIQjULbnXdr8jZQTy8
 UIvjujdYIIZGPE0Vz942X1uVTGZ1EFR7xoDOStrrRFEfJdk3LJZCJqRPDLUaMW6wjhvM
 IuzZ7/nayskMwVr2QL7tDI12H8BKeSQF9yBu9/HC2YYtdaw11VbUUsFc2iKUZkwb4XHi qQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2jum587979-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 17:07:43 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5TH7dWv019551
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 17:07:39 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5TH7dV9018494
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 17:07:39 GMT
Received: from mail-ot0-f169.google.com (/74.125.82.169)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Jun 2018 10:07:38 -0700
Received: by mail-ot0-f169.google.com with SMTP id i17-v6so10673653otl.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 10:07:38 -0700 (PDT)
X-Gm-Message-State: APt69E1uE562BXHLB3kExDcrgoiGeP83clzn443i8HhthmCapnPQnQmY
        ClIiZZhhn+RlcykUooBY0J+DR64VvtEAOeH7uuM=
X-Google-Smtp-Source: AAOMgpcivEWOnNNnONtDnKe7MHlZGegF6WwGURKEpSiwIqgQYIEfOkWznO7gdUTRoa0og3aU1RXr3SaOsfa8kEQ5qPY=
X-Received: by 2002:a9d:2e0e:: with SMTP id q14-v6mr6986688otb.275.1530292058245;
 Fri, 29 Jun 2018 10:07:38 -0700 (PDT)
MIME-Version: 1.0
References: <1530239363-2356-1-git-send-email-hejianet@gmail.com> <1530239363-2356-3-git-send-email-hejianet@gmail.com>
In-Reply-To: <1530239363-2356-3-git-send-email-hejianet@gmail.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Fri, 29 Jun 2018 13:07:02 -0400
X-Gmail-Original-Message-ID: <CAGM2reZ3zYdrYBEGTdy+LLm_HPREyqYeUqqQnU1GCPd3k98z3Q@mail.gmail.com>
Message-ID: <CAGM2reZ3zYdrYBEGTdy+LLm_HPREyqYeUqqQnU1GCPd3k98z3Q@mail.gmail.com>
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
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=944
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806290182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 10:30 PM Jia He <hejianet@gmail.com> wrote:
>
> Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
> where possible") optimized the loop in memmap_init_zone(). But it causes
> possible panic bug. So Daniel Vacek reverted it later.
>
> But as suggested by Daniel Vacek, it is fine to using memblock to skip
> gaps and finding next valid frame with CONFIG_HAVE_ARCH_PFN_VALID.
>
> On arm and arm64, memblock is used by default. But generic version of
> pfn_valid() is based on mem sections and memblock_next_valid_pfn() does
> not always return the next valid one but skips more resulting in some
> valid frames to be skipped (as if they were invalid). And that's why
> kernel was eventually crashing on some !arm machines.

Hi Jia,

Is this a bug? Should we make other arches that support memblock to
use memblock_is_map_memory() ? it is more expensive, but if the
default is broken, maybe it makes sense to change?

Thank you,
Pavel
