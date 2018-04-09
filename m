Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523239272-2-12220992811088692069
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523239272; b=v85pR6edX/XBSQ4sk/u+B8dzN2qAIefntqJ1S0EEYXoCvmhj3R
    0wXGy+rbNb3MgNU5nipoJCVWBBMQZO+vtMlZpqqNAGlqXDbEdU0/Ro+NzJ0X655i
    j6YCgImM9bgT5eGlrJuye0od7HfDVnc2PFFBVh+9a4SOwqw3BaHf7iWPLPlb0v5k
    UFW5bbP14EkP+lpsUkbKqqC7txz7w0LYysTbhPcRiWaxXDcf+Y6/smFxOni7sJ2v
    cqfqo0WorqRBGBcOL+V5FO2QEt7c/k8GGB/FwhaIFupjIPC6EzE4a1QW/C+d2TLC
    TbDNdk/dp5xDWpKP/MdHvb86pqzlFF8DLqvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239272; bh=ffBCmqy8pp
    eP1NHVwDEBLzR270g8OB4goHgQMpBE4bA=; b=dR4UcFMXHObXW6eQKPmvmyMVLy
    Iwm+p4D+2zk8pnETodfXYn8ZPEJkP3zyjaZGzbwALkwgdFbka9muLAwgwz7h68S1
    /b8otNwEUtKtwPiUdQbpaKmeMVet8nI4dHDwduHS4XRHCu91fJL2TC/CcwgD0p3X
    YOe/JQKFXBq9Kpg/zXq0xSiGxS0/e54m3e045C/aWpMDpvawMHr3WVaz0O+z+lPy
    PNZsuwg+ZeH+fNNStPObe0tTCVAIyJFgGxw3I69vKpMTanTbt1mMR+9TOKm7Jc1/
    g/cfQZPXKkYQjJDZIpHVM1623OYxdh9pOdXZbzpt/z6xl92By1S8gXEAsDBg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EJsCWKPa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EJsCWKPa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOmJf1ORqkLyXxCFUJqOueH47k1LSBotIWNbu1a85BBW7Y2p0Fd46ODZ41wMAjpqC6dEPoy6u0GllVHixZqIPTiIKOeBPlW6ClTnn16G758Y9/Bp73C8
    L6O76LPGLYFFYvJ53quqUtQmIjqR8T9WLzHOaMDqvzvgkpRLZMO/CJVFO5803qkmgvlJgBnfRnyT9XnCejmRqK53fEYxOeQJGi9suH1xDkCq4tynBG9ZxoiC
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=CDq0vqnqAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=UMBYwGQvlmYUEeJxU3AA:9 a=nhD4a0yXulyws8as:21 a=ntMR2CejKxnIowcF:21
    a=wPNLvfGTeEIA:10 a=Xn7iXEen_xUG9zZOO_Hb:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757585AbeDICAi (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:00:38 -0400
Received: from mail-sn1nam01on0091.outbound.protection.outlook.com ([104.47.32.91]:51937
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756464AbeDIAcO (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:14 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 202/293] bridge: allow ext learned entries to
 change ports
Thread-Topic: [PATCH AUTOSEL for 4.9 202/293] bridge: allow ext learned
 entries to change ports
Thread-Index: AQHTz5lE3KgLy3ufmUO2TVzusc4RZg==
Date: Mon, 9 Apr 2018 00:25:31 +0000
Message-ID: <20180409002239.163177-202-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0870;7:ybf1a9Lgv6vQvXsgxHLRMGKokTLCxhRaluxrPb0BnE1baW2DQUdd27LW4jiTWIi7z2DArByLNuoTyEfB7+UH6z5WES2xa2oh4PZyK6MWyvHD3CkDAZGFFZWbhglxCbMFA69hbjOKqp2VjKqCz57mFqj7gS0cq63G4Q3gAgy4xrcGovm6HIrhPKIdJQCezwqpSMAvwx+43qd5rC/CQqz7674b1qZOKCXSwCYlFleTp7ktRsdZOr5mjPE+FeRyVlg4;20:ojPSfKJCwtb1Cl9jyf6MH5iy7aFCwFIOgQXNWSAQbo9EObgEFDY6Ifmwvi6gVLklqYZBfWU9CNoyJmFFuNaE13qwsus7BtuGUnSPZWGtOWSU1DgREya4TTnbjvEVN/onitJfAf4VIH1f07rA4rerJfmonWIbar+t1qkKt16HnMw=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: f3223c41-9773-49f4-6289-08d59db153ee
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0870;
x-ms-traffictypediagnostic: DM5PR2101MB0870:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0870E2E4FCEC87745E99497BFBBF0@DM5PR2101MB0870.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0870;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0870;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(39860400002)(366004)(396003)(39380400002)(376002)(199004)(189003)(53936002)(2906002)(6512007)(102836004)(2616005)(76176011)(14454004)(446003)(10090500001)(11346002)(476003)(486006)(107886003)(59450400001)(2900100001)(97736004)(66066001)(6506007)(6436002)(106356001)(99286004)(105586002)(3660700001)(6116002)(86612001)(3280700002)(6666003)(2501003)(10290500003)(26005)(8676002)(8936002)(478600001)(68736007)(5250100002)(5660300001)(316002)(4326008)(72206003)(186003)(110136005)(6486002)(7736002)(25786009)(3846002)(86362001)(36756003)(22452003)(81156014)(81166006)(305945005)(54906003)(1076002)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0870;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: N+OK/+86asFPU2BHGZk/JtfgfyjSUTLVKZK4KicVQxBttXH0QojBKXkomADcE8S9LXdezrw8Ogd319vER/ZiiVX6/FtXSyYzV54UVfIDNg69KLZXK0dTojemYia2fq0iVa0tCfYWJgFeoYD7rxa4Fi7BGHZiXqyfSM4GQNAh20adczi1WbGRlf/b0TOUID+ZPzo2e7R8nRHQyYMJIv8F7KvvtsRlXzpt/LcjsUqcvs4Y1QSXXp1MhBw/blVO8Axj2mZLztvkd8nRibljBLGtT/qTHQBCVZOU4Och6hZhRlNlu4M4geeCseJ4j6pHIUcFWSGvhxmzA8dek2UV0Z0Ye5bTS5t/o2Yyb0uN0ToWGu5uCu6zlkhjnkQJAJ2sCzo1Bf//eOBsBcDGrVjOujPsSNxk9Dm76f3yfTLs5WzNIYE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3223c41-9773-49f4-6289-08d59db153ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:31.8471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0870
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

[ Upstream commit 7597b266c56feaad7d4e6e65822766e929407da2 ]

current code silently ignores change of port in the request
message. This patch makes sure the port is modified and
notification is sent to userspace.

Fixes: cf6b8e1eedff ("bridge: add API to notify bridge driver of learned FB=
D on offloaded device")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: Roopa Prabhu <roopa@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/bridge/br_fdb.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 6b43c8c88f19..f32b8138f9c8 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1101,8 +1101,9 @@ void br_fdb_unsync_static(struct net_bridge *br, stru=
ct net_bridge_port *p)
 int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_por=
t *p,
 			      const unsigned char *addr, u16 vid)
 {
-	struct hlist_head *head;
 	struct net_bridge_fdb_entry *fdb;
+	struct hlist_head *head;
+	bool modified =3D false;
 	int err =3D 0;
=20
 	ASSERT_RTNL();
@@ -1118,14 +1119,25 @@ int br_fdb_external_learn_add(struct net_bridge *br=
, struct net_bridge_port *p,
 		}
 		fdb->added_by_external_learn =3D 1;
 		fdb_notify(br, fdb, RTM_NEWNEIGH);
-	} else if (fdb->added_by_external_learn) {
-		/* Refresh entry */
-		fdb->updated =3D fdb->used =3D jiffies;
-	} else if (!fdb->added_by_user) {
-		/* Take over SW learned entry */
-		fdb->added_by_external_learn =3D 1;
+	} else {
 		fdb->updated =3D jiffies;
-		fdb_notify(br, fdb, RTM_NEWNEIGH);
+
+		if (fdb->dst !=3D p) {
+			fdb->dst =3D p;
+			modified =3D true;
+		}
+
+		if (fdb->added_by_external_learn) {
+			/* Refresh entry */
+			fdb->used =3D jiffies;
+		} else if (!fdb->added_by_user) {
+			/* Take over SW learned entry */
+			fdb->added_by_external_learn =3D 1;
+			modified =3D true;
+		}
+
+		if (modified)
+			fdb_notify(br, fdb, RTM_NEWNEIGH);
 	}
=20
 err_unlock:
--=20
2.15.1
