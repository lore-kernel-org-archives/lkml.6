Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E01C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7650C20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X/m1KbZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7650C20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeKIW5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 17:57:14 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39178 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbeKIW5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 17:57:13 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA9D4TpI126442;
        Fri, 9 Nov 2018 13:11:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=1vsrHPF0i32laW0hDwp5/dt37q797it8Bef0vgYQh9o=;
 b=X/m1KbZUJobRrWSTcTywhZ8iC3xMRwNEd0Y7KOz1qfUOSNSJ3DqThO8YmoM8MbkYzknn
 0pSY2aDHZhkBGtX450T46M9ytgBLkK3JiKkJWCkyksR9WtfotL4Cx5uUK0eWF6ZDdHXM
 n0fbrXaubcNGvFP6/iCReXNpmNb54+FJ0vGB7cmsjH0Gz4/QJaSJPgHl1xtZPGBlS1Xg
 H7tYT45DFzhmEMuXhHz3xg7O2tUQqrUU/4KqzEZnepfj7Kwr7aqizy49BqedGuk7LY9b
 8E33ypFt8S2kC1Sqig1hVJTwgMaa3SR/vJTMFxzyJ9fn8/IdXzXaJmdojkB1EtHeTF0r zA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2nh3mq6yhc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Nov 2018 13:11:17 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wA9DBGKB000416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Nov 2018 13:11:16 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wA9DBED7003994;
        Fri, 9 Nov 2018 13:11:15 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 09 Nov 2018 05:11:14 -0800
To:     John Garry <john.garry@huawei.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Janek Kotas <jank@cadence.com>,
        "vinholikatti\@gmail.com" <vinholikatti@gmail.com>,
        "jejb\@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
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
        <yq1tvkt1vly.fsf@oracle.com>
        <38D3DEAD-C318-4BE2-8605-102FF572AD45@global.cadence.com>
        <yq1tvkrvvad.fsf@oracle.com>
        <c4937848-8459-1201-5ec1-2f453df15e1e@huawei.com>
Date:   Fri, 09 Nov 2018 08:11:11 -0500
In-Reply-To: <c4937848-8459-1201-5ec1-2f453df15e1e@huawei.com> (John Garry's
        message of "Fri, 9 Nov 2018 11:51:59 +0000")
Message-ID: <yq18t22wg40.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9071 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=469
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811090122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> I am building your 4.21 queue today, and it seems to be broken from
> this patch:
>
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/mkp/scsi/+/b3874a425510d1164fd3428ab99273c07d210d82
>
> You seemed to miss adding the c-file:
> make[3]: *** No rule to make target `drivers/scsi/ufs/cdns-pltfrm.o',
> needed by `drivers/scsi/ufs/built-in.a'. Stop
>
> Or am I missing something?

A corner case wrt. handling of new files in my pre-commit hook prevented
the .c file from getting properly committed.

Fixed up, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
