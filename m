Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DFAC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB8FB213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nkRYL9X5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB8FB213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbeJIVpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:45:03 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36204 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeJIVpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:45:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w99ER0UN146007;
        Tue, 9 Oct 2018 14:27:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=0L10St+lienYN6LhonwsS65SroB5R3YqXBF6JDo9OGE=;
 b=nkRYL9X5MLFgMkww/ttqnk4MmlQ+2bY65YLgIFwd6+DNZSd8IxMPBn/6hFek3HIO4jUB
 dA+zcMLLUu1wpwBWeX+1EkZt0wqvmMoIMTrlH47okaosd/lrP8fgKLQLIc7ML1i24s2P
 AKncCG2J3r4mT+FCS2nuiwVi+Xrk1hk3mMkStEDLgmFTeO3N7YFvYdk366KqL6I80Yiy
 zAMy0pPaac/g5/C6LGzp84UGda+0nuAsKaM7IsMbhi6qGHJq3Yyq/kSP1edauNcPx94u
 UWTDAxdeu6LXcSkWyu9qele5vyQDKEk7YKx+CjcJT/Mp1kzAirQJOozq0TUCt22uMgdb sw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2mxnpqwjkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Oct 2018 14:27:41 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w99ERZ7S013725
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Oct 2018 14:27:35 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w99ERYNB014920;
        Tue, 9 Oct 2018 14:27:34 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Oct 2018 14:27:34 +0000
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <Haakon.Bugge@oracle.com>
To:     netdev@vger.kernel.org
Cc:     stephen@networkplumber.org,
        "David S . Miller" <davem@davemloft.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH  v2 1/2] net: if_arp: Fix incorrect indents
Date:   Tue,  9 Oct 2018 16:27:23 +0200
Message-Id: <20181009142724.2213012-2-Haakon.Bugge@oracle.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20181009142724.2213012-1-Haakon.Bugge@oracle.com>
References: <20181009142724.2213012-1-Haakon.Bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9040 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=571
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810090142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing incorrect indents and align comments.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 include/uapi/linux/if_arp.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/if_arp.h b/include/uapi/linux/if_arp.h
index 4605527ca41b..b68b4b3d9172 100644
--- a/include/uapi/linux/if_arp.h
+++ b/include/uapi/linux/if_arp.h
@@ -114,18 +114,18 @@
 
 /* ARP ioctl request. */
 struct arpreq {
-  struct sockaddr	arp_pa;		/* protocol address		*/
-  struct sockaddr	arp_ha;		/* hardware address		*/
-  int			arp_flags;	/* flags			*/
-  struct sockaddr       arp_netmask;    /* netmask (only for proxy arps) */
-  char			arp_dev[16];
+	struct sockaddr	arp_pa;		/* protocol address		 */
+	struct sockaddr	arp_ha;		/* hardware address		 */
+	int		arp_flags;	/* flags			 */
+	struct sockaddr arp_netmask;    /* netmask (only for proxy arps) */
+	char		arp_dev[16];
 };
 
 struct arpreq_old {
-  struct sockaddr	arp_pa;		/* protocol address		*/
-  struct sockaddr	arp_ha;		/* hardware address		*/
-  int			arp_flags;	/* flags			*/
-  struct sockaddr       arp_netmask;    /* netmask (only for proxy arps) */
+	struct sockaddr	arp_pa;		/* protocol address		 */
+	struct sockaddr	arp_ha;		/* hardware address		 */
+	int		arp_flags;	/* flags			 */
+	struct sockaddr	arp_netmask;    /* netmask (only for proxy arps) */
 };
 
 /* ARP Flag values. */
-- 
2.14.3

