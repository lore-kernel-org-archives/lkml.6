Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B289C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC0D217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yWnSyQBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfBZPN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:13:59 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:58400 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbfBZPN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 10:13:58 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1QF8dEV169869;
        Tue, 26 Feb 2019 15:13:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=poLUiTcTmB6umyHLICd1jZ43ohJvONH938E1A4HZoo8=;
 b=yWnSyQBL62KXz6cZNOZ468mBiEtI9NgKTkOooBIYaZOltKvGPDQ0hD4W0gM2qTp2R2PT
 sOJxOAWzojAbRTOCPqu4JU9KcLaHBYW4Rn4nL5Xzp1gYeJ4R266xB2zlln/8rKQpRQze
 dlHmsyUlTcL1ghxrZ2gHqKT50M+zOwlrQkIVIkqq5b10IdkfQS62sG8rOdDg5zlxgJMN
 hibKP3W7Miiq73lRoAWhe86K7d0ph0hPXU6GYa+Spc+QfTFaCsC6U2G/QQiM9q9z4I8G
 BhT13puimKg7IFxz4nNcZk7Cv7miDfxpAZkYv2m6oxatQ/UZWA1TZNCdpwuyEq3fnRyi CA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2qtxtrn3df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Feb 2019 15:13:46 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1QFDkVg012886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Feb 2019 15:13:46 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1QFDj00030662;
        Tue, 26 Feb 2019 15:13:45 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Feb 2019 07:13:45 -0800
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     <shivasharan.srikanteshwara@broadcom.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <sumit.saxena@broadcom.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <megaraidlinux.pdl@broadcom.com>
Subject: Re: [PATCH -next] scsi: megaraid_sas: Remove a bunch of set but not used variables
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190222015858.9744-1-yuehaibing@huawei.com>
Date:   Tue, 26 Feb 2019 10:13:42 -0500
In-Reply-To: <20190222015858.9744-1-yuehaibing@huawei.com> (Yue Haibing's
        message of "Fri, 22 Feb 2019 09:58:58 +0800")
Message-ID: <yq136oad1ll.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9178 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=790 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902260110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Yue,

> From: YueHaibing <yuehaibing@huawei.com>
>
> Fixes gcc '-Wunused-but-set-variable' warning:

Applied to 5.1/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
