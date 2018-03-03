Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520121214-2-11028371540013611250
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520121213; b=iU6fcl9/J6Ncw7RphHy36PFAD5lRLuIGIipIcc8E8yc9j4+
    Bvq3duiVhr73VuRyhmAoUzgUZRI25ETJJvjcgAXfyQ0DOcgV0n/toUe2F0KK1u46
    X8FmQu6oijBLNS/iOBoicnhbZdEfVijR/m9GZpVGoEr1g3swUbymwWGVNfC/FplQ
    sbEAePsSr3Ch8PODS8IsJTrm2xXJcIrR1j+UiTUY/vCU5Bpmx8/+43huEXrt/zUY
    eyYX+lpJ/fI36p/PSUlASeRlJ4vFH1y1U/BoNPDY7Iai8eIkuFAHpc1cx9zu+5AR
    f9v9hX6bq03YvmIgjdjoKKJU+pybWF6HlLjlmgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121213; bh=nXV6zh
    dz5NIJ9HV7k6EZdbki6Nh1rnqJcJuTGEMlxus=; b=WkHix/8HD80tq+HaM6XaRs
    qQaZDvBF7E1wKt2KMKwrE/L9c4Uc6xDIytKZjqoRBCx/NvtRIUbXiejmN993e2nj
    C+cBof30QyuQ2VAefqYuOU0DJyXODrxkr5i6V16v2BkRs638aGhS7GuW6qnFFElf
    U39gEd6L+h+zAFD2e1OYK+vCNOhDLRcXBMg1I+84OiAxCKjVu6u1zyUq98g/o5fE
    kmmeOfQRZIuj929PWHyM+4rgNdYhYqWlujOiKrw00rz4ZVqbR0K5bThOQoGZAB2D
    z0PW2LSvZzQrKnIa3GEAPVWN9eRps3GbgTRQB5rYzQB6JrVMG0JBnFW9MYZR+uQA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=afXD8ZIv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=afXD8ZIv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933992AbeCCXx3 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:53:29 -0500
Received: from mail-cys01nam02on0126.outbound.protection.outlook.com ([104.47.37.126]:47215
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933897AbeCCWc7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:32:59 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 068/219] usb: dwc3: make sure UX_EXIT_PX is
 cleared
Thread-Topic: [PATCH AUTOSEL for 4.9 068/219] usb: dwc3: make sure UX_EXIT_PX
 is cleared
Thread-Index: AQHTsz74CEIcXYrBW0qTvsPf27ECbg==
Date: Sat, 3 Mar 2018 22:28:35 +0000
Message-ID: <20180303222716.26640-68-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1098;7:spVrDarQI/OTulmEGYhVW3fCZ3TYjW1M/m+uFgHoNRMoRAj2IganWNjazFZxFCK8YcyyHvM2GgZQaa4fKAnvzJbl75siFL0edwsOcJBVkC8v0FzDXZgtq3WyxcN6i97VAcUuL9gR7etZ7zr+dB/W3JLM8FrIi0dbsHnThJDnM4LiDTbLK/ek8LASs+7lykpV8dW9aF56gTEorLol459Qk8VLwp89o72Y9idG8VaUZQ8GGj1l/PTWjyENZtgc7fBP
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 54795abd-2f20-4772-3ecc-08d58156b3e7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1098;
x-ms-traffictypediagnostic: MW2PR2101MB1098:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB109814B9C85F1760EEAE6BF2FBC40@MW2PR2101MB1098.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1098;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1098;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(39380400002)(366004)(396003)(346002)(199004)(189003)(2906002)(8936002)(36756003)(6512007)(81156014)(10290500003)(81166006)(99286004)(6436002)(68736007)(478600001)(3846002)(22452003)(53936002)(8676002)(110136005)(54906003)(4326008)(316002)(76176011)(6116002)(7736002)(105586002)(305945005)(3660700001)(1076002)(14454004)(97736004)(575784001)(25786009)(186003)(72206003)(26005)(102836004)(86362001)(6666003)(2501003)(3280700002)(6506007)(5660300001)(10090500001)(59450400001)(66066001)(106356001)(5250100002)(2900100001)(2950100002)(86612001)(6486002)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1098;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: VR5LyTczkNsKG0H7fRZhHuPhTq3s/sFykSxXVfQfrAoHTghlsD6qlvkJFNy5ceUAdZW+1nl4RAY6Rq1dqBFbFmInjKnrty768l8DgsdRqU80DTq3SZ/0y8/6LQ3p87//akXegmJgoGxanLQ7NR9pdvHTs5HvmXWCB+J60MAvzqY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54795abd-2f20-4772-3ecc-08d58156b3e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:35.5569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1098
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Felipe Balbi <felipe.balbi@linux.intel.com>

[ Upstream commit 1966b8657d058ecb95031809b607bf3fd1e01c10 ]

This bit is only supposed to be used with known
buggy PHYs, however some platforms might erroneously
set it. In order to avoid it, let's make sure this
bit is always cleared. If some PHY needs this, we
will need to add a quirk flag.

Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/usb/dwc3/core.c | 6 ++++++
 drivers/usb/dwc3/core.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index fea446900cad..a0c2b8b6edd0 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -463,6 +463,12 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
=20
 	reg =3D dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
=20
+	/*
+	 * Make sure UX_EXIT_PX is cleared as that causes issues with some
+	 * PHYs. Also, this bit is not supposed to be used in normal operation.
+	 */
+	reg &=3D ~DWC3_GUSB3PIPECTL_UX_EXIT_PX;
+
 	/*
 	 * Above 1.94a, it is recommended to set DWC3_GUSB3PIPECTL_SUSPHY
 	 * to '0' during coreConsultant configuration. So default value
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 884c43714456..bc3678e9dcb1 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -223,6 +223,7 @@
 #define DWC3_GUSB3PIPECTL_PHYSOFTRST	(1 << 31)
 #define DWC3_GUSB3PIPECTL_U2SSINP3OK	(1 << 29)
 #define DWC3_GUSB3PIPECTL_DISRXDETINP3	(1 << 28)
+#define DWC3_GUSB3PIPECTL_UX_EXIT_PX	(1 << 27)
 #define DWC3_GUSB3PIPECTL_REQP1P2P3	(1 << 24)
 #define DWC3_GUSB3PIPECTL_DEP1P2P3(n)	((n) << 19)
 #define DWC3_GUSB3PIPECTL_DEP1P2P3_MASK	DWC3_GUSB3PIPECTL_DEP1P2P3(7)
--=20
2.14.1
