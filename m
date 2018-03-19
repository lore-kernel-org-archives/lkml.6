Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3444635-1521482390-2-12423371379905293408
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521482390; b=YziFm/2DkkPg2LaKvgd2iKTvR+4d5qj42aXwZTohKu/7o97
    TGD49OiKi02/P4IPNVFgdEgS/jMyekbKjL6QMKr/ae9dfYCUFPqIocfPjTByDi5J
    8+6b6yZSFBsC9OQdhE9qmlDSo7BAgz2KMt6lBlYExKaOBo6aEujlDdm7c414xy9J
    swG6PAqlcfXOt4XfoHZ2AL1okf+uTnISwXoibDYtJd90Jo94cOI/X/Yt1Ww+6RZO
    PlyQK+opeGRb22hBsFiJd7sMmug7zo0S2+q89uv/6x5q+s5pBKrF4i3ISvJhSD9f
    HQs3oAuYeYBLVZuxuVTMOHKtppRQ18dYITT++uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521482390; bh=M0qkEm
    5MBVjQXiQwfOhVc+s8mAoEYpIrEWBW3ifdEwE=; b=CsMhIYapFP5utBYSnyaEfy
    QaCIyIw8Kwe3pvZLqY6t3r0l1YDblRmp86ajUtNvkfEwIasDeYDN7oWzYSiuCroD
    sLnZYA5vOIzZPWQ7xN3ZiXDmzc0tMrWvaDaAKqpXfrCqVaYr3QLavPBikoWpBZgL
    ByL8yjAm3rVDMYHX4i+o6YjfV/QWLDSMTDF0IIDWs67NNNfVOZsseql6d/zjrv8t
    rmdXa2irZh9cAAolhZ/e/6jHW9AO9AetdMRqX0C3+W9v1GliBpqOWpgkO/1lry6D
    QcrovhiT3veYoc+ISaZ8lCsZp0SUzjNhP+mGPOd/UKaxmnRA+73s64yn02kGj5Gw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=l2sNfz/N x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeludduudenucevlhhushhtvghrufhiiigvpeehvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=l2sNfz/N x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeludduudenucevlhhushhtvghrufhiiigvpeehvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965655AbeCSQEV (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:04:21 -0400
Received: from mail-bl2nam02on0137.outbound.protection.outlook.com ([104.47.38.137]:29088
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935052AbeCSQEG (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:04:06 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ido Shamay <idos@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 199/281] net/mlx4: Check if Granular QoS per
 VF has been enabled before updating QP qos_vport
Thread-Topic: [PATCH AUTOSEL for 4.9 199/281] net/mlx4: Check if Granular QoS
 per VF has been enabled before updating QP qos_vport
Thread-Index: AQHTv5uWL45rhJpmQk22ist3gfQJ5g==
Date: Mon, 19 Mar 2018 16:01:49 +0000
Message-ID: <20180319155742.13731-199-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:HXDqea3vrqdhjAwMbdSimd+gOQJAN3Ls7Yit5agPyJHKb2DwOBrhva1A/JjVa4AaMdpMX8Vg/FIfrGNwWbANOJKYxSnAHo6NP5knSoTghOe5d6dz2DksFQ6+5qU+4dI+F+e6oETVo0IvtoErRp+C1uHLj+ru1tlpv7A+nnKP/jldug9uWOW/RnZHkgZYYklmVPgWobj4SLJPwHBqnCzJDikxgjUpRIRZO2fOvQV48L4iEZkaHsjl2zau4NSQyHqf;20:+sM0zfQIoVM8TYcoS7JI2z3e7upgCPB8FacavFfXcuZIfoLOX7BCHKyohAfo/yxgQvgTxYBC/EuKh5Hz+T16F/W/pmCa+aD/N51icNKAnFw6uFT7iFpOATlneVCbQQlGsbBlPuNAC4zBVMo0Kpa2D4iLCo6zGBYtZJy/uAZr2io=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0d06b9e1-af03-47ea-5586-08d58db30558
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB072757A6FAAE362F62905528FBD40@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(21403327493029);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39380400002)(366004)(346002)(39860400002)(189003)(199004)(4326008)(53936002)(6512007)(81156014)(305945005)(81166006)(14454004)(6486002)(106356001)(76176011)(2900100001)(6436002)(6506007)(68736007)(22452003)(66066001)(3280700002)(6116002)(59450400001)(110136005)(8676002)(54906003)(10090500001)(3846002)(316002)(2950100002)(26005)(86362001)(105586002)(6666003)(99286004)(36756003)(478600001)(2501003)(186003)(5250100002)(86612001)(97736004)(107886003)(7736002)(1076002)(102836004)(72206003)(5660300001)(25786009)(10290500003)(2906002)(3660700001)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 1f4XurH3Lgqg19iKTu/TM/+zx1TSTGZ2nIuiLSzUcD1GEmN6h/NFAdWxNv2/IRbrod7AJ58ySWR3Fj2TFptpmIv4oBTy/SFLfC+gcxCdivm9SN9JANgicV0iiFT68tJ1sOzBiKoQSEQECE5uctqGpVdI8J5DQDQV0yxReWI3RijnsZ4vYohWh61gsGf0oVj4DMmWUtUkQmqHWe7xH6ndUzDyIz52cNPxPjGMSXN0t04t38C1Dp8h4D1wnwzwDUkkRtuWIujaed3vpnuY9NjyliiXf8vDOz6Hn+01npbTayop6G0hSkvjsgDvU+4oVrVm2Ehgq94X1wZ5boH9dETqVw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d06b9e1-af03-47ea-5586-08d58db30558
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:49.3801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
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
index 99c8fc970f88..474ff36b9755 100644
--- a/drivers/net/ethernet/mellanox/mlx4/qp.c
+++ b/drivers/net/ethernet/mellanox/mlx4/qp.c
@@ -487,6 +487,12 @@ int mlx4_update_qp(struct mlx4_dev *dev, u32 qpn,
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
index 1822382212ee..8fd1b1ab7d81 100644
--- a/drivers/net/ethernet/mellanox/mlx4/resource_tracker.c
+++ b/drivers/net/ethernet/mellanox/mlx4/resource_tracker.c
@@ -5214,6 +5214,13 @@ void mlx4_delete_all_resources_for_slave(struct mlx4=
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
@@ -5328,11 +5335,10 @@ void mlx4_vf_immed_vlan_work_handler(struct work_st=
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
