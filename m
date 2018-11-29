Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E710C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F01F2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rdmxrPRa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F01F2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeK2NzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 08:55:24 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:43188 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbeK2NzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 08:55:24 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAT2iLZx091422;
        Thu, 29 Nov 2018 02:51:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=TJJz+I/2MXWvvVTENIkKVfVZ713FyuhY6WDq/R+aUvc=;
 b=rdmxrPRaBz0ZAKEo3Im1auTgUcy0A+T/6rMTOytviNjRn/Kpbnn9aki6v4BXOdeA/0wn
 upFdJmSZ9QzEWMdB9bCzuFpIXNZvrwTSncoaIbQjXnJ2YBztaunaVjqN6+ckNztKqcrk
 lT4vzjozwpnwTPH5ZXXzoLCOaflYtyG/TVDwkfB90QHd6FOLlZ+z8jWQG/K6Xl0ldZj7
 X5BtGhkMzIOWqJbXMc7aZpTfC4ix5m+Iv/Z2LEabYKMIkwUjGSg3lCMq5ANk+of/yS2n
 ve9ivuIS24swW22i8R4kNqCAd09mVSZCyd8Uiao+XHReLnKwG2rf4yKYnP9tKXAt7TFC tw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2nxxkqnpe3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 02:51:22 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAT2pLFW009664
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 02:51:21 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAT2pKXD028040;
        Thu, 29 Nov 2018 02:51:20 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Nov 2018 18:51:20 -0800
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Don Brace <don.brace@microsemi.com>, esc.storagedev@microsemi.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/41] scsi: hpsa: mark expected switch fall-throughs
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <cover.1543374820.git.gustavo@embeddedor.com>
        <991ec154d1a1da019442e4fd025a39fa2ad2bebb.1543374820.git.gustavo@embeddedor.com>
Date:   Wed, 28 Nov 2018 21:51:18 -0500
In-Reply-To: <991ec154d1a1da019442e4fd025a39fa2ad2bebb.1543374820.git.gustavo@embeddedor.com>
        (Gustavo A. R. Silva's message of "Tue, 27 Nov 2018 22:29:07 -0600")
Message-ID: <yq1bm68zjdl.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9091 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=593
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
