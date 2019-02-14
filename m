Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5139EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5B321904
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rpOrk39h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404706AbfBNCst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 21:48:49 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:47990 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732564AbfBNCst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 21:48:49 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1E2dKNm010702;
        Thu, 14 Feb 2019 02:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=oT85RKWwjopzqOdt9LmCqIv99VvJz7mJxvF/aBAYrQA=;
 b=rpOrk39h8+v3WP9cbbAHNNOcBmKN4qyI2Qyp7qqEKfHeLTmusd/isAQA7alfn1Ulevvw
 GIS6uxdJbW3e3yYFRua45pjk5cVjKLnQ3kkZQbtI+rhyVu7Y3ccqzodqWVkJLvvjtOG+
 juQmM/Ml7mKNoN5dacu6emAlg4RInIhvFTNd8i9Rcd7J9ZOiVvPs8PwxwqsykkDgPSB8
 TQx3R8dxIqAbTAhj7AW+mkWJxYuoAPJYY8SmFaSzzgzQNFDyOZE0JZ2NoXyVDGU4DguR
 7TjBPfl609soP9iZ6G4fEcobdVuym2Ft1fZxFmZIY1kHRzjh0eMuYjtrnhf0jQxaH7eG aQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2qhre5nfb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 02:48:36 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1E2mUci032640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 02:48:30 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1E2mTqU000943;
        Thu, 14 Feb 2019 02:48:29 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Feb 2019 02:48:29 +0000
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, liwei213@huawei.com,
        robh+dt@kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, john.stultz@linaro.org,
        amit.kucheria@linaro.org, guodong.xu@linaro.org
Subject: Re: [PATCH v2 3/3] scsi: ufs: Add HI3670 SoC UFS driver support
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190105072859.9134-1-manivannan.sadhasivam@linaro.org>
        <20190105072859.9134-4-manivannan.sadhasivam@linaro.org>
        <20190126144711.GA14260@Mani-XPS-13-9360>
Date:   Wed, 13 Feb 2019 21:48:26 -0500
In-Reply-To: <20190126144711.GA14260@Mani-XPS-13-9360> (Manivannan
        Sadhasivam's message of "Sat, 26 Jan 2019 20:17:11 +0530")
Message-ID: <yq18syjqe4l.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9166 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=665 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902140018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Manivannan,

> Ping on this patch!

I don't have any objections except I would like to see an Acked-by: from
Wei Li or somebody from hisilicon.

-- 
Martin K. Petersen	Oracle Linux Engineering
