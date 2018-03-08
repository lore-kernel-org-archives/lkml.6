Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520486414-2-8966739157549890173
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
    t=1520486413; b=pGxsDSORyRjsByCGdZ6p3sce0AMLNZXDaM62lKWruUdNT3y
    urTPPfnW4yBLSsMkvOnUiAtNKUIdg5ldlpXgjEBS8QEZtZ0I5Es+E1CTsTsmVPSM
    Dqaubcim2UgImWwFWaQXF8CMNnH4Urc0CBh1Ftb3efKLSLKJqXAVAVCBq44cfY5T
    PnECK5tAWsybrofRjeVQflOeELCfeVZ19B0Kg0zldYZYoO1EovBeIm9fuvMLrblD
    6XxFKRjGCQ2lhFU8yxnFnMxCiDMXBwP/A8bbx4Zu7zmo+SXt+p5prfmPApFvEZ4a
    woizahaNf+HS/Oc8pQcS33IJAK34C5IV9rfH58Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :content-type:content-transfer-encoding:mime-version:sender
    :list-id; s=arctest; t=1520486413; bh=/uUNOakKj/II4KAwwEfer+Oyyi
    QmVqQDHtDFOLBWejE=; b=DfcwP2oNtROPaiHlOlg+IvGI4jIwVtsXOtYH5TNZoX
    QpOF14JdCZaG5KATdQnUphpiJrSxeA3ktRMrnntaBbgkfHmBBkh/zqm6jbC/H9e5
    ybG+ks09TKdEwN87qF4/5r06WAkM93Zx2lX1b1gcemX/KEB8H79WRTLTux4ZPFoW
    vUKfDxVRQZBAcDqQOzGDE9ISzErlMFFSG0A1F6Heq1MXnBHUFjlR9PkZIG6tfXp2
    4+gl347IXU0PnKPYTOgkGDfBN0o9ZpqVr316T9q9UTDkX+zYahipILbTDDiEG1uJ
    v0jZo8MhsNnX7Oa4evhyMJUhSpt/jk/wxzn6F5OSy+Dw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kxtmsEUV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kxtmsEUV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966708AbeCHFII (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:08:08 -0500
Received: from mail-bl2nam02on0136.outbound.protection.outlook.com ([104.47.38.136]:43456
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966697AbeCHFIH (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:08:07 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Yuyang Du <yuyang.du@intel.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 01/53] usb: gadget: dummy_hcd: Fix wrong
 power status bit clear/reset in dummy_hub_control()
Thread-Topic: [PATCH AUTOSEL for 3.18 01/53] usb: gadget: dummy_hcd: Fix wrong
 power status bit clear/reset in dummy_hub_control()
Thread-Index: AQHTtpq+uO6dDaGuukSwUDxeiOCyDg==
Date: Thu, 8 Mar 2018 05:03:05 +0000
Message-ID: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:TKI3ATCJgxF52FEBVp8PNOa51Q6FHFNDMfS6mFz/wm4cY6ufhOmkKhdEXvl1UUjogGwEME81dueVCEUWqJx0LZBlBbru4M6YxxiVWfYdHlN0zbzn2Zi7LkVJaUpoxew04y0iGQTadNGMQmXMv6KLIlTNwvzChaBX4+LbRjA0+vLbTcSWYCzFHtKNms8VEJ92iiEKnO+pVpwKhmaG/r6ycp3lzMixtrIiJ8y/UhdemAHPci/X8kucUWAikSQRtvri;20:F1wONg68Uv7FtDqqleILRdTirX9W/xbwqnA+Vv4qxz3bOaWSJAT2yNtN9gwQXFs/trYxOnAbSHv4qQea/7To2pi26asvC0V/nvN+4s655GUUo92yza2WBWNJnF80kMOFPD8hqXz0N1A13SGEvNpMkaYyj2R49t3/i03BIXR3trI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2b90bd5f-5346-4540-1874-08d584b29066
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB072728E9CD896E31A891436EFBDF0@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(35762410373642)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(4326008)(97736004)(105586002)(2906002)(8676002)(26005)(10290500003)(186003)(110136005)(22452003)(7736002)(54906003)(25786009)(3280700002)(305945005)(81166006)(2900100001)(8936002)(102836004)(6506007)(68736007)(106356001)(10090500001)(1076002)(6512007)(86362001)(3846002)(2501003)(14454004)(478600001)(99286004)(575784001)(72206003)(6116002)(3660700001)(5250100002)(53936002)(107886003)(6436002)(5660300001)(316002)(6486002)(36756003)(86612001)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 5QxKTPypJ+c0kgX/vuyI5PWK0AXAGAUx1CU0cdHRcSw77HiuJZmjcQVjb7QnBlj+44YKzisDtXTrL83mqAICP9W90KuPfXZflmWUoUR2cVy+v6KwJdC3+ZZEH3t1JlpuJT67fJ3i0yAUbsi6uLiutEyM/lAShIZO73taSPkKPr9MPig834a3lwAQseOxIMAssEfF/Njp4eZBEOv1YoU+AevK7Q40ihyGWH/AhGc9R8KuwARNY49sPdv71BEcBZ3PDjmz2/u4gfe/1V4KdNuTXj6ObD5F6JBAl4MUvYFmK/Y/WUePtTF/1N4iL+Qg0pYTF6vvOSBAEiOlezi+2hmVdw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b90bd5f-5346-4540-1874-08d584b29066
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:05.3586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
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
index 783715a9e399..215441690d32 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -2001,16 +2001,13 @@ static int dummy_hub_control(
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
@@ -2181,14 +2178,13 @@ static int dummy_hub_control(
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
