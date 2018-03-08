Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1282308-1520493198-2-10883717056723587883
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520493197; b=VuYjM3n3I44idMHK2e0F3+yg8ktR/DMu8wo55Gs1pbcz2j5
    hVDT+wl5IhW2KMtJRrWMBSVEWc+vYgZRUJx3iOAMH/L7wjcfCrh4ohzwRmpx2MIh
    XZ/YEF5sI5lYXKb19b+JD3/YCrgY1b595gwSoQGPIr2X/ZXSr7rY6834xVaaAAUH
    RK1/vKqwcupImYUnIgIebWKyCdSpJN15cX/jH2rVOoLDCyvKjIgpINlMWadEjnAG
    uyqwZGGVNArXPM7PlALCJVoo6tHXPjk30Qurjy9/4+TAGDrKntDSbLOtwVYj2zQy
    i4VCjZ8XPsTnzXqyNNNkefilgIISFvuTDRGjzQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520493197; bh=AHGEzA
    m8jh98t7+3dDyHsN00jLfrtg1Y5dTsFqcz0Q8=; b=hsnhu1j4k6PZG2CrRR4yYL
    QzM6DCBD7zB1EyiHEX6bL+sK7cKXGMzxwAEuNyCTSI2/TKqq/deG2A3j1a4ylXPZ
    qdN9d/1rQe/m0F2iBoj94wf59O6d0ACi+2o0kXIrpGQqRIDZCPiy9RxzU/da1rJn
    G3EvVCdNBCBOOZWudLeFKOcbeYSSTjYhW8CHfJwwvID2rV2Ud+p51De9g+Y6zt5S
    wGatepQCfGH0aq1dLh6cW5HQct7EqLw9M4pS6MrjEw4v2cDHYIeyGKZ+XNpc6YkL
    MFmlhhevq6/4AbD1Ir3dVablqOTWFjO4b2SQvrNaSLv3c1hT92SOTrzpKEaSZxWQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PUa+Umer x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PUa+Umer x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934752AbeCHHMB (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 02:12:01 -0500
Received: from mail-by2nam03on0095.outbound.protection.outlook.com ([104.47.42.95]:43489
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755024AbeCHE4H (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:56:07 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: David Lechner <david@lechnology.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 06/78] dt-bindings: net: add TI CC2560
 Bluetooth chip
Thread-Topic: [PATCH AUTOSEL for 4.15 06/78] dt-bindings: net: add TI CC2560
 Bluetooth chip
Thread-Index: AQHTtpnCU/eWup6AO0OdALSMBe4V9g==
Date: Thu, 8 Mar 2018 04:56:03 +0000
Message-ID: <20180308045525.7662-6-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:jbejWAY+cLJ4GpBNKK6ZqiO9MM9WIxKanHDunvufpvH4PQMMB3Q4zTd1b3xyLPDle0cGlsCtsLSgymrjpok4uQmwxHu2vtWUtOWIbLaTo6YdBNgWd1pTUMmlMnGPEJ92MqjER1oo4W9AcuvrtOWoaYwm13bOiJLKz33n1ZrtLPrErkCkNBj4S9mCGEOoU7hEcICt4tw3qK8j9diQTMURszOM0d8kDtRXfNctEstFtCiEyUGLiR6eonFwFm1AWmUP;20:IXn8MhAb5feaSb67T36U5A6WcoVUBWvM5RGp+gHOVbRXw+P27hvA0vmZl6/Vpf8EBs6pQggUUDSXRy+U2W0q9RIGhDYIPCVrbrLG6g+0F2LQadwaQCiq5YO+j6nofk0cG3e0XKxtzOXcKSOV5AzjyVbYW780LWxa4KL+IkUP/Cg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: af8e8732-60ab-47c6-c2fd-08d584b0e50e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0902880F8F4E51F6838717DEFBDF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(376002)(366004)(396003)(189003)(199004)(8936002)(81156014)(81166006)(7736002)(5250100002)(8676002)(99286004)(26005)(107886003)(186003)(2950100002)(106356001)(10090500001)(5890100001)(575784001)(305945005)(66066001)(97736004)(2501003)(86362001)(3846002)(3660700001)(72206003)(6436002)(1076002)(6486002)(5660300001)(54906003)(110136005)(68736007)(53936002)(14454004)(36756003)(25786009)(478600001)(10290500003)(6506007)(2900100001)(102836004)(76176011)(6512007)(22452003)(6116002)(316002)(4326008)(105586002)(86612001)(2906002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: nt+oy+Rlt0wamDTdXg+F0KufRe07oiLwywZy6ZcWUdpSEl6JMLx6NjPKo1sJ2Zm3TtNhs9kKQCW9zflQQ6QVsMIK3pTAFQOzGdUSii74GTm2NpkNANnYuylGD2GB6QRLJJdAq1gBImzygp+Dc8pKHR6phnsgAr3hIGV1qiVja/otVFOGz2ziU/8neS+j90G5sbsZk2zqf2ylcYsQpSwSKc78NG2qeN11cjbQWUwhLmTBpEldqoMGhRSmN7cocl1IaCKpjp9CSTz3S5PegaOpHCYbTK2rsWjuoxOwsxRSO9Ky6qmcIVAEC8PzP5mVjnuiBfjstHJxBkRp5P65/Qsbww==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af8e8732-60ab-47c6-c2fd-08d584b0e50e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:03.1821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: David Lechner <david@lechnology.com>

[ Upstream commit 07c7edd0db441f83eeee087470add5be280cc018 ]

This adds a compatible string for the Texas Instruments CC2560 Bluetooth
chip to the existing TI WiLink shared transport bindings. These chips are
similar enough that the same bindings work for both. The file is renamed
to ti-bluetooth.txt to make it more generic.

Signed-off-by: David Lechner <david@lechnology.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 .../bindings/net/{ti,wilink-st.txt =3D> ti-bluetooth.txt}     | 13 +++++++=
++++--
 1 file changed, 11 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/net/{ti,wilink-st.txt =3D> ti-blu=
etooth.txt} (75%)

diff --git a/Documentation/devicetree/bindings/net/ti,wilink-st.txt b/Docum=
entation/devicetree/bindings/net/ti-bluetooth.txt
similarity index 75%
rename from Documentation/devicetree/bindings/net/ti,wilink-st.txt
rename to Documentation/devicetree/bindings/net/ti-bluetooth.txt
index 1649c1f66b07..3690732750f0 100644
--- a/Documentation/devicetree/bindings/net/ti,wilink-st.txt
+++ b/Documentation/devicetree/bindings/net/ti-bluetooth.txt
@@ -1,10 +1,18 @@
-TI WiLink 7/8 (wl12xx/wl18xx) Shared Transport BT/FM/GPS devices
+Texas Instruments Bluetooth Chips
+---------------------------------
+
+This documents the binding structure and common properties for serial
+attached TI Bluetooth devices. The following chips are included in this
+binding:
+
+* TI CC256x Bluetooth devices
+* TI WiLink 7/8 (wl12xx/wl18xx) Shared Transport BT/FM/GPS devices
=20
 TI WiLink devices have a UART interface for providing Bluetooth, FM radio,
 and GPS over what's called "shared transport". The shared transport is
 standard BT HCI protocol with additional channels for the other functions.
=20
-These devices also have a separate WiFi interface as described in
+TI WiLink devices also have a separate WiFi interface as described in
 wireless/ti,wlcore.txt.
=20
 This bindings follows the UART slave device binding in
@@ -12,6 +20,7 @@ This bindings follows the UART slave device binding in
=20
 Required properties:
  - compatible: should be one of the following:
+    "ti,cc2560"
     "ti,wl1271-st"
     "ti,wl1273-st"
     "ti,wl1281-st"
--=20
2.14.1
