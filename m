Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4697DC4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 20:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB04217CB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 20:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB04217CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbeHDWjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 18:39:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56474 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727127AbeHDWjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 18:39:40 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w74KYV6e139554
        for <linux-kernel@vger.kernel.org>; Sat, 4 Aug 2018 16:37:47 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kn856fy3y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 16:37:47 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tyreld@linux.vnet.ibm.com>;
        Sat, 4 Aug 2018 14:37:46 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 4 Aug 2018 14:37:42 -0600
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w74Kbfjo9044364
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 4 Aug 2018 13:37:41 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 617626E053;
        Sat,  4 Aug 2018 14:37:41 -0600 (MDT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CF3B6E04C;
        Sat,  4 Aug 2018 14:37:40 -0600 (MDT)
Received: from oc6857751186.ibm.com (unknown [9.80.200.87])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sat,  4 Aug 2018 14:37:39 -0600 (MDT)
Subject: Re: [PATCH] powpc:feature: of_node_put is not needed after iterator.
To:     zhong jiang <zhongjiang@huawei.com>, benh@kernel.crashing.org
Cc:     paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <1533392700-24621-1-git-send-email-zhongjiang@huawei.com>
From:   Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date:   Sat, 4 Aug 2018 13:37:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1533392700-24621-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18080420-0012-0000-0000-00001697810B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009484; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01069877; UDB=6.00550340; IPR=6.00848713;
 MB=3.00022509; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-04 20:37:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080420-0013-0000-0000-000053EB41BC
Message-Id: <eb06cfd4-ccbd-3f7f-2118-10f385d9b217@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-04_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808040228
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2018 07:25 AM, zhong jiang wrote:
> for_each_node_by_name iterators only  exit normally when the loop
> cursor is NULL, So there is no point to call of_node_put.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Reviewed-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

> ---
>  arch/powerpc/platforms/powermac/feature.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powermac/feature.c b/arch/powerpc/platforms/powermac/feature.c
> index 3f82cb2..4eb8cb3 100644
> --- a/arch/powerpc/platforms/powermac/feature.c
> +++ b/arch/powerpc/platforms/powermac/feature.c
> @@ -2889,10 +2889,8 @@ static void __init probe_one_macio(const char *name, const char *compat, int typ
>  	/* On all machines, switch modem & serial ports off */
>  	for_each_node_by_name(np, "ch-a")
>  		initial_serial_shutdown(np);
> -	of_node_put(np);
>  	for_each_node_by_name(np, "ch-b")
>  		initial_serial_shutdown(np);
> -	of_node_put(np);
>  }
> 
>  void __init
> 

