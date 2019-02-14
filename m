Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7481C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F3B2070C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="apQl9Lu+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405372AbfBNDOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:14:33 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:41334 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390020AbfBNDOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:14:32 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1E33urw027500;
        Thu, 14 Feb 2019 03:14:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=q42QLD1W5S2AT774vyKhI2wEJCz7Uxahxfv3PjCHl6A=;
 b=apQl9Lu+bo9bUqFcq2471/8vt+s+odhUN9s8v9ZvkPyO/403lxvCmhUlupihZ62uSqy6
 DZ8Ej/CiQbUKuRI+u51fK/ZLH6wTIujw2XAJB6jSJ3zCnF//C7veMGzG+P/Xji2bD9r/
 pU6FJ3QVjRFsxamoLR/wLHt/HroniJrsRxQg97YZGO0rGrs9/3Rjtc4Ad6JdhgcRVBM1
 ++QvTM+XuJk9KlfmKQ9LPaooEEqUKhGgENDDaWk9HC6S9WIB7iUz+Wz4zZFNdBW2ox4P
 REG6V6KwIjpHP1e+TCyNGarGVQprwu6GPBTGOTjIQ4vAFKYzz/0f10eHsW6IcOsV1U6D Ow== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2qhre5nhdn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 03:14:25 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1E3EO2H004374
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 03:14:25 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1E3EOiF012481;
        Thu, 14 Feb 2019 03:14:24 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Feb 2019 03:14:23 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, Meelis Roos <mroos@linux.ee>
Subject: Re: [PATCH] scsi: qlogicpti: Use of_node_name_eq for node name comparisons
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190213160829.3923-1-robh@kernel.org>
Date:   Wed, 13 Feb 2019 22:14:21 -0500
In-Reply-To: <20190213160829.3923-1-robh@kernel.org> (Rob Herring's message of
        "Wed, 13 Feb 2019 10:08:29 -0600")
Message-ID: <yq11s4bqcxe.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9166 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=721 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902140020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Rob,

> -	qpti->is_pti = strcmp(qpti->prom_name, "QLGC,isp");
> +	qpti->is_pti = !of_node_name_eq(op->dev.of_node, "QLGC,isp");

The apparent polarity inversion made me blink but it appears to be
correct (is_pti is set if it's not an isp controller). Makes me wonder
if the driver is doing the right thing for a "SUNW,isp", though...

Meelis: Do you have anything that identifies itself as SUNW,isp?

In any case: Applied to 5.1/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
