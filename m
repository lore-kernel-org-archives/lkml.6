Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521499245-2-10068014863950287661
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
    t=1521499245; b=TD6ETnxjVy2PgzKwQcoMN7WuDjDz/hMukW5Gr6eK+CSAdcl
    cKCPEW6zI9Duv++EtcnZHJYo5Ndcp+Ku4coQS2eKG8O0dJ7Q38v8bMyTQYv9jc19
    3GIkdJA1146PH/CspdaoUsWqSjyrYVszGBQth4RYUOfEkfzKZQJoJLcmJ4tDobuh
    tmR0uHaYjlfK+z/IQsCCpa7aQNaH+h4CgWWgfQh4fheZCRIBaxVbSXrvpOfpLZjw
    n7k+m2+smlAmXjI3VwHlbA6mmNZV5BoG3JFS/kQ/PM3MwYg3c2MptRGk765hiMXQ
    RHyJN06lhOoUpZaTYvp+aVWfh3GpHD5xbVwf+pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521499245; bh=SgWUAA
    T8auFosX9XYqo878ooCYpofhsw8BejNKXX4xY=; b=b7KJiPvhSM9NjaK/rnsE9/
    4hJRevgWawA5ZFY4TDVREeYxfN1kQEe+zIH6vErRk8/CTbhNfzSq34rpOiB5+aWE
    OIUzHEmkR14jwxG1Xh/0FLkKb5gjXqyXm/6aynLMt1lRuagUMMmrgGAs+AZancNt
    0I+WiriXx1hVD5pz4nqGnokQOSo5aQU/9ASUJekIgKV+7v9BHME0eeB65obXWca0
    sXyUIXkbUVtdg4bie6T9++9WoW1Yz5LFwGpAzGOlygMxLx4xywLfJoFDS609Bu2a
    Bkp+tSvwunIRHwWVvgdbcBEt9XOiXRMW6KS4s5x6U7gkIXJM0WZIh8UTpeCri0Rw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bzIiS1FM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgeduleenucevlhhushhtvghrufhiiigvpeehke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bzIiS1FM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgeduleenucevlhhushhtvghrufhiiigvpeehke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936681AbeCSWj5 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:39:57 -0400
Received: from mail-by2nam01on0103.outbound.protection.outlook.com ([104.47.34.103]:19764
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932883AbeCSPrS (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:47:18 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Peng Li <lipeng321@huawei.com>,
        Mingguang Qu <qumingguang@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 013/124] net: hns3: free the ring_data
 structrue when change tqps
Thread-Topic: [PATCH AUTOSEL for 4.15 013/124] net: hns3: free the ring_data
 structrue when change tqps
Thread-Index: AQHTv5mLBeUCMcN6c0asxgyMf4Ju7A==
Date: Mon, 19 Mar 2018 15:47:11 +0000
Message-ID: <20180319154645.11350-13-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:n4Zh/Vx14Ty0mZMU6QvmASH0T9jvnZ/56OHxHD+3E0cA99W0EBm1cH5VDEJbPZHlX98FEXnUyt2pmOV9VDcnqjMC7Xt0Lh9UzTGbHfxz1X0oFk+jQCsb1IyAEL9dBWKOQwKrbGgam+mpsNBfjUiSisNr0DCYR7eBQTtpVqGIRb6gQ+S7kerYlE7U5/bP75hL8N8G4e+D1K9Rp1kHrlfgJJR/5+WGnWVJjO90pQ526GS8WlSNIXdHoEDZF/dxi0uR;20:E6QjD2Xf+uR5z/OQFi1am/qK1uWe1TtU46XPCc17fUC7UXWdb33K6WAksFIgYfmGS8P3/5xQVjkwN8Xw2y0grMzzKidih08P6XW6NVQfvlxjt8K5/oq2gkD7knfSoZJ0wHPPOHaca8QcyhR/flCr9n5PY/p2DPQHTwtSWRQzszg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 70c28d5f-33bf-4482-7c7c-08d58db0ae4e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB101399062EC1EC103ABB78E6FBD40@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(376002)(39380400002)(189003)(199004)(86612001)(316002)(26005)(72206003)(4326008)(25786009)(110136005)(10290500003)(86362001)(575784001)(54906003)(53936002)(36756003)(107886003)(3280700002)(14454004)(22452003)(6506007)(5660300001)(68736007)(99286004)(186003)(478600001)(76176011)(2950100002)(10090500001)(102836004)(6116002)(5250100002)(2501003)(97736004)(3660700001)(106356001)(81156014)(81166006)(8676002)(8936002)(7736002)(305945005)(2900100001)(105586002)(3846002)(1076002)(66066001)(6436002)(2906002)(6512007)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: y3ox9F74+EKnLVUjwnGIJczBl9xshIvpkvPNDQBLb8lbBHlah6FQzdUEIISHcaIksMMSxokx/+fgAawmDMQlS6lioDFnFZ20kOmK2ndxIBfAm9rlFSA0oYLnFjH2CZHrGXqb1JSVygswr9Wlye0iMLTNsR6JJTAktUq7yqr9ucmAIY+yWmhOzrONeLathhNwBt78QVJ6V06e0YpPXnNrFXyHWmFmtWvpVRIQA2Qnmz/Hwu1fhgOZUwoU/QfXrmiqmERYpywnv9koOPcxViJOqCE+GaWOmSXPsoeDdQVEjpakjY1vFCPNhOd2E2ezyPCWXBqd2JcbPBGQVzdd+GAzFA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c28d5f-33bf-4482-7c7c-08d58db0ae4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:11.6780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Peng Li <lipeng321@huawei.com>

[ Upstream commit 99fdf6b1cadf41bb253408589788f025027274f3 ]

This patch fixes a memory leak problems in change tqps process,
the function hns3_uninit_all_ring and hns3_init_all_ring
may be called many times.

Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Mingguang Qu <qumingguang@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c b/drive=
rs/net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c
index 59415090ff0f..853f273da22d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c
@@ -2785,8 +2785,12 @@ int hns3_uninit_all_ring(struct hns3_nic_priv *priv)
 			h->ae_algo->ops->reset_queue(h, i);
=20
 		hns3_fini_ring(priv->ring_data[i].ring);
+		devm_kfree(priv->dev, priv->ring_data[i].ring);
 		hns3_fini_ring(priv->ring_data[i + h->kinfo.num_tqps].ring);
+		devm_kfree(priv->dev,
+			   priv->ring_data[i + h->kinfo.num_tqps].ring);
 	}
+	devm_kfree(priv->dev, priv->ring_data);
=20
 	return 0;
 }
--=20
2.14.1
