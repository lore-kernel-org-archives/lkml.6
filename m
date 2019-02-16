Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AA0C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 02:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D427222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 02:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XYGe+922"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392593AbfBPC7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 21:59:41 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60694 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbfBPC7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 21:59:40 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1G2sR0q115464;
        Sat, 16 Feb 2019 02:59:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=lFIdTej39JRUYzAJdKvkzeXTOcOeIokr5syHqT8m0X0=;
 b=XYGe+922FOgjw22anRewCNX6UTzPFonIwD/n7iH/ZC8TUKqhvKgTmnYYLJ2traSwGyX3
 VgHzjpbLT4nQXr4T8nlkoVH3IqOGFiuFgDZ84Al5qi6FaGmwrDWw6G/HTUbwASrtTtgu
 y30/h0pIcPPwrRUmsrQmyHO4a9zTld2WBvKIjih4sABS0KMM9qIJTj4uOqEfgd5RzD8o
 RGWMGHfs5kOY+kyDP2wuZjHPHrpF29uL9rWdTTjStOYHI/mEHoD3o9HClKuh2d94G+lz
 hOo8VUG3GBij0Kz70CV7WzDUhdYIxE9AoW0+jjtmxhG6XT+0AJCgVmMQzcRVxkPgE8EC jw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2qp9xtg0jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Feb 2019 02:59:26 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1G2xJFe025826
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Feb 2019 02:59:20 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1G2xIc8014974;
        Sat, 16 Feb 2019 02:59:18 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Feb 2019 18:59:18 -0800
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
Date:   Fri, 15 Feb 2019 21:59:15 -0500
In-Reply-To: <20190126144711.GA14260@Mani-XPS-13-9360> (Manivannan
        Sadhasivam's message of "Sat, 26 Jan 2019 20:17:11 +0530")
Message-ID: <yq1lg2go2v0.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9168 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=775 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902160018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Manivannan,

> Ping on this patch!

Applied to 5.1/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
