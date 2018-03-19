Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339826-1521479502-3-120547024329951203
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES endaca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521479500; b=eIKl9YdSDJYJorkrbGpV/+FjGB9G6AZUOlkFeUYt70jkzCM
    eNMp4kxNkmEymAOd3o75Ksxxb0jmQKpXT2LHMC9kThxUcdO7LCbEwN8vibxAfyx+
    7SBYCHMXhNFT5EW8q/yfREe5PlghdxH/8VoWFTETkm1ncMFYKZlCvK0Pn/79dbSO
    ajgQIShmF4diPRNzoEUEhbssM21Gfs98r73OkKFWYLRwBxDN3qhxtYn0iSFfZSSS
    hNt8dvC5mHlBegpIFTwfb+UmGfeLI24GA6tlZ1B2BNAmNKQ+jtuWeAAukmYleP4Q
    WFrfmoeUMQ8LkWOmcqjwVZ7rjMWbSTidZPJHO8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479500; bh=VdxBcu
    ObIEF9CDKfxDW9g//JEAC2PVTUVlOdJkm5Ku0=; b=N4+cVyGRPrFN1Xgoqe24IQ
    4RK2H4W4qK7Jrq/NcVWvW2oFLHLWdrtzgGfF8/xWABEWkm0WVJFcjodsLpW9UEoK
    SaGER8ity0WR77SHjpQ21X8Ifhb4PciPAOnawnZPW3qKIFaJtdmKSMeWnCPIriEj
    UTPQEJT6MWD2n284/lAm3bK6SIZmhCXURCzOl+p0BQXpFKxgRPy1hFPex7lse5A4
    k91oOAqjpPBRRFizkYReMfFxX1UQETwOeTV1LjGdbD3efDvorxnCrIY6bBeen2JG
    GszgEmCXbZOlPYGiGK5cafqfcuOA3o19HJATiBtlxWYN9F8wK8AL8J96hGnrQy6g
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=m3BSGpYs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleduuddtnecuvehluhhsthgvrhfuihiivgepudef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=m3BSGpYs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleduuddtnecuvehluhhsthgvrhfuihiivgepudef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966031AbeCSRKu (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:10:50 -0400
Received: from mail-by2nam03on0091.outbound.protection.outlook.com ([104.47.42.91]:31330
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966634AbeCSQKl (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:10:41 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ido Shamay <idos@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 124/167] net/mlx4: Check if Granular QoS per
 VF has been enabled before updating QP qos_vport
Thread-Topic: [PATCH AUTOSEL for 4.4 124/167] net/mlx4: Check if Granular QoS
 per VF has been enabled before updating QP qos_vport
Thread-Index: AQHTv5xyKu8xD2Wb6Emofq93wDFJxg==
Date: Mon, 19 Mar 2018 16:07:57 +0000
Message-ID: <20180319160513.16384-124-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1045;7:OOvCbslcFxE1/+Hlc6NidBCC56Rpaei9pXmxQWpxlU3MB3OSloJMIgpB3wRAV9L/IBk6qG/2qYRL3B8tVllQJjo0+0rFSEN5ifQlgu2TIFVkmVtfhLiV68qKSKaZBo5BITKs+F8HxSRUzHG6nHNQyfi3za2pv4RCKFrlM2vUoQAvJgY4mx6Zh95LUM9teO0XHuXsftmPjyngJExv5azwzj2n+0QnkxVD6cfIiaOZUsP/4nNOyWuaBf15l++3lgeZ;20:y2mAi5xdS1lzCJJ9BkuEbncbmxfKll69Z4clqqrtKdsIsLlP44G9yDxZ++wYBqFdM/exmkUkoXOcPm1Xm39ENV/BL/XqdrPHZvDTFBWuWhgsRBQKVJpLVm4QLsVUz4zIZy/hLgyWwL8XxAT8cIW6NuSBwRvIIyLv3R0Kw2q8M5s=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c325f64c-4f15-4495-f1a8-08d58db3f2b8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1045;
x-ms-traffictypediagnostic: DM5PR2101MB1045:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10457D9D16FDC71DA1078D6EFBD40@DM5PR2101MB1045.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(21403327493029);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1045;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1045;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(39380400002)(39860400002)(396003)(199004)(189003)(86612001)(66066001)(6436002)(76176011)(10290500003)(6666003)(2950100002)(305945005)(8676002)(97736004)(6486002)(86362001)(25786009)(26005)(102836004)(8936002)(6512007)(7736002)(3280700002)(106356001)(107886003)(110136005)(68736007)(81156014)(22452003)(6506007)(186003)(54906003)(10090500001)(2900100001)(4326008)(2906002)(14454004)(81166006)(316002)(105586002)(6116002)(3846002)(5660300001)(36756003)(72206003)(1076002)(59450400001)(53936002)(3660700001)(99286004)(2501003)(5250100002)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1045;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: n1jUlaYo4jGNhcuHWB5etbvfhRsvD57lEsLh6gKocqzi8Gr6x4FAK4KCMR2HGeaSAT6CO4+AK5dA5uG/dFqlzNV/DC+kpMbV41OuE19VPZ3uWGfcb14HuVWJQF8GzzbK8FOVwUj6kawU7SQbSfw64dfle8UxvVzs5BrB7cwniINa/BnLza2XwDEMve3R3zP5dessKPK2sn7VopEac44GCs/McNTjGnQlXaGLL5yurwcUf8n5lpE4TR39AzpmaBCCp8/XbeO63fWL9ocdfC4GsEtKcJ1yJHSfzq+hF3IfIrKykPO7gKmvRhOXEU7PxPPMqt7ItL0UXx+5m/XlWD51ZA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c325f64c-4f15-4495-f1a8-08d58db3f2b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:57.8356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1045
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ido Shamay <idos@mellanox.com>

[ Upstream commit 269f9883fe254d109afdfc657875c456d6fabb08 ]

The Granular QoS per VF feature must be enabled in FW before it can be
used.

Thus, the driver cannot modify a QP's qos_vport value (via the UPDATE_QP FW
command) if the feature has not been enabled -- the FW returns an error if
this is attempted.

Fixes: 08068cd5683f ("net/mlx4: Added qos_vport QP configuration in VST mod=
e")
Signed-off-by: Ido Shamay <idos@mellanox.com>
Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/mellanox/mlx4/qp.c               |  6 ++++++
 drivers/net/ethernet/mellanox/mlx4/resource_tracker.c | 16 +++++++++++----=
-
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/qp.c b/drivers/net/ethernet=
/mellanox/mlx4/qp.c
index d73370541e92..62f1a3433a62 100644
--- a/drivers/net/ethernet/mellanox/mlx4/qp.c
+++ b/drivers/net/ethernet/mellanox/mlx4/qp.c
@@ -481,6 +481,12 @@ int mlx4_update_qp(struct mlx4_dev *dev, u32 qpn,
 	}
=20
 	if (attr & MLX4_UPDATE_QP_QOS_VPORT) {
+		if (!(dev->caps.flags2 & MLX4_DEV_CAP_FLAG2_QOS_VPP)) {
+			mlx4_warn(dev, "Granular QoS per VF is not enabled\n");
+			err =3D -EOPNOTSUPP;
+			goto out;
+		}
+
 		qp_mask |=3D 1ULL << MLX4_UPD_QP_MASK_QOS_VPP;
 		cmd->qp_context.qos_vport =3D params->qos_vport;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx4/resource_tracker.c b/driver=
s/net/ethernet/mellanox/mlx4/resource_tracker.c
index d1fc7fa87b05..e3080fbd9d00 100644
--- a/drivers/net/ethernet/mellanox/mlx4/resource_tracker.c
+++ b/drivers/net/ethernet/mellanox/mlx4/resource_tracker.c
@@ -5040,6 +5040,13 @@ void mlx4_delete_all_resources_for_slave(struct mlx4=
_dev *dev, int slave)
 	mutex_unlock(&priv->mfunc.master.res_tracker.slave_list[slave].mutex);
 }
=20
+static void update_qos_vpp(struct mlx4_update_qp_context *ctx,
+			   struct mlx4_vf_immed_vlan_work *work)
+{
+	ctx->qp_mask |=3D cpu_to_be64(1ULL << MLX4_UPD_QP_MASK_QOS_VPP);
+	ctx->qp_context.qos_vport =3D work->qos_vport;
+}
+
 void mlx4_vf_immed_vlan_work_handler(struct work_struct *_work)
 {
 	struct mlx4_vf_immed_vlan_work *work =3D
@@ -5144,11 +5151,10 @@ void mlx4_vf_immed_vlan_work_handler(struct work_st=
ruct *_work)
 					qp->sched_queue & 0xC7;
 				upd_context->qp_context.pri_path.sched_queue |=3D
 					((work->qos & 0x7) << 3);
-				upd_context->qp_mask |=3D
-					cpu_to_be64(1ULL <<
-						    MLX4_UPD_QP_MASK_QOS_VPP);
-				upd_context->qp_context.qos_vport =3D
-					work->qos_vport;
+
+				if (dev->caps.flags2 &
+				    MLX4_DEV_CAP_FLAG2_QOS_VPP)
+					update_qos_vpp(upd_context, work);
 			}
=20
 			err =3D mlx4_cmd(dev, mailbox->dma,
--=20
2.14.1
