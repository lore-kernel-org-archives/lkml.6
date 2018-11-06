Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722DBC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449772086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:07:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449772086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388640AbeKFXcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 18:32:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48746 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387928AbeKFXcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 18:32:32 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA6E5OoC089900
        for <linux-kernel@vger.kernel.org>; Tue, 6 Nov 2018 09:07:07 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nkbud9w05-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 09:07:04 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 6 Nov 2018 14:06:55 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 6 Nov 2018 14:06:47 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA6E6kvk66519186
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Nov 2018 14:06:47 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9C4D5205A;
        Tue,  6 Nov 2018 14:06:46 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.205.42])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 6900B5205F;
        Tue,  6 Nov 2018 14:06:44 +0000 (GMT)
Date:   Tue, 6 Nov 2018 16:06:42 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stefan Agner <stefan@agner.ch>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Greg Hackmann <ghackmann@android.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        CHANDAN VN <chandan.vn@samsung.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>, linux@armlinux.org.uk,
        green.hu@gmail.com, deanbo422@gmail.com, gxt@pku.edu.cn,
        ard.biesheuvel@linaro.org, linux-snps-arc@lists.infradead.org,
        vgupta@synopsys.com
Subject: Re: [PATCH v4 0/6] arm64: Get rid of __early_init_dt_declare_initrd()
References: <20181105225431.24485-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105225431.24485-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18110614-0012-0000-0000-000002C476B4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110614-0013-0000-0000-000020F8BB6B
Message-Id: <20181106140642.GA19280@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-06_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811060125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 02:54:25PM -0800, Florian Fainelli wrote:
> Hi all,
> 
> Changes in v4:
> 
> - dropped initrd_below_start_ok assignment in ARM64, not necessary at
>   all (Ard)
> - replace #ifdef CONFIG_BLK_DEV_INITRD with if
>   (IS_ENABLED(CONFIG_BLK_DEV_INITRD) for consistency with other parts
>   of arm64_memblock_init() (Rob)
> 
> Changes in v3:
> 
> - use C conditionals in drivers/of/fdt.c
> - added check on phys_initrd_size in arch/arm64/mm/init.c to determine
>   whether initrd_start must be populated
> - fixed a build warning with ARC that was just missing an (unsigned
>   long) cast
> 
> Changes in v2:
> 
> - get rid of ARCH_HAS_PHYS_INITRD and instead define
>   phys_initrd_start/phys_initrd_size in init/do_mounts_initrd.c
> 
> - make __early_init_dt_declare_initrd() account for ARM64 specific
>   behavior with __va() when having CONFIG_DEBUG_VM enabled
> 
> - consolidate early_initrd() command line parsing into
>   init/do_mounts_initrd.c
> 
> Because phys_initrd_start/phys_initrd_size are now compiled in
> ini/do_mounts_initrd.c which is only built with CONFIG_BLK_DEV_INITRD=y,
> we need to be a bit careful about the uses throughout architecture
> specific code.
> 
> Previous discussions/submissions list here:
> 
> v3:
> https://www.spinics.net/lists/arm-kernel/msg683566.html
> v2:
> https://lkml.org/lkml/2018/10/25/4
> 
> Florian Fainelli (6):
>   nds32: Remove phys_initrd_start and phys_initrd_size
>   arch: Make phys_initrd_start and phys_initrd_size global variables
>   of/fdt: Populate phys_initrd_start/phys_initrd_size from FDT
>   arm64: Utilize phys_initrd_start/phys_initrd_size
>   of/fdt: Remove custom __early_init_dt_declare_initrd() implementation
>   arch: Move initrd= parsing into do_mounts_initrd.c

For the series:

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
 
>  arch/arc/mm/init.c              | 25 +++++-------------------
>  arch/arm/mm/init.c              | 28 ++-------------------------
>  arch/arm64/include/asm/memory.h |  8 --------
>  arch/arm64/mm/init.c            | 34 ++++++---------------------------
>  arch/nds32/mm/init.c            |  2 --
>  arch/unicore32/mm/init.c        | 24 +++++------------------
>  drivers/of/fdt.c                | 17 ++++++++++++-----
>  include/linux/initrd.h          |  3 +++
>  init/do_mounts_initrd.c         | 20 +++++++++++++++++++
>  9 files changed, 53 insertions(+), 108 deletions(-)
> 
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.

