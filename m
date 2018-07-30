Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8044913F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B9620870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B9620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731904AbeG3Py1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:54:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60506 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726860AbeG3PyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:54:18 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6UEELVO016114
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 10:19:04 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kj314c6dq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 10:19:04 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Mon, 30 Jul 2018 15:19:01 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 30 Jul 2018 15:18:58 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6UEIv6U11796660
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Jul 2018 14:18:58 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 547DD42059;
        Mon, 30 Jul 2018 17:19:10 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5E2342049;
        Mon, 30 Jul 2018 17:19:08 +0100 (BST)
Received: from skywalker (unknown [9.199.40.54])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 30 Jul 2018 17:19:08 +0100 (BST)
Received: (nullmailer pid 12345 invoked by uid 1000);
        Mon, 30 Jul 2018 14:18:55 -0000
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Laurent Dufour <ldufour@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        npiggin@gmail.com
Subject: Re: [PATCH 1/3] powerpc/pseries/mm: Introducing FW_FEATURE_BLOCK_REMOVE
In-Reply-To: <1532699493-10883-2-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1532699493-10883-1-git-send-email-ldufour@linux.vnet.ibm.com> <1532699493-10883-2-git-send-email-ldufour@linux.vnet.ibm.com>
Date:   Mon, 30 Jul 2018 19:48:55 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18073014-0028-0000-0000-000002E2769E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18073014-0029-0000-0000-0000239A78D6
Message-Id: <87lg9solgw.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-30_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807300158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Dufour <ldufour@linux.vnet.ibm.com> writes:

> This feature tells if the hcall H_BLOCK_REMOVE is available.
>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> ---
>  arch/powerpc/include/asm/firmware.h       | 3 ++-
>  arch/powerpc/platforms/pseries/firmware.c | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
> index 535add3f7791..360ba197f9d2 100644
> --- a/arch/powerpc/include/asm/firmware.h
> +++ b/arch/powerpc/include/asm/firmware.h
> @@ -53,6 +53,7 @@
>  #define FW_FEATURE_PRRN		ASM_CONST(0x0000000200000000)
>  #define FW_FEATURE_DRMEM_V2	ASM_CONST(0x0000000400000000)
>  #define FW_FEATURE_DRC_INFO	ASM_CONST(0x0000000800000000)
> +#define FW_FEATURE_BLOCK_REMOVE ASM_CONST(0x0000001000000000)
>  
>  #ifndef __ASSEMBLY__
>  
> @@ -70,7 +71,7 @@ enum {
>  		FW_FEATURE_SET_MODE | FW_FEATURE_BEST_ENERGY |
>  		FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN |
>  		FW_FEATURE_HPT_RESIZE | FW_FEATURE_DRMEM_V2 |
> -		FW_FEATURE_DRC_INFO,
> +		FW_FEATURE_DRC_INFO | FW_FEATURE_BLOCK_REMOVE,
>  	FW_FEATURE_PSERIES_ALWAYS = 0,
>  	FW_FEATURE_POWERNV_POSSIBLE = FW_FEATURE_OPAL,
>  	FW_FEATURE_POWERNV_ALWAYS = 0,
> diff --git a/arch/powerpc/platforms/pseries/firmware.c b/arch/powerpc/platforms/pseries/firmware.c
> index a3bbeb43689e..1624501386f4 100644
> --- a/arch/powerpc/platforms/pseries/firmware.c
> +++ b/arch/powerpc/platforms/pseries/firmware.c
> @@ -65,6 +65,7 @@ hypertas_fw_features_table[] = {
>  	{FW_FEATURE_SET_MODE,		"hcall-set-mode"},
>  	{FW_FEATURE_BEST_ENERGY,	"hcall-best-energy-1*"},
>  	{FW_FEATURE_HPT_RESIZE,		"hcall-hpt-resize"},
> +	{FW_FEATURE_BLOCK_REMOVE,	"hcall-block-remove"},
>  };
>  
>  /* Build up the firmware features bitmask using the contents of
> -- 
> 2.7.4

