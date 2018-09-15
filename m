Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B638ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4733B20866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bSPHLC1J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4733B20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbeIOG56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:57:58 -0400
Received: from mail-by2nam01on0130.outbound.protection.outlook.com ([104.47.34.130]:13056
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729604AbeIOGvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFllWXs7Liohf5u00LZREOTauGm+K/5FeTrJ85dBS5Q=;
 b=bSPHLC1JEIG9MJTkJoMEbspPGESTedcOcjqqzz6zR5BlTIezhiEyLqwbloRRIO/2IOl6nQMwbIKT4Gm93bK5vp/BGPV3GPCNgwWVZNDpGvxlBXCUMyzmF9wf55XSgHdYov/FU+j2MqAr0fSyS2OY1J2imLt7Bo7jI+/5F1lTsgs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0823.namprd21.prod.outlook.com (10.173.192.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:34:34 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:34:34 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stefan Agner <stefan@agner.ch>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 14/34] mmc: tegra: prevent HS200 on Tegra 3
Thread-Topic: [PATCH AUTOSEL 4.9 14/34] mmc: tegra: prevent HS200 on Tegra 3
Thread-Index: AQHUTJRBgsfBJqmEX0SjccNvV+cbfA==
Date:   Sat, 15 Sep 2018 01:34:34 +0000
Message-ID: <20180915013422.180023-14-alexander.levin@microsoft.com>
References: <20180915013422.180023-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013422.180023-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0823;6:KIw5Qb07+EI3Py+y+LTdjSRm3YEjRtqpMTiTfa/syWe5dTSBhqe7aNAUbtKFrF0tPCw4Dpo6UuRUiPZUF5K7atCjF/xuAFiVW/gzNgyjW/urXiivJcU2kXOWtB4Au3aqNjCJd1WH8mTExBnp4qaN4iK3AG3PH+vd6Af/xP1J79KcL7ou85fx7Qk5t7mjXKwxigJyNYxmlDiK4ep0V6rhcVjom/WknFYJU7upF2a+Zoj0ut4IrR8YWff1Lf/3K9LNF/bxRcgLgAgNbpAj27JizMtBMC15r95bAMBSc/GUN80W64uH/jNinAFV68yTzhbyLbPoeJ3puPnuXu6qlYNqviBuyDd5Ick73YFK/x3pmBAqpg+9DmIsa8JVPIan+IQ6/T0T0P85R1PnDY+gKF4zMTEROPrxYs03kipZNdNux89ZxYxmnT5mVNZie8yO8WByzzH6maN/rZLbqEZPLJBYpA==;5:vG3KItoUBvBrvNGirGpSPwEFcqKZSR8sirzlatlaa+OKE5yx9joD0+fL3qJh0TpdH8m01485BKFX80dhvg7c6kL3g+6LshnWX5Xs6iX/zy4bAC+coaBkocxY207HI7jYzkyi1YinQ8AuYwXqgiAkz0tqHAWDJwyTu2su6bmF+rU=;7:2iAxq2vy7Wj/i0I5RXoSBZewCbFiUAc8iH94xB66LIKgPSOM7mJU6Wn0Ks/CSJ2hICuGRvhdSs8RPl+lYHmrS0J4nwFNuAsoyiJbdnlJYMbYTy15f/Nc5ybMEzqlTCzV4NbNKDdCizUnCu0apPdBjS0hYLGNzQXXeMuYo4y6EoNauf4dt61TFf3VAoLrvVRt0d38OZuFkPAAdZpps5ljfg++V9JkrKZc7aGndpwRfZ30PZ3cO8RIlKnBlLaKmQkm
x-ms-office365-filtering-correlation-id: 591c0111-25c8-463e-524c-08d61aab644c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0823;
x-ms-traffictypediagnostic: CY4PR21MB0823:
x-microsoft-antispam-prvs: <CY4PR21MB08238A23F8EEABDA9D37FA0DFB180@CY4PR21MB0823.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0823;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0823;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(39860400002)(366004)(189003)(199004)(53936002)(14454004)(2900100001)(3846002)(6116002)(14444005)(256004)(10290500003)(81166006)(81156014)(217873002)(76176011)(72206003)(478600001)(8936002)(25786009)(8676002)(86362001)(66066001)(6512007)(86612001)(575784001)(7736002)(305945005)(97736004)(11346002)(5660300001)(5250100002)(102836004)(54906003)(2616005)(446003)(6436002)(6506007)(476003)(186003)(110136005)(2501003)(2906002)(105586002)(22452003)(10090500001)(36756003)(4326008)(68736007)(26005)(107886003)(6486002)(486006)(106356001)(1076002)(6346003)(316002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0823;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ykDQFuwNYkB38x4WkJ9HjHsncLA3Q8QLRr70AuI48VHZnqssC251ObjrL98my7mT1T/E96MgmjRs5uMD8N1cX7Tqo510BjIMuG3TysqVbRZTdF1WYzo90x9Yk7dqA9aMKJH0r9Krl4KNhHRc96ZHolYVUyQL+kOAvuxP9vj1ku+1iXYQeK+5Smk6Rx0ywluQWjaEUDTHkYDT2zcGWIYtFq9Yu0oyc7LxwvLBi/JkU//IzWWhEaXggBwu85h2foy4v9cgNmJsMcdQa2w5KWkxnOaiNXP1iNxwN4/RkTYceuFkaMizhYZJNTvVG2UGS77oZwYGPruOnBOG0j91LyquncdVasveqX4but22iDkyKHY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 591c0111-25c8-463e-524c-08d61aab644c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:34:34.2863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0823
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
index 20b6ff5b4af1..088a3ae0dff0 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -350,7 +350,8 @@ static const struct sdhci_pltfm_data sdhci_tegra30_pdat=
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
