Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293580-1521478579-2-4799201384632322304
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
    t=1521478578; b=QEG1uSD1Hqo8FBQ+mwCl2QAbDIPYSd6j/dVOXmlfQb7VS4m
    l3iebRXgUwnCVtizTdyDxp8guUh83qJDOPwonV5jdTrGJiE6lQzuos/uQi6/rutG
    Gfo255Gl0Wl5kx71+HBkep5TJQ9SsWi2eYyg2GPyrKEsw0qsBONL+x/GlmvZT5Vn
    +y2RDb01Ld2exodbH0wURdAbe2kdPmFbmwxRiah/fZjCjc4EgUhfUoWRLtUAYQUP
    6736Cd5SaKiUP+zME1C00R0erFRXdhycEsc7lsG1bzz4yKiUJ2E/AYqloFJUGVSO
    LI10cJwAM3bjiBEF3a8E8NCadMicTOKLGl6YGhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521478578; bh=Rma6as
    f7JMPVGJCV9DU8eDw00uNKBjVRyB14AuvEmGQ=; b=doJcLJ0IJdE5YfKYFDtnAO
    F450QI/48LdQYXkZsLIJyRMjkwfa0851aUss+xT/pYYsPiG0csT6LAuvxtoYWv5K
    Kzj1vS6zl/hDVoQCEvy7RnQcCrGfsikG+Xv4SK27R4JwwRaQDgOvzMbKF2qlqSm2
    WXmFIufAvCWF7vHHa+mpzXy6HSOSRmkWBeq7lFKJg3B46aEH3QdMzaqVeTutn7cX
    mzrRW5YQWENWMwf6UcIBKIc8vhQth+nZ7MsjOw8WV9PqN+HHz/Y029EPhBimThqJ
    a/zjDsDFJOr7B0TcxIvN6cJgKatGijIhokSkvvnu0m/CH6g/jOQs1rU8s2/YFBxg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IQQFG9BE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeeguddtnecuvehluhhsthgvrhfuihiivgepvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IQQFG9BE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeeguddtnecuvehluhhsthgvrhfuihiivgepvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966827AbeCSQ4O (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:56:14 -0400
Received: from mail-dm3nam03on0108.outbound.protection.outlook.com ([104.47.41.108]:23560
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966536AbeCSQLe (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:11:34 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jason Yan <yanaijie@huawei.com>,
        John Garry <john.garry@huawei.com>,
        chenqilin <chenqilin2@huawei.com>,
        chenxiang <chenxiang66@hisilicon.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 156/167] scsi: libsas: fix memory leak in
 sas_smp_get_phy_events()
Thread-Topic: [PATCH AUTOSEL for 4.4 156/167] scsi: libsas: fix memory leak in
 sas_smp_get_phy_events()
Thread-Index: AQHTv5yK/Q2B53uN0UmAsm3MLnxxKA==
Date: Mon, 19 Mar 2018 16:08:38 +0000
Message-ID: <20180319160513.16384-156-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:Tp8f7meZnSjwkPcjJLuxRnwLtC/MUkq6ehQ7RH8NaiMR6v71s50sbxyVJmzNvxLT1YpYFtx2XU6hb8JArluoKBzGI+0krVA/uIFqza2/3mOQL38hl/g6h3m6bg/vJlPO/7xe2GVdGhXGsRFk1wZkJB425AYvNl6ZAIIhszaeoUZCkv65tEoUievhtyP1mfkAOiOr5TMHYQa4KXFJZc0g/UEM+Ag/m4JEhD6aGME6G31Q9F2yta33utkmoHT5fb47;20:xaViO62J4D4phxJtVnwuWhrLMqB8yloLOfkjZPSY3FyPvyeaxGPzcWAzni3LSEvS9ThHdOut3N8y70POrysmvWX8bKvXjymaklsAiV2rCjnK87+ovDj/+yWrp2diNFFPYwwTsZ8SWaiadAdemT+PhIwHCBb7qeqYX091GwKw7MU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bef06c90-762d-408e-638e-08d58db40f6a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09840A89273C95AA5DCFE1CBFBD40@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(376002)(346002)(199004)(189003)(54906003)(14454004)(68736007)(10090500001)(5660300001)(6506007)(186003)(26005)(99286004)(7736002)(305945005)(76176011)(316002)(22452003)(53936002)(102836004)(110136005)(2906002)(107886003)(86362001)(10290500003)(3280700002)(478600001)(3660700001)(72206003)(86612001)(6512007)(3846002)(66066001)(36756003)(97736004)(6116002)(6486002)(25786009)(6666003)(2950100002)(1076002)(4326008)(5250100002)(105586002)(2900100001)(2501003)(81166006)(8936002)(81156014)(6436002)(8676002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: /+RNzp7LbD0/7t7/NLcISPNRRRIZqfJs8DnKFt9OI+tuTXbHefH2lS5b8U5NjBoKok4GWs6AZKA3YB4giGwNZN1wC/t3wsQ7tZ4AnJVKhRK5gzeuKnPJWK63aa+FIUc6i3+PH33f0uI2eu4DkvmbMU/I77YyTlbWjNmDEmHlKnGVNGbMDS507VyLRG4xdroITPmv7H+l1FsIDQRciUB7gyLyj/IezDqoh3P2h4Gep2jQN2z6N2je+WOeIJjxewBpw/LAqlvCf/4526N7eI/Opu3HFFLjs/gLw09laqvUipPxvW9vKyjXj9JyFprybJTu+YZ3lJRr4bLTq4IcQrPAjQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bef06c90-762d-408e-638e-08d58db40f6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:08:38.2682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jason Yan <yanaijie@huawei.com>

[ Upstream commit 4a491b1ab11ca0556d2fda1ff1301e862a2d44c4 ]

We've got a memory leak with the following producer:

while true;
do cat /sys/class/sas_phy/phy-1:0:12/invalid_dword_count >/dev/null;
done

The buffer req is allocated and not freed after we return. Fix it.

Fixes: 2908d778ab3e ("[SCSI] aic94xx: new driver")
Signed-off-by: Jason Yan <yanaijie@huawei.com>
CC: John Garry <john.garry@huawei.com>
CC: chenqilin <chenqilin2@huawei.com>
CC: chenxiang <chenxiang66@hisilicon.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/libsas/sas_expander.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_e=
xpander.c
index 022bb6e10d98..76730a5637ca 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -684,6 +684,7 @@ int sas_smp_get_phy_events(struct sas_phy *phy)
 	phy->phy_reset_problem_count =3D scsi_to_u32(&resp[24]);
=20
  out:
+	kfree(req);
 	kfree(resp);
 	return res;
=20
--=20
2.14.1
