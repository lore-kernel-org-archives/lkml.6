Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE26C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4784B20855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfBKNal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:30:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35818 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727182AbfBKNak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:30:40 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1BDOWR8105264
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 08:30:39 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qk8gmvj6h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 08:30:39 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 11 Feb 2019 13:30:37 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 11 Feb 2019 13:30:31 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1BDUUt22228690
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Feb 2019 13:30:31 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB2D64C044;
        Mon, 11 Feb 2019 13:30:30 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A40264C050;
        Mon, 11 Feb 2019 13:30:29 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.205.211])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 11 Feb 2019 13:30:29 +0000 (GMT)
Date:   Mon, 11 Feb 2019 15:30:27 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "nicolas.pitre@linaro.org" <nicolas.pitre@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: Re: [PATCH] arm: use memblocks_present
References: <20190211131602.3294-1-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211131602.3294-1-peng.fan@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19021113-0016-0000-0000-000002550B9F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021113-0017-0000-0000-000032AF27AC
Message-Id: <20190211133027.GA11446@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-11_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902110105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 01:04:59PM +0000, Peng Fan wrote:
> arm_memory_present is doing same thing as memblocks_present, so
> let's use common code memblocks_present instead of platform
> specific arm_memory_present.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  arch/arm/mm/init.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 478ea8b7db87..6c50dd407ba8 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -182,21 +182,6 @@ int pfn_valid(unsigned long pfn)
>  EXPORT_SYMBOL(pfn_valid);
>  #endif
>  
> -#ifndef CONFIG_SPARSEMEM
> -static void __init arm_memory_present(void)
> -{
> -}
> -#else
> -static void __init arm_memory_present(void)
> -{
> -	struct memblock_region *reg;
> -
> -	for_each_memblock(memory, reg)
> -		memory_present(0, memblock_region_memory_base_pfn(reg),
> -			       memblock_region_memory_end_pfn(reg));
> -}
> -#endif
> -
>  static bool arm_memblock_steal_permitted = true;
>  
>  phys_addr_t __init arm_memblock_steal(phys_addr_t size, phys_addr_t align)
> @@ -292,7 +277,7 @@ void __init bootmem_init(void)
>  	 * Sparsemem tries to allocate bootmem in memory_present(),
>  	 * so must be done after the fixed reservations
>  	 */
> -	arm_memory_present();
> +	memblocks_present();
>  
>  	/*
>  	 * sparse_init() needs the bootmem allocator up and running.
> -- 
> 2.16.4
> 

-- 
Sincerely yours,
Mike.

