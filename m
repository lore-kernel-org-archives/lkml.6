Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520491757-2-96984452666028793
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
    t=1520491756; b=efdfGDMTTs13Mk4RQGmG5Ad8+dgXJXOlHYrLpd3pIs83OkM
    +KOhUgYN5/vlWS/xXeI3j+zV/d+/rHjfhhol9kGxtyFi+e8YS4+ivoUBqdeb7YT7
    U78YUJpqp9NLILJRcwdRN+EGusylmGPk5FbjCMsHRajivNmtWytlyNUNPXSjwL/V
    hLuFLlHwU267OW5Dlo+dAR1E04qih8NQ5bWIQgHf2aNuITYwELXW61WfSb5hLD/N
    RMYBzMjbyjMIL7U5OejsNaRwVLEbAOKBflHnzXnUASkiKRNUFXUql4XPRYcFibNl
    mGxQ1zeZkKyi4uLEFDD/MR9cQEHwCW+N4TQzb4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491756; bh=AHGEzA
    m8jh98t7+3dDyHsN00jLfrtg1Y5dTsFqcz0Q8=; b=aU0ubFb1YbnM4N/HLxmCad
    ZcO2+HjKwUsA6sq/2YxsgZD396HHNpVtsbXufIcTDjGNCiTWMR3lkC5NI6WshxZk
    hQroiWZJwvdw7/0p123e43NkpyfKLD8lXuTDLnCDl7iIKh0viV2oMy2ReA5WUgCS
    VICdByNTphIBgLRWgvnZlk8+gPuYHOW2wf93DspKfRinUbF7wkiFrrwJGKs2OIz3
    nSnbbZ6sWP4epIN7NPcwwJh7r9Ecctrw7NXl+twnpvEYDPCcmNGH8s14vVcTURqc
    BiyDasSYVvETPUMTpQU3CKy5EhfdoHC23B2uJnPIo2faGxkOKI4uhETE41mpL3fg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NKe7V482 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NKe7V482 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965096AbeCHE6Q (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:58:16 -0500
Received: from mail-by2nam03on0117.outbound.protection.outlook.com ([104.47.42.117]:8510
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965050AbeCHE6M (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:12 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: David Lechner <david@lechnology.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 04/67] dt-bindings: net: add TI CC2560
 Bluetooth chip
Thread-Topic: [PATCH AUTOSEL for 4.14 04/67] dt-bindings: net: add TI CC2560
 Bluetooth chip
Thread-Index: AQHTtpn3jW0erqkYkUOnCRUgIQMRMA==
Date: Thu, 8 Mar 2018 04:57:33 +0000
Message-ID: <20180308045641.7814-4-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:6Nh3PXyzSO4H/nvGDiOfmbyMyfUZQCVkV9TyCAhBTGMsOMCH+v8EmFMdE+ZSElArtRAWoaa78IC4KKCaoweSLYmtiRoJmx5Pyw9VyDCDLoEP2ZfubNbfurd2gWqiBGQAK2mZNEa8asRk0NUs9VwYf/rI43RRp4dwC1jPc9FPpmrd+8/nguZGGbwDFHWNp39m7uh8RojeQ4D2wt74Wg4xBGm2MKsMLiz0tlVcjfYV06sHbTDMyLulH5qSPv1dQ7ph;20:PbZXbI190fQizguujesF0D95A3ctVNFmzBrbm2a9qflYWNxiKgSEmlI5imSOQ3O0jH4pfzh4xS5qSmwO6k4t/3choYDCb8GJe3LYpUSu0S5Vbd1WgV7JIdGfxbzezUCKm7rPOl/AIAH4daOi6TJjtT7cPwTJCWR26jaFXzcl1Nk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1ee368c2-0213-42e7-e1f8-08d584b12ca0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09363224426B44B420CB7310FBDF0@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(39380400002)(346002)(376002)(199004)(189003)(478600001)(99286004)(575784001)(6506007)(3660700001)(36756003)(86362001)(54906003)(6116002)(110136005)(2950100002)(102836004)(1076002)(3846002)(6486002)(3280700002)(10090500001)(10290500003)(305945005)(72206003)(5890100001)(6436002)(6666003)(26005)(5250100002)(2906002)(186003)(2501003)(105586002)(76176011)(66066001)(7736002)(68736007)(25786009)(6512007)(106356001)(86612001)(8936002)(107886003)(81166006)(2900100001)(5660300001)(4326008)(81156014)(53936002)(14454004)(97736004)(316002)(22452003)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: yhgP7ONg7leR1mi1+6DfhG4tG67m2j5PiLbgfoodRnDZNgFUP9XAGLkGlR2GZFclmRYy+9LCmvGMGn7DVhJ1f0J9ojtZOjnHeiTJbO6d4O0fUAEdybOuJ48x0MJHmMsnd8BaCBdxm9vtHMEuN6raLeKO/xDcTEwlLDWAQhW8oCflolye6XC0L9PYtN61b9yf3Y2jIoG2gbT18RSJESHL+vvtFklxAIGTQIg/CuD9dWJN8oz4t0BQ2SG3XKGHe68A7jTG0FLxt/hj3fi/WlpeK41UfrhbqZGgPGcyUzu+aTGE4pNtEf2mrGfWucEvGs8R6FSvhyc3zDMDtEySL79ezA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee368c2-0213-42e7-e1f8-08d584b12ca0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:33.1319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
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
