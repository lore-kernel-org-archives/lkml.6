Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3384037-1521480530-2-8858003870325726357
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521480529; b=hN+F/xxfX3jIQclrfnd6VXA27bbeKrmd4cXQH0f89An3JSS
    zeh3upXs6x92j+oofzTiWroK1q9bWUoDRLHc8DxrHeZRqfQafeR01P5z6aYeOtq+
    kwgpvr4rhspOxoh3aOs7hAfv/dSgAnU1fRzHXjkZnhjQGSGVKUkGpb2OF8Ls/KAk
    8HfWXmwWXNHa4go9/rs3vwOMMXtJW/Pwy+SLAVXcoksXOlM+Z5jJTNldupiwnzOZ
    lFIsrWlN/ti4OwvdgRHNLTu6AvS2OFxWU1b5GJuPkyiCVekjE5dLVRIdyNPBx7fH
    JeQAkpQzId5dnnJ0EWj37JFHAtvvG190bArH6fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480529; bh=kMJVQN
    lehx9fLoPn0hF1qTHtpdrtlkXLD6EBe5LJ0oo=; b=PzRKGPiJPv4Q9Xmjl8nXAQ
    HhAku3hLZpB7WVHhmGtn0uZNVl4400AaqbgwXyOE1PTsz3Pz4PPHge5gUN30hUYj
    /fCI+ujvIhQaB1ZsK+SiicKyWnttS83iFiWEiIkIV+OVarnVzUTDy/HHuEYtriJY
    VT1CTgGsc3I7t543mtmby4GxRaqsdsDPClnZlxOJ8JHuQTOi1F3ubwJ7iBEYrbtF
    39uGJD/sY8+IVrCY0AWR40LAZrbBEiYDyjJJd55qnxq2fVNLzKTRRGcJblHovtTm
    pEzCbJnfEd2vOFKesT+B1OgA3IL+SdpqwupKQhXNXROkFEhxWdZGkUAX9MgimVlg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Jlw6IJRp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejtdehieenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Jlw6IJRp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejtdehieenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966314AbeCSR2W (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:28:22 -0400
Received: from mail-by2nam03on0137.outbound.protection.outlook.com ([104.47.42.137]:54368
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966185AbeCSQHk (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:07:40 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 036/167] ARM: dts: imx6qdl-wandboard: Fix
 audio channel swap
Thread-Topic: [PATCH AUTOSEL for 4.4 036/167] ARM: dts: imx6qdl-wandboard: Fix
 audio channel swap
Thread-Index: AQHTv5wvXD6shGUGJU2wGV3+aDyQ2w==
Date: Mon, 19 Mar 2018 16:06:06 +0000
Message-ID: <20180319160513.16384-36-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:8Xu7Gmm2zORdm4r7kBoG+3UP6/GT2sIBBQ0tOv1dlN3XxLSB0TS2xurIaiA6CtwaPTXrn2MWwyiRaCL4BdBj2jYthDO8OyJWjJYGSe6vhQTF3TmfAoR5ef4DiLcmpZP0WV9aGt6EMLMEdw/zU6SVXYrfqRu1+eFplMJHq54cCXA64Z0YN0mNIy2+XjBz5QykaBty/fmZHl31+FbOKo2V80J9Pe3J+8wKY/1DXhnmHJkShQNw1yg6tWmfeBtE+vpg;20:CT5JFK4psMqx0fFH2hMrmZdqFXTsB8qsnC8kAEFX28dqR/xsNxs6MpJXHNd+yDTTZmiSGVX6ZNa1hWK60jgxMZ1y0GDvfMz4QjyuXYWIj4RtuzxwQ1yfq6txO3rYL+dr4RjaloY0tvDUEBv1BTe5Ge4wLzVgGeRFn2xTL7QTNrw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6703898d-2470-44d3-0d12-08d58db38863
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920C8E5BC6BB79357EC4591FBD40@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(376002)(39860400002)(366004)(189003)(199004)(6512007)(14454004)(2906002)(2900100001)(8936002)(186003)(86362001)(5250100002)(316002)(97736004)(2501003)(6116002)(1076002)(3846002)(81166006)(6436002)(6506007)(6486002)(26005)(72206003)(81156014)(53936002)(102836004)(478600001)(10290500003)(8676002)(575784001)(107886003)(6666003)(4326008)(3660700001)(66066001)(25786009)(2950100002)(86612001)(36756003)(54906003)(110136005)(3280700002)(7736002)(305945005)(5660300001)(76176011)(68736007)(22452003)(10090500001)(105586002)(8656006)(106356001)(99286004)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: aH7xVjloJW9MzY7sOR2C4NZu7gj0AGUKvrH9MjEfZeACJlXSoO5+uyjIuiUwPZWX8Djr0k3reeFdv8CahJDU5Ioeatqc80drbIS9pheq0oEA50lL+r3gv/pQOthhjGe5lg78DilD+J+giMcDt1kzfWheKkEQJ/E77J5D/qp2J0lmIB75zkU/HX4LznR9Qhesr16cZAGIxTqjs4UTBJuxHzK1UmR2nePd8wOQ6HUduZV7XM4UwR9vTwfRG1ie3U+kWggE7O8uqMaFozpPlNVwBHO+JMcfQN/8iXUK5IGHCM/ay/vmvW28FU1S2EMiVgtCwBDaYcBiRb0Z9aIT6rZESQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6703898d-2470-44d3-0d12-08d58db38863
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:06.4276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@nxp.com>

[ Upstream commit 79935915300c5eb88a0e94fa9148a7505c14a02a ]

When running a stress playback/stop loop test on a mx6wandboard channel
swaps can be noticed randomly.

Increasing the SGTL5000 LRCLK pad strength to its maximum value fixes
the issue, so add the 'lrclk-strength' property to avoid the audio
channel swaps.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi b/arch/arm/boot/dts/i=
mx6qdl-wandboard.dtsi
index 9e096d811bed..7a032dd84bb2 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
@@ -88,6 +88,7 @@
 		clocks =3D <&clks 201>;
 		VDDA-supply =3D <&reg_2p5v>;
 		VDDIO-supply =3D <&reg_3p3v>;
+		lrclk-strength =3D <3>;
 	};
 };
=20
--=20
2.14.1
