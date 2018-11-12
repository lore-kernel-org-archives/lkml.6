Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0E4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E056022419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E056022419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbeKLVSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 16:18:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45976 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728302AbeKLVSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 16:18:14 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wACBEpdo091304
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 06:25:24 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nq6j25gbn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 06:25:23 -0500
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <haver@linux.vnet.ibm.com>;
        Mon, 12 Nov 2018 11:25:23 -0000
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 12 Nov 2018 11:25:21 -0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wACBPKZe14024864
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Nov 2018 11:25:20 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54A4AC6062;
        Mon, 12 Nov 2018 11:25:20 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1793FC6057;
        Mon, 12 Nov 2018 11:25:19 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.16.170.189])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 12 Nov 2018 11:25:19 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 12 Nov 2018 12:28:12 +0100
From:   haver <haver@linux.vnet.ibm.com>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     gregkh@linuxfoundation.org, gpiccoli@linux.vnet.ibm.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: genwqe: should return proper error value.
In-Reply-To: <1537410553-23836-1-git-send-email-zhongjiang@huawei.com>
References: <1537410553-23836-1-git-send-email-zhongjiang@huawei.com>
X-Sender: haver@linux.vnet.ibm.com
User-Agent: Roundcube Webmail/1.0.1
X-TM-AS-GCONF: 00
x-cbid: 18111211-0016-0000-0000-00000951FD36
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010032; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116324; UDB=6.00577116; IPR=6.00896433;
 MB=3.00024122; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-12 11:25:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111211-0017-0000-0000-000041080201
Message-Id: <19c4da1964bcc195ae3dab346e34e6b9@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-12_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811120104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-20 04:29, zhong jiang wrote:
> The function should return -EFAULT when copy_from_user fails. Even
> though the caller does not distinguish them. but we should keep 
> backward
> compatibility.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/misc/genwqe/card_utils.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/misc/genwqe/card_utils.c 
> b/drivers/misc/genwqe/card_utils.c
> index 8679e0b..f0961ec 100644
> --- a/drivers/misc/genwqe/card_utils.c
> +++ b/drivers/misc/genwqe/card_utils.c
> @@ -298,7 +298,7 @@ static int genwqe_sgl_size(int num_pages)
>  int genwqe_alloc_sync_sgl(struct genwqe_dev *cd, struct genwqe_sgl 
> *sgl,
>  			  void __user *user_addr, size_t user_size, int write)
>  {
> -	int rc;
> +	int ret = -ENOMEM;
>  	struct pci_dev *pci_dev = cd->pci_dev;
> 
>  	sgl->fpage_offs = offset_in_page((unsigned long)user_addr);
> @@ -318,7 +318,7 @@ int genwqe_alloc_sync_sgl(struct genwqe_dev *cd,
> struct genwqe_sgl *sgl,
>  	if (get_order(sgl->sgl_size) > MAX_ORDER) {
>  		dev_err(&pci_dev->dev,
>  			"[%s] err: too much memory requested!\n", __func__);
> -		return -ENOMEM;
> +		return ret;
>  	}
> 
>  	sgl->sgl = __genwqe_alloc_consistent(cd, sgl->sgl_size,
> @@ -326,7 +326,7 @@ int genwqe_alloc_sync_sgl(struct genwqe_dev *cd,
> struct genwqe_sgl *sgl,
>  	if (sgl->sgl == NULL) {
>  		dev_err(&pci_dev->dev,
>  			"[%s] err: no memory available!\n", __func__);
> -		return -ENOMEM;
> +		return ret;
>  	}
> 
>  	/* Only use buffering on incomplete pages */
> @@ -339,7 +339,7 @@ int genwqe_alloc_sync_sgl(struct genwqe_dev *cd,
> struct genwqe_sgl *sgl,
>  		/* Sync with user memory */
>  		if (copy_from_user(sgl->fpage + sgl->fpage_offs,
>  				   user_addr, sgl->fpage_size)) {
> -			rc = -EFAULT;
> +			ret = -EFAULT;
>  			goto err_out;
>  		}
>  	}
> @@ -352,7 +352,7 @@ int genwqe_alloc_sync_sgl(struct genwqe_dev *cd,
> struct genwqe_sgl *sgl,
>  		/* Sync with user memory */
>  		if (copy_from_user(sgl->lpage, user_addr + user_size -
>  				   sgl->lpage_size, sgl->lpage_size)) {
> -			rc = -EFAULT;
> +			ret = -EFAULT;
>  			goto err_out2;
>  		}
>  	}
> @@ -374,7 +374,8 @@ int genwqe_alloc_sync_sgl(struct genwqe_dev *cd,
> struct genwqe_sgl *sgl,
>  	sgl->sgl = NULL;
>  	sgl->sgl_dma_addr = 0;
>  	sgl->sgl_size = 0;
> -	return -ENOMEM;
> +
> +	return ret;
>  }
> 
>  int genwqe_setup_sgl(struct genwqe_dev *cd, struct genwqe_sgl *sgl,

Thanks for the contribution. Should be fine to change that and have
a more precise failure information.

Signed-off-by: Frank Haverkamp <haver@linux.vnet.ibm.com>

