Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521496517-2-16538896383371031079
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
    t=1521496517; b=UDGn5TAIDXgqpciAF/dIbwX/IlZgYAuQJfuJQclEDvTJm+J
    YjQc88NQgEiXgKDczt/U1RegTMCO32w/EdYI3p3L0BX2HyKKELL3of75EbfBhHcH
    xSVUteiG1Z7x/0ZxfyHQ7PKkDkXlk7hmqyBfhAGzpjohNhnPObDByvU1Kuz/hc8B
    oo9n0TRrnTnrYMO/gLHaneVJKsit6Y6ZBDUlLUhG1w4eHKMGr6SPKiCm36A2fQgf
    iHIIk/4fc3vImIJGP0v6JHcKB/igzXnVViPqYb1Z+4R7QrBIpJvV3dg8UiIWvZln
    Im26UA93Tu02epgs2/bMJpl+UdPp4n3kSbhp2LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496517; bh=pM5c6G
    qOcRCpj8ktTPBnDlmj6Tp1ftjPLI100Y0bug4=; b=NoaCY27f9yXgTSnr+vvQ+7
    RdutYN0kFtburxzxcCx+G+r1UWjUIHAXb5luCXNcUhSXFAIhPQRZZ4MeThmbMIZ+
    qzvBJCA8J4EAqHL/Cyyo+6ljkst/RfwR050ZvnTBwBYUALIoqe5SFcz0bvJx9qTS
    cITiIMHEkCDgiNiit/GkFZblzWZf6PBJvS9yFwaSf9VFgmK7dZu1iPB4XVV/78NV
    Ons6XayaSpCZJmRv33gY7SThPxZqf1cSYpx9By0AITor/YRLxp39iZc/G84vmGgN
    tvTimtigdHiYd7dqlj6J/82ILMqCjaEMqtgZZs/wLejMvB4lDCPpRHiboVP49JOg
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bDHAcNPh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehgihhthhhusgdrtghomhdprhgvugguihhtrdgtohhmnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvdekheenucevlhhushhtvghrufhiiigvpedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bDHAcNPh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehgihhthhhusgdrtghomhdprhgvugguihhtrdgtohhmnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvdekheenucevlhhushhtvghrufhiiigvpedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934642AbeCSP5N (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:57:13 -0400
Received: from mail-sn1nam01on0113.outbound.protection.outlook.com ([104.47.32.113]:22624
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934657AbeCSP4u (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:56:50 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 86/97] Input: goodix - disable IRQs while
 suspended
Thread-Topic: [PATCH AUTOSEL for 4.14 86/97] Input: goodix - disable IRQs
 while suspended
Thread-Index: AQHTv5rVdH6OjC8/AUyNcmKrvu7bsA==
Date: Mon, 19 Mar 2018 15:56:25 +0000
Message-ID: <20180319155411.12348-86-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1064;7:R+t3M//N5RD7HnFVtU3cp8Gl9qujb6sG5LvGobW7CWQAcoCOHa2bewsdAc5QHmKHDwTaSp5ONT17frE0cU5GrHd5Cry9WUMb4On0mLgbrx5EfYbGtCtv2/Md5fbM37cF1QlQ63R/yK+6m6LYcwuk6YIp3d4CfeiubJellOH4CNP8DaJLRgwfGUfExhaOpTJOxiUb9D3vqAdFo1oNnBVIR+cModF7dWq3Ap84iv6HDXmuD78TegnQpVu8307MnD8h;20:virbMyofIM4RQb+ES1USJnkUiQVgKBLZBD54xk042THSqdTIn1h+68zAZd74Ot0PI4so28iXp97zGZBJTOLJApk6ej0BbZGR9TuMcFlFlOInCNAufwn5lNgxX23X0uRaDQ4M7k1nUbEcm2D0bSrVVv0uRqXoRmLZSYX65S2EHQQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6aa929e9-0ba3-4cf2-6816-08d58db202fe
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1064;
x-ms-traffictypediagnostic: DM5PR2101MB1064:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1064A530C82C9F33656FFC07FBD40@DM5PR2101MB1064.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1064;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1064;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(376002)(346002)(199004)(189003)(1076002)(106356001)(316002)(36756003)(76176011)(39060400002)(8936002)(81156014)(81166006)(22452003)(8676002)(3660700001)(59450400001)(2906002)(2900100001)(97736004)(305945005)(7736002)(53936002)(3280700002)(5660300001)(99286004)(107886003)(2501003)(966005)(5250100002)(6666003)(2950100002)(10290500003)(25786009)(72206003)(3846002)(478600001)(54906003)(6116002)(4326008)(105586002)(14454004)(110136005)(6512007)(6506007)(10090500001)(102836004)(15650500001)(66066001)(68736007)(186003)(86612001)(6486002)(26005)(6436002)(86362001)(6306002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1064;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: pPTZ2P/PkgGWUjHiOJS8Lq8QNLAJtV1uzXrXeHBWs4l0ZGlGt15oaNqUyF03ltEA99gInAVOZx3VILRw1MwGDE0BlG+haFS2o6rLiM+r5hNOqbooRdK2RE87jrOtvF+46PJSA6Qhmod1/YgigwnDHVgN54ayuO4ZNozUZrPV41DTO7rbPADzUCw6IHWScdJbz2g4TVYWSb5O1QK8seNfxVUArGAcRFd1ZByf0Hi5o8lBJ6Yqz4xAfathQXQ7YKv6RbOeSghg+3qFFPQGF7mBdirVETas104HNfGs9eBPz5hZa/3oWi40DxspzsQ1kBNpw11+xmauNHTMECTVKi4JFw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa929e9-0ba3-4cf2-6816-08d58db202fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:56:25.0838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1064
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit faec44b6838312484d63e82286087cf2d5ebb891 ]

We should not try to do any i2c transfers before the controller is
resumed (which happens before our resume method gets called).

So we need to disable our IRQ while suspended to enforce this. The
code paths for devices with GPIOs for the int and reset pins already
disable the IRQ the through goodix_free_irq().

This commit also disables the IRQ while suspended for devices without
GPIOs for the int and reset pins.

This fixes the i2c bus sometimes getting stuck after a suspend/resume
causing the touchscreen to sometimes not work after a suspend/resume.
This has been tested on a GPD pocked device.

BugLink: https://github.com/nexus511/gpd-ubuntu-packages/issues/10
BugLink: https://www.reddit.com/r/GPDPocket/comments/7niut2/fix_for_broken_=
touch_after_resume_all_linux/
Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Bastien Nocera <hadess@hadess.net>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/input/touchscreen/goodix.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen=
/goodix.c
index b3bbad7d2282..5dafafad6351 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -808,8 +808,10 @@ static int __maybe_unused goodix_suspend(struct device=
 *dev)
 	int error;
=20
 	/* We need gpio pins to suspend/resume */
-	if (!ts->gpiod_int || !ts->gpiod_rst)
+	if (!ts->gpiod_int || !ts->gpiod_rst) {
+		disable_irq(client->irq);
 		return 0;
+	}
=20
 	wait_for_completion(&ts->firmware_loading_complete);
=20
@@ -849,8 +851,10 @@ static int __maybe_unused goodix_resume(struct device =
*dev)
 	struct goodix_ts_data *ts =3D i2c_get_clientdata(client);
 	int error;
=20
-	if (!ts->gpiod_int || !ts->gpiod_rst)
+	if (!ts->gpiod_int || !ts->gpiod_rst) {
+		enable_irq(client->irq);
 		return 0;
+	}
=20
 	/*
 	 * Exit sleep mode by outputting HIGH level to INT pin
--=20
2.14.1
