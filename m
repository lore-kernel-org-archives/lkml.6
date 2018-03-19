Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521496989-2-8559893938661701089
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
    t=1521496988; b=b3LonYWXANni7slEWSkh4GHmMxtporqUn8w56OczYVW/PT3
    GNk8s8NlyObMMDl6aIU/fFUeV3S3cVKYEx098h2D31gWyud/nSST0S6pqCUX7te7
    /62Sbni7mLsRlg/dz6OmadR76qvFl0Jet++VcJu4vVs/T3m3H5yHJNmWRNFrDYOX
    nU5Ha3kRGzLzpKExISfz3/uAn9Irtexnq9zzbNOvSALLMqT8RKsiFStx76ZI5kAy
    BegsL62vkaekGTFgf3U3CjibJNuzWCjpIJTeC26LdDL8xDazI03uPUHjoZ3/Hrq1
    edUYjWPxSk9PoYE5woVVaQWDWB46EpkkfLfFE2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496988; bh=L71erd
    WpGx/DGx3DPtZ+82IZvxTLdIOAOMphmBxL6P8=; b=UqmSUfgdMv0gj6/ZpMIMmQ
    CHpZ1yNnX+qxHdL7pWUCQ6U4jW9qxvrzlOC3VPZnfr6kmLQfN2CNiBPDl/rubQK3
    dPooaQZaGDkWvAYgJcHYOLpNw7g53uVKe8QUsqA3AUDUlesJcv6QMIgS+Vez2P1T
    te51s6Hbf49Tgc+PlACEXyN7bp6HWUq4GUlgfvgz5uo0NxIVa7hBnKXIC4eMcR7x
    jZK0JLSVPU8KY7n+edK92As8O66J35GD0PBRaFP5Q6N3NScR1+SakVIGs07bPByf
    LEaz3wP4PgqVV1Zy6Auw7Ipoj8v1BSmzikMjBxWHeGOYkIibmvfTuIRY/O5Ngscg
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=icUJCAEl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejieehgeenucevlhhushhtvghrufhiiigvpeegje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=icUJCAEl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejieehgeenucevlhhushhtvghrufhiiigvpeegje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934424AbeCSWDE (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:03:04 -0400
Received: from mail-by2nam03on0129.outbound.protection.outlook.com ([104.47.42.129]:43956
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933556AbeCSPz4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:55:56 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 46/97] pinctrl: baytrail: Enable glitch
 filter for GPIOs used as interrupts
Thread-Topic: [PATCH AUTOSEL for 4.14 46/97] pinctrl: baytrail: Enable glitch
 filter for GPIOs used as interrupts
Thread-Index: AQHTv5qxTrlSnylby0WTM94r2Q/eiQ==
Date: Mon, 19 Mar 2018 15:55:24 +0000
Message-ID: <20180319155411.12348-46-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0967;7:uunfVNt17DaWVJMyTF5qWF3l7+elX+Yc9PRjs/phgoRt8i2uDiOM31/Bq+6eAYrRKuUS7AdXw1oDDuA6HsS/Aemb0nJQ2e4j+skaV1JoAZ7P/IESaIxIufcoMSsQ3QD6dxuAmEcamm5E/mY17+PbdkBAfobB0yqCX0q4s+OhXPH4vI/Yya7c1Js+k3Bj1X75erjK5CjvPcl87P+IMOQYrGD05Vv9Fonr1Qokm+JeU8cxs5eKke+0+4Z/OM7u8Z9z;20:OSmclDlSxc7Ubw+H991kPoE+jss+xdFwIpXU98h7SBxwJIndPK0kVcqEc1WcKuecrqH1eFeZudHdu1j87MhWf9FWXybRSRU4ZQckUN9iP8qQwJaIx21T3oZHIyy8gT4MmsBB+q+A1d9TPcMfy/EC5PglJ96omexYJGwPDN+MFkI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 443f5e70-9f70-4fce-5154-08d58db1e1a0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0967A52BA21DA7FC292017EDFBD40@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0967;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0967;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(376002)(39860400002)(366004)(346002)(189003)(199004)(54906003)(10090500001)(110136005)(5250100002)(5890100001)(2501003)(1076002)(6116002)(3846002)(2900100001)(99286004)(22452003)(3280700002)(186003)(2906002)(76176011)(86612001)(26005)(6486002)(10290500003)(102836004)(14454004)(36756003)(68736007)(3660700001)(72206003)(478600001)(107886003)(106356001)(53936002)(6506007)(6512007)(6436002)(86362001)(105586002)(316002)(7736002)(4326008)(305945005)(66066001)(81156014)(81166006)(5660300001)(97736004)(8936002)(25786009)(8676002)(2950100002)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0967;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: ulGb6HEgrNfGNERf7BPdJpt/Z0tVFJpRgxiPfDtSthZ05yY4muU3nRZyai1yd1pPfStAW7XzxBiJGlz7u8XFmpyUdaywkBGlVkE7laBe4fvM/x9O1L7g8DKLpQf2s9NYBoehpXXRAFcCtKp1gO5ZMv5ZKYAGBQmp3/4WZjeIKS5WtPSLVtycaoFh5LvcTDI4+WYCQxDJxJjKvu8nlND2ymZwodkY552WoVm+bgB2vwLJpC9fNIfRI+OcHYX1legLH3UhP4Qb6VVbQRBUR2emTASY2FIT68/AFooL6pcgK4pvpmeTNCSKnoFNRV/rUemjVy/mJpJVMZ1Si+1KcMXstA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443f5e70-9f70-4fce-5154-08d58db1e1a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:55:24.8446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0967
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 9291c65b01d1c67ebd56644cb19317ad665c44b3 ]

On some systems, some PCB traces attached to GpioInts are routed in such
a way that they pick up enough interference to constantly (many times per
second) trigger.

Enabling glitch-filtering fixes this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pinctrl/intel/pinctrl-baytrail.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/int=
el/pinctrl-baytrail.c
index 0f3a02495aeb..beeb7cbb5015 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -46,6 +46,9 @@
 #define BYT_TRIG_POS		BIT(25)
 #define BYT_TRIG_LVL		BIT(24)
 #define BYT_DEBOUNCE_EN		BIT(20)
+#define BYT_GLITCH_FILTER_EN	BIT(19)
+#define BYT_GLITCH_F_SLOW_CLK	BIT(17)
+#define BYT_GLITCH_F_FAST_CLK	BIT(16)
 #define BYT_PULL_STR_SHIFT	9
 #define BYT_PULL_STR_MASK	(3 << BYT_PULL_STR_SHIFT)
 #define BYT_PULL_STR_2K		(0 << BYT_PULL_STR_SHIFT)
@@ -1579,6 +1582,9 @@ static int byt_irq_type(struct irq_data *d, unsigned =
int type)
 	 */
 	value &=3D ~(BYT_DIRECT_IRQ_EN | BYT_TRIG_POS | BYT_TRIG_NEG |
 		   BYT_TRIG_LVL);
+	/* Enable glitch filtering */
+	value |=3D BYT_GLITCH_FILTER_EN | BYT_GLITCH_F_SLOW_CLK |
+		 BYT_GLITCH_F_FAST_CLK;
=20
 	writel(value, reg);
=20
--=20
2.14.1
