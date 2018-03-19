Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3247637-1521476384-2-1112569879326281989
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
    t=1521476383; b=ugUWEBwX9is6tCzB15MO3hBBG9feer0xVjl8VMbF+Yq5Q21
    A3Zc9/8jRABqTssNRaPy+cdFhJRDelJ0LMDJvDYG5YhrbCxGik8LgvqpOh++/9iC
    h+T5MvLJuR86GgkOWH9ky+bA4xFFIU35y7b452seSAU09JjishRAhdu38YjEH3IN
    3+7m7LvdPomJ5mo0AZMdsu8ML5mtErKYJ770uGUZs3o4sjTqzVibmNqFy6/L4x/S
    H0SHF9simgjt0KWamTapNvBEF3ctq4+fSP2dg4rqxzpC4/8OhA+tQyqJalMzOXrc
    i21tAd6Ralco4C4wgTIGxvK5JCno0IL9DLnqO2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521476383; bh=8vsq4H
    r3YEcFQZwhfv1d6s18DLBz3u+ZPjqpGJisKx8=; b=qvavOFwDyDuYFUBBzojxof
    orxoVL2Fo6Jpw9HW+hoaxjF0kGK5LRhSfnDlgRJ5+ejD8kwDQlZEvApFkYOUC7jY
    YZOlXIYjHtKj6TOfKaPRfXXwUNFpxrSbQccWpNJSXdVB96gVfRZqDsfmuAPp453f
    UwbBngk5ro88Cze+uTFNhFQTSj93I/JIC4NUhjqOQqaOE1MavW5HhWaVM8aSK2Uw
    0PNZhqmn52Bgk2towJUg6m+bnO6XyKpmp+MtsinUWsDn9KvUHaoSIhH5dEQfBhq7
    ARUW/Uq3WAHcNRig5U/kB1fo+/QgPGEiSK4BFDvDnG9xVQuW1/gyCpX/fBeAbWVQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GI3uoU7v x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeegvdefnecuvehluhhsthgvrhfuihiivgepfedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GI3uoU7v x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeegvdefnecuvehluhhsthgvrhfuihiivgepfedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935352AbeCSQTZ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:19:25 -0400
Received: from mail-dm3nam03on0096.outbound.protection.outlook.com ([104.47.41.96]:59104
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966963AbeCSQOZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:14:25 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jason Yan <yanaijie@huawei.com>,
        John Garry <john.garry@huawei.com>,
        chenqilin <chenqilin2@huawei.com>,
        chenxiang <chenxiang66@hisilicon.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 095/102] scsi: libsas: fix memory leak in
 sas_smp_get_phy_events()
Thread-Topic: [PATCH AUTOSEL for 3.18 095/102] scsi: libsas: fix memory leak
 in sas_smp_get_phy_events()
Thread-Index: AQHTv504r0L4bw3P6kOAK4jYuK0kxA==
Date: Mon, 19 Mar 2018 16:13:30 +0000
Message-ID: <20180319161117.17833-95-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0869;7:taJW5PRaMM57CBark5GuCoqz3ERzgmluEMe6MrqYywIfetvLoJ7pKxWPk/Zyu1R5+HA8MIyPnvjirzL0g1f0Sa0U9Vfe4Vu9CxSTCoMgAwPpXSZpcbAIBoQeHiKFhICyZScZHDodKE71dd3t9xyrdFMJXn56p5FJ46n+bPDGoqiugxV65aWmFIz93m4XavH0A89mEjD/5rGvE+4WGVxKby7p9qZSDyWBuicAJ4/lHXbVltV9iFBBNOjsF4n+WM6V;20:WfwnKaHrvgULmz72Bz4UnQPtOm0eNOk/kZ/bW2MBii/C2XyxfWcTWktS3m302V/qmSl7bBCeGjs5O0H6Usp+FrC/BMK4TDOoILsaYxQBa+XgqtANwCAvfqT8mTAZKRY57xEwunHGnsZ6Z1clnEpHhBF7LA6q0S28wSEmf5Q5i8o=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f8db30a5-6c8e-4a34-bece-08d58db4784f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0869;
x-ms-traffictypediagnostic: DM5PR2101MB0869:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08697E6A8B55050F4E69BD61FBD40@DM5PR2101MB0869.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0869;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0869;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(366004)(39380400002)(396003)(376002)(189003)(199004)(3846002)(6116002)(186003)(1076002)(53936002)(97736004)(26005)(86612001)(105586002)(2900100001)(575784001)(86362001)(66066001)(6512007)(81156014)(81166006)(68736007)(102836004)(8676002)(72206003)(4326008)(36756003)(6506007)(478600001)(3660700001)(316002)(8936002)(54906003)(14454004)(5660300001)(110136005)(76176011)(2906002)(6666003)(6486002)(2950100002)(25786009)(10090500001)(6436002)(99286004)(107886003)(10290500003)(106356001)(22452003)(2501003)(7736002)(305945005)(5250100002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0869;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: ZTWqcrIB/GVMZK6suK4mGTWCoWb3UTQ+kK5jxvni0OiKHg6SGzHVoHWgYz+GpE4clLugnRffgJWF5VdXOcxCIbYc/L/qVKFmZwCIGVGXaOn5t8YRde1sfeNtPbH2o2dPxnXFRTO3t8gj1Hswv5yPfbokZcq2Q4P9RWC3s5fhjnPo3ukmqBmuGrxfnUHjE9S5hJ9JJPUcfMBjNyRgB0UpXbLYbS7QIAv/KQ10O40I4FOgmURs0YmBBB1IEy5AUUf3rLrrJTDHzMHfMPu0OphibKX9Bbi5mdbIqwePBRgNoDFEYCmM5xVxu9i2l1O49SVNsBV0htKTT3c5tKGbdUBj4Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8db30a5-6c8e-4a34-bece-08d58db4784f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:13:30.8882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0869
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
index 0cac7d8fd0f7..98783fecd0b7 100644
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
