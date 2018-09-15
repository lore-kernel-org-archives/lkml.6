Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A69ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07943208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="kZt1a49J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07943208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbeIOGtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:49:55 -0400
Received: from mail-co1nam03on0116.outbound.protection.outlook.com ([104.47.40.116]:27616
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729301AbeIOGtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:49:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQTDyIxlwQzDalLAhp528Tu+4M2os1KAWNCA2C3XmuI=;
 b=kZt1a49JDx2ldUl6h677EH8Qcdo+gpn4wqPEKNXFiZBqLvjd0flGjU1OY4xASWz9vQ4dyC0kZ8mzBNzv3t4bxZY89/zlhvp+64TzbXCsAcVi1TnpZg1AXraw+6fuDQYAvxaFX3XI/Y+3oilThXZI8/9XVd0G2aFwBWvbu0MuNJQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:32:46 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:32:46 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stefan Agner <stefan@agner.ch>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 27/57] mmc: tegra: prevent HS200 on Tegra 3
Thread-Topic: [PATCH AUTOSEL 4.14 27/57] mmc: tegra: prevent HS200 on Tegra 3
Thread-Index: AQHUTJQBmjjiGHAOyUuTVdBThDj8+Q==
Date:   Sat, 15 Sep 2018 01:32:46 +0000
Message-ID: <20180915013223.179909-27-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:m7efbsIyJCWmZmVgRxVWCIAkMZecftzehNstKB6/7NA3jH/hOhTwlpf6wJJLF92+gJ+kyXLP2+41bxlIh+4U63pP0Kox4enPVrHH80B+utj3roMjU+27uiBNOwX5nK/gOSwjJUP4QwZhBHh2hNQR9DfOik8VVCLGSkLsjqBPU+wKIkFeljTJwqYoW3rhtMkOESbaMq6+bJcPOfUulqByUMmtpH4P75RiVXDLSJAJhYvkWOMafZ7SoOy/BSJiu/qCoDmYyrehtKitncJnJdBZvN7sceBBTaZ3YONf3bFz7rQRnVLvShxRXd1XWPZiB3hc6iayXVV60MsN+TCLkwII2eJ9GBtElYY/Yw4MuYEA7UJJ/YHs4oU19rl246YRymdHeScXTutWAGiFRMDB5a4HFhhl5I7/ZFL+DfyQ4bdOYbcxb+iu0mm+T1Tm0SWuX5edh8be/URPt0IF6jeqlr0k3Q==;5:jZxeEQFlqu7XRsPf79aLuVa07v8jNgpB7JGIIjlope2iz9RCiOxCuE/Oygs0vF2V+VAldp1hb6BBS/u6A/I+IWvKDQqLEUEGAUyw8hyXhvoB/4p25wtTUpjhoDtWxpoJiYy3jZ4EocwQxARG89yInlsEFWhjxuHFvEfw9AtiC3I=;7:+DVakplc3xSY/v45rmF49BP2NqE7YUIg1oQmaASkH1nPrPASW5krNvphETt1Ob8cWGNdGKe7hpRsJr54U2yjRyxPlx04tF3SPA+9Yl1jlVrUcPdkH/iaifgEOgb7BixbWhTm4dHamOKvwGnUuhY4rdRGeo2gwEpP/5XVXl+B/k4MHlliFcui6hozRous12TOiwM8HSHls1SnJ3+Da1tK0vp97EbeeWCXuGICAUO14CUQE5FSEUATUwD1qcOYWxYZ
x-ms-office365-filtering-correlation-id: 37237b41-ca46-4a2b-a09b-08d61aab2426
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08226EB32527713469686FB8FB180@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(1076002)(72206003)(6506007)(102836004)(478600001)(8936002)(10290500003)(2906002)(81166006)(81156014)(5660300001)(22452003)(2900100001)(8676002)(110136005)(54906003)(107886003)(99286004)(25786009)(4326008)(316002)(10090500001)(97736004)(305945005)(7736002)(6116002)(3846002)(256004)(14444005)(66066001)(76176011)(217873002)(6436002)(14454004)(36756003)(476003)(86612001)(6512007)(26005)(5250100002)(53936002)(486006)(106356001)(11346002)(2616005)(6486002)(86362001)(446003)(186003)(105586002)(2501003)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /MqYnJsKDwlaM3XfVJY3cdC4BbQeLBvFZ/sEHH5gueEjG0GxBPsDIXc6730TQOpQ5eJYd5zZUT/exqOkMPiUPrckDWMJZ2SC/uH41MQC3T6g42A5+SWD5Snfu1XyF+W01a++TnX4f6/wfL2imxYvda3NZVDYsYczzicPcWsX3SVh90A/tMetptJlqQQR2q8jOeGdysTE5ZVm8NMV0HZKm7WpVmCiAdkVKCjfDlopNkdUfsVN8yXD+L2ghk6scy7dk0SCnCep6ys4Pa/5G5FXvxjwzadvdU9i36n1FfKUxDuqPAX1UZ5h7ssiSu5J/pdJcg97Im5695DUo37/5Jmwpo9BCsR4WcSq06ZT4C+eIJ4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37237b41-ca46-4a2b-a09b-08d61aab2426
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:46.6494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan@agner.ch>

[ Upstream commit 127407e36f4fe3a1d5e8b9998b479956ce83a7dc ]

The stack assumes that SDHC controller which support SD3.0 (SDR104) do
support HS200. This is not the case for Tegra 3, which does support SD
3.0
but only supports eMMC spec 4.41.

Use SDHCI_QUIRK2_BROKEN_HS200 to indicate that the controller does not
support HS200.

Note that commit 156e14b126ff ("mmc: sdhci: fix caps2 for HS200") added
the tie between SD3.0 (SDR104) and HS200. I don't think that this is
necessarly true. It is fully legitimate to support SD3.0 and not support
HS200. The quirk naming suggests something is broken in the controller,
but this is not the case: The controller simply does not support HS200.

Fixes: 7ad2ed1dfcbe ("mmc: tegra: enable UHS-I modes")
Signed-off-by: Stefan Agner <stefan@agner.ch>
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mmc/host/sdhci-tegra.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.=
c
index 0cd6fa80db66..ce3f344d2b66 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -334,7 +334,8 @@ static const struct sdhci_pltfm_data sdhci_tegra30_pdat=
a =3D {
 		  SDHCI_QUIRK_NO_HISPD_BIT |
 		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
-	.quirks2 =3D SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.quirks2 =3D SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_BROKEN_HS200,
 	.ops  =3D &tegra_sdhci_ops,
 };
=20
--=20
2.17.1
