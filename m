Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520122686-2-8134054884640473008
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
    t=1520122685; b=NR0STOiMnIQ+dMkHEoYfzPyQAYIBV+zJrDTNUkN7rq3jEWN
    kEs3S6ub6nDToWVghS7DqULBt7xozq9dNnQfIfZtz8iiMyLFiG61nVXUzqMTsnZW
    AVpGRiwuAnFLZbvEDjuQRkpkEUhkowZaykVDqUSSs2vq9sQDgFjrIMLWZi2SA0vX
    sJSwb5V1uEVmlJE14xA2YCfuehIVs4IqGbhI/Q1ugkHiwpyzlc7BE7gwscfBLKGN
    dfhTvJ5oaIExu4CfKzJCjj4c5iDVYUxZSQtx9EfYbwA2oP8ITAYvJXZRdarLXFdI
    HO7+ZKXNDh03BxpnlLLdcGTGmfmJI72b1hgTDAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122685; bh=7nU44y
    9L3XERk8wLQt8wbcj6labQlUwn/9YZnSg6Og4=; b=i/Ca16R3vCndq2KfDjYyzd
    Ygbu0/Jspm2h55/AlC6/5qtfM8WIixfpWKM9m8L990T+rY81xbFLWvIPeEjLulvp
    BPyWkg3VRqn4u3RoqIxl4MYW2uL9KGQcN4sSFHoo6tudCvscv1QY0GSutx43hxSj
    VZLmeNiKpJmAjNpuuTOuKOs3KTPLkXwU+yLgPLpbcwUV/vfd6RsC2PzAxciQgcbu
    taD6TCBBRxu2uR3JXipoMGrmPOW144fSmX9x/ybFtvup5PgDs2JXeKDFSWdTDTDV
    uI2Tr3QUndA1XkZ6oONfFb2teeUokwgv4fkQ+a7G0/HwQMvFAfUYQ6b6xyqdYPCA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WtnJSXKv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WtnJSXKv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933332AbeCCW3O (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:29:14 -0500
Received: from mail-bl2nam02on0122.outbound.protection.outlook.com ([104.47.38.122]:14153
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932402AbeCCW3L (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:29:11 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 46/84] pinctrl: sh-pfc: r8a7791: Add can_clk
 function
Thread-Topic: [PATCH AUTOSEL for 4.14 46/84] pinctrl: sh-pfc: r8a7791: Add
 can_clk function
Thread-Index: AQHTsz6rDgGbsr9rg0GQv8GoBOMAjg==
Date: Sat, 3 Mar 2018 22:26:26 +0000
Message-ID: <20180303222518.26271-46-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1065;6:U78c0/GSbW+UqGww7Gx+JCdcW2c/nEcLzIwo3RKjj/AANRSctlKzOo9jSQvpWHVPTTWOL9dLruWCIZx+VYQ/f5fQnX4WxBUiM9KMSgySoIjRHUrGfnDOsHXOzU8mRiQiCDsXhh8ypTE9MlUhKJSRv+rzaDhyMZRoJyP+NcOj9y6TWU+AC8sQG2MaI07RZ0QfKhinRNP/y00ntG27UDMGGGhT3mtstV4uvi/DjL1jl1lqWmJFggNt5DoMeMxbEizXNeOPEd1fj8jBFFodXYOR19B1K33v0b5MJaGrEDyf2kFduLAOcs92TQ3bdFuRB3ng7/gBHnvZyO5EBQIv/9PQjANeFA9gXmLfEMV5e4T7gWH/5Ba/P9tsKj0dtt+NETn+;5:Y+2OlYR+QrB3TASGLnHg4UWwWEn5odmyBFIdJN7p00YETZXdFrJj8e6W80K2mqaGXWa0V1lWnNMjDmraA9nemx7XinAe0OiOeg+IB8cWOInDE9eLuTyGWt+WBcywJqKN1cxDscRbFdtKhiW4CRHH1bnXAEPmt4gwjHBRyqIKygk=;24:bu6tUEslLrzRI2bZ5qQLGSMxh5In08k6TxmvZ9w2h65iI2Tim+xoI9OqazPJ3Ws2Z7hjKlqbyNswPXuk3JpiEcdT/OZNchiorS65ExHh+1k=;7:PtcRmnEWGfJwFCmOyTVHA9gULI6Cd8oaZ7V4MDwm53pzUCwVPLQT2yuLL4FzFcZhOJBEYsvKKyyi4BbXdgQEuP/+wvSuPiOpXBVa0otEhMxvLIJTU/tyZHa7uXwklA/bpXaEfC3sDSeofyWAbmKPm9p7tT8zSkw1JayuM20XuPvkY7ptSW5XNqtTUbEfbRWGl3Jwd60QS+1qE5dfwC4JJ1BN0k9VjaybdbsTmtR10mdlAoisqs6cAnXjNOFYKiDn
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d2248585-4e5e-4e81-a57c-08d581562e71
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1065;
x-ms-traffictypediagnostic: MW2PR2101MB1065:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1065D64EB0AC872012D5AF59FBC40@MW2PR2101MB1065.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1065;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1065;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(39860400002)(189003)(199004)(6506007)(22452003)(54906003)(25786009)(6666003)(186003)(2950100002)(102836004)(5250100002)(2501003)(110136005)(97736004)(316002)(2900100001)(36756003)(76176011)(6436002)(59450400001)(6486002)(26005)(4326008)(99286004)(68736007)(6512007)(6116002)(10090500001)(106356001)(105586002)(478600001)(66066001)(107886003)(3660700001)(305945005)(86612001)(14454004)(81166006)(7736002)(86362001)(1076002)(72206003)(2906002)(10290500003)(8676002)(8936002)(81156014)(3846002)(5660300001)(3280700002)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1065;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: V/MB+Ih4y+6x/D25sjTUgBJlb5yf847VLBaOFTuf7admR734TzMLOwJsC3RLg3UZ40gAascRvqyEw91ASrM5TGMkBNX0dJEiBU+bVD7Se3Q2LX6Y14QXgr2468YL4qECV9ovecUESDdKcPdYwfLN+rSfizPvTgaxRh66M9FD4tQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2248585-4e5e-4e81-a57c-08d581562e71
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:26.3848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1065
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

[ Upstream commit 57eec02caee60332b8052615e7257f932ae07abc ]

This patch adds can_clk function to r8a7743/r8a7791 which is cleaner,
and allows for independent configuration.
We keep the can_clk* pins definitions from within can0_groups and
can1_groups for uniformity and backwards compatibility.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.co=
m>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/=
pfc-r8a7791.c
index 10bd35f8c894..c01ef02d326b 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -4826,6 +4826,10 @@ static const char * const can0_groups[] =3D {
 	"can0_data_d",
 	"can0_data_e",
 	"can0_data_f",
+	/*
+	 * Retained for backwards compatibility, use can_clk_groups in new
+	 * designs.
+	 */
 	"can_clk",
 	"can_clk_b",
 	"can_clk_c",
@@ -4837,6 +4841,21 @@ static const char * const can1_groups[] =3D {
 	"can1_data_b",
 	"can1_data_c",
 	"can1_data_d",
+	/*
+	 * Retained for backwards compatibility, use can_clk_groups in new
+	 * designs.
+	 */
+	"can_clk",
+	"can_clk_b",
+	"can_clk_c",
+	"can_clk_d",
+};
+
+/*
+ * can_clk_groups allows for independent configuration, use can_clk functi=
on
+ * in new designs.
+ */
+static const char * const can_clk_groups[] =3D {
 	"can_clk",
 	"can_clk_b",
 	"can_clk_c",
@@ -5308,7 +5327,7 @@ static const char * const vin2_groups[] =3D {
 };
=20
 static const struct {
-	struct sh_pfc_function common[56];
+	struct sh_pfc_function common[57];
 	struct sh_pfc_function r8a779x[2];
 } pinmux_functions =3D {
 	.common =3D {
@@ -5316,6 +5335,7 @@ static const struct {
 		SH_PFC_FUNCTION(avb),
 		SH_PFC_FUNCTION(can0),
 		SH_PFC_FUNCTION(can1),
+		SH_PFC_FUNCTION(can_clk),
 		SH_PFC_FUNCTION(du),
 		SH_PFC_FUNCTION(du0),
 		SH_PFC_FUNCTION(du1),
--=20
2.14.1
