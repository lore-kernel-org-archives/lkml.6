Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521475016-5-6014227665164372668
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
    t=1521475015; b=intfLh5W4sxILP/LtQjHTmjGBtaHgw5i2tlh5Vt20+v8Ks6
    tSiOxVevf+nsU1NM7VxQi477ATd6W8lT7fKw8np5BslbtrKbjgNE50vAm5V/y/Hf
    06ZvNF5hKD7bG8E746hYhZle6xXb9hoaZyrZ2Ynex+y5keaHrN2a+zTEW0rHwxEQ
    k/1dhJnBBPrB5Ki4Z5amhPGSXH/9Tp7eAsygso6aj2Pwm+3jqAfDeED5UpWz9UXJ
    s9JnMzLyHTI1LKY0Xz927zwIi+7H8UWxFz2FYA1zhaDqQQ7LDlxAhfNHlQj/QUIh
    fwqvxk69Vxu3t5UIh6kuIn3gR8KhBUgx6xyKWPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475015; bh=6COhQC
    J77ELX36kpXwEnjp/E1lwwLVfeYxAjF60B4cg=; b=WDn+myid65ANY5+38wlCKD
    5BxgtggthL9ViikF5y0EdQ7T0fLW6FEqnUK6a5xOrxqFSC+JN280c5bnOd8ZRG5z
    lxmqgoYEcco4I3kEAqmDl+cN4R4HJZREsOV3Uqfj+GWsBGkBFuDU9o1nY6wJhSkJ
    w8LlMIWl+M5YBwgaKSSoydssrNgnxowJ2kDHyBlHbcki3GOhuOuEC40DYoknm1Ny
    FeilQ2EWaA1KzTA1jQWLTIYiKYMtbVeWTtE3XU7U6832xBxz72xAV5y2CTvYc9w5
    NOU2egzrZptcSwv9rtzsgRaG+61eDwMzxG8sQJCjSOw3lleQJOaTZVg70BtVktGw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BCJ755au x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeekhedunecuvehluhhsthgvrhfuihiivgepgedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BCJ755au x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeekhedunecuvehluhhsthgvrhfuihiivgepgedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934621AbeCSP4q (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:56:46 -0400
Received: from mail-by2nam03on0103.outbound.protection.outlook.com ([104.47.42.103]:19072
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934572AbeCSP4k (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:56:40 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jason Yan <yanaijie@huawei.com>,
        John Garry <john.garry@huawei.com>,
        chenqilin <chenqilin2@huawei.com>,
        chenxiang <chenxiang66@hisilicon.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 69/97] scsi: libsas: fix error when getting
 phy events
Thread-Topic: [PATCH AUTOSEL for 4.14 69/97] scsi: libsas: fix error when
 getting phy events
Thread-Index: AQHTv5rHOQ58X+xy1EOHYlK/qYI+JQ==
Date: Mon, 19 Mar 2018 15:56:01 +0000
Message-ID: <20180319155411.12348-69-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:DM5SmElNtoDPGmuTKOsJunWDsKwSfTk66HP+J77/GN9gU50wmGl+bR+0CQg/8S3nyxf4htJsGVu/Ks0O0npeP7fushXljr6/gOfKFRZPKHKkNRQG5oXHrXJbKeH6vGOxmp+WMKh/xCUAruf+ld0qf78c+I0Ty7De6SUOPf6CYu7Ooxz9CHHQ2xqev5AUgW92tq2btzOctOLBr26AB7Q9OWW5WEpMJEEvHoDQRemSFrUe7I/fMS7RAMAl2V4Qv7We;20:xQCuEC7PRVO+xRT9VycDZ6R9TW9h4WnAmIao95BoDJChaBWk+4OI2poUEpYnZ3cv18ikAs6NhS5afTK3HkYnxZFItP33XZry9PE+s9UTbpFWDzjP+qYM4gdezv9aOp23Y7yMPRXYKRmcGl9AfEHAJlQBt3shQ3V/zDlvljtcEcc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6bc8d40f-9ccf-45fa-5c0d-08d58db1fd92
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10319FC465F71BF9068CF3ADFBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(366004)(346002)(396003)(39860400002)(39380400002)(199004)(189003)(25786009)(6506007)(59450400001)(66066001)(99286004)(76176011)(10290500003)(54906003)(68736007)(3660700001)(97736004)(22452003)(107886003)(53936002)(86362001)(110136005)(2501003)(5250100002)(86612001)(14454004)(478600001)(72206003)(316002)(102836004)(26005)(186003)(6116002)(3846002)(7736002)(2950100002)(10090500001)(6436002)(3280700002)(6512007)(6666003)(2900100001)(8676002)(8936002)(36756003)(106356001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(6486002)(81166006)(2906002)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: oNe3cF/Z50WQDkbeYbDUzqSwGCoFp5rhvyOz4sslkRZk6YqN8c41LXXCXESClbh6Ir39buWZ5NjcDMABdWk3BSDhAu8QCYzEWjl6leATwOnQMvo0INGIPiNUIcLQjgpXws+5yxhKfNZOFDgqwq5wRCYyworyOfCW1OO+hwDKTu+QQUVnKuKrs7DPOW5unZtb7QI1WhuaK5aqmG/ZdGE+ZH7mjaHXaeRhnW0pVQBze/mgAbSfFlFRjDkZjlhtpd51nVZBmKwNVXq7hmo5BtkQIMv489Z3NPlADhuMM0um1WW784AuOpQDLFbYTrSZSWJC0vr7DZ/a1tf32kuw8BWx3g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc8d40f-9ccf-45fa-5c0d-08d58db1fd92
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:56:01.3873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jason Yan <yanaijie@huawei.com>

[ Upstream commit 2b23d9509fd7174b362482cf5f3b5f9a2265bc33 ]

The intend purpose here was to goto out if smp_execute_task() returned
error. Obviously something got screwed up. We will never get these link
error statistics below:

~:/sys/class/sas_phy/phy-1:0:12 # cat invalid_dword_count
0
~:/sys/class/sas_phy/phy-1:0:12 # cat running_disparity_error_count
0
~:/sys/class/sas_phy/phy-1:0:12 # cat loss_of_dword_sync_count
0
~:/sys/class/sas_phy/phy-1:0:12 # cat phy_reset_problem_count
0

Obviously we should goto error handler if smp_execute_task() returns
non-zero.

Fixes: 2908d778ab3e ("[SCSI] aic94xx: new driver")
Signed-off-by: Jason Yan <yanaijie@huawei.com>
CC: John Garry <john.garry@huawei.com>
CC: chenqilin <chenqilin2@huawei.com>
CC: chenxiang <chenxiang66@hisilicon.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/libsas/sas_expander.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_e=
xpander.c
index fc17b4a5217e..6873d8fbc541 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -686,7 +686,7 @@ int sas_smp_get_phy_events(struct sas_phy *phy)
 	res =3D smp_execute_task(dev, req, RPEL_REQ_SIZE,
 			            resp, RPEL_RESP_SIZE);
=20
-	if (!res)
+	if (res)
 		goto out;
=20
 	phy->invalid_dword_count =3D scsi_to_u32(&resp[12]);
--=20
2.14.1
