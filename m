Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254DFECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 06:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7DEA214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 06:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xMmnOHag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7DEA214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbeIQMCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 08:02:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35082 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbeIQMCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 08:02:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8H6YIfs073422;
        Mon, 17 Sep 2018 06:36:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=xz+QhbnVrPLUfTZvKeN+jQsxx+u85DA7oLWJsb1SR5o=;
 b=xMmnOHagihY6284enYECN3dTyEg8bCcl0livG9cGcEgKjItQoz9dwbeUthh1/7Tg5iW/
 dUcL3bW0OzYuFPe7ZvBS+YSezaTsLfH17DzGN4MhwcfX8gwZoZTwbIH+LtgU6PQqSbQE
 CI6z9vV6BfYqbVVxGCniqIjWk3gq0GvdRls1cgBRRcr1XLNh5z+ksUULmk00A0XMdgCb
 lQbirGxND5KljvKkjqH4QMJUr14QOcr0zLle+7DWofZPcOOfZ/4QHyvyqHz6n0+lkMRx
 T/TSmhcCP75c7zij4HU5JdSR2g/9D+aZnsauaNrqu6ui4qfmmAyVTvAfQsfabElNP1KU wA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2mgsgtc7e9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Sep 2018 06:36:03 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8H6a2ED032657
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Sep 2018 06:36:03 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8H6a2It030378;
        Mon, 17 Sep 2018 06:36:02 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 16 Sep 2018 23:36:02 -0700
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: remove unnecessary unlikely()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180905204720.992-1-igor.stoppa@huawei.com>
Date:   Mon, 17 Sep 2018 02:36:00 -0400
In-Reply-To: <20180905204720.992-1-igor.stoppa@huawei.com> (Igor Stoppa's
        message of "Wed, 5 Sep 2018 23:47:20 +0300")
Message-ID: <yq1pnxcska7.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9018 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=667
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809170070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Igor,

> BUG_ON() already contains an unlikely(), there is no need for another one.

Applied to 4.20/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
