Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F9CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A082070C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hkel3mAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405390AbfBNDQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:16:37 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:42958 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390020AbfBNDQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:16:36 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1E34EsT027568;
        Thu, 14 Feb 2019 03:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=tatKjz/3Mm0rRI2DZl28mkbLp9/wLjjsW4yl95wzzgs=;
 b=Hkel3mAOe2dSC1kBSAhdfsO16raDueERex9lae70QA8L2aFFufPBN+PGgKq5dazHG/CW
 EJ/bzLdhly2IyH38Uq/eDf1XWBqY/ZQNsa58Z1XaNoUmG6I2bge7+6OEOe4ldBmrEoUa
 NhlRXMjW1sJSOh3w3svASUcGd4ipaGMEqMS8JGsnGMI+GXpecUvWbszaZa/8iYUu0W8j
 GxTd6G0NjVrNeAMZjC9D1yKd+WyvSnZkHlEmBqU4q3R2o9c0zvKS0+v/UymEOGDdT3l6
 GTn3lMujkRrDR29acHlBdYsODYkQJtmWX8RE5G9aE6HtXq2cA3NW+rHPrjVlKgxRK6hM Zg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2qhre5nhhy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 03:16:30 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1E3GODS032298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 03:16:24 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1E3GND0013988;
        Thu, 14 Feb 2019 03:16:24 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Feb 2019 03:16:23 +0000
To:     Colin King <colin.king@canonical.com>
Cc:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: lpfc: fix a handful of indentation issues
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190212152945.11362-1-colin.king@canonical.com>
Date:   Wed, 13 Feb 2019 22:16:21 -0500
In-Reply-To: <20190212152945.11362-1-colin.king@canonical.com> (Colin King's
        message of "Tue, 12 Feb 2019 15:29:45 +0000")
Message-ID: <yq1wom3oy9m.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9166 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=651 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902140020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> There are a handful of statements that are indented incorrectly. Fix
> these.

Applied to 5.1/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
