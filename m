Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521474648-2-15540462810418307535
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
    t=1521474648; b=IZ1ZSKxfuhijGp0qcofaliNOSdT01gQo9Xffp+2Rz5f0h/a
    mQfyqF2MtAjnvLtXNxcXat8Nv0k/e/Wb7pcoOcra5Ca4B1yyhj5WzqYOwWr7QZFZ
    lT9W+2zTVW63N4vwe0hjU8moiU4Y2UrwtDGx9XVrd37wxvC7JWfLjHRVjGNY+uoJ
    UjdZl7fi3AUgXHephqfmGWtmVctZOyHKB8SbJCRjd8lQyiEcXk6LKSdYMtLGRayC
    H4pxkHwUEzCWCIVcDnpdk/+55Tmeprl4U2SXsosDSX2RpCCwpuYG8tGkgGQ6q6kq
    sSu09/IY1Pqz9eFiF9aICE27Fa/qdAhjgDXAjjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521474648; bh=GKFEll
    nF5ndB7r/8utMj5Kp+6FdSjmNc/g4SW7OfT/g=; b=FUOR5oUBsl7XovxSaeyUcl
    hF1BkATod1lo39NjEuNIKEHZqZNGDHOvnAlhVySqYaBwyrC9XSY+z/dvgOxHua7H
    +9/UYm7BCTHczTX35XWwUZEFMoexxpHHBTZpKHRW82Hj7O1zZ7OsO2IsBHgolbEW
    e9fbOivKcIWvbJrEnIQXA+qSnNE+rmHpMho2AUyJ+eJwG5BUNyKucaY3xoajDepA
    bbXAGLPLNSvZLJeVSOTZdIDjsm3OqTUeT+0AfsbSM2HMzgq3IBjWWFaX8xApoYqt
    TmA0xDtXw/Y//9XLaJZESYk9psrYxAb2Ql6ZLg13UuAd1T+klpST6DvUGRBbI0mw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PpHeWjSt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdektdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeejgedvnecuvehluhhsthgvrhfuihiivgepfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PpHeWjSt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdektdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeejgedvnecuvehluhhsthgvrhfuihiivgepfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933518AbeCSPup (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:50:45 -0400
Received: from mail-sn1nam01on0096.outbound.protection.outlook.com ([104.47.32.96]:13186
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934134AbeCSPuk (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:50:40 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mike Christie <mchristi@redhat.com>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 123/124] tcmu: release blocks for partially
 setup cmds
Thread-Topic: [PATCH AUTOSEL for 4.15 123/124] tcmu: release blocks for
 partially setup cmds
Thread-Index: AQHTv5nYpPU7O7j1o0q1GGLeBghHZQ==
Date: Mon, 19 Mar 2018 15:49:20 +0000
Message-ID: <20180319154645.11350-123-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1029;7:FhyEDGH5nybR7wTWUa1wmupMdTA1D1QWWh0s4IhUodZCbBfY/FYgnijq48FneKxP8IkYlI+mniMZYy1rj+A0AbFl7Mn+AG3s6a2TZ/2w28Su4SSiCO0rmjwVD6zTFd+QpCguM6unV1LVzb+/DryaBHnTCrMliNMiOhdMdAPRTub0lzV7OwQX1UoJ/bhE4qzeBVsIL8AnWdmSJBBaa5gJxa4im/2kAL3EyG82J1VKYjQzdky9oBDu5UoIaM+O1Thz;20:nfu186ejJUApdbI0O7v1tnp76pliB6Vvy7wjBX5ZhHUe4O3oRSt1J9MhFsdC5+fSJJnh63se0nNxf+4XfvZb4SJwSrDNklZVgz9HOWjRsoq6euQy4EhHJ5SJR3P3/Ku+d8+daXAowxvMO2CZzj/7BlShGQG8OkCvH0ueaA72mi0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 045eb2ee-f8c9-4333-156b-08d58db12997
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1029;
x-ms-traffictypediagnostic: DM5PR2101MB1029:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB102935D7203C365266EA6F6FFBD40@DM5PR2101MB1029.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1029;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1029;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(39860400002)(376002)(346002)(189003)(199004)(59450400001)(10090500001)(102836004)(6506007)(2501003)(5250100002)(2950100002)(86612001)(6666003)(105586002)(14454004)(54906003)(110136005)(3660700001)(97736004)(99286004)(1076002)(2900100001)(6116002)(3846002)(36756003)(7736002)(5660300001)(305945005)(478600001)(186003)(575784001)(81166006)(2906002)(22452003)(3280700002)(76176011)(25786009)(316002)(6512007)(66066001)(4326008)(6486002)(53936002)(6436002)(86362001)(8936002)(107886003)(106356001)(72206003)(8676002)(10290500003)(81156014)(68736007)(26005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1029;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 4kNAxJrxoSNc4XMceJuQEIX7xAZZarL1GEjqQCbAC5odHkXLfIB3tGKTyWrYKbE5lGlEM8OCGJYI/qT2x7aw9MHP38jd4ypb4qiDHSoViCnH35lXtAjXuJog94hg16fqIGu6WS/WOQ7EycVJ5mJHM/azjL3wCGzIBdyG9og6ZlzJF27lTskSIt1gAJaJ8RlSXX43qeD1ras7oCE++VYsLUgc2nea9/uwFA6twO1T4yjeeUWyEz9D/3bCA3Fqe5xy+4kohu8ADBmJXfdIPNvgYgwaTQAFdX1IeCPRFEyHqCgJKSt3xVhd/yIlhFINVhL6MuKkugU8Z9HCBrVs3S13bQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 045eb2ee-f8c9-4333-156b-08d58db12997
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:49:20.9963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1029
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mike Christie <mchristi@redhat.com>

[ Upstream commit 810b8153c4243d2012a6ec002ddd3bbc9a9ae8c2 ]

If we cannot setup a cmd because we run out of ring space
or global pages release the blocks before sleeping. This
prevents a deadlock where dev0 has waiting_blocks set and
needs N blocks, but dev1 to devX have each allocated N / X blocks
and also hit the global block limit so they went to sleep.

find_free_blocks is not able to take the sleeping dev's
blocks becaause their waiting_blocks is set and even
if it was not the block returned by find_last_bit could equal
dbi_max. The latter will probably never happen because
DATA_BLOCK_BITS is so high but in the next patches
DATA_BLOCK_BITS and TCMU_GLOBAL_MAX_BLOCKS will be settable so
it might be lower and could happen.

Signed-off-by: Mike Christie <mchristi@redhat.com>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/target/target_core_user.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core=
_user.c
index a415d87f22d2..3ab96d0f705e 100644
--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -805,6 +805,13 @@ tcmu_queue_cmd_ring(struct tcmu_cmd *tcmu_cmd)
 		int ret;
 		DEFINE_WAIT(__wait);
=20
+		/*
+		 * Don't leave commands partially setup because the unmap
+		 * thread might need the blocks to make forward progress.
+		 */
+		tcmu_cmd_free_data(tcmu_cmd, tcmu_cmd->dbi_cur);
+		tcmu_cmd_reset_dbi_cur(tcmu_cmd);
+
 		prepare_to_wait(&udev->wait_cmdr, &__wait, TASK_INTERRUPTIBLE);
=20
 		pr_debug("sleeping for ring space\n");
--=20
2.14.1
