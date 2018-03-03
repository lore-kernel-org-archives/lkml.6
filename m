Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520116063-5-8459156139600365260
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enfr, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520116062; b=W+MxrhC/ChWVP8zkxJqdJKu01JA/0n9OX3JynulhyK1kFyw
    YgqPy7vCbSIznUMf7N2K7GU+bdg9q+BnpASpxnxJgP5hbRx6YU4anlqEJ3DizWjL
    IWpT0j9B3NAMpSCpRy8RROXUim+1wcylVoQeSkvt+nNeETHhkbWGTjeEmuuhcf4Y
    QsGn36V7TW6nyyfOINSW8JjdMzxihP0o5/olQqwP/NOpFhP15B7JFV5cK4zkSiux
    R2y5RVuurjTydLufE3Irdd47W2s76hko6aMZv4bjbrT2sG+DaCG004O4hyOwHzkn
    lXX5Oi/o76vu+7bMyhhd+HZvgJnxWDV8EK7Ww9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116062; bh=7nU44y
    9L3XERk8wLQt8wbcj6labQlUwn/9YZnSg6Og4=; b=sBEJ6dbyleXq9Qf60QK7mn
    a+JN/TPfqwbhKI9ZtR/Ljtw5M4A3OQe5DOIQYD1kJfYWwyqotXVCDzVQ7JAp1Ni0
    Mo3UmiFKJIrrhVvdkBQNTYobUldoIg1kl6HbFpPiPYdyU4PMH1Nxr52vjjR7M49y
    fLT08oA4N7yqAdDiPxgPxvzh2ZrlPU3JdebmCrBd/RIOayKsNc5zsZcbvDTXRpr8
    4Dz4+gBIv27bKkyKP2iNYzAx5hH21ArxYqi0S6HxFhK9PmW0y0lKsdIQ3MAlilDd
    PhyefdyftiHM6AZlxxAOXouMSWZqkvkK7UcnP5wMdt7Drw5GklCbCvtRH+l79FIg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GA1O0TOi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GA1O0TOi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932649AbeCCW01 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:26:27 -0500
Received: from mail-by2nam01on0123.outbound.protection.outlook.com ([104.47.34.123]:26076
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932651AbeCCW0T (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:26:19 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 060/102] pinctrl: sh-pfc: r8a7791: Add
 can_clk function
Thread-Topic: [PATCH AUTOSEL for 4.15 060/102] pinctrl: sh-pfc: r8a7791: Add
 can_clk function
Thread-Index: AQHTsz5uywnIoVAcpESoObeOieELaw==
Date: Sat, 3 Mar 2018 22:24:44 +0000
Message-ID: <20180303222318.26006-60-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;6:0083Tuqyg/NnP+KTNpgcgyQKigj1/nk4zp2JnbjxhWJMxcpehBsu0cdQaqXJub+TpCKbg4tZ+v3EbxrHRiinFxC6q0ozZxSimVo1tmgXN3kluy9NireHe3i4LUrhcRdkCUa/xC7jA993sG7ug17qL1vbbu1UDqpF1NHFESb2quSa/VPa+zQ5353klsvhS8VpBUFx2YLWmgVK+jXn4xWLzcRJXs5tFyJB1Eh/ENKvo0CDvHTcN5VsmuWJQeP8gbSZUYRQ4xVzxtwpEB83nsdzGEj8NLuSVX4SF+8bCYqKHiOcEc6++p3ZINorh/VFuFtXhMUYmeLvxBtHb4vyDPiSIfaQLC5g1jjiXzl8JRomHLiAkR69eg1/XYfcaf5VgVYj;5:8rp2JmtHGvlmLyXZaxeG+RT9wfMfmMIzkTrIjdSwkpfotL97UOaecTUs1oGJ76SHcvYFibpOXZnU41mA0M2zf5WK73n6NEu9UVdkbHf5MnBlR8jSe1mr0A3uh/oWutLLyq+NsbPTZ82IxvDHyZBfosncjUMNNZaPd1u6Pe1fHEI=;24:luEJPztGOjsdqt+qXES+jJWt9umJVh4S7/zryDwH5/KCUpKtL1riceeLTOhU4IuEIO+XoS6IdnVxGi7nmBQL07xu6IRzGiEAxhFxAyW7o00=;7:yv5MIP8qapZUt0YMiIShVY8eumpQA8zWm5sJDBX0tU3gG7sXAU1j54wwKHlY7oJg25xNlXUCY2CH8YZAhA3eBkEppWquQZRqsGeyzhO20QEe5Q64cmwqdthQStqQIu1fg+9jUJPZEHScwlasKUorfU5nJhU60w32yXBw8ZJwBn126wb/qQ4ge5JO5YCtW1dp5y9YtNL/4bQERkAkbue8C8kcGUPgKt3x/KmfvWj22z/iVnzCY1yYtimEvoatKW5V
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3965bfb5-6ce7-4bd2-17eb-08d58155c828
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB06CFF790F6EB538359BA34FBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(346002)(39860400002)(189003)(199004)(68736007)(2900100001)(97736004)(107886003)(36756003)(1076002)(76176011)(86612001)(6666003)(6116002)(99286004)(22452003)(10090500001)(3280700002)(105586002)(2950100002)(3846002)(26005)(2501003)(6506007)(4326008)(305945005)(25786009)(7736002)(66066001)(54906003)(86362001)(8936002)(72206003)(3660700001)(6512007)(110136005)(14454004)(5660300001)(5250100002)(478600001)(102836004)(106356001)(8676002)(81166006)(6486002)(186003)(316002)(10290500003)(53936002)(6436002)(59450400001)(2906002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Ru7uRnUwJxBjUrkmkG5TpQHesGwHkAG5cVjtF7toTsBXV/XGe7fBWb2nZMaM6Qw8GknOp1RV8oyq7bK7sCwgL1+BxJKTWecpwOaIvJw3Unp/S1mytNg+bKHeUDptXi7V6YQaHO42yLot7cG5m0qaLFEgLWx+UIVzVdt6zWjOpWQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3965bfb5-6ce7-4bd2-17eb-08d58155c828
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:44.2284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
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
