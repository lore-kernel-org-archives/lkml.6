Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521495417-2-1589498201365034564
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
    t=1521495416; b=XN8hosfpSEOlwVpFXp94U+VLf8kg2o7irL65hLghUOv5saj
    ufN8cGjqwzHwpOnE8nDsueGG0pfko2SAexPmlZuXNP5yje/no31HbJWUv2bFpuoH
    DUEH1ZOtIUCIFcQgKX4zuGvKp/8ntZQE7zADiYJtFwWM3XKzaQvMjcfkAIHhxqKe
    TkFPhugGj25HwA8UNXO0oTqEMHQjjVcl1gpBdtYqKOqn8En3I1JwrpyyFosfxG0F
    KFuco6z3pOcZGbyHVwZDwPZj1z5qlGyi59XuflKauC9H7czjY5dYkV7WNX0IOAY5
    BVBs60SXgryEHz18tl83HzlarrBYwLFM11ws42g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495416; bh=t1uGdM
    n94ZNts/g/JFaqER6CQPTHePxRVc8cU85mJyY=; b=uqcoRIobQiOmV0fmoyIbqu
    UBmy3knJ4lJwXIFuEBTgzLAgenf7SXsT5C8watfRar588HWLW6dpZnfiTkg7UAwk
    LN0tFR3dEVnYRf0xBoayJcb+h/Kd+ZcGo96p5r/CBAvZyv/DS7SDXcvbvjc8gK6J
    PpHNIZlEzGzVFM0PmZdrqKVmAOq8IwfUSBTIRQT8+l/nQhYMoj+nHfKVu1pdz5CR
    bMQ/qESSkivVs34OZylhC9iH+UCTAgNtCLvcllG8PswVntjT89YacEBmI1h+f2pz
    ZrAEoqS/t7bX7oUP/VXAXuTFPS6wwlwPty+iXt2HJ3k7eJ9gT7TlymxMy83IHOrw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=n0B+7CGe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfedttdenucevlhhushhtvghrufhiiigvpedvhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=n0B+7CGe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfedttdenucevlhhushhtvghrufhiiigvpedvhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965135AbeCSVgf (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:36:35 -0400
Received: from mail-bl2nam02on0101.outbound.protection.outlook.com ([104.47.38.101]:39744
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965115AbeCSP71 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:59:27 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Julia Lawall <julia.lawall@lip6.fr>,
        Jon Mason <jon.mason@broadcom.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 053/281] mdio: mux: fix
 device_node_continue.cocci warnings
Thread-Topic: [PATCH AUTOSEL for 4.9 053/281] mdio: mux: fix
 device_node_continue.cocci warnings
Thread-Index: AQHTv5sthWiUEhjrxUqE23N/W1nxEQ==
Date: Mon, 19 Mar 2018 15:58:52 +0000
Message-ID: <20180319155742.13731-53-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:M4v0HkwRzp4s3sP+KdAiQiiJ6q/tRaNvvf0Emw+cw8UsrhFZz4LP6MLQ6JRr2Rggd71VIiPuoMnqmvzF+84Chh14PDZ+nbqbp5XcOqkcwUrX3Iz2Fp1ZnVEShO0e1MYWY9SZMLaLG76AhMNVG44HPeHt95AXnB2wIm9Z53AajLl82c9R+6BrCvE5GomwuQ8VB30vabuJKDmw/NR1MewHXVi8qSWlBWoCAQozo0UjyFSlclbIpEvUdeL6XCSgvEeo;20:dwlXQGfEGMaj7dQjilxKoAoIlUqABJCPiPmRkUEjSv064UXy/QSIZE/53fSYZ/+PU9J800KbvI/sCFzQt8HkXg2KF82IcK0MLtOdulw6AmXBF+cL0woKq6ObR3JhFue/B+ZtvS83aHeXyKiehGRdHm6iMncDC+OPuxwuxPzPCIA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9a9a643e-7f8a-4a1b-232e-08d58db25ff4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1109E1CCF498788E40C9E394FBD40@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(396003)(366004)(39860400002)(199004)(189003)(26005)(316002)(53936002)(6486002)(6436002)(7736002)(305945005)(22452003)(66066001)(76176011)(6512007)(5250100002)(10090500001)(2501003)(99286004)(105586002)(110136005)(54906003)(186003)(2900100001)(4326008)(25786009)(86612001)(5660300001)(86362001)(8936002)(6116002)(97736004)(3846002)(36756003)(102836004)(1076002)(10290500003)(81166006)(8676002)(6506007)(106356001)(107886003)(81156014)(478600001)(72206003)(59450400001)(14454004)(2906002)(6666003)(2950100002)(3280700002)(68736007)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: jYQUsPK0NemuyADEEZstD2cIhqSGatzAr/SWfNd5tG4arBmzG8YQESj7qnGVsxRfyFhJW4bx7rTYdOtTWIPF+GlQ/MD0LsTneyaSVt/X75mA7eMrAB20xxa9CB+sIhqxU/uLHYQXxh43OsfvipdDj8NkNxYeP5BPVe3rbnmat/gyn/v2R0FRhQgkYvDxPN2kg8Ju3bOBpXqOwFL6fleXKu56CFnRAexhWx4KvwQXiyuTfa1XfeuVAA8QibYrul3IshR2U89J3w9yRzslb1CRTWmckFh927TewNkRc7hJK1X6/+xhFySS3NrmpLJjuVU5yZNeyXp275QDVbq/FXXB3w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9a643e-7f8a-4a1b-232e-08d58db25ff4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:52.7048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Julia Lawall <julia.lawall@lip6.fr>

[ Upstream commit 8c977f5a856a7276450ddf3a7b57b4a8815b63f9 ]

Device node iterators put the previous value of the index variable, so an
explicit put causes a double put.

In particular, of_mdiobus_register can fail before doing anything
interesting, so one could view it as a no-op from the reference count
point of view.

Generated by: scripts/coccinelle/iterators/device_node_continue.cocci

CC: Jon Mason <jon.mason@broadcom.com>
Signed-off-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/phy/mdio-mux.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/phy/mdio-mux.c b/drivers/net/phy/mdio-mux.c
index 6943c5ece44a..599ce24c514f 100644
--- a/drivers/net/phy/mdio-mux.c
+++ b/drivers/net/phy/mdio-mux.c
@@ -169,7 +169,6 @@ int mdio_mux_init(struct device *dev,
 		if (r) {
 			mdiobus_free(cb->mii_bus);
 			devm_kfree(dev, cb);
-			of_node_put(child_bus_node);
 		} else {
 			cb->next =3D pb->children;
 			pb->children =3D cb;
--=20
2.14.1
