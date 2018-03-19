Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521497469-2-7140978375735286869
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES endasv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521497468; b=lzW1uBH7XMJDETEAdXuFWQ9leEeRmP96thwVTeiNamagsHa
    RxlaNEyGfenyxXaTmO3zk8E8TbQjnAebYBtjPBsNSnWefefO3fDuM2in1Noq59eJ
    Z7n28LtSAJ4l49vHba94gRsKha2Onu/SL4EiHYWfgYwYTsjqiSXcM0vA5jxZVkuw
    iBXggjoMGD+bH9pkpJWvfWUJn7NwGAdt1h3i7jZwBx6S9L4EdviRTknGg05epK4v
    r2eTBrYZ08M2dNPuAGgBqwG6JTJOjyvl4nUua/8kdDDOkh9U6owOoHXX3VQZ5+qJ
    Awn16qGymboVlwhjePAhzk9iXG1ZDsCS01OSCVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497468; bh=Ql6qBF
    G2veQpDTw1XrQKc9/Wv+nWhSXERxa0w6oVhcc=; b=kxiVcF5ajXdePmrOAna6WA
    FMf2NkLvR1Phc7778ZPFoxjAfDagcgkJ3VOuH3Hu6DbFN9siCMRKXzHeionqBZ8x
    BrlfTLcV9f8C9vvm883y0g9v2cCHlHYC8xR+Fxk1LAzeum8R7wEixqUY2vkpITUq
    l8kcIISdqBKv1ZLIBQ5GX0rFDT17e7PLUW9NJ9Lu4kkS0FusYfVzCvdcGq2sYz3g
    WL0E3+VWTuReI7I7JqGA5mumyMCqWBVBXlpexSlfDH7IWJEdnoCXOFAZU2e+uYqC
    WMa+RpfMiwpFpUEnrJSZH/Oh5vRiVWJ/ERhngSJKMNGm9kBQyTNJe+XIAhLnW7tQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Kf7z9y9H x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfeeiieenucevlhhushhtvghrufhiiigvpeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Kf7z9y9H x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfeeiieenucevlhhushhtvghrufhiiigvpeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S972209AbeCSWKA (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:10:00 -0400
Received: from mail-bn3nam01on0109.outbound.protection.outlook.com ([104.47.33.109]:27808
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934260AbeCSPyp (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:54:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Peng Li <lipeng321@huawei.com>,
        Mingguang Qu <qumingguang@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 12/97] net: hns3: free the ring_data
 structrue when change tqps
Thread-Topic: [PATCH AUTOSEL for 4.14 12/97] net: hns3: free the ring_data
 structrue when change tqps
Thread-Index: AQHTv5qUF2wIils3BUON4edQXjFleg==
Date: Mon, 19 Mar 2018 15:54:35 +0000
Message-ID: <20180319155411.12348-12-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0903;7:8r1atBmge4CZxCyaShm7UlF6yfRYRFINkyoPbW2kZhNYk5Gj3UDtOziuaJ41j+6d33L8O5WatqwldrdoMETK/bzx7dYi9D5qYgGrBf7wFA7vSAdD6Etj/qGrX8r+H08nXohOguyLqGWyvVm0Jfg4YJHrGxVtIXZCqZ0v6nnU3eWW5/86p3Qm+vC4GqYhF8qg1brhT8lEPuyIsWCh+wE7jE3fHFO5WsPstLs1+FCwhcT+6EQ9xb1vU7BQRZm3Tpp3;20:HkW6XZILwpxlDwGwcxq/hNxzdZcrAXYNGUkhNkNmTk+URDBez4k0I9iRzFvCn+uRcZxBvVELnzMguS1hu/eytGt9086MMnivTZJVIp63t3pytixENEb03IMl4E3EQCQgYozYN9Umw/bPasqf5hrLCNVOphqin9F6XoMFxAzVABU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 768734e6-64fb-4ace-ba0a-08d58db1b6b4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0903;
x-ms-traffictypediagnostic: DM5PR2101MB0903:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09039A41EF7E501F515A0315FBD40@DM5PR2101MB0903.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0903;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0903;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(396003)(39860400002)(366004)(346002)(189003)(199004)(106356001)(99286004)(22452003)(5250100002)(66066001)(2950100002)(2501003)(105586002)(54906003)(86612001)(110136005)(316002)(5660300001)(102836004)(3660700001)(36756003)(6486002)(478600001)(2906002)(97736004)(10090500001)(26005)(186003)(53936002)(1076002)(6116002)(3846002)(72206003)(81156014)(7736002)(305945005)(8676002)(81166006)(10290500003)(107886003)(6512007)(8936002)(68736007)(6506007)(76176011)(14454004)(4326008)(2900100001)(3280700002)(25786009)(86362001)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0903;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: KDxnVTCeEA3GG+nnIO1FHbxC8riBGSUMZBxbpyztuX7DtzWJ5m3odK3CW4fGCb+etSF7PfI28/LYwIBId2WlXCFlutQxLT9LpcyBkOSPSdfQpMnXeJt17cCwnMUsJLo3ETJNMvg4cFjEkM6ZIhn3G0SoV/chHaF/lUWjMOp2wOANsRN5oc+qXkngwh0o6KP6BXBocoeyk92ynvGB7RrZYsse+psQeZycNrrGaBWtfHjtHbgZFwNFuv6eMOcESsLYgQIWCQzKybxTTVtHnSpVS6+qdZkStRexFG7QQrVEcf3neis2f0g/9WtQjK4hlIBs9lR3zcZyp2gwiQ9q5gQWgA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 768734e6-64fb-4ace-ba0a-08d58db1b6b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:54:35.5157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0903
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
index 186772493711..3e7e13b9a385 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c
@@ -2687,8 +2687,12 @@ static int hns3_uninit_all_ring(struct hns3_nic_priv=
 *priv)
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
