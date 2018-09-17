Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B7CECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A293C208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="c4QQWik3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A293C208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbeIQIxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:53:37 -0400
Received: from mail-by2nam03on0117.outbound.protection.outlook.com ([104.47.42.117]:22121
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728680AbeIQI2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JK2gpGXcMn+WvFVIHoDXTePumnDwXByvxFbwb60jNbM=;
 b=c4QQWik300jmOsi0Wv4xNOLaAH4BAdc4fvt7H5fLPS2nWLGeUqDQpvU8MVha8M+QWm+c32EWUxdbDoBlqTV+pr2mTImGqcJFi7UHH7NyiCBOTV1bR5olCls4RxUA4qqVJ2iBg/0GvdmP3Ri5ZI4F/i9Luy77RAjrZeSg8ipVGmo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0168.namprd21.prod.outlook.com (10.173.192.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:02:47 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:47 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 116/136] ASoC: rsnd: SSI parent cares SWSP bit
Thread-Topic: [PATCH AUTOSEL 4.18 116/136] ASoC: rsnd: SSI parent cares SWSP
 bit
Thread-Index: AQHUTjK4yU3g543kp0SmZR7WTCyNDw==
Date:   Mon, 17 Sep 2018 03:01:24 +0000
Message-ID: <20180917030006.245495-116-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0168;6:ElikckgMdhhOdiCKiHSataQLaxA1C1QQtWPtR58pDczIFrECjjbJHoX3GhwQYDO3LdfQiCN3MHYDSBBiTh4B1mRz++SaPkFwhIXY2Qy2VFfCx/R+PFRaExn37pPomTwz6i7UetlJWsDcV+PnKED7Clk4++zvXxkubMK3p1iroSWMq/sHRLfB60YVT/4oOeyrgm6ql/jM3s6K7H8D9b1+zuo/N+VtshkATa2aQGb3t1xxWR2WB/FdvWrpNTffMqpZpo1HE0Kdh+4awyeh9B3rzOxa3AkiQaRdyfbGdeuOkhqU9Vc1wzZgF6AunQ9ylUn+hxm8qi542s3DKvgkrbW2YX5uYUpGr9Bi4mpIelKDNOU9Qc0cbUgxQ2QX+O2G9HosZEzRT4hbghtzZaTjaMvLK1XHuZf3QwsyyCDvF5GmIH+gCSYsqO/4EBZdfLs8qpqDEG4WV5lVxAbhL6iNMh96Hg==;5:wob0B2B8RAap78mBOHBxeYJgOkd0iqM0i+KmgxaAnOypJqSIyPNa0EQXv76xa1puqggyxX5nPTyn0v17PaVqoqNRiyJnusQ+UyheYwEJuXa1DDFOL6i0zth+gMpJc4nDAGwFn2MTJ1GbgVFI8DZZSUASClKGH9z4q0/a1kTTBoc=;7:pXxqMY26Sfu/QYHY33AsNrweh4P8N/MO72EsLCXKo0Nr126FKNY7f4zHlAZ4b41P703YNWkAW4jENuyxcouUy7DRttLE8j+SY5ZGHycIHigpsFjj4k+UT7dqPmdfdTIFsc9SoF/AAjImwh5wOlX1J0TdkwGUuJVjzgrm/KFNhbqXQvxhu7G+BjznjfNcECkhkLv7i1N3A4cXW1L9KGQSlXRSH2+rc6bl05HZhNN8lZU0XI53B18sZ6D1qW3/CGuI
x-ms-office365-filtering-correlation-id: fa3f6f4c-2205-49ae-2f24-08d61c4a0be1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0168;
x-ms-traffictypediagnostic: CY4PR21MB0168:
x-microsoft-antispam-prvs: <CY4PR21MB0168F83F10EC915B41D1E825FB1E0@CY4PR21MB0168.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0168;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0168;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(136003)(199004)(189003)(11346002)(4326008)(105586002)(106356001)(486006)(446003)(6436002)(2616005)(22452003)(107886003)(10090500001)(25786009)(476003)(14454004)(110136005)(54906003)(316002)(2906002)(76176011)(99286004)(36756003)(186003)(26005)(6346003)(5660300001)(7736002)(305945005)(10290500003)(8676002)(81156014)(81166006)(6486002)(68736007)(6666003)(102836004)(6116002)(3846002)(1076002)(53936002)(217873002)(72206003)(97736004)(6506007)(8936002)(86362001)(256004)(6512007)(2501003)(5250100002)(2900100001)(14444005)(478600001)(66066001)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0168;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: FoMcqOEXUiKiWrYeKoAtIo2ysP31epIcGFh4yS6wMNnaoYVHMyVfFha0SVE7Ly2ixcvcOHOhjqbokFUgewN0G2SV+TJUGzQTfJqbRbqPJJurz4r7lwpAk3m6j2z0u0dehnxfCV1EdpifQcrccPYZg5wgx3gzjl0+ZS5EyHbdN/ROsoDvI5I07VlAFACRFkCsUqBU9d0de32KEHZDIAXUyOL0IEOD3a/Z4HoeE9AU5iF+6DVM0e3DXTl2EjjoIWZ45Zrh9dZGOuJBEwxGCY12AnLuBzChJUMOVDcXDZ4cJ416X0P4V6CU/iP9urseOjxlWeTneu5urUcdP8L9g0XAzjMGeF1QnAHKGuZwf34XcTM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3f6f4c-2205-49ae-2f24-08d61c4a0be1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:25.0259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit 203cdf51f28820bee7893b4be392847418e6f4ec ]

SSICR has SWSP bit (=3D Serial WS Polarity) which decides WS pin 1st
channel polarity (low or hi). This bit shouldn't exchange after running.

Current SSI "parent" doesn't care SSICR, just controls clock only.
Because of this behavior, if platform uses SSI0 as playback,
SSI1 as capture, and if user starts capture -> playback order,
SSI0 SSICR::SWSP bit exchanged 0 -> 1 during captureing, and it makes
capture noise.
This patch cares SSICR on SSI parent, too.
Special thanks to Yokoyama-san

Reported-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/sh/rcar/ssi.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 6e1166ec24a0..dbd13ac2b000 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -37,6 +37,7 @@
 #define	CHNL_4		(1 << 22)	/* Channels */
 #define	CHNL_6		(2 << 22)	/* Channels */
 #define	CHNL_8		(3 << 22)	/* Channels */
+#define DWL_MASK	(7 << 19)	/* Data Word Length mask */
 #define	DWL_8		(0 << 19)	/* Data Word Length */
 #define	DWL_16		(1 << 19)	/* Data Word Length */
 #define	DWL_18		(2 << 19)	/* Data Word Length */
@@ -353,21 +354,18 @@ static void rsnd_ssi_config_init(struct rsnd_mod *mod=
,
 	struct rsnd_dai *rdai =3D rsnd_io_to_rdai(io);
 	struct snd_pcm_runtime *runtime =3D rsnd_io_to_runtime(io);
 	struct rsnd_ssi *ssi =3D rsnd_mod_to_ssi(mod);
-	u32 cr_own;
-	u32 cr_mode;
-	u32 wsr;
+	u32 cr_own	=3D ssi->cr_own;
+	u32 cr_mode	=3D ssi->cr_mode;
+	u32 wsr		=3D ssi->wsr;
 	int is_tdm;
=20
-	if (rsnd_ssi_is_parent(mod, io))
-		return;
-
 	is_tdm =3D rsnd_runtime_is_ssi_tdm(io);
=20
 	/*
 	 * always use 32bit system word.
 	 * see also rsnd_ssi_master_clk_enable()
 	 */
-	cr_own =3D FORCE | SWL_32;
+	cr_own |=3D FORCE | SWL_32;
=20
 	if (rdai->bit_clk_inv)
 		cr_own |=3D SCKP;
@@ -377,9 +375,18 @@ static void rsnd_ssi_config_init(struct rsnd_mod *mod,
 		cr_own |=3D SDTA;
 	if (rdai->sys_delay)
 		cr_own |=3D DEL;
+
+	/*
+	 * We shouldn't exchange SWSP after running.
+	 * This means, parent needs to care it.
+	 */
+	if (rsnd_ssi_is_parent(mod, io))
+		goto init_end;
+
 	if (rsnd_io_is_play(io))
 		cr_own |=3D TRMD;
=20
+	cr_own &=3D ~DWL_MASK;
 	switch (snd_pcm_format_width(runtime->format)) {
 	case 16:
 		cr_own |=3D DWL_16;
@@ -406,7 +413,7 @@ static void rsnd_ssi_config_init(struct rsnd_mod *mod,
 		wsr	|=3D WS_MODE;
 		cr_own	|=3D CHNL_8;
 	}
-
+init_end:
 	ssi->cr_own	=3D cr_own;
 	ssi->cr_mode	=3D cr_mode;
 	ssi->wsr	=3D wsr;
@@ -470,15 +477,18 @@ static int rsnd_ssi_quit(struct rsnd_mod *mod,
 		return -EIO;
 	}
=20
-	if (!rsnd_ssi_is_parent(mod, io))
-		ssi->cr_own	=3D 0;
-
 	rsnd_ssi_master_clk_stop(mod, io);
=20
 	rsnd_mod_power_off(mod);
=20
 	ssi->usrcnt--;
=20
+	if (!ssi->usrcnt) {
+		ssi->cr_own	=3D 0;
+		ssi->cr_mode	=3D 0;
+		ssi->wsr	=3D 0;
+	}
+
 	return 0;
 }
=20
--=20
2.17.1
