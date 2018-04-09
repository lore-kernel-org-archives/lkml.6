Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523236724-2-10848240647693217976
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
    1523236724; b=Or9BBnQXnOjiVFf7w66czDQXYC26HuxeNhTUb860JnVS/C1d/z
    QOsoq4uSNgm9iHLlZh/z7E+PCPWUGfzq4D0mBXqeSK9WsWgqcXfC8N06ZbR8z6jx
    0o6buof/xBCQ/ctFngIKree6YWTMOLtIGDpzcbdl4+TjLlK6yQlWdUqD2PLW8QrF
    E6zMDlm6pd9UiovbV92jqtr4N6J8soDNeLG4ecP7feT3HvYBos3Upj3V1B/TYvBQ
    oAdGyouss1TmuTB4myIrzEl+965MPPCcxVJb8YQgajLgNjLWmcz7QxWjPvMcwAZs
    i7UkzweizfMIu/G9/NCg3zYqRqV0vmPZsnoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236724; bh=FpwpQUCiOs
    Tk001uO/SWqrr7F2xaxwF/r2h35n+++Bk=; b=R/bBCLkJnjEA8OBq7bDUeb9KJP
    KQqIhsGXecFv1KXN66+zrbRwIOmVreb9fb4EDoyOlW+fGAC9DPAw1jKb9CF4iuUF
    1nw8YH52nft3ST7qPJ09fKnWOWiJ013szykj0HJolas8JGkAejdGspj4dlz66TLd
    95g8ErBoWZNew2kolZnD6rTsyjOxIBZik6XcvEvGEG14EaCJYKeZMIPFHnbaD4Sq
    LJTqCI75y62HbZ2pVVoXzJSGDi3TnlXC9NTJHYPRqGnKSP8wbAqNa8e0vZbpNP/7
    yt/tFhBOcknirvpCqx8LfKTujYzG+QB//zlyvT1ZNXigZkKtYdLvHS9HnQ4Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NoXQ4sZ+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NoXQ4sZ+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEczOdkGJecR5hPvR0tjTHRgErHTlX5n7zXzZ1k15ZzqLE1R7R1Nx8WTp6/2fPGO1SZZur1K9su1Pny15DnuM4jQ5+HWTlVMLNAyAvkICJA7pWDOFM4Q
    jEqVYfUapmVE6yEXGyQVPGAA3EoLae/C1grFe7VFs8Bmv3TmkLNrlirNCgGRpwfoQqECa3sP6Mtn8fyRXTHUC3D9r9P/TCy0tY5l8OLrGqaLyzL+kHMUnzCs
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=CDq0vqnqAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=UMBYwGQvlmYUEeJxU3AA:9 a=nhD4a0yXulyws8as:21 a=ntMR2CejKxnIowcF:21
    a=wPNLvfGTeEIA:10 a=Xn7iXEen_xUG9zZOO_Hb:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754683AbeDIBSN (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:18:13 -0400
Received: from mail-sn1nam02on0135.outbound.protection.outlook.com ([104.47.36.135]:3040
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932841AbeDIAhs (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:48 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 100/162] bridge: allow ext learned entries to
 change ports
Thread-Topic: [PATCH AUTOSEL for 4.4 100/162] bridge: allow ext learned
 entries to change ports
Thread-Index: AQHTz5m/9sIKvCfOZUeo6xZuoYESgQ==
Date: Mon, 9 Apr 2018 00:28:59 +0000
Message-ID: <20180409002738.163941-100-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:TNLbFZImVv5QZMdqCSZzrvUaJTLKD4uU6xzuY+KE2JGNYKnP9869oxgAz+hsDfoaPLQtt5A/aBfwrZOIgfLelqqednyMC3cwSpMtd00AXhGCeBZTm4FbO8AQSbBC4+z5aARmrPEjc2dC1V6jw0Axm45SM79ePe4PvS7RdgpIcLS/DVabVbnpovC7YdFFZbQ/VoNR5S/RKoQRZyIKDq1PVktVwew6WKWm0ym0Ch3Iz8e8WsclFjO4MGmumWTjJRfJ;20:s9JsSFMSKoOyT/CajOlmS0Xgv7bSv/JiqwLa6a1mSKfMFeuG0ICmq2GMHGjdOLoOovtUv3MZOJ6IKTM3vh+izbVVeX8icIn4uQpK9DwpmOspcAZT6QfVHYzALsftjCozX45YLCDCNcS9A/8sdEC3GlAYFFJNsPbMU9mSgK9svp4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: bfc387cb-77fb-4c52-36e0-08d59db21c1b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10314CA82991C41ED595FFAFFBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(7736002)(11346002)(26005)(6666003)(86612001)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(575784001)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(59450400001)(110136005)(316002)(6506007)(446003)(107886003)(53936002)(4326008)(105586002)(6436002)(6486002)(476003)(6512007)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Wx+CiR3o7j0g3fQC17EJznT3Euy77tEAHGyD2vG06i4iGMwC1UFVRqQveUbBuoynqkLQY8YMpfkHP4GAYqhxkcmIMsfJ08tf63jcx0vzcrDxUfdgva3h35Jd2Ys98B0JqS5QWtA3R881YeH1JIr9V/7jG7A1kqIYuof+nRsyrll9Vj2mFb2K+otp5p5uXL8QmUYDtcuk6R1HKv74quCIt8OuS17Gc2TBpXgu0ptiM4vMyyg6CtE2RMFLGyBbYB6N0Y4Iu99Wb2MSmmYq5d6ugXL/ciwWslGkSqYASo4PW1wC6vPXGh1XqVUjpB8tesHZtrGmWXTkn/Q//38tPIsM7wyigqTrQGnmBgYnfPzLHykaBP5CBIHtsRBeXv9rXqT+Rodhd7OLPWX3rTxsUB8R9YnDXGNbX/ZSn7lZmdmbI7E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc387cb-77fb-4c52-36e0-08d59db21c1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:59.9741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
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
index 09442e0f7f67..50213ff8ac73 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1092,8 +1092,9 @@ void br_fdb_unsync_static(struct net_bridge *br, stru=
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
@@ -1109,14 +1110,25 @@ int br_fdb_external_learn_add(struct net_bridge *br=
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
