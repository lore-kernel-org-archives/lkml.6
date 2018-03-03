Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520122892-2-17317437312120584591
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
    t=1520122892; b=NKl1ri6YrswTbbV48TBXf07F+ul/3mf7x/j6YRQgaTTt5B+
    4SqirOeFHObhVN7vLvEPRiJO+f/Oc28R7OZnDi8XsTIV/R2lGJ1F9Ddh4/Uy9H/9
    w2ZVQ1huVVm6Dv1myA6uz9lchpoA1JhAkPw7axG9pHXPDoKQbFngdOX5Mvt58BXi
    sVmrzBTX4CCIvopGVBsmdkI75r3OO5HBaJo/UqWR6xsolPRMSxAtwjtgChVIqQey
    J9+h227VGVgb2bj9bHrHm6TyTJaeotDvMo1E0yfY/Q0/kDv8jbZ+w23hBh/caFMV
    cdMlDpefjz0oD4LXAZLmL7kwbHw+vwE0OxA3tQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122892; bh=Za8MAv
    C9ZkpW38OvxbUhVND1rMoPYPWCXsAJWcPoEGQ=; b=t546+5QwwesValVtbp6pqS
    8EkcGF6s9RX90l2bvpJCpLqctozPPtoFhacx9k84Svy7fFujDEtmTb7AdeHY23nN
    LcBELAwMxH3K9L9OWtWjjT6xNrTwl9S0o+xqOurJKA9tHdL3j0NqdjVRHP/s74Ax
    qN4XQhTti28YCodD1rrjIr2A3pO1stKERnKud6IO5MUO2VfyBXWPKATa7YVkmVX/
    FENWxEK1aOJLOM1wHxCHbYlWtMYDvtwbbjCqbzKnHuizA4IKxATWvpH9uTyDOOzM
    hi0PcSdnHDMtR/Zn+UWVdFmO8Pi7/NkO8lePfIlD4xOn8VqKUrm3YV2E8cFhMx7Q
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oAp4SoHq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oAp4SoHq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933285AbeCDAVR (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:21:17 -0500
Received: from mail-by2nam01on0114.outbound.protection.outlook.com ([104.47.34.114]:45301
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933269AbeCCW26 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:28:58 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 35/84] drm/etnaviv: make THERMAL selectable
Thread-Topic: [PATCH AUTOSEL for 4.14 35/84] drm/etnaviv: make THERMAL
 selectable
Thread-Index: AQHTsz6ntjYbUsUAvEOAKv/4yat2+g==
Date: Sat, 3 Mar 2018 22:26:20 +0000
Message-ID: <20180303222518.26271-35-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1115;6:uAv5TTDQCqtkZQAtwBOz0jMYiG+FZwyQrcbPNIVLG2zwNueSKEF9OFFy537TdId8BCJkWUvzA9ZIwDtCAOjH/uHtcGh+kNR+jJPpXDOYTp/laGNtxoFpBRFuQ/rgx+pJ9MnmdYm0Vp6HAidRfX0oL5Dq60u49wO9a1vSNSb8XO7iiOy3ZGwSghElCcIKxqcpj3vN35TMAKlhbc5nDWcOmjiAVXtQH7eTvJJduvGcRzNsWtyijJZTSvj7yscyx6kwLjUXWB+JLUJxj9CWkU8k8y3MkoQoDDf9N2+5n6MrggofwkADTzQR4Mtn9B/h5Wy2pNmedQtdxmjmfu6pYS1IE7C73uVRKBNvMrqKBQx3CXP5TtxBmd5KQbFpoonv+vWt;5:WiwE1tZwJMAt0k30ZvFgcdGgx6GR/n+EGVhNXh443/zRTaliALVbdcOtriYzOcbK0QpQ2IBU8FjwLiNGrNUGLLU6/uHWOVCPU9vCmaKe9n/7rcoIpi74pMLnvrmTiHzmsNdl5xO1/cFPKn0YdRTEED63swk0ncRxUhND2ghSYAk=;24:ZhgvxUAt/OiIDaTbGm5DlQ2sTOtCpX+GwKn/DixT4yp5ykRe6R5V/spf0vmr0TJ8ZcVdkNZqZz9DfqZ6k2QVC+baTKCShXJR0YC02UEpiNg=;7:l4Lvl81xWrZuHoaaWTqC93Lgm3yxJ4vK228lwyv1bCPmcGeOrZr8P7aY9L5vx/i+OE1p/qsUmb+V2Q+Z370QfFejmtoZmseVoKWAjvx/bCzrhScQ5tsu7nGBP3ekCLDCu39csdxp0hh8gkmch/K88Yti2bo0Vrvh+ySQS/iO1BhmdytwhdjR8rzl4QLx7KrVmSneg4DFCnvKwzrBqXRplY0jpjmvljpePAPvahMErC2AjcEdtzLTyPbtCXYyY/Va
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 38e11d1b-783a-430e-66b9-08d581562657
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1115;
x-ms-traffictypediagnostic: MW2PR2101MB1115:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1115218DF0FC8DF454E0254EFBC40@MW2PR2101MB1115.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1115;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1115;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(39380400002)(189003)(199004)(26005)(97736004)(186003)(2900100001)(316002)(59450400001)(6506007)(102836004)(36756003)(110136005)(106356001)(54906003)(72206003)(4326008)(8676002)(81156014)(25786009)(2950100002)(6666003)(305945005)(10290500003)(5660300001)(107886003)(14454004)(8936002)(3660700001)(3280700002)(105586002)(81166006)(478600001)(2906002)(6116002)(3846002)(1076002)(2501003)(6436002)(5250100002)(6486002)(68736007)(7736002)(10090500001)(6512007)(66066001)(53936002)(99286004)(86612001)(76176011)(22452003)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1115;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: BfmDAIqtC68ZdEyhI2db+Mppt+3w6Qw7h42yfvhhFyWHRnDsouqITyEmVcPcbkbVA7LaEnjgk7rkHxG7CxeBtbKlfZ67WsmxY6DB0ZkK3TEpi1xtr+9+cFxO+8qk6kQqmmEQNgR0TlNNzTNhJxMmXkf4NFapVPOrrnTcqhXpLk0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e11d1b-783a-430e-66b9-08d581562657
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:20.1973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Philipp Zabel <p.zabel@pengutronix.de>

[ Upstream commit 49b82c389d2a40eaef1355aaa35868b367aec9d1 ]

The etnaviv driver causes a link failure if it is built-in but THERMAL
is built as a module:

  drivers/gpu/drm/etnaviv/etnaviv_gpu.o: In function `etnaviv_gpu_bind':
  etnaviv_gpu.c:(.text+0x4c4): undefined reference to `thermal_of_cooling_d=
evice_register'
  etnaviv_gpu.c:(.text+0x600): undefined reference to `thermal_cooling_devi=
ce_unregister'
  drivers/gpu/drm/etnaviv/etnaviv_gpu.o: In function `etnaviv_gpu_unbind':
  etnaviv_gpu.c:(.text+0x2aac): undefined reference to `thermal_cooling_dev=
ice_unregister'

Adding a Kconfig dependency on THERMAL || !THERMAL to avoid this causes
a dependency loop on x86_64:

  drivers/gpu/drm/tve200/Kconfig:1:error: recursive dependency detected!
  For a resolution refer to Documentation/kbuild/kconfig-language.txt
  subsection "Kconfig recursive dependency limitations"
  drivers/gpu/drm/tve200/Kconfig:1:       symbol DRM_TVE200 depends on CMA
  For a resolution refer to Documentation/kbuild/kconfig-language.txt
  subsection "Kconfig recursive dependency limitations"
  mm/Kconfig:489: symbol CMA is selected by DRM_ETNAVIV
  For a resolution refer to Documentation/kbuild/kconfig-language.txt
  subsection "Kconfig recursive dependency limitations"
  drivers/gpu/drm/etnaviv/Kconfig:2:      symbol DRM_ETNAVIV depends on THE=
RMAL
  For a resolution refer to Documentation/kbuild/kconfig-language.txt
  subsection "Kconfig recursive dependency limitations"
  drivers/thermal/Kconfig:5:      symbol THERMAL is selected by ACPI_VIDEO
  For a resolution refer to Documentation/kbuild/kconfig-language.txt
  subsection "Kconfig recursive dependency limitations"
  drivers/acpi/Kconfig:189:       symbol ACPI_VIDEO is selected by BACKLIGH=
T_CLASS_DEVICE
  For a resolution refer to Documentation/kbuild/kconfig-language.txt
  subsection "Kconfig recursive dependency limitations"
  drivers/video/backlight/Kconfig:158:    symbol BACKLIGHT_CLASS_DEVICE is =
selected by DRM_PARADE_PS8622
  For a resolution refer to Documentation/kbuild/kconfig-language.txt
  subsection "Kconfig recursive dependency limitations"
  drivers/gpu/drm/bridge/Kconfig:62:      symbol DRM_PARADE_PS8622 depends =
on DRM_BRIDGE
  For a resolution refer to Documentation/kbuild/kconfig-language.txt
  subsection "Kconfig recursive dependency limitations"
  drivers/gpu/drm/bridge/Kconfig:1:       symbol DRM_BRIDGE is selected by =
DRM_TVE200

To work around this, add a new option DRM_ETNAVIV_THERMAL to optionally
enable thermal throttling support and make DRM_ETNAVIV select THERMAL
at the same time.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/etnaviv/Kconfig       | 9 +++++++++
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 8 +++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/Kconfig b/drivers/gpu/drm/etnaviv/Kcon=
fig
index 38b477b5fbf9..4df3c48adcec 100644
--- a/drivers/gpu/drm/etnaviv/Kconfig
+++ b/drivers/gpu/drm/etnaviv/Kconfig
@@ -6,6 +6,7 @@ config DRM_ETNAVIV
 	depends on MMU
 	select SHMEM
 	select SYNC_FILE
+	select THERMAL if DRM_ETNAVIV_THERMAL
 	select TMPFS
 	select IOMMU_API
 	select IOMMU_SUPPORT
@@ -15,6 +16,14 @@ config DRM_ETNAVIV
 	help
 	  DRM driver for Vivante GPUs.
=20
+config DRM_ETNAVIV_THERMAL
+	bool "enable ETNAVIV thermal throttling"
+	depends on DRM_ETNAVIV
+	default y
+	help
+	  Compile in support for thermal throttling.
+	  Say Y unless you want to risk burning your SoC.
+
 config DRM_ETNAVIV_REGISTER_LOGGING
 	bool "enable ETNAVIV register logging"
 	depends on DRM_ETNAVIV
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnavi=
v/etnaviv_gpu.c
index fc9a6a83dfc7..a1562f89c3d7 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1622,7 +1622,7 @@ static int etnaviv_gpu_bind(struct device *dev, struc=
t device *master,
 	struct etnaviv_gpu *gpu =3D dev_get_drvdata(dev);
 	int ret;
=20
-	if (IS_ENABLED(CONFIG_THERMAL)) {
+	if (IS_ENABLED(CONFIG_DRM_ETNAVIV_THERMAL)) {
 		gpu->cooling =3D thermal_of_cooling_device_register(dev->of_node,
 				(char *)dev_name(dev), gpu, &cooling_ops);
 		if (IS_ERR(gpu->cooling))
@@ -1635,7 +1635,8 @@ static int etnaviv_gpu_bind(struct device *dev, struc=
t device *master,
 	ret =3D etnaviv_gpu_clk_enable(gpu);
 #endif
 	if (ret < 0) {
-		thermal_cooling_device_unregister(gpu->cooling);
+		if (IS_ENABLED(CONFIG_DRM_ETNAVIV_THERMAL))
+			thermal_cooling_device_unregister(gpu->cooling);
 		return ret;
 	}
=20
@@ -1692,7 +1693,8 @@ static void etnaviv_gpu_unbind(struct device *dev, st=
ruct device *master,
=20
 	gpu->drm =3D NULL;
=20
-	thermal_cooling_device_unregister(gpu->cooling);
+	if (IS_ENABLED(CONFIG_DRM_ETNAVIV_THERMAL))
+		thermal_cooling_device_unregister(gpu->cooling);
 	gpu->cooling =3D NULL;
 }
=20
--=20
2.14.1
