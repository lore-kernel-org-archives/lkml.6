Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520116279-2-15863653532753181044
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
    t=1520116256; b=Knkla69SAzcIjhgfUKBQUJZvl1cCzzMsibfUPrN502b5v/8
    TVld0NZuQpdY+Iek99hQW9qEq4PDil5ZvFaUiJQE6MaVM+neccdTvZVjYBCZmESA
    52d7e2V2mCwRn0nL0MKh2SeYUKWFVe8bWZ5dOoqoXwOig09GypZG/luxLor+xHVV
    C/Witgxf2gIaha9QPQvzXoZaSFqy4CdVIDlCAZ/mJf7lfr21CtJhAy3VeXnw4oKG
    faCNhX1atibN3eQ0IO7MpvMxd4Bg9Xr58DOFsQONyHeT0Wy3P8fFowfN1zr4A2yK
    l45uhnateeEHU7pjzDPpTtqM8CeoeodEu8CWrLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116256; bh=P+BoPO
    dgHMLt8V3QOPJUUtVY4dk0pvO60Fm+PpNQPKw=; b=rmbIbutAWf8jWDce9wlxgq
    hNy15G5sprkAbdCxzn8PzHKNb+8fwNA0ewyLwobIy0BDD/QLvEIBuzhAa/x2ZShw
    XoXBej0ma+1PRRVP4lRkNPZaaiPpwyGkHdQ1RbJ9vJk+tWmtxYH5bQdo6b4qYgo6
    9FQWcwwmS7OPTkhLi9mqlhFIUPYc76pveBE7TEBWwOpkqraniVlugsvVCsOdzZjS
    UeWU4CyB9mb/dPqXZhKLvj+VGIUGTJ0Z0rY4Iz4K1eDOEV5BDhEh+DRazSeQJkkJ
    fZS6Xf5Wo+YNhFHlmoYpxSVMPyBATC3sNMbi+RdOQ4ebLD+w4EcE5gjSsr32KFyA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=X4el4r0j x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=X4el4r0j x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933511AbeCCWav (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:30:51 -0500
Received: from mail-by2nam01on0115.outbound.protection.outlook.com ([104.47.34.115]:14144
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933500AbeCCWat (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:30:49 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 71/84] arm64: dts: renesas: salvator-common:
 Add EthernetAVB PHY reset
Thread-Topic: [PATCH AUTOSEL for 4.14 71/84] arm64: dts: renesas:
 salvator-common: Add EthernetAVB PHY reset
Thread-Index: AQHTsz60iifxwEGFPECHNPOMdv34qQ==
Date: Sat, 3 Mar 2018 22:26:41 +0000
Message-ID: <20180303222518.26271-71-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1115;6:4GKkfqah56s2yzhMUeTyf+q/bgb7FRsC1j6Cnux4V77wzs9T70aQOPGa9v+aKg7XU1rATKyrOy1r3mghKwAEVUAlc3ThYjog7pRiPm9fDkXV703oaopwdpBVNlJv7/rPsBPc9f0M/ZLbxiW5+zfVYHM+JM7zF19JvsdCDRwO1HIaomiQr+Sies9+xyCea+Z9lUohgGzp+MOJkRIDx66V0gm28TCi7ebyRWCtAeDLw/RrWI8oMmohOVBgg1n5wZNwrjnUMZE3Yj+UbREQBAOlj0eshk+UxifKJGohj/gEndW8sJt4HcyaQ1e2Z8nIn3wzAZlj0saJZYTuaQGR9/NeDLN3cRSEpDgOU6wO28h0mNQcHTDweHgqUextu69Rcgt1;5:2jzmfbAe9E5QmFSMTu3DpavJ8aq3WztGjc3IDBXLdAxktGucCqGGOlYuX1WOgwU2rjSo2r4IHznjR0aaafO0KNT8IeEe4YE62l/jPYu8YUw7kIHBXBJgQq7JiTg6A6249dYCwXLfMlgbRYiFfeVJf5D12XMJCBiM+iR9N60WpeU=;24:JIu2I3xb6u5rWhO3457k7dQXoOOA43PZsijDGnZ7+BX3TRA+rBAdWQW/ZrOofoIHbZ2XDmF4kapFqOv4tTW3wzY+Q5CZE3UdbE978ZienzU=;7:nkPjPmbpWXqVWuMhH7wKCmrDcntwppkbPKzbm2a74GJawYj26Bj9oM7Glfy0mQM5IQq0mWa2T/nHYRzlrlfWQ6qyy7ul1Trzn7LL+PKyJncJTVpYU4Rks1LEgY0tdP5cIPd9baC2UxWL5XOYgNIIIlH2pS3eZXPhQT2rt+OYXo+FQLPQFXGcY+yBocFsi96jNSvxWq1YgIySCWN6EwAEhD8LDXtbapdWi2nzon3sEa0La17L3YhW3CEOMAcxOCfu
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5b04aee5-0dc1-46ed-3585-08d5815668c8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1115;
x-ms-traffictypediagnostic: MW2PR2101MB1115:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1115F3773A2D21E8CA2E995DFBC40@MW2PR2101MB1115.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1115;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1115;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(39380400002)(189003)(199004)(26005)(97736004)(186003)(2900100001)(316002)(59450400001)(6506007)(102836004)(36756003)(110136005)(106356001)(54906003)(72206003)(4326008)(8676002)(81156014)(25786009)(2950100002)(6666003)(305945005)(10290500003)(5660300001)(107886003)(14454004)(8936002)(3660700001)(3280700002)(105586002)(81166006)(478600001)(2906002)(6116002)(3846002)(1076002)(2501003)(6436002)(5250100002)(6486002)(68736007)(7736002)(10090500001)(6512007)(66066001)(53936002)(99286004)(86612001)(76176011)(22452003)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1115;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: adBnSrWT8Fox5Gv4R4QWYe8BxYhbqQeW14zwbWAfJ85GpcoFUUVF5a0783gl3XdNsdEDescasLvL1TtPcXIOKe6FoUkaHn7ASWe4rfX39ssuHx+cXmQWUxBwD8UF3u5KztDXJCzNLFR3GfGKPQUW4ZrMqGnOs9T49kRqnS1+dHs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b04aee5-0dc1-46ed-3585-08d5815668c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:41.9161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit f5bbcd533a9d1af97b8a0862a421bb8455f1bf6d ]

Describe the GPIO used to reset the Ethernet PHY for EthernetAVB.
This allows the driver to reset the PHY during probe and after system
resume.

This fixes Ethernet operation after resume from s2ram on Salvator-XS,
where the enable pin of the regulator providing PHY power is connected
to PRESETn, and PSCI powers down the SoC during system suspend.

On Salvator-X, the enable pin is always pulled high, but the driver may
still need to reset the PHY if this wasn't done by the bootloader
before.

Inspired by patches in the BSP for the individual Salvator-X/XS boards
by Kazuya Mizuguchi.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/boot/dts/renesas/salvator-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/=
boot/dts/renesas/salvator-common.dtsi
index d9d885006a8e..9eb11a8d9eda 100644
--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -264,6 +264,7 @@
 		reg =3D <0>;
 		interrupt-parent =3D <&gpio2>;
 		interrupts =3D <11 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios =3D <&gpio2 10 GPIO_ACTIVE_LOW>;
 	};
 };
=20
--=20
2.14.1
