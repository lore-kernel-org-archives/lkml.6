Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521498363-2-8192508423191641060
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
    t=1521498362; b=Sbkhp0uHQkrgn9eklzh53LgYWf6MaATqb9VNNsywnVhiTSO
    L5F1XJsj3yhoNQeY+6n5/KkxOxwdGtquD1bxELXlZ7Tkujz3+EPUHBpklvRUmwZA
    eQ9qSkmdLZfZYXzccFAWXjkYOUVkYG4Y4nh0W48tutymgdzRSQEa9dvgmONTBCrS
    e2LQ43tydn+eW2I0XTQm+KU5gNY+wrokwuVXV69z0JMc3L2S8pCup0LaHqmAVsKP
    RyrGnGqDYmzHicLn/TYJznqxcwFMc7raN3cjPNw4EPp0jxbTpVN0QHVk9vA18pfz
    pQ7repta8grCBXPQkq5zDrkzZ7Q0Kxt8lal7Frg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521498362; bh=OaSPBW
    y0CQcJm2gQbqwCRSKii/97szb8SHUvL4pBGVo=; b=cvWKGtoDT5sWhwqlZgieaC
    yZCefwIGHG3uwlEZmCX9Ek4u63KhXRIY5lF9VnnFe1zjfsV9cugdUM3nS4fnYnrj
    uK82kwKFcOEhhdAG8z9xTta2NURX+tfGdI0mgNkdQ7If/RZK5DxQ7vI2+t0o+4FL
    klaPey47M1Ccfg3se1nRgDJ8OYqUzSHBYaUBrDJXSMVMFlbWGuLMbzfHn39uwrWk
    nNCwZ4WqMG0Lm0YE0+26sCxmLcOOX55ixNsX1yUolyVRGMORuQV/fGRTSI7whHF8
    LevxfM3m0t36x9IfkzTSgqZuDKenKHxHqlN9iNboqUljWatos0xinlwcWzB1fvZg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WDGrEMT5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejudejgeenucevlhhushhtvghrufhiiigvpedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WDGrEMT5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejudejgeenucevlhhushhtvghrufhiiigvpedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933844AbeCSWZo (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:25:44 -0400
Received: from mail-dm3nam03on0129.outbound.protection.outlook.com ([104.47.41.129]:48439
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933876AbeCSPtD (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:49:03 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Fuyun Liang <liangfuyun1@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 081/124] net: hns3: fix for changing MTU
Thread-Topic: [PATCH AUTOSEL for 4.15 081/124] net: hns3: fix for changing MTU
Thread-Index: AQHTv5m5FTRCmF3pU0KAG619h9Dsvg==
Date: Mon, 19 Mar 2018 15:48:29 +0000
Message-ID: <20180319154645.11350-81-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:GaWlEbSLNDDTOBZMKHlWiPCVzO6DFwbxaCdsP7BDnjG+A7fz25EJOOBCaVWo9AHrwTy3P1WxDz20wjWEdgPhPpryZ1KqKEv/sQMrIKLkJ23xAxFGiv+QSNuqHTu+x8zdxluk3k+lrDRmI3QQ0ENqxU18IhTDkdv+Fkzr5QNClXu4Gbklt4JiFzJH8IypGGvG6CW5hKjKNOo8i/+igAt/x/Oq6Z2FGoO/9I6fTcKXcdCinMgIgx+YEWzNV4hrEkGh;20:PqXVEDL5ov57FmOXILHUiuXW9vGGG1RFei7Jj5bnCWDZ1hhQx7jX2+jBKKU/3z23Jo5qRWkh/NYj2mz05t2o+UWLGqetoHKOu6+H0AFAAkabJ/NsT8XWc4kq8wvMnmBEmU7RiFpns25NRuwE0JWrjfDr5cuBJHLNXNTG5wapOUw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 912f4d2e-e8a1-477c-c707-08d58db0ef23
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
x-microsoft-antispam-prvs: <DM5PR2101MB09369E26D2C0E40393B79E86FBD40@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(39860400002)(366004)(376002)(396003)(199004)(189003)(2900100001)(3280700002)(2950100002)(10290500003)(66066001)(106356001)(76176011)(86612001)(6666003)(478600001)(5250100002)(6512007)(6486002)(107886003)(36756003)(97736004)(72206003)(25786009)(6436002)(53936002)(7736002)(2501003)(54906003)(110136005)(105586002)(10090500001)(2906002)(86362001)(305945005)(5660300001)(316002)(8676002)(6346003)(1076002)(3846002)(3660700001)(81156014)(4326008)(14454004)(26005)(6116002)(102836004)(8936002)(81166006)(6506007)(186003)(22452003)(99286004)(68736007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: /IKynBIspNH/j1pGcQRcZ8VUz8MiMpcu/vwPbbmL2i9oJpGAJoI7D5hQhEHZRnH5hVbbSStnjfgU63OjqokWe+vlwZYqWjHc9/T3ur3yHvlP8T8dx170VWN5sGAMRaHQlIn/ElfeASDQYx0Oo9UYJEJVXUsy6X13YoY1nQBwGnxaoqJsDIj8xHrDBi8E2zZ9TV5L7z5t2oL1JFI4PIa4Rkihz+wMSM/VIUUm9TU5l/QWxzprOv8zfDFmYehNZCA5qTkOnVd9YQYkMCEHPRtVeWCqQVXiGKwgjHaatqYtExkAOLHAfadxEo+8gn4B2ri7FD/HflAYBBUJFfTeR/J68g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 912f4d2e-e8a1-477c-c707-08d58db0ef23
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:29.0550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
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
index 428ede16b10a..a685368ab25b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c
@@ -1324,6 +1324,8 @@ static int hns3_nic_change_mtu(struct net_device *net=
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
