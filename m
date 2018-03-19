Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3384037-1521481340-2-5428586190946968761
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES daensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521481339; b=YQu/aHnFBFJMLhVVouSfbd8mVqDqssgbvwkEvx41HuI7iF1
    RUF42MKM3hz0H857KRHAd7u+a7T5FNfAhjuoCdk/hLRzyXFxTrhzawIKljVcLMow
    nkYDRYgh91RQh2NPplJ+wk/apCaIKc4/NfjvsoXPc571qt4D7LNtoagHivp6cfbb
    froKcE73+DestGu/IKBmInvT8s62ngOYLCCApXtjziumMDJGV4TzzRYHF08CrcAN
    9z7lMZ2+1WUxMsO6uBsmfe1m/ku/R42eP0HAqWjIbE6Bw9sLcDFKCvZLzxWcCtrw
    QbPxe/3kHGfD78D9FMa5X/tTJU+9aYwXXCH7TGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481339; bh=UrzVSU
    VQJAkQS9SGpnIIVflXmXz4nmJ+Izlo/Tn2sE8=; b=AYVbu4nctXl/wHYX1kzbql
    Spg1DOcJ7LmGAXvYW9gYYECT8pUArAh7A2NBlacksTF0PqMbeUHx/McHGesw5yxH
    AMcKPonkiqN7ZW3MNLa3wi8vVsK6R9nndDwchUABVUN9WTjLW06jF0DXxRsr3CFo
    PF/5ZnK8/K45fFjolwLf7vqyqjFgsy2AA5kvp/+bzJAU+h8X500aVZl/NTYnrnqg
    RQswQza87ANqWbzm/q5t8JVrjVKFOxtikgq+H3QcFn7VM1o6eMRbdyQyGHhfCeKD
    iM7Lm9XwbCRNqNupkjoCDChz5i1o14U8g7bl3wPodbTCZ0wkTNmubmeSu1o+fWsA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AY5rGu8m x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejhedtleenucevlhhushhtvghrufhiiigvpeehle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AY5rGu8m x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejhedtleenucevlhhushhtvghrufhiiigvpeehle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965857AbeCSQFx (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:05:53 -0400
Received: from mail-bl2nam02on0128.outbound.protection.outlook.com ([104.47.38.128]:47286
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965837AbeCSQFq (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:05:46 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Netanel Belgazal <netanel@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 250/281] net: ena: disable admin msix while
 working in polling mode
Thread-Topic: [PATCH AUTOSEL for 4.9 250/281] net: ena: disable admin msix
 while working in polling mode
Thread-Index: AQHTv5u7UltfT78gQkusKnu6mknm6Q==
Date: Mon, 19 Mar 2018 16:02:50 +0000
Message-ID: <20180319155742.13731-250-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:4MdSrI/lAyJ3lvqZCQSy6ln4KXgxLHZc6++GdpK1tliIIB/tnFc9BvJKBcxvmHpuJII4ZFTFIcp9ivyODlebJHnnCP+htkl7eXDljgtiemrZAQMWbwTANTTw78J49NeHrMwR28QhmQC1my8hlV8bjdHc8zn8mhzr5FaSv+8KSSDl1yIwrzyWdHDBoJZW+O6nPzGbBj8M66IyrtO+2A3i3e3M0kPu/69W704hp4lIUHZLG2e3WIBy00A78CHhm2gW;20:4+uPimSTwFEh/G9ib3lYfyGjceAkJtxKYo+qdI14oyQzRR7J1iM2uNEZD3DZdowt6Dm1pn5l3p3bsngHWY3+R13bjxJJ6RJeXmqRFaWm3uMrbSF29g+Y6A3lrmktcATmqSICjoq6LdUDk+Hpkt5tfb8NlefXGZW8nqpj1KDOVfY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6f833041-4017-46e0-4afa-08d58db33dd1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07277F68FD0A9879BE8A02A8FBD40@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(33061846794335)(47284530071512);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39380400002)(366004)(346002)(39860400002)(189003)(199004)(4326008)(53936002)(6512007)(81156014)(305945005)(81166006)(14454004)(6486002)(106356001)(76176011)(2900100001)(6436002)(6506007)(68736007)(22452003)(66066001)(3280700002)(6116002)(110136005)(8676002)(54906003)(10090500001)(3846002)(316002)(2950100002)(26005)(575784001)(86362001)(105586002)(6666003)(99286004)(36756003)(478600001)(2501003)(186003)(5250100002)(86612001)(97736004)(107886003)(7736002)(1076002)(102836004)(72206003)(5660300001)(25786009)(10290500003)(2906002)(3660700001)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: HNVJ/7QLeOOJNsHl50emRlv5qYRK+EpdoIY2r4uBE1uGf5f6ASkgMLDFF1i5MtJXpPaI49gdJbKEXpt+MkmpIfDHUbBBiwVBRdOIpfCWfirZE8yGHJCTCfbgjMBg0QnXPWesCVksLFYjBqdoegCt1EwJ0uldUA9fD4C5E4ncHbQ5jkcUesqwOM9gRz8FNgwVWfIhPtsxo3mVBeXXwefo2fw9GY4vj7y6YWRD1vJESkpbMcXHRUlfhjH8AuUviLwrFuGQyEPumaC2l+MnVe27nyCONOlt90hl5N/YYnNjvhdn//lSecz7YOq85MNZ18y1+J2WHBPI0k8kQu8xZuuj4Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f833041-4017-46e0-4afa-08d58db33dd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:50.3309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Netanel Belgazal <netanel@amazon.com>

[ Upstream commit a2cc5198dac102775b21787752a2e0afe44ad311 ]

Fixes: 1738cd3ed342 ("Add a driver for Amazon Elastic Network Adapters (ENA=
)")
Signed-off-by: Netanel Belgazal <netanel@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/amazon/ena/ena_com.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethern=
et/amazon/ena/ena_com.c
index f4c107b66af4..e13c9cd45dc0 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -61,6 +61,8 @@
=20
 #define ENA_MMIO_READ_TIMEOUT 0xFFFFFFFF
=20
+#define ENA_REGS_ADMIN_INTR_MASK 1
+
 /*************************************************************************=
****/
 /*************************************************************************=
****/
 /*************************************************************************=
****/
@@ -1448,6 +1450,12 @@ void ena_com_admin_destroy(struct ena_com_dev *ena_d=
ev)
=20
 void ena_com_set_admin_polling_mode(struct ena_com_dev *ena_dev, bool poll=
ing)
 {
+	u32 mask_value =3D 0;
+
+	if (polling)
+		mask_value =3D ENA_REGS_ADMIN_INTR_MASK;
+
+	writel(mask_value, ena_dev->reg_bar + ENA_REGS_INTR_MASK_OFF);
 	ena_dev->admin_queue.polling =3D polling;
 }
=20
--=20
2.14.1
