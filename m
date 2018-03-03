Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520118616-3-1359077948796152923
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
    t=1520118615; b=wvpbIiTTpYK+HhtzShTTzX1CoGnDIgFMJ7ReP/IKnaq2xwc
    8xCGd5iZVzSMj0bxW22KX7H0qnhvoS2U/trcTLzgvvhRLmqApqLUBykQi1cNWZcX
    VDKq+rIdZgRDtf2wVH2o6JilxfnAj/uGmwBfxcji2zHWJ9pxNKc57e8DW1ec/wLJ
    bwffAvBowygxyw2mkPvs8tl3UZAletrpnyXqhIqWPqgk0M91IS6XHyFczCVIqQDz
    zjHNrlVy2f88JILniMFt1b0E4j4zf4JPDQ7fz/b/IvHYNAWI1ye+BwoaVszSrl84
    2NoVrqE/Sg3lj0gWV+hjfZmYKc6jVykCld+KNfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118615; bh=XrsSbC
    II64F7HaYTCdxwxN2JfZNv8DdnQyM8wb4fXmY=; b=q/mhTG9IjZ7Qim3/E4Oqri
    27vOTVUuOOrYhM1EQm2zxXqFAcx8HRuo683NAYTTYhZ0eO/wpNvi35jieVe9X2ev
    QF/Pz29JDKmYAWbf6og+UNiZl4wnK+YI/DyZ6vJtd9BYA5j73GIfpbtzTNHja8EC
    /eubH0BUdGBb1c94MumA79w52b5h/VKoTl6v+8MdMOdM5nAAxtsy+5zYt8A2QY1e
    IlhYqq3wUcemo+TU3uhD12seCkrdl+eTLev+HehDWkgOVJvlafwh8CQQQW5kfNcO
    PGJvhiGSbLXKzVsX5aL+DLoKwTxvkdRXMp/FunSCNJv5j/hs2bbzJYhi9t5JrAcA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HS4FGUQQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HS4FGUQQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933473AbeCCXHY (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:07:24 -0500
Received: from mail-bl2nam02on0124.outbound.protection.outlook.com ([104.47.38.124]:62688
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935164AbeCCWkH (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:07 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Yuyang Du <yuyang.du@intel.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 074/115] usb: gadget: dummy_hcd: Fix wrong
 power status bit clear/reset in dummy_hub_control()
Thread-Topic: [PATCH AUTOSEL for 4.4 074/115] usb: gadget: dummy_hcd: Fix
 wrong power status bit clear/reset in dummy_hub_control()
Thread-Index: AQHTsz9hFZm9phX4uEyucdHbizKwvQ==
Date: Sat, 3 Mar 2018 22:31:32 +0000
Message-ID: <20180303223010.27106-74-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1033;6:ks4fceOlqS2p763YfZ9aG1JrBCKWBX15q2jtMUjKFtKVn/v5vXHZ5La/3A/GsZ+bIykGACSQ5YMKBxO4XxKIGJtF0QnP4tm8El4ZWtr7WooGH9BLno7G9DemS5N6/BpABwFwZMrpdVi2jkUam5a4N4OBw/20dYl+8p/2LfIY2rpPFuJpMwFeHWYu1WE3yrRHYolkRmHSxj5M0yhyeOjgphnhBI8zyYD9fWKVqtb1afrWWlIOWKrw7DGUgdQK9/+e93io2eOXmpiUBofHn/NRwYJ2ztqN2rKZeul7PoeQx8GcPj8LeIHKALqSzfM0DlGneG817Qi3NJDnlp4gaa0PygdU+icBRRQSEaQXFfepAXc4oBhhVD36ot46ykJvjFyU;5:zVuPok8aR1Egjacf7gUcKl/4o5a23Qf1MC5uVOj3NdbdbMUYFfeJwbcpzy6Q/wZNoW+Jr8wE3wIvS8k6gqvictbhWAlE5R41yPD68Nvdzw77albkT4R8ewojmW6Z5YPNn7cVF2Mf53GwQAyYhocA8328PWl1Y/IBIV8kqGATzaA=;24:ePPLmqjmBfeOjw9uyHpwqi7oTk7YdYIWU1WAjwCcJX3KHrp6cYXCGr44bzxFkAqoyi/4LJvy1SZoI1dQ/x6S4z4Fh0/Y7aeJSu7bSC3oJYY=;7:sZaApcp18Gp+WSH+EO3Ryarpv18/0Fq4G6diPrOlawAz1cxEpRnkTIcSrrK7ql7a2Bm9G0jmfQpsrI11U08u7XLucRDW/lD28dfgJ0HTg2oBc8AClmUW3Li7eP3f1E6DDdhQMXR9ZLZby1wqoTlJXstF9tvQlwQBkk4lkCKA3t8KiUVBU7MP+QxtYOhY+TnnocIRCtu2orkraEwX0W21ZWxtnW9IUP/Vy8M0K13jYhmFa2IgTPN4j1QBpeKooNBY
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 48f8e123-1523-4af8-d6ef-08d58157b291
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1033;
x-ms-traffictypediagnostic: MW2PR2101MB1033:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB103384FEE42A3F80DF83BE3EFBC40@MW2PR2101MB1033.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(35762410373642)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1033;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1033;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(366004)(346002)(396003)(189003)(199004)(3280700002)(3846002)(316002)(6666003)(99286004)(110136005)(2900100001)(54906003)(2501003)(10090500001)(53936002)(5250100002)(106356001)(76176011)(36756003)(107886003)(2950100002)(6486002)(22452003)(6512007)(6436002)(575784001)(86362001)(6116002)(1076002)(6506007)(2906002)(68736007)(102836004)(4326008)(97736004)(186003)(478600001)(72206003)(26005)(3660700001)(8676002)(25786009)(66066001)(14454004)(5660300001)(305945005)(86612001)(81166006)(8936002)(10290500003)(105586002)(7736002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1033;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: TsfHRQl13M/qOvTQwNnutPrrFiLLpGBf5hNq+fRZ110ns/zRq38T28s7uezfRsPFne82cWpIEPRHJTvNy2htNeSC+fVl0usS+Wt58YP68HYFZLWp4USf7Q8gWE8PAhdBvj2jSzJvgu2PgZQ7BtBNnu8/Ykk/HTtxY+5jXsfFaJg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f8e123-1523-4af8-d6ef-08d58157b291
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:32.6665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1033
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
index 8080a11947b7..eb876ed96861 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -2105,16 +2105,13 @@ static int dummy_hub_control(
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
@@ -2285,14 +2282,13 @@ static int dummy_hub_control(
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
