Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521475574-2-3444359858400503475
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
    t=1521475574; b=IXfNZ5WdoGOcE5ujHc5OZv6Mnf3zNPVySGpcQhdBl5RnXzF
    NsPwelEV64RDRyFPGxYSvFSG0IMD5E0R6tckVLukS5J6HJHy5hK364o6Hrv8AR05
    WFAVwuPk0CXM7+HA/vRheyZuerCjqvr9hAEcBUweUUQRCG9cKLFsd0mJUaKL+y9f
    AMzgpvdzesjDmWZphlCsSxwEJZ33JBr5RkTyO1z29Wr6D4ZkI+Zfyo5MyNE3lZg7
    T68IrA/aANa3lnQjBCC/HYxaU4iRz/vM0qO8y5ZuAfv/0rC2ya6sXF6c8YgVpdgu
    VHV4o/B1CsyH3oPkKIF18w7/jYohZd6Qc/sUWJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475574; bh=jqX+3J
    7oOxkeQnz9LD5XvjE5Vh1K6YzDPDd8cc+PWbI=; b=b8yAuFvHulrhyYYI35kaz7
    /AGRwRkbb8jrXl75DxBamC66VRiB751qq2Tv/Q1igoK3RdGIk+jyRM5E8dsR9N3X
    SizBZwNYwyiNJ30vpVe2+XkMFpPes1qGoXF85aKfmhro/XDzKGsKhe8G4xdwy+VF
    Xlnm6DzMVa3Z7JowVdqlG50Y3jnV3LLOeL71SD4vv9VGY6JryEE4t1lcVs8MHjFH
    ZhJfwPK06MJgdWATi4d3sEKkfJXqgeXhYKhDN8VXgch1lGUq4qvkJtvw5qCsILgU
    2DDLdoOHR4tzF7TiexpmCM4Ba5uVT6HzOVyyVXVrJkUTnE6NhkYmixxEYvM0CVcA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IQiIybao x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeelkedtnecuvehluhhsthgvrhfuihiivgepudduje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IQiIybao x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeelkedtnecuvehluhhsthgvrhfuihiivgepudduje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965900AbeCSQGL (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:06:11 -0400
Received: from mail-by2nam01on0107.outbound.protection.outlook.com ([104.47.34.107]:58080
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965874AbeCSQGB (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:06:01 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: chenxiang <chenxiang66@hisilicon.com>,
        Jason Yan <yanaijie@huawei.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 267/281] scsi: libsas: initialize sas_phy
 status according to response of DISCOVER
Thread-Topic: [PATCH AUTOSEL for 4.9 267/281] scsi: libsas: initialize sas_phy
 status according to response of DISCOVER
Thread-Index: AQHTv5vHuG5ZT4cLJEiGhT/GP8w+PA==
Date: Mon, 19 Mar 2018 16:03:10 +0000
Message-ID: <20180319155742.13731-267-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0728;7:Uj9kyS2jEdD1x7AmfC/9F+YuKT3r4uUc4EwT1mLtq3dOoSFKhXTTl+1GJH1dEP17kkJDBEBBberk+G/VgfBG+Jdc1T5FtIkuj73soZnqP/2KwHb2ke+fbB5i/vW0Gfh1w0N4xu1yNUas8JNlV1BffOdQltsTi6s77PjtjvjSrRKmiy/V5bUCxw0gvuAcN6OPrD2TliBHg+xG7wxka7mklG6qGyyXb1lmCZgP99h2nrSAp9BZwh0fNjuG2g53FzGI;20:fHYRQxb/aQYy7CxRYbOCMYxZWHsYE/JATNDb81NCWhC1oEmVlNRwe0vvWi1x+0y348qQBjfUuplj7TYhqby8NlT/VPZXLtr5p/BeqNwSaem8gBqQGjLXOPBi48UezrXYL2PjMhirB5aU1TuxhhzIYkIGj0WK5cwuk3c7S3C3zEI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 230961ae-8f4f-473a-5e12-08d58db34e9d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0728;
x-ms-traffictypediagnostic: DM5PR2101MB0728:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB072895AA153ED727531242ADFBD40@DM5PR2101MB0728.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0728;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0728;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(346002)(376002)(39860400002)(396003)(199004)(189003)(8936002)(99286004)(478600001)(53936002)(107886003)(110136005)(86612001)(72206003)(97736004)(76176011)(316002)(3280700002)(5250100002)(2501003)(5890100001)(36756003)(2906002)(105586002)(1076002)(86362001)(14454004)(6436002)(54906003)(6512007)(6116002)(6486002)(106356001)(3846002)(22452003)(3660700001)(186003)(59450400001)(68736007)(66066001)(25786009)(102836004)(4326008)(10290500003)(26005)(6666003)(305945005)(2950100002)(7736002)(10090500001)(81156014)(81166006)(8676002)(6506007)(5660300001)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0728;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: e49LmGRNaO44qvuNdkAGcJZsx530DSEyOInt6G9GDan5cQlbuFASNyKuGxidCSwCei2RRWtmA6ufuxjK/ny+wzRbwKd7mW57GK5EOmscVoVJHJt/NbXnOOdKPUCWJep3n4pT3phSHoLDAM7b1M4g9ddG0rzuNxh0DncD/3mtDsZ+mB8UIvgBdPCVF/GlOpDi1BUNslEg2mY8i/ZvD81sNMDoYry8sd2Kr83UZ9SrBKWaCKwrncwhodOD6VY0OO+cQoMLChRJr4v+KPK1FA9ybmbrcqcKwF3JYMAldLDfRLBQ557Vgb56DQaXbmhlea10ac+Gona04JV4/rrb0V42vw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 230961ae-8f4f-473a-5e12-08d58db34e9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:03:10.9783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0728
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: chenxiang <chenxiang66@hisilicon.com>

[ Upstream commit affc67788fe5dfffad5cda3d461db5cf2b2ff2b0 ]

The status of SAS PHY is in sas_phy->enabled. There is an issue that the
status of a remote SAS PHY may be initialized incorrectly: if disable
remote SAS PHY through sysfs interface (such as echo 0 >
/sys/class/sas_phy/phy-1:0:0/enable), then reboot the system, and we
will find the status of remote SAS PHY which is disabled before is
1 (cat /sys/class/sas_phy/phy-1:0:0/enable). But actually the status of
remote SAS PHY is disabled and the device attached is not found.

In SAS protocol, NEGOTIATED LOGICAL LINK RATE field of DISCOVER response
is 0x1 when remote SAS PHY is disabled. So initialize sas_phy->enabled
according to the value of NEGOTIATED LOGICAL LINK RATE field.

Signed-off-by: chenxiang <chenxiang66@hisilicon.com>
Reviewed-by: John Garry <john.garry@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/libsas/sas_expander.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_e=
xpander.c
index ccdb9d5e2f28..12886f96b286 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -282,6 +282,7 @@ static void sas_set_ex_phy(struct domain_device *dev, i=
nt phy_id, void *rsp)
 	phy->phy->minimum_linkrate =3D dr->pmin_linkrate;
 	phy->phy->maximum_linkrate =3D dr->pmax_linkrate;
 	phy->phy->negotiated_linkrate =3D phy->linkrate;
+	phy->phy->enabled =3D (phy->linkrate !=3D SAS_PHY_DISABLED);
=20
  skip:
 	if (new_phy)
--=20
2.14.1
