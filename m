Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A5CECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 13:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB8E20843
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 13:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mpV8BdUg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB8E20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbeJUVZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 17:25:27 -0400
Received: from mail-he1eur01on0045.outbound.protection.outlook.com ([104.47.0.45]:64912
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727477AbeJUVZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 17:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIf2COuK0zLkMJh3lpZjsWmlj8zfmdBSe3G9aAkENZE=;
 b=mpV8BdUgVVh+vzvIzJ+AMUdeYWd5iUDuiJe7c7X5DOGkXEoTUtgjBKlNrEQFod9Lsgy2MAC+dcZN5QXUfHi+XGEAAikAGrL/ECLEIVDfHvJgUCMjCHE+ZzvFOjPjijVjw8WwvK3/mqUyHqmf3ATliXOLIAO4ngxPf4FyTnf3IkU=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4580.eurprd04.prod.outlook.com (52.135.149.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Sun, 21 Oct 2018 13:10:52 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10%2]) with mapi id 15.20.1250.028; Sun, 21 Oct 2018
 13:10:52 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH RESEND V4 2/9] clk: fractional-divider: add
 CLK_FRAC_DIVIDER_ZERO_BASED flag support
Thread-Topic: [PATCH RESEND V4 2/9] clk: fractional-divider: add
 CLK_FRAC_DIVIDER_ZERO_BASED flag support
Thread-Index: AQHUaT9+IL/E0HVOXUillU8lJDIyeg==
Date:   Sun, 21 Oct 2018 13:10:52 +0000
Message-ID: <1540127173-21346-3-git-send-email-aisheng.dong@nxp.com>
References: <1540127173-21346-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1540127173-21346-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::22) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4580;6:AUwSgMT5quNafxRuVsCHpQ9/8xVc3HnrndW8GVqS3hlo5Sc2wEXSgPYg2CyENB8IVuHmaOQ104GqEOySufZhFC8d9lIG2r+2us9zCL79MjcgMurUBf6mwnUuuDPX/L74CgRQIhzNDKnLDJMCacHUIjxIJW6Vw06x3HwJ3gqKUPnQfA9hab4NYgtMIIc56IW2MNPb14aur5S5lqfyolC6EQR44QcXhxuwsTMqLG552u0MidHQUEGurHOF93JNn9JIJnYYBnh76gk7nEDO+24g+o1b0DKUhkfVMOl7FjFW99aZQRy5QUhCwXddtEXDj5DOCnoc2v1uhzsfsvkFTsIA3FTOgpBhemM6yHHDjG9Az1W3RQAYyocVFNFahpLd1pukx+651vE1JT+/n3VVTxpFdJaH4g55xM89ucRajETateXpcatuVUibVaVmRKQvRvEHCBXm6x+9gCXqX0mcPEkiUg==;5:/bwLz9HtUlKXSWDHPaZD+E+C/XGKbxH8Pnl0B8D/ZXW5lsmqLhL7uUA/7gmIq3AkDArXkTbJ85XqNVdqaCczu1EY9xA9eS4B45/tmZnuZh57kLSc9O5PgijiK72faotmnp9OW3tq0Kl9XDGlGM+ya8m/aqFVQx0P7Jof1+xPmr4=;7:wTdLkxDW76zZ6z97SlHnFj2VbQx+tDNr5bJPQKWxmogAMrYp0gNBhsbj72JglXCFZCD8gUQ5PMhBshIVgq/YXUzbgWMPG5DS+VxExdmLPQucUT71D2EeUtiOX6Tuw2ug/PvubG47ELksHTHrcNlR9YYLH5OTwBBbcTCEOoeb18rGAyPdIn2atIjKBMcG1prisOemDDHxCa66E1aK9TEolamFw0gwCWbN8vvJ2/VWgzKXrJapXdDIGCMEwg7l8tG8
x-ms-office365-filtering-correlation-id: 6a63d259-e2bc-4333-8180-08d63756a0a1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4580;
x-ms-traffictypediagnostic: AM0PR04MB4580:
x-microsoft-antispam-prvs: <AM0PR04MB458096066170F7A56C3A0C8F80FB0@AM0PR04MB4580.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4580;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4580;
x-forefront-prvs: 083289FD26
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(346002)(39850400004)(136003)(54534003)(199004)(189003)(476003)(2616005)(11346002)(446003)(66066001)(54906003)(316002)(26005)(52116002)(99286004)(486006)(186003)(7736002)(386003)(6506007)(305945005)(102836004)(105586002)(76176011)(50226002)(86362001)(106356001)(256004)(14444005)(81156014)(81166006)(217873002)(8936002)(8676002)(6916009)(5250100002)(25786009)(2900100001)(2501003)(68736007)(71190400001)(2906002)(5660300001)(14454004)(3846002)(4326008)(6116002)(6512007)(53936002)(2351001)(6486002)(36756003)(71200400001)(478600001)(5640700003)(97736004)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4580;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cyURRt/tT4mYaOxTFkFgx+h+4kJ75PH7rDl8A6nLCBniYIkChJtrojwyHE3lUMZJfeIGtHD5hMkRNGB4wvkzzhatRmwMMDTkIGQBlv2yL49JAK3BK5mJUp061s//Ipp+IeKhjawRnJMICXgFNzsTj69lj03Vx9Mk5jrCgBDDfmhGPHNYuFZfZ1WVub5jUwH5eVi1hfjhoTeJItGZsVb0McDFlWpxop6s/t4za3KGWOWQK5LssaYHuwmb6cqGYr4ZXfjjw5j67TTYWqognSlC00jGzUaqc+xT9+GPfzUmRY8O2YfZBBx/Q71v04ii1jPqRsfhG20zBKWFJSQPNPMlWiqdorwOFF1r3oBoZAwCDpM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a63d259-e2bc-4333-8180-08d63756a0a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2018 13:10:52.6158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4580
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding CLK_FRAC_DIVIDER_ZERO_BASED flag to indicate the numerator and
denominator value in register are start from 0.

This can be used to support frac dividers like below:
Divider output clock =3D Divider input clock x [(frac +1) / (div +1)]
where frac/div in register is:
000b - Divide by 1.
001b - Divide by 2.
010b - Divide by 3.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
v3->v4:
 * no changes
v2->v3:
 * no changes
v1->v2:
 * improve comments suggested by Stephen
---
 drivers/clk/clk-fractional-divider.c | 10 ++++++++++
 include/linux/clk-provider.h         |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractio=
nal-divider.c
index fdf625f..7ccde6b 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -40,6 +40,11 @@ static unsigned long clk_fd_recalc_rate(struct clk_hw *h=
w,
 	m =3D (val & fd->mmask) >> fd->mshift;
 	n =3D (val & fd->nmask) >> fd->nshift;
=20
+	if (fd->flags & CLK_FRAC_DIVIDER_ZERO_BASED) {
+		m++;
+		n++;
+	}
+
 	if (!n || !m)
 		return parent_rate;
=20
@@ -103,6 +108,11 @@ static int clk_fd_set_rate(struct clk_hw *hw, unsigned=
 long rate,
 			GENMASK(fd->mwidth - 1, 0), GENMASK(fd->nwidth - 1, 0),
 			&m, &n);
=20
+	if (fd->flags & CLK_FRAC_DIVIDER_ZERO_BASED) {
+		m--;
+		n--;
+	}
+
 	if (fd->lock)
 		spin_lock_irqsave(fd->lock, flags);
 	else
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 08f135a..90d7c26 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -603,6 +603,12 @@ void clk_hw_unregister_fixed_factor(struct clk_hw *hw)=
;
  * @lock:	register lock
  *
  * Clock with adjustable fractional divider affecting its output frequency=
.
+ *
+ * Flags:
+ * CLK_FRAC_DIVIDER_ZERO_BASED - by default the numerator and denominator
+ *	is the value read from the register. If CLK_FRAC_DIVIDER_ZERO_BASED
+ *	is set then the numerator and denominator are both the value read
+ *	plus one.
  */
 struct clk_fractional_divider {
 	struct clk_hw	hw;
@@ -622,6 +628,8 @@ struct clk_fractional_divider {
=20
 #define to_clk_fd(_hw) container_of(_hw, struct clk_fractional_divider, hw=
)
=20
+#define CLK_FRAC_DIVIDER_ZERO_BASED		BIT(0)
+
 extern const struct clk_ops clk_fractional_divider_ops;
 struct clk *clk_register_fractional_divider(struct device *dev,
 		const char *name, const char *parent_name, unsigned long flags,
--=20
2.7.4

