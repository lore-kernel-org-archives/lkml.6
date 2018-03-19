Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3440611-1521482908-2-2439088256322049430
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
    t=1521482907; b=ojoRWl333L3g6l0Sp3yC+kZ9ONJgqJkEoFG0nKwXKoBoikT
    xWKbrCXavqYyCj20pHNRDRJFwDvWkVt+pC7ouzmQFCSHN1mNkpl/uHrhMbPpLCz+
    1Iviex5M5jAWRaZHa9/DHSZHkxSt5hOAfdudc2zFAq6Mk28lRD81hfgTOjETBJCB
    JrBHCEGSQEoOV3FTbVu3dJfQifWYQCiGp/NYGITODnYHwcM69j5EK/r9/4anOcss
    ycWtHx6FxyHVgvbxlvWSDS1Q1J5r2s+vwqlLLGpq6GTcSDBkaGVJzPD+3/h3UnBo
    zR6JryjXrvLquM4bMFbMN4rSRFs6BR9RUXfm0XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521482907; bh=70xCEd
    lHWi8aTrpwhcaYzB1G1UYbBkSOsS+2eFP14PM=; b=VlU4XbOYqx/msYTo4QjYcK
    iVIuNAKH6KLiwVg/KI/w7FMcTwpQxURUlpG6pP16q9WcjBFkEx3++hHV9Xyn56CQ
    Nn5zkgzYDzWPW4AoHHPqjjBagMZSYPfG5wgDqEbGgZM0f/hTQmx8HYTaOxhbaSoT
    mC5qDfeImmWK4lskkY6lr20icNEj8OeoHDvfjSGJs+NIGGVvhvd7R45ouu0nCLYb
    TpdfIpY/ebO1NKjQtcbHIvrz5Vjy4uSu0SRwH7pRNVv+n5wLhNUPbcnWyaTq1dvL
    FOMtMsMn0k+h6EmQcDghnJh3lm75hyY5zll3zx+AoXvtV3hmDkhKrfjMM+k7vsxw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QcEdX7Li x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekieduvdenucevlhhushhtvghrufhiiigvpeejle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QcEdX7Li x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekieduvdenucevlhhushhtvghrufhiiigvpeejle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965588AbeCSSIY (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:08:24 -0400
Received: from mail-cys01nam02on0139.outbound.protection.outlook.com ([104.47.37.139]:43744
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965554AbeCSQDO (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:03:14 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 173/281] dt-bindings: display: sun4i: Add
 allwinner,tcon-channel property
Thread-Topic: [PATCH AUTOSEL for 4.9 173/281] dt-bindings: display: sun4i: Add
 allwinner,tcon-channel property
Thread-Index: AQHTv5uEyhRuuojrb0qhu15AHcMSUQ==
Date: Mon, 19 Mar 2018 16:01:18 +0000
Message-ID: <20180319155742.13731-173-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:tLTXo4x7zXxPzplYz9Y4r0GKYDvnhDp8mdlr2Mc8LsUlp5G6Q882/QXFJRgUNjMdDUr37sUkQ9pgEOvrAeuEBNA4HgauOgL/yilTaivvb3LZdj9v+SNpW2Ahtt8jL/ymnVgovjUpuLFYu2l9eP7Kua0DZ5XzSgCGqYuGEZMZsGFABXsNlSvm8kNKDWKOBwfup93asoMYlxkCPC1Z0igqkfcG7yoK2TH1YrzZAU5W+RgMtREjZoUmpCFT025ntiAZ;20:Is8sEkTnSMu6P4YSO7U2xfHQA/VlAfG3+KjwVf38UEKpqtYN1KH2Riqz0LNtzUo0ba+uCZrJAjkZYQW/rn4dcmNjwqvRjd9HeHVKbl5Opo1m24voH6LkCFbP0tK3/ONXjVX7aBRIu/VEuoMUG7DzP0HvkG2UrQfy7YFcXzj8mDg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 919a95d2-4b9d-4f22-3b4f-08d58db2e7dd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB072514084B9CAC2E01232DEEFBD40@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(346002)(366004)(39380400002)(199004)(189003)(2900100001)(4326008)(54906003)(10090500001)(81166006)(316002)(2906002)(14454004)(110136005)(107886003)(6506007)(186003)(81156014)(22452003)(68736007)(53936002)(3660700001)(478600001)(5250100002)(2501003)(99286004)(36756003)(105586002)(6116002)(3846002)(5660300001)(72206003)(1076002)(2950100002)(6666003)(305945005)(6436002)(86612001)(66066001)(10290500003)(76176011)(97736004)(8676002)(7736002)(8936002)(6512007)(102836004)(106356001)(3280700002)(6486002)(86362001)(25786009)(26005)(22906009)(142933001)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: DEdLATIpTDJDJnj75qDArJEfeivu03hghvrZ1BGzg+xHTHxrZCKvS96wlRokxN60CY94XBxRvAJsPIWoPSxUppV3xGe9I3S3JiIUXPJG/5Uf5jUt3oEhP+KBk8N15OypB36YWPVdyO3FfRCVWarGjheUfLHDVEfjprAq80MOXvtpBeYzN1yc+BoPaN0NYX1rzazEakw/zI3C+Y82OTidWGAkhdjrmgHhCcXKZRMLVJor1SrouF+hF2YLVqKmDPhhAupuKUnVdrONqQBt0raeXjJaIBJvhBH9zk4/vdxj3FjIWOkByu75PAeFRnIs3cP1n/AGN/Y0NcgABniSSvKC4w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 919a95d2-4b9d-4f22-3b4f-08d58db2e7dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:18.1577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Maxime Ripard <maxime.ripard@free-electrons.com>

[ Upstream commit 22662f12768f971809b478386d9cc4947d00497a ]

The Allwinner Timings Controller has two, mutually exclusive, channels.
When the binding has been introduced, it was assumed that there would be
only a single user per channel in the system.

While this is likely for the channel 0 which only connects to LCD displays,
it turns out that the channel 1 can be connected to multiple controllers in
the SoC (HDMI and TV encoders for example). And while the simultaneous use
of HDMI and TV outputs cannot be achieved, switching from one to the other
at runtime definitely sounds plausible.

Add an extra property, allwinner,tcon-channel, to specify for a given
endpoint which TCON channel it is connected to, while falling back to the
previous mechanism if that property is missing.

Acked-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 11 +++++++=
----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt =
b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index 4f7ae7555758..bda9d6fab6b4 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -47,10 +47,13 @@ Required properties:
   Documentation/devicetree/bindings/media/video-interfaces.txt. The
   first port should be the input endpoint, the second one the output
=20
-  The output should have two endpoints. The first is the block
-  connected to the TCON channel 0 (usually a panel or a bridge), the
-  second the block connected to the TCON channel 1 (usually the TV
-  encoder)
+  The output may have multiple endpoints. The TCON has two channels,
+  usually with the first channel being used for the panels interfaces
+  (RGB, LVDS, etc.), and the second being used for the outputs that
+  require another controller (TV Encoder, HDMI, etc.). The endpoints
+  will take an extra property, allwinner,tcon-channel, to specify the
+  channel the endpoint is associated to. If that property is not
+  present, the endpoint number will be used as the channel number.
=20
 On SoCs other than the A33, there is one more clock required:
    - 'tcon-ch1': The clock driving the TCON channel 1
--=20
2.14.1
