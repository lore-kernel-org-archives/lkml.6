Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D449DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9299520832
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vOgZJmnP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9299520832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeK2Nzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 08:55:33 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49384 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbeK2Nzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 08:55:33 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAT2iTZT088123;
        Thu, 29 Nov 2018 02:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=TJJz+I/2MXWvvVTENIkKVfVZ713FyuhY6WDq/R+aUvc=;
 b=vOgZJmnPmZyXbdHe9BmJ9/3RM/mFxl3kmcOR6mXsu9PsV9LXeUYfYoJk/lsY4FUq1Zln
 vuiCgT5uKkkvbacC8GF7ToPmzz3MkkP5hMp1H+HLMAiAdJPsnEQCKt3Xin/SMMAcoWvj
 R3zNDq2vlqerO6U0//f7W61mWvFcsVEQu2//qO3zx0rr+iU1D9RyHG6vwnClGZb14Lxo
 cVUes6joPzbtr2ZpOgovqIMbaLCE8Ej5nHrAggwDKwovJvTFJ6CGRCy9KslPVCjjC48+
 9oyK7CKDM/uQ8lzE3zzwTWp39fDnGjwg3c0mE14FCJOi1vuBi0dGADwn1FDWa8UI+751 +A== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2nxy9rdpba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 02:51:31 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAT2pVCi009954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 02:51:31 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAT2pUAq023669;
        Thu, 29 Nov 2018 02:51:30 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Nov 2018 18:51:30 -0800
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 21/41] scsi: libfc: fc_rport: Mark expected switch fall-through
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <cover.1543374820.git.gustavo@embeddedor.com>
        <1713e55b2fa29809530bc694c37d9cadb22c6f98.1543374820.git.gustavo@embeddedor.com>
Date:   Wed, 28 Nov 2018 21:51:28 -0500
In-Reply-To: <1713e55b2fa29809530bc694c37d9cadb22c6f98.1543374820.git.gustavo@embeddedor.com>
        (Gustavo A. R. Silva's message of "Tue, 27 Nov 2018 22:30:55 -0600")
Message-ID: <yq17egwzjdb.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9091 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=596
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811290020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Gustavo A.,

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.

Applied to 4.21/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
