Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517682467-2-7467370759768402198
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enrosv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517682466; b=hGNHSi0eyjefmJ746v0JL43Kez2e36t13FLLqRPzKHRQBT9
    f73GSs4BzU992ImstxNJUSzHGGO5qB0YZMspqnI3R7e4Jk11oqn9LGMjrN83+9XD
    psbdZVKcgOM8Ypc7s2r8piIBXWqNFtrluIMpAXxHrl96w1v8uy10WtcaZAWn6qDv
    CvYUC8inKLX2Mi9OfLybOgoUVF9Ija2pjMg3vYJ3fsdyuzfO+VYxMhCMCNMM5NL4
    a+w8o6D+J7Avlf8huOza95gTe+cE2TI0NQbDMJ1onNSTmHkt9OILDjVvBV+/dqzQ
    ILZSvvzaiT3cTkjPbPr/mjnCZ7/4vyQJMYiVtvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682466; bh=0wCBBK
    iYtZnqh70KpwB+01ivj+oWz0Kefdy7vPr3WSY=; b=hqfutwZGOTrcJDw8/KrXH+
    qdAL1FyiG+gBgqDhrlkojAmkw0+BM2QeF58aQwhxxMK9j2Cytu3Y49oM2CwFqx4g
    ceWCRwE7d1TSTRU3oQXn7+s5iZnmRpU4+Yf5oEOBDB2Z5nktS2alTz8rFpsUyAWN
    py+7LnCDLkauheN+LWrnuhSeuLx5I4TbfhG7tKBCgwzCexnDgCDtsgmReP8RkQIa
    yOuo4xcH/HMKYBbEqKLSqeC9ngIC0klIxiyiDya2WWW9dRdFKWuO+YcrKNbtTSlX
    1tIPc7+dZPD56EwY+NQf3NBr1dqE2dAwiLJbimu+QhcFTb2P17W7rPTuH1naX0ow
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KAfXdRU1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KAfXdRU1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754335AbeBCS1n (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:27:43 -0500
Received: from mail-bl2nam02on0122.outbound.protection.outlook.com ([104.47.38.122]:14996
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752997AbeBCSGA (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:00 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tommi Rantala <tommi.t.rantala@nokia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 23/52] tipc: error path leak fixes in
 tipc_enable_bearer()
Thread-Topic: [PATCH AUTOSEL for 4.9 23/52] tipc: error path leak fixes in
 tipc_enable_bearer()
Thread-Index: AQHTnRlVEZ8aNDWfIUm4kb+EqfMdkA==
Date: Sat, 3 Feb 2018 18:03:46 +0000
Message-ID: <20180203180303.8490-23-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1091;7:4N+6cNWtsLVjqLXpxQxigbBYl38GosZPNyy0EzeauKZoJQ7kcl8qHGA77dkm5MbOkyu6RrCSIpJKvQAflAtcvUh4S08VVnC7xaIc+zp9hXxufNFpGlrj9sUW8trgOQ40yb6swezBlZlyN55Vx1hn32z/NqSzwbk8yKWvqzZ565vu+iiXuNnA0Ufy1fw6gxMwVBzdUIDayEcxMx2OrJRTcpI3p03EaMZ0PPSGkVhJvutGTM6LA1U8JeBZYtdAyE5u
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8edaa0c5-db68-44fa-488b-08d56b307868
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1091;
x-ms-traffictypediagnostic: BL0PR2101MB1091:
x-microsoft-antispam-prvs: <BL0PR2101MB1091A9D1C2A0F9979F966172FBF80@BL0PR2101MB1091.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(37575265505322)(28532068793085)(89211679590171)(82608151540597);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1091;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1091;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(346002)(376002)(366004)(39860400002)(199004)(189003)(86362001)(106356001)(22452003)(4326008)(97736004)(25786009)(2950100002)(5660300001)(2906002)(81156014)(105586002)(3280700002)(8676002)(8936002)(6116002)(68736007)(81166006)(3660700001)(86612001)(2900100001)(107886003)(3846002)(8656006)(102836004)(1076002)(26005)(6346003)(66066001)(10090500001)(76176011)(6506007)(10290500003)(14454004)(186003)(6486002)(59450400001)(6436002)(53936002)(72206003)(7736002)(316002)(305945005)(99286004)(110136005)(54906003)(36756003)(2501003)(5250100002)(6512007)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1091;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: S1WtgSUEiLU69GY4ITqD3pjEQ9s/zHaPjZg3q1vCzbecZB4+Rg1evCE3/3NJUZwCcS3IEDX1Uhj7gU8T3/71gw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8edaa0c5-db68-44fa-488b-08d56b307868
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:03:46.3151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1091
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tommi Rantala <tommi.t.rantala@nokia.com>

[ Upstream commit 19142551b2be4a9e13838099fde1351386e5e007 ]

Fix memory leak in tipc_enable_bearer() if enable_media() fails, and
cleanup with bearer_disable() if tipc_mon_create() fails.

Acked-by: Ying Xue <ying.xue@windriver.com>
Acked-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/tipc/bearer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 52d74760fb68..ca68db207965 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -322,6 +322,7 @@ restart:
 	if (res) {
 		pr_warn("Bearer <%s> rejected, enable failure (%d)\n",
 			name, -res);
+		kfree(b);
 		return -EINVAL;
 	}
=20
@@ -345,8 +346,10 @@ restart:
 	if (skb)
 		tipc_bearer_xmit_skb(net, bearer_id, skb, &b->bcast_addr);
=20
-	if (tipc_mon_create(net, bearer_id))
+	if (tipc_mon_create(net, bearer_id)) {
+		bearer_disable(net, b);
 		return -ENOMEM;
+	}
=20
 	pr_info("Enabled bearer <%s>, discovery domain %s, priority %u\n",
 		name,
--=20
2.11.0
