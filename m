Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D68C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E3720880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fckD+Utu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfBTOVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:21:37 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53448 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfBTOVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:21:36 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KEIiFL158103;
        Wed, 20 Feb 2019 14:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=hGcPQ2L5NAHFuLuFgEGUnQ0V/GI9Z63apyRnnHFbiog=;
 b=fckD+UtuDcDasPhkHGl12EE5VJQjOBup7K3/w6pfYjlNEEONEgp7xOTjab4b9A3IJzLT
 LdgeR9onj7wdf5zYGxw15lA2/XjchmB44TWGZEBeFHyuyanU97ZQuZ0BMIEE7LiJhrA4
 wJvuts4ejOYEzmduLA7OTO/rbjydTOuk0Xm5fwYfEEK8b/+kfAn9Ccq01DMl3woxD6Ez
 VYVpjb/lDFCun2seTM0Eb3IMzV2JznsCyJnvo/seRl7no9g4K4c87DArhw+BSneiMB+S
 KNMZMgNpwZIKmHNNlDute4YnB6N9+OS583YPsUUQigdGgdnMg+iMUZ/O4Y4WG4ML6YIu gg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2qpb5rhq8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 14:21:09 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1KEL8H2019492
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 14:21:08 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1KEL6qm011223;
        Wed, 20 Feb 2019 14:21:06 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 06:21:06 -0800
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        liwei213@huawei.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, guodong.xu@linaro.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        amit.kucheria@linaro.org, john.stultz@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        Wei Xu <xuwei5@hisilicon.com>, linux-next@vger.kernel.org
Subject: Re: [PATCH v2 2/3] arm64: dts: hisilicon: hi3670: Add UFS controller support
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190105072859.9134-1-manivannan.sadhasivam@linaro.org>
        <20190105072859.9134-3-manivannan.sadhasivam@linaro.org>
        <20190220113508.GB7498@ulmo>
Date:   Wed, 20 Feb 2019 09:21:01 -0500
In-Reply-To: <20190220113508.GB7498@ulmo> (Thierry Reding's message of "Wed,
        20 Feb 2019 12:35:08 +0100")
Message-ID: <yq18syak0c2.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9172 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=873 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902200104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thierry,

> it looks like you picked this up into the SCSI tree (perhaps
> inadvertently). It's been causing linux-next to fail to build since
> Monday (next-20190218) because it references a phandle (&crg_rst)
> that's not available.

I dropped the offending patch from the SCSI tree yesterday. When Stephen
updates -next, things should be fine.

-- 
Martin K. Petersen	Oracle Linux Engineering
