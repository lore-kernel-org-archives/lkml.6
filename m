Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827928-1521494574-2-17292893190557902315
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521494574; b=UfSpBcjDVIdHTHZPLK4zau5iQDMky5O4JQy3H11aTsTNNPK
    0CzNhAfvV2s9pdIfT1jVIHqY3z3uKerkIXm8tnoXKqp7JoX7CsakJ8z3ZGy1nyEn
    56FwhO1M9KChq8A7TGk8FX2ypFoJBDTInY5c55G2/LT275jAICMM9+2K7fKL/1sL
    nYOuO/vC7Vt/OZYSEgnjFsLnZvth35Uk2Xfj8cEvR8+Cp3PXHRvQ0Td7oTDuvQ9l
    kowW9eXgjoVQiQePcNFJi0J+cditX+IFBxPA74X/vvC3AOnT48rHJM7IEM+Aib5Z
    iY/CMxQRzrOATti1aP2hTmhCxYioXfWw/mjHvjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494574; bh=ba/VO3
    qV6qttk8gzQzu37g/Hqcrzn+W2dJvndL1Y74o=; b=EOJddM2THSEk1xemXHoFL4
    V2BdIAx98J8MxAkyLzwIWhq77Ois6kcsjpatfTUOH/5PzCxou11bV2lT3JWkanNX
    nx9Lagy1peQJgev4mDIUPofgOnCwx/8G3sl4EnJKtvlut5dpiqbbPa4POX9Tw4ko
    T4Vy+viAYK3IC7Hrt+8VgUgMQ8o3cz3fHaLoR1cEjVcJzKt0qhRWTVSNMX/kqPOL
    mvEH6R6Yv9def3dOoxt54kEelD/AsRN5/vT1iyDQRT9s1c/lZIXu6+E9ri41PH46
    hyxTAwLwJyP67zOApphFNGjpY+vnK2PFTVhCpd4wFVrGHm5EA3YQ9v3LcB9X6RPg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=odsjyX9Q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekfedttdenucevlhhushhtvghrufhiiigvpedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=odsjyX9Q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekfedttdenucevlhhushhtvghrufhiiigvpedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934924AbeCSVV5 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:21:57 -0400
Received: from mail-co1nam03on0111.outbound.protection.outlook.com ([104.47.40.111]:3840
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965006AbeCSQAr (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:00:47 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tariq Toukan <tariqt@mellanox.com>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 096/281] net/mlx5: Tolerate
 irq_set_affinity_hint() failures
Thread-Topic: [PATCH AUTOSEL for 4.9 096/281] net/mlx5: Tolerate
 irq_set_affinity_hint() failures
Thread-Index: AQHTv5tNUw7pe1MGnkqN9nq50o3sDw==
Date: Mon, 19 Mar 2018 15:59:46 +0000
Message-ID: <20180319155742.13731-96-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0933;7:UdxRYjZ9e3RhGGEQMukTdok4ef9XI4Hu5KuKUzDAbByxoWwm0Bbac3hVR/Hr3FcRr14X4h1nqX1zQuJxtiYcq8+G9Ewli0TMdbll06cDIfptO0OCVs+qrA6vK698nrd/MG6geOODuwNuPxokCRVyYJ1w9389oZmcULUZVHD3T8sbUgZTd4SQCqn/auy4T15fIuNsjF26WFmfDHU5OLo5pT/rJfjYRU0XzUJDmJ512lLD8UsdpbvIk7HD/HzlTqHC;20:noRfhWxuhwd5H4pdXb8tkD+1E7Zc96fKVRx8S2NpSroaFjmY7SKbI2pJi/By4tlaZcTQSsJfxcLkQR+UnMhtv7ME0IZtr1hyCq+LCYJ23bXTSUVofAZ972Arg9ERgvm+rhh4J+qCgYZD14GNZTzMBP1R6NtFiYMxvcTo3lh6KCg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9459dd1c-f10d-4048-a600-08d58db2915d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0933;
x-ms-traffictypediagnostic: DM5PR2101MB0933:
x-microsoft-antispam-prvs: <DM5PR2101MB0933EF7C6FA684582CC11434FBD40@DM5PR2101MB0933.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0933;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0933;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(346002)(376002)(199004)(189003)(2501003)(72206003)(1076002)(66066001)(10290500003)(99286004)(10090500001)(7736002)(14454004)(6116002)(5660300001)(2906002)(97736004)(6346003)(102836004)(575784001)(22452003)(86612001)(3660700001)(186003)(2900100001)(25786009)(478600001)(5250100002)(26005)(6486002)(6436002)(81156014)(81166006)(36756003)(4326008)(86362001)(76176011)(6512007)(8936002)(106356001)(3846002)(53936002)(105586002)(3280700002)(305945005)(68736007)(110136005)(2950100002)(54906003)(8676002)(107886003)(316002)(6506007)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0933;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: O0+vKuuoaqqSafvbfSrOBbNoYYom2n7bzGpahokYY2B8FLQh2A8w3lWINN/blUiKhkOfmNrt9QIkXOf+w0ausG6ycDcR4D58uXe/mmRLzz+zBReRP+Uh5PA50ZRrZ8mWqrMg4aYYCINXovRiOoLkuyLnRJ3CNK2vj/uYfuFVG7eERFRdnjaqL93x/OOe034dEQyDiDDSQW+2LdBh9X7bJdr7ri+Q2VF/QFk493wlzbnm94PDkzlddlnweT2Ct3n8lLTBHxe4rMiILh8EJUDG5rN14cNrP1BPy43ZTcWIoTRAn6N1b86Zdtp4nl8yfxVTsCVE1DCmKXptoyafdI1kRQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9459dd1c-f10d-4048-a600-08d58db2915d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:46.5658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0933
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tariq Toukan <tariqt@mellanox.com>

[ Upstream commit b665d98edc9ab295169be2fc5bb4e89a46de0a1a ]

Add tolerance to failures of irq_set_affinity_hint().
Its role is to give hints that optimizes performance,
and should not block the driver load.

In non-SMP systems, functionality is not available as
there is a single core, and all these calls definitely
fail.  Hence, do not call the function and avoid the
warning prints.

Fixes: db058a186f98 ("net/mlx5_core: Set irq affinity hints")
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Cc: kernel-team@fb.com
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/e=
thernet/mellanox/mlx5/core/main.c
index 981cd1d84a5b..935e62635f12 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -548,7 +548,6 @@ static int mlx5_irq_set_affinity_hint(struct mlx5_core_=
dev *mdev, int i)
 	struct mlx5_priv *priv  =3D &mdev->priv;
 	struct msix_entry *msix =3D priv->msix_arr;
 	int irq                 =3D msix[i + MLX5_EQ_VEC_COMP_BASE].vector;
-	int err;
=20
 	if (!zalloc_cpumask_var(&priv->irq_info[i].mask, GFP_KERNEL)) {
 		mlx5_core_warn(mdev, "zalloc_cpumask_var failed");
@@ -558,18 +557,12 @@ static int mlx5_irq_set_affinity_hint(struct mlx5_cor=
e_dev *mdev, int i)
 	cpumask_set_cpu(cpumask_local_spread(i, priv->numa_node),
 			priv->irq_info[i].mask);
=20
-	err =3D irq_set_affinity_hint(irq, priv->irq_info[i].mask);
-	if (err) {
-		mlx5_core_warn(mdev, "irq_set_affinity_hint failed,irq 0x%.4x",
-			       irq);
-		goto err_clear_mask;
-	}
+#ifdef CONFIG_SMP
+	if (irq_set_affinity_hint(irq, priv->irq_info[i].mask))
+		mlx5_core_warn(mdev, "irq_set_affinity_hint failed, irq 0x%.4x", irq);
+#endif
=20
 	return 0;
-
-err_clear_mask:
-	free_cpumask_var(priv->irq_info[i].mask);
-	return err;
 }
=20
 static void mlx5_irq_clear_affinity_hint(struct mlx5_core_dev *mdev, int i=
)
--=20
2.14.1
