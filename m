Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1639138-1517683860-2-16662647953736677406
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683859; b=Vb+X8Az8WgEGhbz//Crp9NO+1aWSHIx/YEZpp1m1R5IBWi+
    5+c7j7gyfIUxkbcp6HaX5VIIBuzSBOKeUn3iSSrvu3V7VTaomqNmJoyCSqOzUuWO
    MDS+94QZD8rTTCl1t7KGAzRqApZ5B6fiay/aovofNW6hIYjBeTsEsaCkgzkOPuxD
    mEqUEd8IhL6zJhO4kQQa8LAhELipEOSCA4w0Nx7OqarZUJFnvZnt1QurQ1vSKsFx
    aeGiEVSTmtliUN9MWnT53V6/77WZnGSsyQHhnEDscUxD8gu4v+7CUWBvwSGkV5Rx
    RFvkQZ7tIvCNhUTBAnX84GMDjJt6Skn2SukVkGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683859; bh=MqDSvy
    CckUdl66n+gar7wbFOOB/7QFGSUaXZAHYAS/w=; b=GiTfGG7Jge4CtB4fUxHwI0
    TBiX8G7EOCWlfJG8jZLFmcdDh9d35QYMxBhIVnN8oi7njAFPwmD0AeHtKt/bLULt
    HVvDRW24/YfIgKOzKuQRVomSKKZrXUt6JGfrPagGDWUSViQ9CTKq2a2ti31Q4jMZ
    c+EOBrPBnLsf7J7qwzw/8Gioip5gVNUlHa/t1cc1REg8c/xEmkkzhxfyHaghFyHz
    NJQzqjJUjQsD4lPgPMq+oYAFtTKnxOL3brfKhTa2QwPe/jLzFhuS5Xvx4kPxbgvJ
    rLcZsGVBCmpGCJdIc+or/h7POe80T0+XxIAZk3U2tHteUnGt3Cx+SDw/3Hm9NVAw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=T1IP2FS6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=T1IP2FS6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755351AbeBCSqP (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:46:15 -0500
Received: from mail-dm3nam03on0124.outbound.protection.outlook.com ([104.47.41.124]:55488
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752952AbeBCSBk (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:01:40 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Moshe Shemesh <moshe@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 043/110] net/mlx5: Stay in polling mode when
 command EQ destroy fails
Thread-Topic: [PATCH AUTOSEL for 4.14 043/110] net/mlx5: Stay in polling mode
 when command EQ destroy fails
Thread-Index: AQHTnRjsC4IEDHSSKUmzYJwcBTY+Aw==
Date: Sat, 3 Feb 2018 18:00:49 +0000
Message-ID: <20180203180015.29073-43-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1092;7:0bnySCrM/XRZPNeJJ+UXmBelyeXmCWoxdZYaJeNE8hXd0AYiUSWNOLPMYjVoxI9he/YndEiQy6qK1R8JGTtFJ0EdOLRgBAZKCKntE0DNOggtefYryj56aZZH6GsARWcDkCe7lloG3HCDtj3PgMhko994BuAlu89s/ra+tDZRPfNrupS/SrtUbgmMUonK/dU5UAqu4HoKyryG2T3KOUF539nTzGvGpK2ZxQho9XzIRjv5gy3RNIMPuKvwL3NhZHfA
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0563e0c2-da2c-4827-560a-08d56b30230d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1092;
x-ms-traffictypediagnostic: BL0PR2101MB1092:
x-microsoft-antispam-prvs: <BL0PR2101MB1092AC5645487DC2115A5CFCFBF80@BL0PR2101MB1092.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231101)(2400082)(944501161)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1092;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1092;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(3280700002)(14454004)(3660700001)(105586002)(3846002)(6666003)(22452003)(6116002)(99286004)(305945005)(7736002)(2950100002)(66066001)(478600001)(54906003)(110136005)(68736007)(316002)(86362001)(106356001)(186003)(26005)(6506007)(76176011)(6346003)(10090500001)(102836004)(6436002)(4326008)(8936002)(2501003)(53936002)(86612001)(2900100001)(6486002)(2906002)(6512007)(25786009)(97736004)(72206003)(1076002)(107886003)(36756003)(5660300001)(5250100002)(8676002)(81156014)(81166006)(10290500003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1092;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: QLGsJHtU7BcWvHldsKZFhaavKtBFwtAiB3wmEZ57AMAyVD2YUVZelcay3P/9en3YR+5vsVV+DzD0t76o7xkd8A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0563e0c2-da2c-4827-560a-08d56b30230d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:49.3315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1092
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Moshe Shemesh <moshe@mellanox.com>

[ Upstream commit a2fba188fd5eadd6061bef4f2f2577a43231ebf3 ]

During unload, on mlx5_stop_eqs we move command interface from events
mode to polling mode, but if command interface EQ destroy fail we move
back to events mode.
That's wrong since even if we fail to destroy command interface EQ, we
do release its irq, so no interrupts will be received.

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/eth=
ernet/mellanox/mlx5/core/eq.c
index 494726f02e3e..eb91de86202b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -802,11 +802,9 @@ void mlx5_stop_eqs(struct mlx5_core_dev *dev)
 	mlx5_cmd_use_polling(dev);
=20
 	err =3D mlx5_destroy_unmap_eq(dev, &table->cmd_eq);
-	if (err) {
+	if (err)
 		mlx5_core_err(dev, "failed to destroy command eq, err(%d)\n",
 			      err);
-		mlx5_cmd_use_events(dev);
-	}
 }
=20
 int mlx5_core_eq_query(struct mlx5_core_dev *dev, struct mlx5_eq *eq,
--=20
2.11.0
