Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34B9C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 03:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B931420862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 03:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wf8tWjFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B931420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbeKFNJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 08:09:08 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:43802 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbeKFNJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 08:09:07 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA63iwBx021397;
        Tue, 6 Nov 2018 03:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=tD+eCuFOiY3HoipE3dJo69X6QRm/DdyuDJPSwkhh8io=;
 b=Wf8tWjFR0DBsCmtdnuWGx2F1B2pAxIeO2Efo8LuZoiewcttcBEPtx81wvLGLfB40P60D
 tXgg1MRheebu5N81oSpYXcEL46UKRVK5mVOgiWsdjsWp2O13DdiI4kSEM+kb1EEgQr1n
 Nkk5LKxsl/CZ6mKIzSEHZPQzZj432SGhDq5cAM04A7/PJczCkgK+gPp35l/vrRxvxpWm
 MaJXNRDhfyDe9puOsDizE6ZkQHwRjBTqzdnfTivvQYp1u9P6vHTxaLLDRoqOejYVSe9j
 JjyfV4uIjyGLD0pL9JknAgLbmWRIblPakUdQFiNNmeay8wMIJcRnrbVUVNQHLCoNV0sb lQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2nh3mpjrk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Nov 2018 03:45:55 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA63jnJ1012708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Nov 2018 03:45:50 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wA63jm4Y031266;
        Tue, 6 Nov 2018 03:45:49 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Nov 2018 19:45:48 -0800
To:     Masanari Iida <standby24x7@gmail.com>
Cc:     linux-kernel@vger.kernel.org, qla2xxx-upstream@qlogic.com,
        linux-scsi@vger.kernel.org, himanshu.madhani@cavium.com
Subject: Re: [PATCH] scsi: qla2xxx: Fix a typo in MODULE_PARM_DESC
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20181028050548.3147-1-standby24x7@gmail.com>
Date:   Mon, 05 Nov 2018 22:45:46 -0500
In-Reply-To: <20181028050548.3147-1-standby24x7@gmail.com> (Masanari Iida's
        message of "Sun, 28 Oct 2018 14:05:48 +0900")
Message-ID: <yq1va5a6f85.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9068 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=632
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811060030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Masanari,

> This patch fixes a spelling typo in MODULE_PARM_DESC
> of ql2xplogiabsentdevice.

Applied to 4.20/scsi-fixes. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
