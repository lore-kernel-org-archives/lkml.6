Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BCFC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD6B2170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LdlLl9KT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD6B2170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbeI1GKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 02:10:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51606 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbeI1GKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 02:10:48 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8RNnQsF056728;
        Thu, 27 Sep 2018 23:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=25h3/Mc6zIN0w+9x7KnX2xYtk344xgmpLLwffA32AGA=;
 b=LdlLl9KTQgcrYkVrihFb8sPXEGbjWlzq49z6VfRGwWeNx0IIt0gC4+CYs23nknjw942N
 SOlQrQ3Vpuz7hp7Rcy7y3Bh3Hgi5qGR4ExYhl3UMnFqU9ZziyynGGt1j60GJf/tFObFO
 lCSuSiQmlUawf/u4ed1HwZ9goOtkRu4dLbvm0EqXTSlqpPxLn3an+FknkBwvAOvNt9eB
 3Hjgk7acz+MsJGzd5f+V+Of5xPSexIypf5f4AHb2mgtNjiiomB01d5ylqCuuhk5qOoGY
 bM3bB3NYQSv5fkvho+AyY742pTetmdZw6t5OWgqxFVy9gn4dEnZdnNogM3bNXrQn48V0 Lw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2mnd5tw2yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Sep 2018 23:49:52 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8RNnpWv032521
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Sep 2018 23:49:51 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8RNnoH4016439;
        Thu, 27 Sep 2018 23:49:50 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Sep 2018 16:49:50 -0700
To:     Masanari Iida <standby24x7@gmail.com>
Cc:     qla2xxx-upstream@qlogic.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        himanshu.madhani@cavium.com, giridhar.malavali@cavium.com,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: qla2xxx: Fix comment in MODULE_PARM_DESC in qla2xxx
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180911094811.12681-1-standby24x7@gmail.com>
Date:   Thu, 27 Sep 2018 19:49:47 -0400
In-Reply-To: <20180911094811.12681-1-standby24x7@gmail.com> (Masanari Iida's
        message of "Tue, 11 Sep 2018 18:48:11 +0900")
Message-ID: <yq1tvmabiw4.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9029 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=714
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809270222
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Masanari,

> Default value of ql2xasynctmfenable for qla2xxx driver was set to 1 in
> commit 043dc1d7e8501.  But comment in MODULE_PARAM_DESC was not
> modified.

Applied to 4.20/scsi-queue. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
