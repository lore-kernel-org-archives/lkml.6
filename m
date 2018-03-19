Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3247637-1521476358-2-3972344592482351138
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
    t=1521476357; b=Eo6UnWzXxZRhMWYYUCYJSVUnX0DWPQ6QtUBU9BTY9xsy00M
    1RJAiZyPjWfkhOvkdCOxn5kGr3uilv0J6f3sds4cgNJFA78xFguKhfPwNcyeH9CO
    2Ibe7pU2rn3oMHEIPj2G/vtOFTvWLY0SwJwGCa+CLowMBqcjAEimgdk+nvxuKf4A
    qgDVit0ZurHfJndEsdKIwIvlCIc7InX51uMF1wxavqDC2ra+Fgt0q2TPU/7sNupl
    YdwM0HIH7jO6/OBoxJxBQod58J51933OypA23kblGreL/nk4hwdpziKrJ5/V3DLf
    5OeeED8JtOb2OASj+QheT/rwxixcC1en4gOys4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521476357; bh=xbk76O
    bSWtOdf8gVCBPdK3CCyMxlYS+NfJ32F8spQuU=; b=whqXKAvMd6ducUQxED/hSA
    RIG3SI6/4XhJzT3miZyAXFYfZzM5rhOU9gYd1YC7aglYlV8+3p7R2YUXAdWRw9BP
    gEdqwnWutGMH/GAxqYYuSfxfcndy/Sz2PyCkP7ZrWO30cAH12+D13blSjP+bCdOj
    tgGC1J4Qa8z/773SPGF4ThDaa5aNap8fzACjzx3q7dklho3B0zw7TsnGYfgV/7Ny
    VZ+fE+AVScI271iqer25xZ/Fv99UhGGcBHZ/pOAnyF6pZ3hj8zqHa7E6VK6SqcPD
    WGt25jdtnvOey81eDIWDjmQw+bS3FnwitAGSbOHmZly0ra71zPss888/WdMY3onw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lasxWiu1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeekudehnecuvehluhhsthgvrhfuihiivgepjeeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lasxWiu1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeekudehnecuvehluhhsthgvrhfuihiivgepjeeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967052AbeCSQSs (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:18:48 -0400
Received: from mail-dm3nam03on0096.outbound.protection.outlook.com ([104.47.41.96]:59104
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966968AbeCSQO3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:14:29 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jason Yan <yanaijie@huawei.com>,
        John Garry <john.garry@huawei.com>,
        chenqilin <chenqilin2@huawei.com>,
        chenxiang <chenxiang66@hisilicon.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 096/102] scsi: libsas: fix error when getting
 phy events
Thread-Topic: [PATCH AUTOSEL for 3.18 096/102] scsi: libsas: fix error when
 getting phy events
Thread-Index: AQHTv505kXqdE7aAcUWWpt97fF6xNw==
Date: Mon, 19 Mar 2018 16:13:32 +0000
Message-ID: <20180319161117.17833-96-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0869;7:lv3/DxxXRC3MxgpCCrDUCSyD8Olh/Tu72CSRQT4haOvCwI7sEb6TpSOzHG3YRkKFskloU6b8kKgP0vs7NWRztie0HqxDOwDWf/rCVtwq+h/qL4MkmITVFrXBHkcZPVZfF4Hg0qKZJ8Cs8R3w13x4Y+VyINns0fjLvWG/Nh7paM/HxgFJsHbW/QHdZoGLp9fImSDeK0qpRj9EW/VQw0/SO0l57LPDhH7l/5SmG+oRc8VE/soE/Buq2IZRXRu5/wXa;20:gA+NQdf6IZ7UjmyLZEq7RphRF47Af7rLoWOKehPaqHhUWbK6g+jTX+RL2FY97IbvsZ0jG5QEbSAuVnyqCW+8zZX6mgHUWV61FYF/8kUTPZTrbcQ9sK3E3XkSJH39V1r74MVvZlEVN7mAVOxSFAB4X+JVeDCN+b949bhctxMhqQI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b65f307f-3a91-46da-a40e-08d58db47890
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0869;
x-ms-traffictypediagnostic: DM5PR2101MB0869:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08697D42022F0D6CEE495BD2FBD40@DM5PR2101MB0869.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0869;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0869;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(366004)(39380400002)(396003)(376002)(189003)(199004)(3846002)(6116002)(186003)(1076002)(53936002)(97736004)(26005)(86612001)(105586002)(2900100001)(575784001)(86362001)(66066001)(6512007)(81156014)(81166006)(68736007)(102836004)(8676002)(72206003)(4326008)(36756003)(6506007)(478600001)(3660700001)(316002)(8936002)(54906003)(14454004)(5660300001)(110136005)(76176011)(2906002)(6666003)(6486002)(2950100002)(25786009)(10090500001)(6436002)(99286004)(107886003)(10290500003)(106356001)(22452003)(2501003)(7736002)(305945005)(59450400001)(5250100002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0869;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: i3VMSzHSzIQE5hcz63kje/4teZxajuZTjyTo45+hKqIyYo7+rigXjP+/pcLeCi8tPZWgCc5glOVLIty45DcbXCqc6oUYc+KO9qrLegKcloHr7U5EBzdF6MoW5Ss1ri+cZf+XfgAmM9w+mbJsUf4UHXNHQso2l2q7fLVIhlzbJcYENvbfJUtSBzZDoxafpZC+6MsdmqyOViw5+PPXekov7bJJkwRp2biPWbT00ztnL4IeKE/J7kuxAtXa3gtMLG4kN9Ve5TnK8LiHAklvfHI0pTDnUkwvQP5X67mz40L1ts3FQS6i20cgqvTqJO9I150mbCqsQO132yr3EuJhPAeOLQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b65f307f-3a91-46da-a40e-08d58db47890
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:13:32.2041
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
index 98783fecd0b7..9ee5a359248c 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -675,7 +675,7 @@ int sas_smp_get_phy_events(struct sas_phy *phy)
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
