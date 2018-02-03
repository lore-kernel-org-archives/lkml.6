Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1602359-1517683585-2-8973348110342055305
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
    t=1517683585; b=Fm/CmNePM0Vd5dwJWYkq1oWjLAbwNiR3THMXUfu2Ifike1J
    OmN58RKuQ2wZYiNRJTPmJ59bgkDKTukEbS6tIe7UjaLrlpvuI8PNODKF3gXT8Giz
    bm6dbI4UmWw3quVgO0VyZdolJ8+WIXtCV1kwCktTHcNQUlnDbMOslnvjC5xoLUPt
    jT6+QrG9a1OSSqO36o8QbMhpiqLLjpqo4DCq0S7ACd4zTAlIoG9WARnU6hAyiYl/
    2xyFJteESe2EZK6UP6u3ST+udwezF72Olcjp2XnvRwLQb3lvMoimcCIRj5x8aqYp
    v17btccTiJNk+xuDVlRaUsMU1tmDRAMi8cOsUVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683585; bh=vURbp9
    sH1BRNIgwcoDgQix4nS507fBCGRMcQMH8gWNM=; b=vxFf9hiyaYFq5PNRb+U56o
    fYt8iBsKgtMhhKlMGhK33wEAwmsgL1Nw4BBchn4z5POA+jcMm20Oa/DgqBjMT4Tz
    QzldwGyz4l26XBcuaRgqIHEqdlSK6+jDb8qbKOXNsn6VIFQP6C4KeHVDdKl3Zlc4
    3jMRS3kVSSLcm2oSAyKC5hp8ecTpygKEZLoxI+go/0UQJe9ng/k7nq/rEwoAjc7Z
    Yh7b/qbmZPX4Qrvj/Jm1vghf8GrVKujRdGPcBQcMdJMUmmPhQnHk6XPFt0vKesQt
    GUYy+bRHitNoPMEo50O2+6GdbOOGNLazKvb2D/iK0QjlMXX/t/KqoIO8afOZDbTQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=h2qd1pQx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=h2qd1pQx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754821AbeBCSqV (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:46:21 -0500
Received: from mail-co1nam03on0092.outbound.protection.outlook.com ([104.47.40.92]:4928
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752944AbeBCSBj (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:01:39 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Moshe Shemesh <moshe@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 042/110] net/mlx5: Cleanup IRQs in case of
 unload failure
Thread-Topic: [PATCH AUTOSEL for 4.14 042/110] net/mlx5: Cleanup IRQs in case
 of unload failure
Thread-Index: AQHTnRjsCNVZnWPcBEmC9W8bgYtYmQ==
Date: Sat, 3 Feb 2018 18:00:48 +0000
Message-ID: <20180203180015.29073-42-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1092;7:ExlYxcP0AP3zi929suB8eac+rS5ZrxS9a/EcyCTAaca3Y3sLggU3V11lIyaesh0U6a6wwUQvMg3dLA3Ry8tIU4czUMietERnRZXWhYjbi6V53bs6XYBl2wAzoaFj4UADZqzKHWuiI4gM4IkCg+loRLK6wC3+RdtVcsYRDuqRS7Qr2Px1ifRWaSj4s8/qg5gTya8XvKILqC14SayA5zIZLQgDpGt8n5SGHpuWT2M/WDZDXbm4UeUFh5HUbH+QaU/w
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f92cd441-6514-4a6e-f994-08d56b30228e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1092;
x-ms-traffictypediagnostic: BL0PR2101MB1092:
x-microsoft-antispam-prvs: <BL0PR2101MB10921A31CD065B3816E880C1FBF80@BL0PR2101MB1092.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231101)(2400082)(944501161)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1092;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1092;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(3280700002)(14454004)(3660700001)(105586002)(3846002)(6666003)(22452003)(6116002)(99286004)(305945005)(7736002)(2950100002)(66066001)(478600001)(54906003)(110136005)(68736007)(316002)(86362001)(106356001)(186003)(26005)(59450400001)(6506007)(76176011)(6346003)(10090500001)(102836004)(6436002)(4326008)(8936002)(5890100001)(2501003)(53936002)(86612001)(2900100001)(6486002)(2906002)(6512007)(25786009)(97736004)(72206003)(1076002)(107886003)(36756003)(5660300001)(5250100002)(8676002)(81156014)(81166006)(10290500003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1092;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: hE+Mg5t4WLqadMDPvqmQAQahi2M5OjiD1ajQF1++20YjJnnWxkL84iFucPc/FwdIYScnltxUksYzG/FOaVa17g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f92cd441-6514-4a6e-f994-08d56b30228e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:48.8471
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

[ Upstream commit d6b2785cd55ee72e9608762650b3ef299f801b1b ]

When mlx5_stop_eqs fails to destroy any of the eqs it returns with an error=
.
In such failure flow the function will return without
releasing all EQs irqs and then pci_free_irq_vectors will fail.
Fix by only warn on destroy EQ failure and continue to release other
EQs and their irqs.

It fixes the following kernel trace:
kernel: kernel BUG at drivers/pci/msi.c:352!
...
...
kernel: Call Trace:
kernel: pci_disable_msix+0xd3/0x100
kernel: pci_free_irq_vectors+0xe/0x20
kernel: mlx5_load_one.isra.17+0x9f5/0xec0 [mlx5_core]

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c | 20 +++++++++++++-------
 include/linux/mlx5/driver.h                  |  2 +-
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/eth=
ernet/mellanox/mlx5/core/eq.c
index fc606bfd1d6e..494726f02e3e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -776,7 +776,7 @@ err1:
 	return err;
 }
=20
-int mlx5_stop_eqs(struct mlx5_core_dev *dev)
+void mlx5_stop_eqs(struct mlx5_core_dev *dev)
 {
 	struct mlx5_eq_table *table =3D &dev->priv.eq_table;
 	int err;
@@ -785,22 +785,28 @@ int mlx5_stop_eqs(struct mlx5_core_dev *dev)
 	if (MLX5_CAP_GEN(dev, pg)) {
 		err =3D mlx5_destroy_unmap_eq(dev, &table->pfault_eq);
 		if (err)
-			return err;
+			mlx5_core_err(dev, "failed to destroy page fault eq, err(%d)\n",
+				      err);
 	}
 #endif
=20
 	err =3D mlx5_destroy_unmap_eq(dev, &table->pages_eq);
 	if (err)
-		return err;
+		mlx5_core_err(dev, "failed to destroy pages eq, err(%d)\n",
+			      err);
=20
-	mlx5_destroy_unmap_eq(dev, &table->async_eq);
+	err =3D mlx5_destroy_unmap_eq(dev, &table->async_eq);
+	if (err)
+		mlx5_core_err(dev, "failed to destroy async eq, err(%d)\n",
+			      err);
 	mlx5_cmd_use_polling(dev);
=20
 	err =3D mlx5_destroy_unmap_eq(dev, &table->cmd_eq);
-	if (err)
+	if (err) {
+		mlx5_core_err(dev, "failed to destroy command eq, err(%d)\n",
+			      err);
 		mlx5_cmd_use_events(dev);
-
-	return err;
+	}
 }
=20
 int mlx5_core_eq_query(struct mlx5_core_dev *dev, struct mlx5_eq *eq,
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index a13525daf09b..574a01caa193 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1017,7 +1017,7 @@ int mlx5_create_map_eq(struct mlx5_core_dev *dev, str=
uct mlx5_eq *eq, u8 vecidx,
 		       enum mlx5_eq_type type);
 int mlx5_destroy_unmap_eq(struct mlx5_core_dev *dev, struct mlx5_eq *eq);
 int mlx5_start_eqs(struct mlx5_core_dev *dev);
-int mlx5_stop_eqs(struct mlx5_core_dev *dev);
+void mlx5_stop_eqs(struct mlx5_core_dev *dev);
 int mlx5_vector2eqn(struct mlx5_core_dev *dev, int vector, int *eqn,
 		    unsigned int *irqn);
 int mlx5_core_attach_mcg(struct mlx5_core_dev *dev, union ib_gid *mgid, u3=
2 qpn);
--=20
2.11.0
