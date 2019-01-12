Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515A3C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9872084E
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nMigRp4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfALCpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 21:45:53 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37298 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbfALCpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 21:45:52 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0C2jbNo151008;
        Sat, 12 Jan 2019 02:45:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=QTeyAwL1dhFY2maVOdeafDusy3rqeDFimH8Kkl+mWcI=;
 b=nMigRp4V81Ez2cn9oGpw6EAxyiP1TstQjVfSOprD5F0+29cKTy+GOTx8IgPUjh/neR8p
 /56CBe9jYJKa/ZloXxZFecVPWx/WJPRbsEHWlP0fn5TlMD1sOhqLOpc9B0wvYhlVMIoW
 3MkRZGOIsAd2wW7PwaLF2mfrjUm1BBRirD9fouAYOHTx3SprGFKlky9HDpLNUji9yUHa
 qOtBe9sVRXij3T5s+wdqr7KL/eUrmK0SJL6GUjeKRhlnUL0rpDFOa4FkcIB3CgzrX1QC
 OUYu/BYSvRZD+hsWjbVHF9uFOM3gpkrdBjDYCX2ddbsdvLvNMq4kLhSczDVoehcf/Kas SQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2py7ntr03p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Jan 2019 02:45:36 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0C2jagR006354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Jan 2019 02:45:36 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0C2jZT6002578;
        Sat, 12 Jan 2019 02:45:35 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 11 Jan 2019 18:45:35 -0800
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Bradley Grove <linuxdrivers@attotech.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/41] scsi: esas2r: esas2r_init: mark expected switch fall-throughs
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <cover.1543374820.git.gustavo@embeddedor.com>
        <eb98d6f510cd93e45d7832837acd4e5811f3d20e.1543374820.git.gustavo@embeddedor.com>
Date:   Fri, 11 Jan 2019 21:45:32 -0500
In-Reply-To: <eb98d6f510cd93e45d7832837acd4e5811f3d20e.1543374820.git.gustavo@embeddedor.com>
        (Gustavo A. R. Silva's message of "Tue, 27 Nov 2018 22:28:57 -0600")
Message-ID: <yq15zuuy4oj.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9133 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=669
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901120021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Gustavo,

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.

Applied to 5.1/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
