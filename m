Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290EBC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67A420842
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:05:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D67A420842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbeIZDOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 23:14:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35534 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726213AbeIZDOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 23:14:47 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8PKxLC3026473
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 17:05:19 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mqtj4d4fd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 17:05:19 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Tue, 25 Sep 2018 22:05:17 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Sep 2018 22:05:13 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8PL5C6361997124
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Sep 2018 21:05:12 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 32CC611C054;
        Wed, 26 Sep 2018 00:04:54 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA1EA11C058;
        Wed, 26 Sep 2018 00:04:52 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.204.176])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 26 Sep 2018 00:04:52 +0100 (BST)
Date:   Wed, 26 Sep 2018 00:05:09 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        pavel.tatashin@microsoft.com, mhocko@suse.com,
        dave.jiang@intel.com, dave.hansen@intel.com, jglisse@redhat.com,
        dan.j.williams@intel.com, logang@deltatee.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v5 1/4] mm: Remove now defunct NO_BOOTMEM from depends
 list for deferred init
References: <20180925200551.3576.18755.stgit@localhost.localdomain>
 <20180925201814.3576.15105.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925201814.3576.15105.stgit@localhost.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18092521-0012-0000-0000-000002AE85EC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092521-0013-0000-0000-000020E29B4E
Message-Id: <20180925210509.GA13839@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809250206
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 01:19:15PM -0700, Alexander Duyck wrote:
> The CONFIG_NO_BOOTMEM config option was recently removed by the patch "mm:
> remove CONFIG_NO_BOOTMEM" (https://patchwork.kernel.org/patch/10600647/).
> However it looks like it missed a few spots. The biggest one being the
> dependency for deferred init. This patch goes through and removes the
> remaining spots that appear to have been missed in the patch so that I am
> able to build again with deferred memory initialization.

Thanks for fixing it!
 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Acked-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

> ---
> 
> v5: New patch, added to fix regression found in latest linux-next
> 
>  arch/csky/Kconfig |    1 -
>  mm/Kconfig        |    1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index fe2c94b94fe3..fb2a0ae84dd5 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -38,7 +38,6 @@ config CSKY
>  	select HAVE_MEMBLOCK
>  	select MAY_HAVE_SPARSE_IRQ
>  	select MODULES_USE_ELF_RELA if MODULES
> -	select NO_BOOTMEM



>  	select OF
>  	select OF_EARLY_FLATTREE
>  	select OF_RESERVED_MEM
> diff --git a/mm/Kconfig b/mm/Kconfig
> index c6a0d82af45f..b4421aa608c4 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -631,7 +631,6 @@ config MAX_STACK_SIZE_MB
>  config DEFERRED_STRUCT_PAGE_INIT
>  	bool "Defer initialisation of struct pages to kthreads"
>  	default n
> -	depends on NO_BOOTMEM
>  	depends on SPARSEMEM
>  	depends on !NEED_PER_CPU_KM
>  	depends on 64BIT
> 

-- 
Sincerely yours,
Mike.

