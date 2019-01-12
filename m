Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D55C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 03:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31FCF206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 03:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Czrpytcn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfALDbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 22:31:32 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40320 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfALDbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 22:31:31 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0C3VOVC132706;
        Sat, 12 Jan 2019 03:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=+T080z3P/U57k3O0/JUqmqme88A4nMOkWJCMqQgeOaQ=;
 b=CzrpytcndA31DTAemGUFGi4i/gf2jI+h8QR8aJ02kIoqX6RQ6oBdMW2zsTn/7gX1W6Nx
 rz+YTbPGRBBNbn6GU0s72iyYurcPCIchzJazKBbDiNgpNLe5DDUldrowfSU4ClpjTkp+
 aywKHJ7+/Atksg9UuwNZTh5kotAzc7KbGADnZd+5IuOH/oGgCOXeH8SX2x5y1cb99pD+
 8gz7kAZY+8TChxaqlHvs2aT+w9d5Ht7j23BM8J/yLJ4lz4tW1/41bZATmQI9aRtlMXwa
 YKyJz3mJiFqJ6JEvOKYkXjwiPtPM/UrmYC4WEZA7LqKH6m218e1TC2Z96ugrnJEvgldC 8Q== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2ptn7rfn4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Jan 2019 03:31:23 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0C3VNar003663
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Jan 2019 03:31:23 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0C3VMph023851;
        Sat, 12 Jan 2019 03:31:23 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 11 Jan 2019 19:31:22 -0800
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Michael Reed <mdr@sgi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: qla1280: set 64bit coherent mask
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190109140902.21638-1-tbogendoerfer@suse.de>
Date:   Fri, 11 Jan 2019 22:31:18 -0500
In-Reply-To: <20190109140902.21638-1-tbogendoerfer@suse.de> (Thomas
        Bogendoerfer's message of "Wed, 9 Jan 2019 15:09:02 +0100")
Message-ID: <yq1r2div9fd.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9133 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=787
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901120027
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thomas,

> Reason is that SGI IP27 always generates 64bit DMA addresses and has
> no fallback mode for 32bit DMA addresses implemented. QLA1280
> supports 64bit addressing for all DMA accesses so setting coherent mask
> to 64bit fixes the issue.

Applied to 5.0/scsi-fixes, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
