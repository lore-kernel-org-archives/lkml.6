Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520490924-2-5422303882301550276
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
    t=1520490924; b=jQN0GKSR4E7PRYETPkL4sr9j1rHPrK4dlbtfFjz7P2KeDu1
    bZFjxLY8nsG/HqIlDbOQuDajymW3JUsIMWM4jmYOkiCg9jAKb7jxLDNse+GppzPd
    VXchc36MWXCW43NgM1ExEcv+CEgvrIVbGRJG1UO3o2mY+OvLLG+n4uFMFp2ArzZ2
    oLgVcgZ2qEEoKknQC8Qs3ZO588Ej2JHbYYTH9Y5/M5ZTHAD+oeUVyUyWYUv23Qfu
    SVPo0YGH8MittZvKxbeJjofNMxuFMdYkh3Yq+74w+Dp2j0Dy4kdQV3w03XgdxBvJ
    K6q4QIFgUy6f0EHnwTFD49YZfqVSbL7rLz6LDKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490924; bh=e3dQbi
    92RMyy1c2PcXnZkvt9fmqvDHSEOJbTAqUrqbY=; b=DgmrENst4ajVr5WZo38Nl4
    RLmOOBueHETnf7T3NcaBJuLdF57y1oCV6lv+52UCg5F1uvE6txvFhvKYixdo70Px
    n26rnMyq9aq27F2gKInnm+sBLpTJXEplOleE9T0pEquZAuzHHCGLbXICGR0gfDP5
    +n5l8Y3vh7vF8jocAML1rL8vwsxVSdimql9FGbAey4QtX5JPjpvG20aiwmvFnsNF
    Mf90KPJGiN7axAfSZfyk+HbW7om0bD15yjV7XNjk2ZgPpkTaE4ZL9h5wz1isUZTm
    pYlOvya8keYKA/OV5+AJG1TCYVCTyoG2D9rVls7kf08AzQ+MA9Mso8SjNuFHBKyw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=d+DScBDz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=d+DScBDz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755341AbeCHGfW (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:35:22 -0500
Received: from mail-bl2nam02on0092.outbound.protection.outlook.com ([104.47.38.92]:59552
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965459AbeCHE74 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:59:56 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Yuyang Du <yuyang.du@intel.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 003/190] usb: gadget: dummy_hcd: Fix wrong
 power status bit clear/reset in dummy_hub_control()
Thread-Topic: [PATCH AUTOSEL for 4.9 003/190] usb: gadget: dummy_hcd: Fix
 wrong power status bit clear/reset in dummy_hub_control()
Thread-Index: AQHTtpokgoLEZfHIUk6oS7WTzwYyFw==
Date: Thu, 8 Mar 2018 04:58:47 +0000
Message-ID: <20180308045810.8041-3-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;20:TnZYRzNEnT1DnbBtmOZtkvsHBiDDQmdhbo2IE9whDJZGRrpo+L3w5y/adC2LHUyDUR0OcQcYgATSJ0L+m3lwMSvGqC/VAC9zzxIWt0uy/W9fDdpb4/11IgzXRiHpk0h1k+i81bb3yg0eh8H6GRf0x2XzFXFJU/6Bl/5Lc2J8IQY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6d0eee45-22dc-423d-bc3a-08d584b16d59
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09203FE059C9738161391C33FBDF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(35762410373642)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(189003)(199004)(81156014)(81166006)(5250100002)(8936002)(54906003)(2501003)(305945005)(8676002)(107886003)(110136005)(97736004)(99286004)(6436002)(36756003)(316002)(72206003)(76176011)(14454004)(6486002)(7736002)(478600001)(10290500003)(186003)(22452003)(68736007)(105586002)(2950100002)(106356001)(102836004)(575784001)(26005)(6506007)(86362001)(3660700001)(5660300001)(2906002)(10090500001)(1076002)(25786009)(2900100001)(53936002)(4326008)(66066001)(6512007)(6666003)(6116002)(3280700002)(3846002)(86612001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 5han2M3Sdr/N/PVKW9njCuu9zQNXCur6oufL2eTxi6XkJjt1V2dimgSnXftDlMj72VeyVpijuvVxYIYWGvbyXnP83xmGOfNNYsBAxrQr4sKshhNa4UP1ILTV5yz4nmj+dIP8LhTbTJOj/i/0wllash5E4koLbjdomErz3LtyaPQmKDdXC2auZK/Uve5oovOFwEaF16lgLy+OoK+l6begwvKSMcphBJ22UemZTtgwoeyKYApKuoUc4zLXVaItVh0S8qcOEjdCzawZxuyJv9seixVBC08K9fnDU2riBItqWWrWwXXBb/+718I6glXIkbvWQgubrtgjYGIFGoS2svjClA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d0eee45-22dc-423d-bc3a-08d584b16d59
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:58:47.6171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
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
