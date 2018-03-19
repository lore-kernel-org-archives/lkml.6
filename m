Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3715406-1521493327-2-6903726482162693984
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521493326; b=n6paP7qXYE8WTNEqAyUf52Js3yfpgMC7WgZu+7ByF6t8giU
    G/NsHwBFQDJUtgV4kiv3MExfHayHOmn7BlM7Od6pkTmIS0KwCxXAV1CfdgP953Sf
    FCuFlgDfdDnOePtLC0ekX+n9a+FEU+PNS/d+8Df5GKc+kzUqQ0hbfPoIYzqx/Jan
    Mz3LldyfVjRkWBdeaMH9E60uX7ImIpegRXoh7TFGnb2zs1dQRIxJD54gj/cXG/el
    AyVkouu0NjTTnpS2IUeoCcQL3G9KWzlM0qKAb0NB5RVMTaBV8bCghzfIEv8XA8wh
    8ZYupyDW/lpo+LYb88J4HHiXg2EmZgMBB6xF20A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521493326; bh=MA6SHd
    SVA6u8PdYHlRkj9p6VREYNGq9a2gjZQVpbpO8=; b=Cqkfs+zhiO4U/ppCNb45CN
    YRhOqnUWRnXoUBvpEpNMbUbUU4vF5wyrZ+3RXNZ5bcTDnvbHcfRVbSz8WP+gPLwP
    Sp3nQkXZq+KuQNG3bNGbG3E/7dRs9jMOxVnn2HcHNZiOWUpd3aH4EIbhDT1lUaVl
    J7Km5wLaVnEoYwAU+BisKyiad28Q/0XD0rOGxVYBI6UWmJYH7F0c+HFY1jI19mHp
    ml8mA0gbcFIPZQw+Oa/d5zs0ACCa6tD7UDTvKO7JcRzb0J/OBCMX41GIklNiuDEE
    1aF7wlLwnR+V5WHkbx+RbZFp6UzxhaRKcKJz0oeXNuqUGTJphXub5BLXgHphVtkg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=k45w7hh1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjedtheenucevlhhushhtvghrufhiiigvpedvtd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=k45w7hh1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjedtheenucevlhhushhtvghrufhiiigvpedvtd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968694AbeCSVBw (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:01:52 -0400
Received: from mail-dm3nam03on0119.outbound.protection.outlook.com ([104.47.41.119]:22560
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965481AbeCSQCw (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:02:52 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 161/281] net/mlx5: avoid build warning for
 uniprocessor
Thread-Topic: [PATCH AUTOSEL for 4.9 161/281] net/mlx5: avoid build warning
 for uniprocessor
Thread-Index: AQHTv5t7eq+0oF4EH0OO5LTRUM3aBA==
Date: Mon, 19 Mar 2018 16:01:03 +0000
Message-ID: <20180319155742.13731-161-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1062;7:5WWcdzlXISogB7k23VbofCJT3+aIfE6jgDcDVwUJhsH6WYqggGjhLv3hGG7bk6w/MlicLB6n3QTqn6E9E+AIwjVCcubj8eZWC3CLLUukQIzSUyAzjVnDEtLgr4Fp5f+IA9eU1leJ56wgGrXFoCp8HZuN/SUMkXdgg1qOJgoM9pd76oIVMJCvCePRhkW35YNzp8xWlzgVngFZjjlHgIBlxGEcOCWBa4VBweIEukyq4VLH8yjSdOXD3H0kJC765NKx;20:rus+wv3GX0IJP86dPjOVKlk81nNxR6n/FnkkFgCy4YnplaH79fzf1eaJ5re2XAHP862a99EtxXlhylIZrIPHE25uvoUG+6rMiqYdvR3ccDFEaCefKxz7vyCQNVdfnK8XE95NOy15KtiaUwLFRXCtXO5+Q0iyDOS0dv7DGyYW8h0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 21760392-4fe3-4fdb-8f61-08d58db2d850
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1062;
x-ms-traffictypediagnostic: DM5PR2101MB1062:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1062633031DF9C65AC7E8163FBD40@DM5PR2101MB1062.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1062;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1062;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(366004)(396003)(39380400002)(199004)(189003)(106356001)(10290500003)(478600001)(110136005)(22452003)(3280700002)(6666003)(54906003)(2906002)(2900100001)(2950100002)(186003)(10090500001)(97736004)(26005)(5660300001)(72206003)(66066001)(53936002)(107886003)(102836004)(59450400001)(6512007)(6506007)(316002)(7736002)(305945005)(1076002)(6436002)(36756003)(3846002)(6116002)(6486002)(105586002)(8936002)(86612001)(68736007)(3660700001)(86362001)(575784001)(81166006)(81156014)(8676002)(25786009)(2501003)(4326008)(76176011)(5250100002)(14454004)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1062;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Vb+YVa9uOBV2BnIQ4tayiqoYOM8iPweM920wagfK5wuEV19wF4UTb3HLdNrHaUC7cwsqqqg7FYXV7Sb1YzT00KbJw0W1PpgjPAZAA4SCaUKC6tZCnBmd81+PvWoDPXWYxPxQrN1j9SJkkK4m3drLXm5vjLsjJsZDZI5cBC1WhVo2dmNN6P+/kAHY/vtYjOfnpGfDydBjZpoKvXotUuwigjBtBWP7+afahV0rFlrVVb9mJ63hdrF6eyjo4SaRS49IvuBhjS64Iy9vJi3e/1ndERSYQDR+PcZPNNYMohFUO4aaEdPLBJIF3uXAFjjLsHiIZEEcIpz2souF31HBIbdivg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21760392-4fe3-4fdb-8f61-08d58db2d850
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:03.9936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1062
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit f0d7ae95fff4ab444b8433f07afc4b077ef1a285 ]

Building the driver with CONFIG_SMP disabled results in a harmless
warning:

ethernet/mellanox/mlx5/core/main.c: In function 'mlx5_irq_set_affinity_hint=
':
ethernet/mellanox/mlx5/core/main.c:615:6: error: unused variable 'irq' [-We=
rror=3Dunused-variable]

It's better to express the conditional compilation using IS_ENABLED()
here, as that lets the compiler see what the intented use for the variable
is, and that it can be silently discarded.

Fixes: b665d98edc9a ("net/mlx5: Tolerate irq_set_affinity_hint() failures")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/e=
thernet/mellanox/mlx5/core/main.c
index 935e62635f12..3c183b8c083a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -557,10 +557,9 @@ static int mlx5_irq_set_affinity_hint(struct mlx5_core=
_dev *mdev, int i)
 	cpumask_set_cpu(cpumask_local_spread(i, priv->numa_node),
 			priv->irq_info[i].mask);
=20
-#ifdef CONFIG_SMP
-	if (irq_set_affinity_hint(irq, priv->irq_info[i].mask))
+	if (IS_ENABLED(CONFIG_SMP) &&
+	    irq_set_affinity_hint(irq, priv->irq_info[i].mask))
 		mlx5_core_warn(mdev, "irq_set_affinity_hint failed, irq 0x%.4x", irq);
-#endif
=20
 	return 0;
 }
--=20
2.14.1
