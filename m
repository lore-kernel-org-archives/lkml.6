Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517683594-2-7934747688423803294
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683593; b=edKUU0b+X6t1ZFt5FMVBj0DL4QHwlWJj74JCP0qMIcpq8NQ
    vxSrw6JR2OLLr/Zaige2LRsKDn1vzOUGiHsclz6e4v8/KX9CibMchJ5XtYdSkI4x
    8+fmjApNH3FbASp7qGKckqXE/OAZ3Uzb8lk4JhtWNMy58QxBZAhL709tgQjSSJec
    Bk/GlwQdOgq+K5Jc5YLqkUJ3bF4RcGpqwVmUrTy1P/DC7PEvZYcGzgZ7bQ1IQr3O
    lDTwDABmhxB8SwgF+DFO+ZdwMM2o4WsmQDgA/+A2XYSSE+spAiMKnRXmRAFVTs5Q
    xf6PAHwv+VGZ27W9doPqtrlEvlkj4EstaknHblw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683593; bh=n88q3a
    Npm20j6x6LR2mETozcU176dF/BQ/kWxLNx6To=; b=FNEeBiHlX79dcCS3NWLhqm
    7zJiPCyXodKyzj8hweDVvfmv8GPmH0uIxU1w4q66oJQLJhcrGUEuxtSoQ0FAYiLm
    Utc1Ivc/lRlf84SDObQD57CRDvJmoIw4skVu+49sQ9yIpwuJnkoBduEUbZRvAriL
    wRjmGqi5JjDVONj3RF7x7SNDD29oD2VRRWgggZDdi1Zn6XA2jEmB6W/lRyTmrNOO
    uOOIe/WSsXjl6IbXgF3+1kc+iuzx20AfXZgcRGdLSvFoYkzOgZKM5+vK3nRlAB7Q
    ROgHMX4cSejXwnJHmO9GfAMVljwViot/pi7SLHDCkM1Mq44D3w7bFOKjP+FVvn3Q
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IGIra51s x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IGIra51s x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755363AbeBCSqY (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:46:24 -0500
Received: from mail-dm3nam03on0113.outbound.protection.outlook.com ([104.47.41.113]:19232
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752937AbeBCSBf (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:01:35 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Huy Nguyen <huyn@mellanox.com>, Moshe Shemesh <moshe@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 041/110] net/mlx5e: Fix ETS BW check
Thread-Topic: [PATCH AUTOSEL for 4.14 041/110] net/mlx5e: Fix ETS BW check
Thread-Index: AQHTnRjrShMtZX516EClk/q68GyWIw==
Date: Sat, 3 Feb 2018 18:00:48 +0000
Message-ID: <20180203180015.29073-41-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1092;7:4la70ktmELAIbdlQXkTEidOIlKExdV0uN1NqXSzjAXn4XNKlEAJlVotivhuJOA+jB8OHV4h7OG6IkNxtT8ycfbpci99v59/9zy6S06heNaH1fjqvIURWNjYdsisEyzglDGRvoDQqrL7uuUZvuCQy+CG14dYDZMmWnZXGdYTGEQTKfCOesEnVZnjLcxdPx5qp5FVvvLKAxvhfltVVKBtcBL4Zukr7vVKgQ1OKTw4qkJKHEjAF1d+MI2OgwBowjYWH
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 58ba8f2b-bc76-4db9-250b-08d56b302239
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1092;
x-ms-traffictypediagnostic: BL0PR2101MB1092:
x-microsoft-antispam-prvs: <BL0PR2101MB1092DCA8638528C3BAAF2022FBF80@BL0PR2101MB1092.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231101)(2400082)(944501161)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1092;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1092;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(3280700002)(14454004)(3660700001)(105586002)(3846002)(6666003)(22452003)(6116002)(99286004)(305945005)(7736002)(2950100002)(66066001)(478600001)(54906003)(110136005)(68736007)(316002)(86362001)(106356001)(186003)(26005)(59450400001)(6506007)(76176011)(6346003)(10090500001)(102836004)(6436002)(4326008)(8936002)(2501003)(53936002)(86612001)(2900100001)(6486002)(2906002)(6512007)(25786009)(97736004)(72206003)(1076002)(107886003)(36756003)(5660300001)(5250100002)(8676002)(81156014)(81166006)(10290500003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1092;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 2oHUznpd5S5RwK6U01/ZzPdOlPYtH3Gue0NdFhGzbyIGhHTdXffYBZoKraKp1wzQP3Mz7qYaZryTfFA5qtyLEg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ba8f2b-bc76-4db9-250b-08d56b302239
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:48.4253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1092
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Huy Nguyen <huyn@mellanox.com>

[ Upstream commit ff0891915cd7b24ab27eee9b360c0452853bf9f6 ]

Fix bug that allows ets bw sum to be 0% when ets tc type exists.

Fixes: 08fb1dacdd76 ('net/mlx5e: Support DCBNL IEEE ETS')
Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Reviewed-by: Huy Nguyen <huyn@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c b/drivers/n=
et/ethernet/mellanox/mlx5/core/en_dcbnl.c
index 51c4cc00a186..9d64d0759ee9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
@@ -259,6 +259,7 @@ int mlx5e_dcbnl_ieee_setets_core(struct mlx5e_priv *pri=
v, struct ieee_ets *ets)
 static int mlx5e_dbcnl_validate_ets(struct net_device *netdev,
 				    struct ieee_ets *ets)
 {
+	bool have_ets_tc =3D false;
 	int bw_sum =3D 0;
 	int i;
=20
@@ -273,11 +274,14 @@ static int mlx5e_dbcnl_validate_ets(struct net_device=
 *netdev,
 	}
=20
 	/* Validate Bandwidth Sum */
-	for (i =3D 0; i < IEEE_8021QAZ_MAX_TCS; i++)
-		if (ets->tc_tsa[i] =3D=3D IEEE_8021QAZ_TSA_ETS)
+	for (i =3D 0; i < IEEE_8021QAZ_MAX_TCS; i++) {
+		if (ets->tc_tsa[i] =3D=3D IEEE_8021QAZ_TSA_ETS) {
+			have_ets_tc =3D true;
 			bw_sum +=3D ets->tc_tx_bw[i];
+		}
+	}
=20
-	if (bw_sum !=3D 0 && bw_sum !=3D 100) {
+	if (have_ets_tc && bw_sum !=3D 100) {
 		netdev_err(netdev,
 			   "Failed to validate ETS: BW sum is illegal\n");
 		return -EINVAL;
--=20
2.11.0
