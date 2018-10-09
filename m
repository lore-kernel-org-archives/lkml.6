Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC73C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1309921479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NBDh0ONJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1309921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbeJIVpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:45:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36196 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJIVpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:45:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w99EQxT3145908;
        Tue, 9 Oct 2018 14:27:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=xv3dsR3XrRJvmNRNG5ZMgstXPyFS5XUcTTYsP8LeZik=;
 b=NBDh0ONJD5AgSdNHeBe1zrBjbJA9962Lx6/qNIen63T74C22h2586/D+uNUBCzxMR5+U
 2zHtnzi8//Ut8+KyVzNiZmY8Kp3DF4ViWZ8SW4fSg1gsGwYg9xr5IGK26wMDqJR1RRnj
 KUek7LNQlasm6QZ+l0cPPJe47/Bfu6Nb1vwYKFHLx3IWiT8gX7JVj6yQxz85f5wk0SaA
 kcUKqfCWT35gTgr4j82WbuuakPibdMB/UQB85Wnb+0qIRqmBW3tXdCGB3F0Yem7aDf6T
 ShNpNpEb/iFoU46JcRvlprqO7OjvuMwVVW85bEPlQ/kvJ0Mg2yhqa18rB5bBKSvy4I/f SA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2mxnpqwjkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Oct 2018 14:27:39 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w99ERYKw029348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Oct 2018 14:27:34 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w99ERXf1023762;
        Tue, 9 Oct 2018 14:27:33 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Oct 2018 14:27:32 +0000
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <Haakon.Bugge@oracle.com>
To:     netdev@vger.kernel.org
Cc:     stephen@networkplumber.org,
        "David S . Miller" <davem@davemloft.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH  v2 0/2] net: if_arp: use define instead of hard-coded value
Date:   Tue,  9 Oct 2018 16:27:22 +0200
Message-Id: <20181009142724.2213012-1-Haakon.Bugge@oracle.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9040 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=327
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810090142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Struct arpreq contains the name of the device. All other places in the
kernel, the define IFNAMSIZ is used to designate its size. But in
if_arp.h, a literal constant is used.

Fixed by explicitly including uapi/linu/if.h, where IFNAMSIZ is defined.

The series also fixes some incorrect indents.


v1 -> v2:
   * Include uapi/linux/if.h from if_arp.h
   * Added Stephen's t-b

Håkon Bugge (2):
  net: if_arp: Fix incorrect indents
  net: if_arp: use define instead of hard-coded value

 include/uapi/linux/if_arp.h | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

--
2.14.3



From a36b99413ea5beca1539f4faf065f33c7c19e6a5 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <Haakon.Bugge@oracle.com>
Date: Fri, 21 Sep 2018 11:28:36 +0200
Subject: [PATCH 0/2]
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Struct arpreq contains the name of the device. All other places in the
kernel, the define IFNAMSIZ is used to designate its size. But in
if_arp.h, a literal constant is used.

As it could be good reasons to use constants instead of the defines in
include files under uapi, it seems to be OK to use the define here,
without opening a can of worms in user-land.

This because if_arp.h includes netdevice.h, which also uses
IFNAMSIZ. For the distros I have checked, this also holds true for the
use-land side.

The series also fixes some incorrect indents.

Håkon Bugge (2):
  net: if_arp: Fix incorrect indents
  net: if_arp: use define instead of hard-coded value

 include/uapi/linux/if_arp.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--
2.14.3

