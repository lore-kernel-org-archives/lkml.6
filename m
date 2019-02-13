Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AE3C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9DE21902
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392709AbfBMQdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:33:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52706 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2392610AbfBMQdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:33:36 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1DGUaSG036346
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 11:33:34 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qmpeg1kas-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 11:33:34 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 13 Feb 2019 16:33:31 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Feb 2019 16:33:28 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1DGXSA256557586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 16:33:28 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8E2DA4054;
        Wed, 13 Feb 2019 16:33:27 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51D8BA405B;
        Wed, 13 Feb 2019 16:33:27 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 13 Feb 2019 16:33:27 +0000 (GMT)
Date:   Wed, 13 Feb 2019 18:33:25 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 5/5] RISC-V: Free-up initrd in free_initrd_mem()
References: <20190213115301.103989-1-anup.patel@wdc.com>
 <20190213115301.103989-6-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213115301.103989-6-anup.patel@wdc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19021316-0016-0000-0000-000002560CA4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021316-0017-0000-0000-000032B034DC
Message-Id: <20190213163325.GC6110@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-13_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=908 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902130118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 11:53:51AM +0000, Anup Patel wrote:
> We should free-up initrd memory in free_initrd_mem() instead
> of doing nothing.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  arch/riscv/mm/init.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index b1167a6f5a92..aabf1869c54b 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -94,8 +94,9 @@ static void __init setup_initrd(void)
>  	initrd_end = 0;
>  }
>  
> -void free_initrd_mem(unsigned long start, unsigned long end)
> +void __init free_initrd_mem(unsigned long start, unsigned long end)
>  {
> +	free_reserved_area((void *)start, (void *)end, -1, "initrd");
>  }
>  #endif /* CONFIG_BLK_DEV_INITRD */
>  
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.

