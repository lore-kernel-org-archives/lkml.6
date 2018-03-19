Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891259-1521496720-5-1336912148644588551
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
    t=1521496720; b=bcS0zsCv14or9MKza943vghMJuQqfIaGA+1z4Ugk+rGE7rz
    MbrHUjMrGpkMf6nmX/gUToFJ0IUBeQ5eZb9wv/01WASIOMT2u8dMiWetn+wxQxz9
    iR0lVmwDCLqO1A+8kNWyCtbfKruRtrZItgsfIrambzpl5AhKmQr+qIKRh+IbK0cW
    xz6ISZOr4rcH9Lryyk7p3L5uT46+Rooogt+qlmLSOQSxzT/GBm1K4JA5ILDDNPab
    G9F9+MSJcrlUhhqTKVHzU3V5vGAbWMDzvAANPMmW+CxtBokMnr5RE7iNqI07QKLq
    Sl9PRru+A9bh/nwKz0nitwz5ZL0M04Jes7ZcHCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496720; bh=5qh4Bd
    auiCh7RR5LGgDiqNMlHzHasLCAjvJ0h2HhSWs=; b=gnt7qc8CHi8f/XJvFu2eMI
    C5fj4xS9Jlv9z/Yp8/LhF3bo0h6DPth4OCzUZvLMFPxPG27GullretlsBqaqtx+5
    Uo3e7zjVwdIcAe8PV/fD7I/ooaNfO1qDyNdq8scySxzjB+ILI4PsGWcXFLwOcApS
    FDxUOHVJ+txqL36Pnm0buoiweAbszLKVC3JdCcXFuQU0XwzfGFG+MOvrA2ZG0d5V
    bV2KG/fXktiZ8/zqplkhi6YR9Y30DKhX9C5Kb0nK9b62fcxALRuuqUQWoScQ3NdF
    9oIXV5q/xy0ExVSU9K7Q6dBFb/6aGUV8azzEHANZBQmAsgMK+uJ8BPL3uGXHV6YQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fSieny/l x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejudeitdenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fSieny/l x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejudeitdenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964815AbeCSV6V (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:58:21 -0400
Received: from mail-by2nam01on0117.outbound.protection.outlook.com ([104.47.34.117]:58464
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934549AbeCSP4f (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:56:35 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Fuyun Liang <liangfuyun1@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 64/97] net: hns3: fix for changing MTU
Thread-Topic: [PATCH AUTOSEL for 4.14 64/97] net: hns3: fix for changing MTU
Thread-Index: AQHTv5rCiefytgbY/UKFybGNbyKbcg==
Date: Mon, 19 Mar 2018 15:55:54 +0000
Message-ID: <20180319155411.12348-64-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:MlZfrftUAIVz/xjnH/wvzeK8apUmyhUJMZU9lA3kKRkbxM5K8PhdCvAluAZ+qkThr/xr8mO7yhGry74ro8QGBeSj9ETv3fIs0i+N4Pkj3dvOvAXnXE5VuAs7Dwy5evzs0UQnAD2JFfldwmoVz+Cg0c9kz+7Z7uC3AFET5LkTM3SGEua3qA9qzZjEoIWYPp+WlaxxX4ehmnMXzVFxXpuH/baHPnofDcvE8r6IUH3o2TFlRTt9fix3avuDl6mL3AFH;20:Zn+7ijaEgX3QR65u/q0GETrGtL1Zgsjz5r/C6rCsOEHYaDt+KP3wluydcYvkQNr8xRrmg9jf3Tbk5BNNWBN0xT8+8jDfvycLLZvS/tMO1Kf8ZKy/xg2eCFlnAD5HDiWbsVQXzbV2RcVWvek3CPoAeG37SBSfjQl0SqCOrUYk5zQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0b8c622b-689e-4119-bd8d-08d58db1fbcf
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031BC33BE8B8939692AF59AFBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39860400002)(39380400002)(199004)(189003)(25786009)(6506007)(66066001)(99286004)(76176011)(10290500003)(54906003)(68736007)(3660700001)(97736004)(22452003)(107886003)(53936002)(86362001)(110136005)(2501003)(5250100002)(86612001)(14454004)(478600001)(72206003)(316002)(102836004)(26005)(186003)(6116002)(3846002)(7736002)(2950100002)(10090500001)(6436002)(3280700002)(6512007)(6666003)(2900100001)(8676002)(8936002)(36756003)(106356001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(6486002)(81166006)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: x/Nz5/CgkDW+8xjr4/+msr5/y9nlXXcpifXCJlm+ZNTjADOZva333SAMU6oEhqCIlesv1CdlvbWtqnWySmaMxMX2HFHd6LTyetSzlbR4E+g1K6yP3q6AdEV6N/FRDUbTA9G5idS+oFMKUXe3R/s9mE/+NBH/y7z+HCoxBKyilAHeLhPPowF03wKYVlrzLQDIM6V/dkddmkn9O6eQOu9iuX5tpz6wx3NHzNIEINSIrgNfmYm+r/1Ft8x5JYmLFEz8UnMoajJVQA8RiSH1tACHpagzP4dC8kN1is/sbwrueDGYnz7xLbTp7UIQIBhMMKQCxd43Q6aGKkImBElEAbv3JA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8c622b-689e-4119-bd8d-08d58db1fbcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:55:54.1329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Fuyun Liang <liangfuyun1@huawei.com>

[ Upstream commit 5bad95a1e55f4d5bb41e130db859d57eaf1b1549 ]

when changing MTU, The new MTU must need to be set to netdevice.

Fixes: a8e8b7ff3517 ("net: hns3: Add support to change MTU in HNS3 hardware=
")
Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c b/drive=
rs/net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c
index fad480e323dd..d1e4dcec5db2 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c
@@ -1313,6 +1313,8 @@ static int hns3_nic_change_mtu(struct net_device *net=
dev, int new_mtu)
 		return ret;
 	}
=20
+	netdev->mtu =3D new_mtu;
+
 	/* if the netdev was running earlier, bring it up again */
 	if (if_running && hns3_nic_net_open(netdev))
 		ret =3D -EINVAL;
--=20
2.14.1
