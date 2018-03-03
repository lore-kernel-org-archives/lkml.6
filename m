Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520120319-2-1253049624098662568
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520120319; b=s+fI+R3kAOrHV1ONIDT+ewSdH1Nh7l/27GQ86oYJNJg0zJk
    xhTdHuip5Ayy8zJoU6vGlKqVLAxAceAjftd0YbSfc1BHgiSj7d+a4v2B39yEQtIW
    7aXVL1E/CjaD76VukxF1j5SEGvq+xLCAKZkfem+yutqNubvEqIdBO8kwMjYu17KD
    kPr2nJm35d3OCTAI9j26vyU7U1dFMZASV+UsZwEfTPhn/KYxsYgIIleBpLA4Jjy3
    f3ClrlZqpsoMwqaukUUfriDkhXTux9MN7856hY5maW6aQcTGg9GXTdu1Fj3QNeak
    jvN73LS2dl0VFofF0UvS66fvL8i7O/YTTrwLA7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120319; bh=e3dQbi
    92RMyy1c2PcXnZkvt9fmqvDHSEOJbTAqUrqbY=; b=jhVkhEj53hFMOOHUE68Wgy
    fjtKLIIqMCigbBGtsL47QzCTYBolgqbsjGIk8U36u2lET3n7xoldAFoXOEgzDWe9
    eUVhNWqwflfQpFeiA7aLMOgzwgmGwgJJyYYBhBe5XDfq5fBUMnd7ePmSsd6RldPy
    k+xrQxWMS3GhvPa/QPB0+sEOB6tcLCCLhZBy5qas8/ofeO1L6aH/DsMnD/IYD5Ia
    gtRxbAJYJRJFEfN4JhtfihVimm2X+Nedks+ocydcbxhnWLWrXf/VSc4ON0jp1S+e
    U98K75Mmhy6UeFJMr/VF98/t4OAh5WoFlvzWmf3O9XylD4wl5VOG1KyjqdM6qA9w
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kpcct8A9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kpcct8A9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934095AbeCCXiD (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:38:03 -0500
Received: from mail-sn1nam01on0132.outbound.protection.outlook.com ([104.47.32.132]:20800
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934352AbeCCWfN (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:35:13 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Yuyang Du <yuyang.du@intel.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 147/219] usb: gadget: dummy_hcd: Fix wrong
 power status bit clear/reset in dummy_hub_control()
Thread-Topic: [PATCH AUTOSEL for 4.9 147/219] usb: gadget: dummy_hcd: Fix
 wrong power status bit clear/reset in dummy_hub_control()
Thread-Index: AQHTsz8TUwQDu1s0HkydiZITn3c6/w==
Date: Sat, 3 Mar 2018 22:29:21 +0000
Message-ID: <20180303222716.26640-147-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0924;6:HB41Oc4MUjLhLH+sQKNn24iGAMMA5M4zA/Cf7bCc8AHujy2y8jhLr+16o8JbujVNrtLCHFNQkb5OdjOm+Zio1cKuhBGZ6DvjRkAUlAAEGzZ1ugNSE8A/j9XNs5MRIP72vPLHjQTtFNqNJnK2G+V7UpJL4CfKDUz37zIfh/BXGr7faIU+P9f6ooj4/N3wYr8xNQQSQ+xLGCCNF/v7kvIEkt8HcyaiPOXZgI0hwLbKXJI8tTZ/CWIpuL46IqnnDj29aId1SKGnYBC8vX1eh9rESR0vfmSO1oBDAOU+ojhl8o7YX76LQxtYmvVw3Bij2wiso5IUJBQMQhiEDq5jZiPINH3MBqhNvppavbF/nJQtn+E=;5:H8yr2Xc0BQNKphDjklNXIhhvodBRw5kQw71erz0hSQZP5kiLEunuYztC6aY3NAKqVcbtOgMa6eu4pwqACb6hbiS7raOoNcMiRplzExT/yUk4muOj+t9Qi8DC5s/vGjA+MAtwrDGIQ9mLuM/dP0UTYT5eHeAXO8BpCmzX7nnsNHI=;24:RFSiuG7KHyCELkorZflpa38rJrDJtHjHzgi75T0noqXPG9TWLstgJ5l6u8AJchzWV/MwnXLq9l0iTmCYJvCACXA16Wd5RQtN4mTQUklTGAQ=;7:vT5zHKVl09q7uV8Ogv9URnNveEFJqa5KaJFertrBeBwKd2CSzzYnEnAcQJVaY4u/qNDlhvI99Rpgq5lza8m70dCCL9FzQpd7NTSGhirKYfmbxPX6bpaKD1Wru7TZ7TvHnh7TQrqdGjEFCBf1bcg3hdSXL4dKW/JJaZU3KQiYM0AYLHYxE1LyIDrz3rZCnRgiyo/OQ+duv9y9xmTKZ8q5cTLs/McE5s/lgApq5NLqw81qML34USHTzhOTULZaBQia
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1c101659-80a9-472f-f011-08d581570056
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0924;
x-ms-traffictypediagnostic: MW2PR2101MB0924:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0924230F385CE8E1A56752A6FBC40@MW2PR2101MB0924.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(35762410373642)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0924;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0924;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(366004)(39380400002)(189003)(199004)(102836004)(2950100002)(10090500001)(6666003)(316002)(26005)(186003)(25786009)(2900100001)(2906002)(54906003)(22452003)(110136005)(97736004)(6506007)(7736002)(4326008)(305945005)(5250100002)(86362001)(575784001)(2501003)(99286004)(68736007)(72206003)(53936002)(6436002)(6116002)(3846002)(5660300001)(66066001)(1076002)(76176011)(14454004)(36756003)(3660700001)(6486002)(86612001)(81156014)(8676002)(81166006)(10290500003)(6512007)(8936002)(3280700002)(478600001)(107886003)(106356001)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0924;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c101659-80a9-472f-f011-08d581570056
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:21.9007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0924
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Yuyang Du <yuyang.du@intel.com>

[ Upstream commit 9f20dfb44d03745d0d3cef2ffb3abf8d8024fa61 ]

This fixes the commit: 1cd8fd2887e1 ("usb: gadget: dummy_hcd: add
SuperSpeed support").

In the case of ClearPortFeature and USB_PORT_FEAT_POWER, simply clear
the right bit regardless of what the wValue is.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Yuyang Du <yuyang.du@intel.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/usb/gadget/udc/dummy_hcd.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/du=
mmy_hcd.c
index b62a3de65075..ff4d6cac7ac0 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -2103,16 +2103,13 @@ static int dummy_hub_control(
 			}
 			break;
 		case USB_PORT_FEAT_POWER:
-			if (hcd->speed =3D=3D HCD_USB3) {
-				if (dum_hcd->port_status & USB_PORT_STAT_POWER)
-					dev_dbg(dummy_dev(dum_hcd),
-						"power-off\n");
-			} else
-				if (dum_hcd->port_status &
-							USB_SS_PORT_STAT_POWER)
-					dev_dbg(dummy_dev(dum_hcd),
-						"power-off\n");
-			/* FALLS THROUGH */
+			dev_dbg(dummy_dev(dum_hcd), "power-off\n");
+			if (hcd->speed =3D=3D HCD_USB3)
+				dum_hcd->port_status &=3D ~USB_SS_PORT_STAT_POWER;
+			else
+				dum_hcd->port_status &=3D ~USB_PORT_STAT_POWER;
+			set_link_state(dum_hcd);
+			break;
 		default:
 			dum_hcd->port_status &=3D ~(1 << wValue);
 			set_link_state(dum_hcd);
@@ -2283,14 +2280,13 @@ static int dummy_hub_control(
 				if ((dum_hcd->port_status &
 				     USB_SS_PORT_STAT_POWER) !=3D 0) {
 					dum_hcd->port_status |=3D (1 << wValue);
-					set_link_state(dum_hcd);
 				}
 			} else
 				if ((dum_hcd->port_status &
 				     USB_PORT_STAT_POWER) !=3D 0) {
 					dum_hcd->port_status |=3D (1 << wValue);
-					set_link_state(dum_hcd);
 				}
+			set_link_state(dum_hcd);
 		}
 		break;
 	case GetPortErrorCount:
--=20
2.14.1
