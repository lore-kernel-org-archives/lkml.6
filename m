Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827928-1521495309-2-2873333128748788575
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521495308; b=N0rwkN7fMdtbVBF/b9rmp9q+HaAlQcnVzmwgzqrN4ifV9VT
    +463lHhH8gY9Fw1P3qsxkcjmvZ2d/n8lMvdNMagz/zQjayEb1ZPZxKaPC5RhRjpw
    cKO+sHFdoq2w9QIFn//+8/2E6a3syltWK74IiWWTwTfjS8c92oOSbsNnZYa7yqUM
    0ZAQvEBnwu3KEaQXlpbmFtwZy1Q170QuAbxKRFzZb+MaogDKkwxP8CDk0AboYxui
    AGYcVnJeGeplwhLGKS+IjUD50ClNmdieV9YfJGGNBfZp0nXYLFo6agebH4s3UsqS
    e8nSpX1AW9Wq1WlBjMh6b9AkCceAMku+2umH8hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495308; bh=VnjkpR
    Ff1u8KPGBtPjtXR+yfhcFEDGPJdHYg8JLdPrQ=; b=psKPSBjd+f6Az1Qp9wKLvk
    FHWS7F6V4ZF6qvWK1x2eX7Ai7ZDQcfzad8aLaKDKM56PfcibjLonEAa6aEZN9tKP
    ZrYifbvh1ScXnkaFSIA2y27Y2BllKB+MgfyIaS0vk+D12KRmXMI/nLCnSx5+PMhX
    A7r27zAymfPtWYsU+LzOQo4Q0dTiRbV3USxiHOXZ3r8xTFRhlJ4AGPzXrYcuzU3J
    sTmVf4lNBxBZX/mawPmo/KzrEpEL70hynQjItRjd64bhvHqRWhRfnSpCarYbBu40
    Ct4oFQcdmAc2918WFb7EmE8Aj3Hls63pPundjFWGlgbopMiGOd+rKVVvKNCQxcCA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EVNF3MmK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejuddvleenucevlhhushhtvghrufhiiigvpeduvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EVNF3MmK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejuddvleenucevlhhushhtvghrufhiiigvpeduvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970910AbeCSVe3 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:34:29 -0400
Received: from mail-by2nam03on0129.outbound.protection.outlook.com ([104.47.42.129]:62208
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965026AbeCSP7f (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:59:35 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Pan Bian <bianpan2016@163.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 058/281] usb: dwc3: keystone: check return
 value
Thread-Topic: [PATCH AUTOSEL for 4.9 058/281] usb: dwc3: keystone: check
 return value
Thread-Index: AQHTv5swfKgIWWGSGU+wWAPMVuIs0A==
Date: Mon, 19 Mar 2018 15:58:58 +0000
Message-ID: <20180319155742.13731-58-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:vYMOyNLQM2ZCwe1b4G+xIC0d3QS5fv0pJGz9VsncFyLbnd/p6ZShpJSIeAbjp9jwBKYoFCjI5Tm9+Lhl8YtMThe7BZ909pDL9CMyMpaDY/NYLJ0yuekQAuM2dj6rdE6Fx0cfZlhr8Qx+ww26ZMhQ8OEVNrtd1LaukXqbCSERXVM46iU+ZaBhqsc4MHyYUXKUtyMDVuQYCk7tT5z6FvyTuyMPaQRkxm2X081kPRZoNXG/SROfcR4kuOhb/zbYuANj;20:aYYerRZsNfyQaF2weu+S16l/qq0vE83mvPj4Uxa8kO1sjiQTCVuoDZhmDpbcDfp2mMD9K7zZN9LLi5s6jFuOx2EloF94IZl+oArGfWYGny+NwIOzrHZYQJRO2hquSN0LACFoSyw9DHt9ztmddUQNjLs8nim/PDccD3sf0o55VHY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b49b5e87-227b-4f23-dc33-08d58db2619d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB110958FA2227094AFACEE4ABFBD40@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(130843839470238)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(396003)(366004)(39860400002)(199004)(189003)(26005)(316002)(53936002)(6486002)(6436002)(7736002)(305945005)(22452003)(66066001)(76176011)(6512007)(5250100002)(10090500001)(2501003)(99286004)(105586002)(110136005)(54906003)(186003)(2900100001)(4326008)(25786009)(86612001)(5660300001)(86362001)(8936002)(6116002)(97736004)(3846002)(36756003)(102836004)(1076002)(10290500003)(81166006)(8676002)(6506007)(106356001)(107886003)(81156014)(478600001)(72206003)(59450400001)(14454004)(2906002)(6666003)(2950100002)(3280700002)(68736007)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: uXipBjq7RaKmKH88ykBgFJREtPUe3w+rreKNXK/sn7gS2oKeJWwE60QLBh0yA/G/v6j3+ThHncRgdxOX0bRY4G2/GBtY/QVZ3skFMiyB+irM8tV7emU3hyaGWUHPpibxicEP+ol1qjJbhB3vOPUeOWoJdhhBJmkcwyf4PHivq82Klq1qFJOJK3YBsF/8obpkZfJx7ZMdGp5kVgOPoO5BbEqzLstc9zzTDv2n+KuwH4gz5rZCfk2bi4j0+uk4iDtNKx7JmzVdGMJt6vq+B8onetFD9Ok+SbtgmbQVhTy5IdxSU63NLlmqc8Q7F9NOrefDYYdiHL630FT13UmZe79XdA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b49b5e87-227b-4f23-dc33-08d58db2619d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:58.0477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit 018047a1dba7636e1f7fdae2cc290a528991d648 ]

Function devm_clk_get() returns an ERR_PTR when it fails. However, in
function kdwc3_probe(), its return value is not checked, which may
result in a bad memory access bug. This patch fixes the bug.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/usb/dwc3/dwc3-keystone.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-keystone.c b/drivers/usb/dwc3/dwc3-keyst=
one.c
index 72664700b8a2..12ee23f53cdd 100644
--- a/drivers/usb/dwc3/dwc3-keystone.c
+++ b/drivers/usb/dwc3/dwc3-keystone.c
@@ -107,6 +107,10 @@ static int kdwc3_probe(struct platform_device *pdev)
 		return PTR_ERR(kdwc->usbss);
=20
 	kdwc->clk =3D devm_clk_get(kdwc->dev, "usb");
+	if (IS_ERR(kdwc->clk)) {
+		dev_err(kdwc->dev, "unable to get usb clock\n");
+		return PTR_ERR(kdwc->clk);
+	}
=20
 	error =3D clk_prepare_enable(kdwc->clk);
 	if (error < 0) {
--=20
2.14.1
