Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523240971-2-227997300985074673
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523240971; b=rB3Melg2jW5Paal3xHyNYUKKSInxXSBE1Nrgo8Fh7tW8ka9T1H
    aNhDiI51i6lTBiRtV4T3S3EN5t9VGJoKiJhh2jpywjW9k30ICxrrMjUZcXyzAYuL
    I80I3A/Hv1n95PbGzntMPuOFlfjBcXfUj8uY0GX/bAkFBqjr5Yrv7IFJtv32YxR4
    bd6LVGCbVR9VNN/H5OuCh7DDV4VC6IVo46LpzGtVZVa0vlTz16fSHC+3izmg3Glo
    8wy0EqPhTACM52NdVLGxeMyewqEEST+4x8MhW3q/Y2CcB5FLLG/8D97sVdsLjDkj
    7qyMaiM+z6vKCtdk8npvA18RD0IvuJCbPE8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240971; bh=Oi72D9fSeR
    4ugLTPPq+SF3ZLBoN/fBgwXv54z2mNkOY=; b=sBWD+T93t395esD57RMIpILh08
    Q4cKzTuQXm1BjkuJDJZq1foLMNR6XIWIr6IMG8W8+5AkVm2iLMcUnFVhH397PxrQ
    33RMZFvxlWRqaohyI4teqPAQlHEZIqptzNnoBy0/Nwflg7BVmNul/6PDYwKiNoIW
    /ZE9DIsyVsDxHyNMqNFag+odO9YmOYNGll/8IEc6qSHDYofmPtH5k5Kz93j+FAuW
    qolSv3vvKqGoumxPtO2Go+x9O254AYBUEnJHcqIocTlJz+Nr3NMTmrdD5nlaTTWA
    plYOrYT0npJ8vnxNSowqNTxwu2YcXnQSIaYYaCCivddbxRpwYpJesn3haobw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lWoCJzX9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lWoCJzX9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLKtwQ+xgOAndQ3Z0N0HhcDUwHIBYkJ1eNtpxCT+zWdxlqmBA3wA184hFMsLsTIH4jHiK0rXq6y+owM8qZEDSFjwI0SRY8xN6hU/Yf+dLq+WJ4oHlHEz
    qpx85X7y+oU5jdux0ChbrRGbarzuVHWJ0axAgN+Cp7vPmp3JfH+1I672bdsKQm0yNWaOzGbAUs3h8aVujwuQW04yINSb7mRpXqLg2z5krW5bWt5hj9TbGUT7
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=Ikd4Dj_1AAAA:8 a=yMhMjlubAAAA:8
    a=FWyOINcZwCyCYCK63scA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757681AbeDIC3A (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:29:00 -0400
Received: from mail-bn3nam01on0096.outbound.protection.outlook.com ([104.47.33.96]:38912
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755876AbeDIA2h (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:28:37 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 079/293] drm/tegra: dc: Avoid reset asserts on
 Tegra20
Thread-Topic: [PATCH AUTOSEL for 4.9 079/293] drm/tegra: dc: Avoid reset
 asserts on Tegra20
Thread-Index: AQHTz5kLut1pB1vMx0mgTow+kJ0Jaw==
Date: Mon, 9 Apr 2018 00:23:55 +0000
Message-ID: <20180409002239.163177-79-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:j9IR29RjQMbripygwsUKMs4FgLN2XDSj0Yf5+NF92saN0h0vlK9lIeOlPy8kP0D823wrw7yZAZgucMtA8U/amWD5eH2F69gIbgghUJ4XmsEQv7qG39BKS5NFnOoOW/Z3IQF2kxAX8jiHFef1lzc29hne8zs7yzA8wSYdt6Nhes87FkdbBXywgGRSv/J6cWZhWPX5ebjqusRlb8SPyNPPN8B3hXpjZxLkrdQN+OM5DPmXeqU7DR0UAbo1TOhncoeo;20:2pIGrMzC6xSJYIx64GQeQIlGQLlqam9Q7325Xm+DQh4mPZJNhwIBvnfWKdZIIStwKKU206K9Y1OKYNeT+J0MRNmL59XWQ0XMFE36urjqUbi1tIFiVCef4EuBF5NqGA1HWGyBC0Zbfa0JiGMefi5kaiHkVyA3FgZjL8J4royxx3s=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: ceca2d17-a039-467c-34b9-08d59db0d22b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08071A122B8292B673BCDA3BFBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(18589796830644);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(14454004)(4326008)(54906003)(25786009)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(39060400002)(6512007)(478600001)(3660700001)(81156014)(86362001)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(6666003)(316002)(59450400001)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: vGFV9DujRMbwer7TU4yyviY/5sdRPVBiXn0rviwreY00bmONRXt3b7NSFuAnHCsqU63EehWkACK5eeUUuYuOJBPP+qmwk/ZkXZVfcpBjvpa/DXlmfTOn6A8jrqKPwIdmNMMZ8gusZhSXZEsA1Jdtk7jbUA4ueVnlixlbbJ5V5WAMV/6tXGsdjOirncsdZpua781zvs6ev31KLDpmxhJJehjUcmx6SDGFjwYYdtPHutlvJnkcy49gqcoUctXM5RaTmkSjDROhCewfHXTt84KG7jvdUHai6t36l9PN0KUm99zLeUTEmb7hlyjPc76B5YYVJIxjMsAliSs/CD/sUEcDIc2bbJHiTpG94esMxVoR5efBIT1q9N4kB+PIJU0RaCcl/OZXta06utQNBbTNheXo7byF/C3yIsEMRMOjbrzYPVg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceca2d17-a039-467c-34b9-08d59db0d22b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:55.9562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dmitry Osipenko <digetx@gmail.com>

[ Upstream commit 6ac1571b4c60cb73a1f174b15ea93f7e38d74a88 ]

Commit 33a8eb8d40ee ("drm/tegra: dc: Implement runtime PM") introduced
HW reset control. It causes a hang on Tegra20 if both display
controllers are utilized (RGB panel and HDMI). The TRM suggests that
each display controller has its own reset control, apparently it is not
correct.

Fixes: 33a8eb8d40ee ("drm/tegra: dc: Implement runtime PM")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Reviewed-by: Erik Faye-Lund <kusmabite@gmail.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/tegra/dc.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 4010d69cbd08..e93cbe7e8f5c 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -30,6 +30,7 @@ struct tegra_dc_soc_info {
 	bool supports_block_linear;
 	unsigned int pitch_align;
 	bool has_powergate;
+	bool broken_reset;
 };
=20
 struct tegra_plane {
@@ -1847,6 +1848,7 @@ static const struct tegra_dc_soc_info tegra20_dc_soc_=
info =3D {
 	.supports_block_linear =3D false,
 	.pitch_align =3D 8,
 	.has_powergate =3D false,
+	.broken_reset =3D true,
 };
=20
 static const struct tegra_dc_soc_info tegra30_dc_soc_info =3D {
@@ -1856,6 +1858,7 @@ static const struct tegra_dc_soc_info tegra30_dc_soc_=
info =3D {
 	.supports_block_linear =3D false,
 	.pitch_align =3D 8,
 	.has_powergate =3D false,
+	.broken_reset =3D false,
 };
=20
 static const struct tegra_dc_soc_info tegra114_dc_soc_info =3D {
@@ -1865,6 +1868,7 @@ static const struct tegra_dc_soc_info tegra114_dc_soc=
_info =3D {
 	.supports_block_linear =3D false,
 	.pitch_align =3D 64,
 	.has_powergate =3D true,
+	.broken_reset =3D false,
 };
=20
 static const struct tegra_dc_soc_info tegra124_dc_soc_info =3D {
@@ -1874,6 +1878,7 @@ static const struct tegra_dc_soc_info tegra124_dc_soc=
_info =3D {
 	.supports_block_linear =3D true,
 	.pitch_align =3D 64,
 	.has_powergate =3D true,
+	.broken_reset =3D false,
 };
=20
 static const struct tegra_dc_soc_info tegra210_dc_soc_info =3D {
@@ -1883,6 +1888,7 @@ static const struct tegra_dc_soc_info tegra210_dc_soc=
_info =3D {
 	.supports_block_linear =3D true,
 	.pitch_align =3D 64,
 	.has_powergate =3D true,
+	.broken_reset =3D false,
 };
=20
 static const struct of_device_id tegra_dc_of_match[] =3D {
@@ -1980,7 +1986,8 @@ static int tegra_dc_probe(struct platform_device *pde=
v)
 		return PTR_ERR(dc->rst);
 	}
=20
-	reset_control_assert(dc->rst);
+	if (!dc->soc->broken_reset)
+		reset_control_assert(dc->rst);
=20
 	if (dc->soc->has_powergate) {
 		if (dc->pipe =3D=3D 0)
@@ -2054,10 +2061,12 @@ static int tegra_dc_suspend(struct device *dev)
 	struct tegra_dc *dc =3D dev_get_drvdata(dev);
 	int err;
=20
-	err =3D reset_control_assert(dc->rst);
-	if (err < 0) {
-		dev_err(dev, "failed to assert reset: %d\n", err);
-		return err;
+	if (!dc->soc->broken_reset) {
+		err =3D reset_control_assert(dc->rst);
+		if (err < 0) {
+			dev_err(dev, "failed to assert reset: %d\n", err);
+			return err;
+		}
 	}
=20
 	if (dc->soc->has_powergate)
@@ -2087,10 +2096,13 @@ static int tegra_dc_resume(struct device *dev)
 			return err;
 		}
=20
-		err =3D reset_control_deassert(dc->rst);
-		if (err < 0) {
-			dev_err(dev, "failed to deassert reset: %d\n", err);
-			return err;
+		if (!dc->soc->broken_reset) {
+			err =3D reset_control_deassert(dc->rst);
+			if (err < 0) {
+				dev_err(dev,
+					"failed to deassert reset: %d\n", err);
+				return err;
+			}
 		}
 	}
=20
--=20
2.15.1
