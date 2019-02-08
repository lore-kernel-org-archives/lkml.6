Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49683C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 23:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9E5218D2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 23:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="x7vpJk08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfBHXOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 18:14:10 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:58260 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfBHXOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 18:14:10 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x18N9Cri179094;
        Fri, 8 Feb 2019 23:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=TniJTpdbJTtrYUazXy6zBM1dSYyHVJmUSKjnnGIxGto=;
 b=x7vpJk087YUi9kA8f8CFieF3Z4DUf21UfP3IJDZqlRxNai4T431aY1Ewge8QncZAOYSm
 qpFKaI+i/QVYtBErTD3v7dCVGNAcnNQxzQQsq7IDJDM4FH+G3GC8vdOQ5qkAtUH5gioT
 rQqvEYHdAXjFqFqfKD+fLmCzopE+VsirYsYoGhGLqCdW53J1z76Ngmr7HlTxEcz/HAly
 EW5JnY0KthhCBZQYr5TEohIPdqi8zj/VP9VE693CctsMUX3EaKdnhPUr6F+cD2eUi/be
 JY8Gd4BATZLNO823hMnPGaBDg1/G9aMAnKiUKIdLID+JIpCPQ90m9zfzjOlTEW09gQDz sg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2qd97ff86u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Feb 2019 23:14:00 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x18NDx07016512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Feb 2019 23:13:59 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x18NDvYA013416;
        Fri, 8 Feb 2019 23:13:58 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Feb 2019 15:13:57 -0800
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>
Subject: Re: [PATCH 1/6] scsi: hisi_sas: Add support for DIX feature for v3 hw
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1549450376-114929-1-git-send-email-john.garry@huawei.com>
        <1549450376-114929-2-git-send-email-john.garry@huawei.com>
Date:   Fri, 08 Feb 2019 18:13:55 -0500
In-Reply-To: <1549450376-114929-2-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Wed, 6 Feb 2019 18:52:51 +0800")
Message-ID: <yq1zhr5vpos.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9161 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=813 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902080157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

Just noticed this while inspecting the resulting complete diff:

>  static u32 get_prot_chk_msk_v3_hw(struct scsi_cmnd *scsi_cmnd)
>  {
>  	unsigned char prot_flags = scsi_cmnd->prot_flags;
>  
> -	if (prot_flags & SCSI_PROT_TRANSFER_PI) {
> -		if (prot_flags & SCSI_PROT_REF_CHECK)
> -			return 0xc << 16;
> -		return 0xfc << 16;
> -	}
> -	return 0;
> +	if (prot_flags & SCSI_PROT_REF_CHECK)
> +		return T10_CHK_APP_TAG_MSK;

Polarity is a bit unclear here. Is this statement disabling checking of
the app tag?

> +	return T10_CHK_REF_TAG_MSK | T10_CHK_APP_TAG_MSK;
>  }

-- 
Martin K. Petersen	Oracle Linux Engineering
