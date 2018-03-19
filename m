Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3764808-1521493590-2-11768863161195246887
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
    t=1521493590; b=p5GFUaPDbpoHQ8QuobRuxwPLa4a5T/Buhhv/TZ+8wVZ8ECf
    fLSxGxvkXGoxqgsV6i5hNoamiB1C4ZMRvGRNHCsEhMGL3S3KOzTxhSd79Fpy/31t
    7hEtpZAKTWHN3tOqv5UIBY0VcI1mVlk5fPHXL7teBnZLxtpJf/EySQg3P1mWed8W
    gDuyYWLtOgKFt3sSiSE3/KAZd1FqADYawD4GtZe+LbdB6QK8COSWtPEj18L/zNog
    ol6NuETu6YrXxttjySgHmZvqwKPQ3HLWlLBcoRyVZYef5anR9diZAQ+ZaIYWN/yN
    RURFdv8S+Louu8QgzODEoX2JhDVMTN1xtpl8Dlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521493590; bh=23Aig3
    GQ0jPnUpwVTDuHDH2Pm48hvCKM38Z7yryGg+Y=; b=n434fW9gd/udkVOTfVQICE
    FHyMqZCX6YBajIRaT2BJ2XSppXq4JkptcxaOcKvNBnJowbh20dh6LTLImQCPJ+mb
    uV1urmWnGOY7SgBUR0KQcpfpDHFLuy06mXJCgqarn5s7BDq9px5QAhiFvmSnbWA5
    U0We67WE9WliIzxgqJAgYUsFgTQP+9YfXuB8gstRBrAwKV0D2SgFJf4nP+Ouvtb2
    oYmv9ZApD4KtA2LUXCI8/KTXbtxG70qd37cuB7zqENO/DUtck8h5Li8LjXeefEq1
    +GbgsZB9wycIprWptRXKv7AqxvjRbIXSLi0+LfqCVjUdCzO9Q8b3OBhxMOXQ1lDw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DsXzyBIK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejieeikeenucevlhhushhtvghrufhiiigvpeduhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DsXzyBIK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejieeikeenucevlhhushhtvghrufhiiigvpeduhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934680AbeCSVFc (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:05:32 -0400
Received: from mail-co1nam03on0123.outbound.protection.outlook.com ([104.47.40.123]:22550
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965357AbeCSQCJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:02:09 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 147/281] pinctrl: baytrail: Enable glitch
 filter for GPIOs used as interrupts
Thread-Topic: [PATCH AUTOSEL for 4.9 147/281] pinctrl: baytrail: Enable glitch
 filter for GPIOs used as interrupts
Thread-Index: AQHTv5txJsNvnfNnJE2BHIsn1O+twg==
Date: Mon, 19 Mar 2018 16:00:47 +0000
Message-ID: <20180319155742.13731-147-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0933;7:H7O1k3UOIPJQ2PRvTY5PEj2hsYVfIcLL7f4VQ6fgIUddAE7nyBZcb4PfxtD7m3zMcHNEXaJPh478lmgM40b++ZRoHlatY7x275TNvK8de9znfce3e2ryWdOE8EoKLF3JV5uUQPhNwcYV/K5iAq/pH1BDfq7/w2xnKH+8yyUpG/q96WBCIGwHHj568JjN3ebs2zl7h5J8Wi/cE9il47O3zaYyVeYmEkM9usNlcEazoWkhL/3nyeGSg4wwMCA0sPoU;20:uBmP1OqcxPzD41RBxMhFA6dOBsGqWPCd92BvW+GvnFo/o/JZoBbw+j0HNatSNNipxZ/XOQxJwYBPqoLzn4DYARpb59YqClrChk0qFEI0AxTWYmxGsQz4Tqeyp+2Jpf8+UGbiSecywCq346z+hvXpOSQmr1IIZeIMIin3WmPlOnM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: be4e0cd4-8e70-4afd-6abb-08d58db2bf43
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0933;
x-ms-traffictypediagnostic: DM5PR2101MB0933:
x-microsoft-antispam-prvs: <DM5PR2101MB0933DEBFF919F37B61F7F67AFBD40@DM5PR2101MB0933.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0933;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0933;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(346002)(376002)(199004)(189003)(2501003)(72206003)(1076002)(66066001)(10290500003)(99286004)(10090500001)(7736002)(14454004)(6116002)(5660300001)(2906002)(97736004)(6666003)(6346003)(102836004)(22452003)(86612001)(3660700001)(186003)(2900100001)(25786009)(478600001)(5250100002)(26005)(5890100001)(6486002)(6436002)(81156014)(81166006)(36756003)(4326008)(86362001)(76176011)(6512007)(8936002)(106356001)(3846002)(53936002)(105586002)(3280700002)(305945005)(68736007)(110136005)(2950100002)(54906003)(8676002)(107886003)(316002)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0933;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: dQdIOMvXFXmjQgxpY1HcACBpwOt5BYWvtfMr8+1fN2eflxzfX6uaZ9mQL6243gn4uWidUDxECemwA+jSuakTS4s5zZsju+UE19UuIJbtNCcw8hZbjEcXCPaa3QiJ4DIth6UIKRwrGDxjIyfGRajKQUOowvWI8kyIXLyj9RJZRI+1v8WvflfgDxZtpjcZF7V/+vpXm900kB6kTWR24aycC18XH1sgzbyc9+5/n3CdXwa2vcr1E2mqgf3VL5ehI3BaJtxHJZpyT3DOuBdwP1W9aZJ3yaJDZIArJNLv2vIvtydV1sbRgqDWJCfKnIgkgFOuahTURn1603y5nqmCWbki6w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be4e0cd4-8e70-4afd-6abb-08d58db2bf43
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:47.3826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0933
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
index 0a965026b134..fc5b18d3db20 100644
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
