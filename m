Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98936C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ADF724EC4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S1jMDZTm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ADF724EC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755128AbeF2SIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:08:51 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33714 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753997AbeF2SIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:08:50 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5TI8Me1111646
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 18:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=gCB9/Qh7bO4dkmDLlkYrlVttKVyi8ep2z3JNqNMq31g=;
 b=S1jMDZTm1ZGfncMVq4VArf9AcQjs46NsEiaMtjhMD4JQ6lNvwgRnsof50gVXzOIZkBwh
 JR1vLa0k/xyE8qo5B9SqqWk7v5ERHdsmOA63Asm12uDqtIy0y2j19frf+sBNS40cFKIf
 BUx/Tv90b+XksL2VN7v22Ejk+Yz19s090/JYK5xkqu2fIW3cPlFzTp8QMfIUvN5u/I6x
 I7ZIDSjNhir3pvn9Z4wlG496nVSGO3iZv5+PJQk4tPtLfLpzzsDmmHY2cdHXU90dz7xD
 sUFdFxADiMAl1PeaEHyaDUt03pL4nZie+14d2rD2bxy2+mi0UexUutavclB5ppwEk60C Eg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2jukmu7kcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 18:08:49 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5TI8iB4006567
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 18:08:44 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5TI8i7r015804
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 18:08:44 GMT
Received: from mail-oi0-f52.google.com (/209.85.218.52)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Jun 2018 11:08:44 -0700
Received: by mail-oi0-f52.google.com with SMTP id c2-v6so9245360oic.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 11:08:44 -0700 (PDT)
X-Gm-Message-State: APt69E0dDcodSDCXLURjaUpkrOIeCRq2WwHzfgmYpZbK6gSzbJrX3g3g
        BCXKCRd2kX2idzaFXruPUk3/C7W7XLiKsTGg60M=
X-Google-Smtp-Source: AAOMgpdKtok5oBtunSLZ90tEpW4lG67MYCUiqQnkp8OiXh00zEKCN0kQgG+I0DE+0qxlEUoxrF3ayDPzI3O6cD5PFJo=
X-Received: by 2002:aca:db0a:: with SMTP id s10-v6mr9392926oig.339.1530295723576;
 Fri, 29 Jun 2018 11:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <1530239363-2356-1-git-send-email-hejianet@gmail.com> <1530239363-2356-2-git-send-email-hejianet@gmail.com>
In-Reply-To: <1530239363-2356-2-git-send-email-hejianet@gmail.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Fri, 29 Jun 2018 14:08:07 -0400
X-Gmail-Original-Message-ID: <CAGM2reZ74Re6-CnAoNqK_VG+AOzs7u4cOUaJ4iMy25Q8P_aXEQ@mail.gmail.com>
Message-ID: <CAGM2reZ74Re6-CnAoNqK_VG+AOzs7u4cOUaJ4iMy25Q8P_aXEQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/6] arm: arm64: introduce CONFIG_HAVE_MEMBLOCK_PFN_VALID
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
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806290193
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 10:30 PM Jia He <hejianet@gmail.com> wrote:
>
> Make CONFIG_HAVE_MEMBLOCK_PFN_VALID a new config option so it can move
> memblock_next_valid_pfn to generic code file. All the latter optimizations
> are based on this config.
>
> The memblock initialization time on arm/arm64 can benefit from this.
>
> Signed-off-by: Jia He <jia.he@hxt-semitech.com>

Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
On Thu, Jun 28, 2018 at 10:30 PM Jia He <hejianet@gmail.com> wrote:
>
> Make CONFIG_HAVE_MEMBLOCK_PFN_VALID a new config option so it can move
> memblock_next_valid_pfn to generic code file. All the latter optimizations
> are based on this config.
>
> The memblock initialization time on arm/arm64 can benefit from this.
>
> Signed-off-by: Jia He <jia.he@hxt-semitech.com>
> ---
>  arch/arm/Kconfig   | 4 ++++
>  arch/arm64/Kconfig | 4 ++++
>  mm/Kconfig         | 3 +++
>  3 files changed, 11 insertions(+)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 843edfd..7ea2636 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1642,6 +1642,10 @@ config ARCH_SELECT_MEMORY_MODEL
>  config HAVE_ARCH_PFN_VALID
>         def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
>
> +config HAVE_MEMBLOCK_PFN_VALID
> +       def_bool y
> +       depends on HAVE_ARCH_PFN_VALID
> +
>  config HAVE_GENERIC_GUP
>         def_bool y
>         depends on ARM_LPAE
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 42c090c..26d75f4 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -778,6 +778,10 @@ config ARCH_SELECT_MEMORY_MODEL
>  config HAVE_ARCH_PFN_VALID
>         def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
>
> +config HAVE_MEMBLOCK_PFN_VALID
> +       def_bool y
> +       depends on HAVE_ARCH_PFN_VALID
> +
>  config HW_PERF_EVENTS
>         def_bool y
>         depends on ARM_PMU
> diff --git a/mm/Kconfig b/mm/Kconfig
> index ce95491..2c38080a5 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -137,6 +137,9 @@ config HAVE_MEMBLOCK_NODE_MAP
>  config HAVE_MEMBLOCK_PHYS_MAP
>         bool
>
> +config HAVE_MEMBLOCK_PFN_VALID
> +       bool
> +
>  config HAVE_GENERIC_GUP
>         bool
>
> --
> 1.8.3.1
>
