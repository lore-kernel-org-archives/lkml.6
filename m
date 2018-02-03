Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517681902-2-5870135444153137872
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517681901; b=D+1yciIO7e5/FLljLIyvrpCHyCOex5Sh7wLZjWT8yYn3EQe
    A1JBlRMYqTBZR3OibRjJG9xrSCZz4SYgi+Ir2QFZ+jiW1wTaeq9HvBgkVhnN6iqc
    HrUEuiQ37/nm4xoGwvOWL6fzTLAZBWizcvV/M95nHBsXNzbuj4h4mjTVikVxGoou
    n6E4+P7JYOqhqY3x/sBr9rKcFS3C02yli2d0+1b5vmI7mJkLEyjnlIC3Bc6CfIuy
    P95nJhy8FLBmo5YtNbQUcgQjh+LTyLRcCSHJS2uVkgw0/D3tpx3R6YrWByopoC7o
    cyE+W4P2XsLSKh6LTBnAyOToEYwZ5n/MvwOm/kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681901; bh=/jNjAm
    niXexzqUjhT+M0nwUEUUmTbDorRtI3Ca0WuXA=; b=qlU50VN6VC6WggNecjMLpp
    ke7tp0KaBFwabcFxQaHaLyaR5oMwn/Z6whNF8SUeLfaJhYG6hK+YcoBCCspqmrf4
    7fjtqLSjVb6tk2HGoGcxg3Ocy5uPWPPmp3HzBM79ZIUuI/MqEmpHwE+mPgvshwDw
    Itci8KpA+9Ld5gmEnJ1sYBNKD+rc7uysWCXRxCJvsavnLvpZNpVlvtD5sU1bFWXC
    Mda7dWQHBcpc7FjWYNdwV79u4F94CWYiWZKYexpfBgxf2Nu7+2jwvQgMgekYZ8Zp
    Jd24qJXxZg3B/juzMyX09Mh5XtexWF/EDn1nFNmsUwur79TwHvxpjzfxyeA9/hFA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Wg3cizta x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Wg3cizta x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752976AbeBCSSR (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:18:17 -0500
Received: from mail-by2nam03on0126.outbound.protection.outlook.com ([104.47.42.126]:45078
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753516AbeBCSGv (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:51 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 12/32] tg3: Add workaround to restrict 5762
 MRRS to 2048
Thread-Topic: [PATCH AUTOSEL for 4.4 12/32] tg3: Add workaround to restrict
 5762 MRRS to 2048
Thread-Index: AQHTnRlwePRTYvT+MEmy/TfaUBM6Nw==
Date: Sat, 3 Feb 2018 18:04:30 +0000
Message-ID: <20180203180413.7438-12-alexander.levin@microsoft.com>
References: <20180203180413.7438-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180413.7438-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1089;7:QMVYIXJNHytQ63l5ub4Q/oNxDobgcwe9P1H6HA08ZV6fD3Ama0FxAfGUtPckXsEhDbatkGgGXNXmGSYPt0Fn+UQpiFSdqm7hscJlKOs99gWcydk3ABFSs4oLHHSjKh6ODqzVh5U3/Wp4u2O1Uq3urHCCS3xD3WCgBPCO2FYOk2IjZqH2eBui/Q84PeKBHunacxGMoWyr6D3BzTdN6fGxKefFK4U52ESuaL4WEKMU9x4c+wJ97Dqo3BYAmH8ZY6XG
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 375203c7-9456-4421-69ab-08d56b30ba4c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1089;
x-ms-traffictypediagnostic: BL0PR2101MB1089:
x-microsoft-antispam-prvs: <BL0PR2101MB10898E9570FE51B2A3AFBA4DFBF80@BL0PR2101MB1089.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1089;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1089;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(39860400002)(376002)(366004)(346002)(199004)(189003)(86362001)(575784001)(106356001)(22452003)(4326008)(97736004)(25786009)(6666003)(2950100002)(5660300001)(2906002)(81156014)(105586002)(3280700002)(8676002)(8936002)(6116002)(68736007)(81166006)(3660700001)(86612001)(2900100001)(107886003)(3846002)(1076002)(102836004)(26005)(6346003)(66066001)(10090500001)(76176011)(6506007)(10290500003)(186003)(6486002)(14454004)(59450400001)(6436002)(53936002)(72206003)(316002)(305945005)(7736002)(99286004)(54906003)(110136005)(36756003)(2501003)(5250100002)(6512007)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1089;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 2H28VcBesEVFikil7ahc5ls6wAuDwIgZzRl6RDu17DxJpjx9fwXtkCIGIFExIn+o4J41a4AHhfe+UmVaYdJsmw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 375203c7-9456-4421-69ab-08d56b30ba4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:04:30.4714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1089
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Siva Reddy Kallam <siva.kallam@broadcom.com>

[ Upstream commit 4419bb1cedcda0272e1dc410345c5a1d1da0e367 ]

One of AMD based server with 5762 hangs with jumbo frame traffic.
This AMD platform has southbridge limitation which is restricting MRRS
to 4000. As a work around, driver to restricts the MRRS to 2048 for
this particular 5762 NX1 card.

Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 10 ++++++++++
 drivers/net/ethernet/broadcom/tg3.h |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/bro=
adcom/tg3.c
index ab53e0cfb4dc..1594dfb2fa92 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -10051,6 +10051,16 @@ static int tg3_reset_hw(struct tg3 *tp, bool reset=
_phy)
=20
 	tw32(GRC_MODE, tp->grc_mode | val);
=20
+	/* On one of the AMD platform, MRRS is restricted to 4000 because of
+	 * south bridge limitation. As a workaround, Driver is setting MRRS
+	 * to 2048 instead of default 4096.
+	 */
+	if (tp->pdev->subsystem_vendor =3D=3D PCI_VENDOR_ID_DELL &&
+	    tp->pdev->subsystem_device =3D=3D TG3PCI_SUBDEVICE_ID_DELL_5762) {
+		val =3D tr32(TG3PCI_DEV_STATUS_CTRL) & ~MAX_READ_REQ_MASK;
+		tw32(TG3PCI_DEV_STATUS_CTRL, val | MAX_READ_REQ_SIZE_2048);
+	}
+
 	/* Setup the timer prescalar register.  Clock is always 66Mhz. */
 	val =3D tr32(GRC_MISC_CFG);
 	val &=3D ~0xff;
diff --git a/drivers/net/ethernet/broadcom/tg3.h b/drivers/net/ethernet/bro=
adcom/tg3.h
index 31c9f8295953..19532961e173 100644
--- a/drivers/net/ethernet/broadcom/tg3.h
+++ b/drivers/net/ethernet/broadcom/tg3.h
@@ -95,6 +95,7 @@
 #define TG3PCI_SUBDEVICE_ID_DELL_JAGUAR		0x0106
 #define TG3PCI_SUBDEVICE_ID_DELL_MERLOT		0x0109
 #define TG3PCI_SUBDEVICE_ID_DELL_SLIM_MERLOT	0x010a
+#define TG3PCI_SUBDEVICE_ID_DELL_5762		0x07f0
 #define TG3PCI_SUBVENDOR_ID_COMPAQ		PCI_VENDOR_ID_COMPAQ
 #define TG3PCI_SUBDEVICE_ID_COMPAQ_BANSHEE	0x007c
 #define TG3PCI_SUBDEVICE_ID_COMPAQ_BANSHEE_2	0x009a
@@ -280,6 +281,9 @@
 #define TG3PCI_STD_RING_PROD_IDX	0x00000098 /* 64-bit */
 #define TG3PCI_RCV_RET_RING_CON_IDX	0x000000a0 /* 64-bit */
 /* 0xa8 --> 0xb8 unused */
+#define TG3PCI_DEV_STATUS_CTRL		0x000000b4
+#define  MAX_READ_REQ_SIZE_2048		 0x00004000
+#define  MAX_READ_REQ_MASK		 0x00007000
 #define TG3PCI_DUAL_MAC_CTRL		0x000000b8
 #define  DUAL_MAC_CTRL_CH_MASK		 0x00000003
 #define  DUAL_MAC_CTRL_ID		 0x00000004
--=20
2.11.0
