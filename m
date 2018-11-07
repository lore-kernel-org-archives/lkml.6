Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16F8C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 02:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561282085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 02:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wrE53XpB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 561282085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389235AbeKGLnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 06:43:55 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35528 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388677AbeKGLnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 06:43:55 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA72Eo3m078958;
        Wed, 7 Nov 2018 02:15:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=vk4bj8aG6r5bvgnXUSZLuU5BLeIpR4bipDkrgwyJkrc=;
 b=wrE53XpBKhLm1gPggPXKUSZJhkv2MmZl7hlYq3phtuvwLlKj3W4CexRdzqu7HbgZ6Xr5
 zF/D6RsuCLluaeZr6YACvodzdAao1BEiyz/gLEBhzCfql/sz1yP4AqMya30uAodBz1pH
 uup1eL6mCJXZFdwbuepm4lXBBCEHSQjgblkNIjKVgR0/4MQ4RxNub8lt12H9ge2ZB9/U
 aX5wKOHfAGO4GVNda4zyz+4YsfAHBzNCxgnCe6yYDkXHVkjlc6i+MXiGdFSQti9rg4Jg
 cDM/JckA5HrQJLK0YLsE8yhGkOYvioi45aYwGinT3/Zyw4VvQPqpLr9y3fbY9hf70lKT LQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2nh4aqrsh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Nov 2018 02:15:30 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA72FSWK023685
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Nov 2018 02:15:29 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA72FRFA013477;
        Wed, 7 Nov 2018 02:15:28 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 06 Nov 2018 18:15:26 -0800
To:     Janek Kotas <jank@cadence.com>
Cc:     "vinholikatti\@gmail.com" <vinholikatti@gmail.com>,
        "jejb\@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen\@oracle.com" <martin.petersen@oracle.com>,
        "robh+dt\@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland\@arm.com" <mark.rutland@arm.com>,
        "devicetree\@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi\@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] scsi: ufs: Add UFS platform driver for Cadence UFS
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <C77CE2E3-F88A-4B1E-BECB-5D031E2930E3@global.cadence.com>
        <1A428C77-982A-4EB8-8FDD-A33979753660@global.cadence.com>
Date:   Tue, 06 Nov 2018 21:15:21 -0500
In-Reply-To: <1A428C77-982A-4EB8-8FDD-A33979753660@global.cadence.com> (Janek
        Kotas's message of "Tue, 6 Nov 2018 13:37:21 +0000")
Message-ID: <yq1tvkt1vly.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9069 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=587
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811070019
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Janek,

> Could you please take a look at the proposed patch?

Rob reviewed the dt binding patch but has it been merged or should I
take both patches through SCSI?

-- 
Martin K. Petersen	Oracle Linux Engineering
