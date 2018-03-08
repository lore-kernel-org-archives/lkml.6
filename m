Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520488056-2-10151803054781306984
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520488055; b=rK/U1Xm71HUXowaKKsd9MSTddrmVl5gBiLv02vfdrHG9b4s
    UoZh/rUh5Ovez9GM+Uq3j9tL5L7DRCkgX9vMzJzqRYr+NxZTGcQoiHj6KjF2pqZk
    gKRP8LVWKaKV1CwxFthztrzHx2sc4FAGtfvZDz+3SK8aSlnJckXPJoWzmQCgXB8p
    4B/55viOcqmUmqDHLdWoPin5vDLnmeUo7X7rq6nh4cT45xI1tY41W/K3xw+jL/o/
    fB1jCduwYze5J6C5PiOWUjZUuS4Ouh54HOYGylFLddOzRtdcc4TP5umb5I+RDQwF
    fSZNa+apAwKF+hD30HtfTQyvE8bbilJ9Kf1fOmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488055; bh=XrsSbC
    II64F7HaYTCdxwxN2JfZNv8DdnQyM8wb4fXmY=; b=dRFwJ9T5dnAimRDgMNIZEB
    +Mf3kFrD+vWkqvflQJTFqZJBj+k4djmg5dpXJbjpRWOD6NrJYYPZe+Njrh8qKnbs
    V5iLreZ64cRiHPdBie6AcAu7dFNsf3H9nrnMt5/YWsbs5o0e69PWCh+tTgkXUG+b
    5YDV+4r0Y+vzd8n5Y3I51nQerlmMGKR8ZpCLzfKe+ynmZpnt+KNE2UJB+U/OfeuZ
    AcXqdPGSBPO13prZUk7d2Xb3uCI0/2n5NwpRZLz8U8DwgDDz9eRxtnugfWRLkprY
    WypUaojW2LnEwKoaJ+OA5gnHzTYwAxKEac4M6N8VsX5lpXlFrCU+pGTO9SDEfaFA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HcXDPg3N x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HcXDPg3N x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966181AbeCHFrU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:47:20 -0500
Received: from mail-by2nam03on0127.outbound.protection.outlook.com ([104.47.42.127]:45712
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965817AbeCHFFI (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:08 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Yuyang Du <yuyang.du@intel.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 002/101] usb: gadget: dummy_hcd: Fix wrong
 power status bit clear/reset in dummy_hub_control()
Thread-Topic: [PATCH AUTOSEL for 4.4 002/101] usb: gadget: dummy_hcd: Fix
 wrong power status bit clear/reset in dummy_hub_control()
Thread-Index: AQHTtpp4GkxE+YiM7k6LJmcgwCjYnw==
Date: Thu, 8 Mar 2018 05:01:08 +0000
Message-ID: <20180308050023.8548-2-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0981;20:wsb/FLVr7AhE+cYvzaarpV3P4BeZRByzguf1Iy9Ax6KVThb43JR+wyxsxC6cCt+lUXWoRDUf1vRWnchaYUuYZK+AigfI7J+veZYG9NqKl69FpSFTkLpXqeRfxx3xkEdZR+asMOMlLoq/o8ChV38aM65epvGDAwGyryTlUTQEi44=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d7710f9e-63c7-4d5a-835c-08d584b226f2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0981;
x-ms-traffictypediagnostic: DM5PR2101MB0981:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0981FCBFA60ACB9824B7C535FBDF0@DM5PR2101MB0981.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(35762410373642)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0981;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0981;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(305945005)(86612001)(2906002)(7736002)(6486002)(36756003)(54906003)(110136005)(6436002)(2950100002)(10290500003)(316002)(186003)(22452003)(10090500001)(478600001)(105586002)(6512007)(53936002)(66066001)(68736007)(76176011)(102836004)(3280700002)(107886003)(25786009)(8936002)(106356001)(6506007)(5660300001)(3846002)(97736004)(14454004)(2501003)(26005)(5250100002)(4326008)(3660700001)(86362001)(575784001)(6116002)(81166006)(99286004)(72206003)(2900100001)(1076002)(8676002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0981;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: X6Frxr/QPF+CVgis8OCW3r1Vo3kn3l14BrQhNuNRw1hxUTypqGR+UYqq579bn60OnE6jjpevEGSnu5L6nbOmrM1Qd+VgvKgbM2Lz/2DSzCPLh8v9uw37mpTQQUYqcsYxeSJu6Rk7v/q9f5VGGYNNNcGlqDzz8dU69R3o0HS88+/qpZ7qBhX/fcUPZRRVCZJKdRBBH50vUNWQeUzK7cG2PI/et1fHHA05dMFXkOfWR6Br7FP1mieuMtc6L4FKUcUR3OAr0IRWHnwwcJj2dBN1nqKpc7/wTTRLkwgtJzH2Ovu4xQcK29pCaJeUwSEyWVUMYz5P6UeSXrF/zdjIuIXipA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7710f9e-63c7-4d5a-835c-08d584b226f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:08.3357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
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
