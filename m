Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1379734-1520124125-2-15906550034530170576
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
    t=1520124124; b=oyTIpr+BOBURYbXVhYQbkTNvmyDcvvFdcL4vFXr5wdiREgS
    mYf3Znpf53EgNWqwCHgl8Pb+h0zFLxZJG26Vg0ZlA+Uf1yeOSH4fAvk0Nm1laLoC
    GM5BlES68g6oT5nU1a18jF0ZkgNZQQJOa88WKFwxLdc/P9RJoOsoSMeMNsTl4BKj
    ATStLspXVw3oy3M7KvF8zDcnaOMBlBB11thnplVMKQ+3TAkogIcEkXMEDLsO5xo/
    OEuPzPuPikGpeQA45H6GY7eqzfGzd7ARzIrNOS+Y2pQaWAMORyOA4aD/v5zq1+fb
    lVcMAeWBeKIU7hfv9ORHGCTdiarAt328rPVRp8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520124124; bh=RYf3zj
    I+B3sEMWDW3Fi7V3ywYmuycJHNsz9n7fHmp0g=; b=cE6Ft50lURtsHwJ1J8Eud+
    6Qhv3/tPgDsNY0qRBNixyn1NoeY/0CgMFqHOMukbV+t/DaREI0kAczLjGkbk7S5I
    xwwX42lWGV3PR7UQqAIH54Sf0gXvNoP0XodlPE6Y7SdmfCtYWlP1PXOe/d52YvOL
    ltRxiQ8RdHD9GffNvsCXbjeT6dRYNJoZ/HVKQW3ZkFltQ4SR4ZEV02WxTEy6XLEa
    +6i4p0iqwwIxvDbm5RWRgJUuJWSyYHyloeNKahk3SCucAQixDkjALCxSOySwfy8L
    dcs8Cw5cDkQzLP+2cegPYPOhS84uS7n4zbm7eXN74PWUXbglsTkdw1VVVb7MO6xw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HerqiG8s x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HerqiG8s x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932880AbeCDAle (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:41:34 -0500
Received: from mail-bn3nam01on0098.outbound.protection.outlook.com ([104.47.33.98]:35904
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932612AbeCCW0Q (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:26:16 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 047/102] drm/etnaviv: make THERMAL selectable
Thread-Topic: [PATCH AUTOSEL for 4.15 047/102] drm/etnaviv: make THERMAL
 selectable
Thread-Index: AQHTsz5pW/IKulnklE+Ff+A2DuFWKw==
Date: Sat, 3 Mar 2018 22:24:36 +0000
Message-ID: <20180303222318.26006-47-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;6:jlBe+Jg+P4OLTYCA5ZZLvHxasLdWcsrkmDWyb20rmlHGnq9++hsTuEfoPxivGuAnORd2FeDzGq1RiB/s9Rx6qWP0z8hQhWTSj82MD7iGAIZua0siCM5QNLkuoSTY6lNyEZQrdIvo3wYWFdeM5R6RgyRHjDI2A22W90W04qqWDBfRE2SMkUynCwpe1GP1Cy8/jIKhBnebvXpJGJgbNzeABj+dV0+xX+qVTnSU6aXXnqqzu7KVKPRRzq8uMyu7JA0opRwiJtWDIcRS0T9O51Ke9OuX8p1CYax2mXLRT0M3W7yeUg/2t4XoaHPt4P9SUBl+99VePgWyb6dmU97K8clSbquGxG9gpGGk74FlyY+adSb0M8nr3tOiL6W33d0Ld0yd;5:9qVwy4NZclztbPTgQ8px16vh5kY07lclHoe7OSIkDTl8E/dFxPE1LcxiNH3ZctGpcELjw0WxKkOOKka5CXjnaWyYHkWXWqTNC29MImypFjsrPlsHrUXo/OFWV2aVpIX6SLiRZuw/MeDOkz24fM+zjRNwJvCedtfiZHtkokFNfqY=;24:EtdpvHeVaV8bwC2Hpxq4hf0xNRxRJ/M/9YM9sgS8EfbSPc2qjcfEXkZfwIVzsAiol09gGfQvyshJWCuAiBonsF4ooAZrBVIwjld3wNwqFb4=;7:eHam8HnQDM7hV0vz9x2qZkqkAsaa4+xDfsC8d7d2duFURBetUye5dFpsctR4rSlOkSAsKNmkPTlgIDepzGXEvk9Uw18bVEHmA+cMXh/wAzVQLV5nbJY6vkc3PZkvuQtESSaqdNvPW4uVIPIg+v2cJNI8G8+CbUY4d+zMjwDT8SDW9+EEk1jQF+cNxHS0O0tyiLzOrdF1eGcy1iz5Lwp1/aXulon2vbbdTo53Up44nwSUSAXnATqxCTOSXnQXu86A
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cb59fab1-b09c-4dc0-bd03-08d58155c279
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0970100E0FF9B673167108AEFBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(39380400002)(376002)(396003)(199004)(189003)(3660700001)(10290500003)(2950100002)(3846002)(2900100001)(22452003)(10090500001)(86612001)(6116002)(6666003)(68736007)(105586002)(5660300001)(5250100002)(106356001)(97736004)(2501003)(66066001)(8936002)(1076002)(99286004)(2906002)(36756003)(86362001)(14454004)(6506007)(110136005)(4326008)(102836004)(6512007)(81156014)(305945005)(81166006)(7736002)(8676002)(53936002)(72206003)(59450400001)(6436002)(316002)(478600001)(76176011)(25786009)(6486002)(26005)(54906003)(3280700002)(186003)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: FWs1FGqcRk8QC7n1QMwkGkWClx9y4Puh8KCeysN5xrn/6hiEoAFztVs2EIyq/OjUd6V1f/muUBCVIAUefxPc2TMSki4vQRrWrGhgHdo5KLeSvyAi2sERQ0hTcDpv1ACEBgUbG80mFYkWDclPdb02QNOhd/rsVCmko0T7v2xQW+U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb59fab1-b09c-4dc0-bd03-08d58155c279
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:36.4940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
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
index a29b8f59eb15..3f58b4077767 100644
--- a/drivers/gpu/drm/etnaviv/Kconfig
+++ b/drivers/gpu/drm/etnaviv/Kconfig
@@ -6,6 +6,7 @@ config DRM_ETNAVIV
 	depends on MMU
 	select SHMEM
 	select SYNC_FILE
+	select THERMAL if DRM_ETNAVIV_THERMAL
 	select TMPFS
 	select WANT_DEV_COREDUMP
 	select CMA if HAVE_DMA_CONTIGUOUS
@@ -13,6 +14,14 @@ config DRM_ETNAVIV
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
index e19cbe05da2a..968cbc2be9c4 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1738,7 +1738,7 @@ static int etnaviv_gpu_bind(struct device *dev, struc=
t device *master,
 	struct etnaviv_gpu *gpu =3D dev_get_drvdata(dev);
 	int ret;
=20
-	if (IS_ENABLED(CONFIG_THERMAL)) {
+	if (IS_ENABLED(CONFIG_DRM_ETNAVIV_THERMAL)) {
 		gpu->cooling =3D thermal_of_cooling_device_register(dev->of_node,
 				(char *)dev_name(dev), gpu, &cooling_ops);
 		if (IS_ERR(gpu->cooling))
@@ -1751,7 +1751,8 @@ static int etnaviv_gpu_bind(struct device *dev, struc=
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
@@ -1808,7 +1809,8 @@ static void etnaviv_gpu_unbind(struct device *dev, st=
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
