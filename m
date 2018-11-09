Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD8AC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 02:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5A020855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 02:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NYCDfMgc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E5A020855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbeKIMH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 07:07:29 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:51328 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbeKIMH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 07:07:28 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA92NsSF047206;
        Fri, 9 Nov 2018 02:28:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=fCMJvr6etYYCJ+aZyzUfbwUatNtjpl5NdHrjJMHJGAU=;
 b=NYCDfMgcGaEE+mN2oPLzqie6aXx6vtfWokGfxODyWAOV88FqBcPcpCYPva+N7q/RAwLk
 kdoa62HJSZ+AOoEwA6/0rKFDo1X3C0HtHts0L/sPQCIuO9L/t2yDAAznK2GXFUwZy6AW
 y76j9nGDeOfXoOPoeCR1ldCJhDYGNWN6Fj33y87FWlkOetbV7ReH45Ak6+Y+miyvoL3W
 0c5frDLyLQXI5Dyw4p4SQUN9DQsnwHJKbTEfVSnd2tmbnJDCvcGHLZEknWn/NJrSb1Cz
 Dn03C6jXviv/u39oXUxKC9swO54xtm24F2qqwpxOrp2HWOliyw+n8F64Oy+wgfojnGnN hA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2nh3mq4sjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Nov 2018 02:28:52 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA92SkIv019955
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Nov 2018 02:28:46 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wA92Sj2n027020;
        Fri, 9 Nov 2018 02:28:45 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 08 Nov 2018 18:28:45 -0800
To:     Janek Kotas <jank@cadence.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
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
Date:   Thu, 08 Nov 2018 21:28:42 -0500
In-Reply-To: <38D3DEAD-C318-4BE2-8605-102FF572AD45@global.cadence.com> (Janek
        Kotas's message of "Wed, 7 Nov 2018 08:23:50 +0000")
Message-ID: <yq1tvkrvvad.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9071 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=704
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811090020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Janek,

>> Rob reviewed the dt binding patch but has it been merged or should I
>> take both patches through SCSI?

Applied to 4.21/scsi-queue. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
