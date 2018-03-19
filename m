Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293580-1521479254-2-16111624710519980763
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
    t=1521479253; b=nu/izpl7VHmU/pj2DtPvG7/fN/qE/XCMSedHtDf8trPmunp
    LhALfv9pWDA8yIcSwqB+9rDNvYIxu0U6hpHdgILsS50IteSVm4xn+diloUvOs0CI
    TwzO8xuqUT2FDu7XSJhGE/Yy5NBOn/adoO2rq16HiO7WWAJWY89YorMHX03HudSP
    WGV9I3ZfZQmixe0jdzcAyx76QPayrCzBPkTEXzZ5MXR2gaaC+Lz1ibIiEnWK0En2
    JGAJ7JuM9G023qZ7bS/OcKkWqqYSEVfDU8ZUBXIlhJ7lqWfIBOGb4EQSIaiuAHwj
    /JhAF1kkPO3oK4snB2foFoH1zSTlTpU8QHoFycA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479253; bh=ifsRV9
    VbKOcTl1ZfKn2sprYVzbmDcg22MO1vaH2sWD8=; b=YSnkv1V270AF/wXk/UfyDR
    3CgC0Cu1gYRTicoEMHd0LB8QgLJ6C0Ljp2GsA4SgklgDcgkP84MDOFBFgIJWnvSa
    71wEaKmyXFswnNkxer5wgok7qpZ/Cy6wRm4F1wmmIMy+fNh327wq0NuXj3QyS2u2
    bGnZ4hX4mTHLdcesWlDQ4YxPqUOtYXC70UsiGjnu/EVpT/7eyKpbDhGrs0aZZke7
    Ir4fXsEWPgfnzPzU1/+71Qm1TLiw2+WavdNgc5TD+GM9KoAoEjHKCCyx64s50aKD
    OM2fJTxGG0fJ9Z58JowsXmqlUpUPtv+FjWRhIg5s+GFLuo02+RZLGlMAUKEhZuFw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N9rSnkNE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeljeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedvjeeknecuvehluhhsthgvrhfuihiivgepgeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N9rSnkNE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeljeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedvjeeknecuvehluhhsthgvrhfuihiivgepgeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966666AbeCSRHa (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:07:30 -0400
Received: from mail-co1nam03on0115.outbound.protection.outlook.com ([104.47.40.115]:37952
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966487AbeCSQKt (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:10:49 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: James Wang <jnwang@suse.com>, Jens Axboe <axboe@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 138/167] Fix loop device flush before
 configure v3
Thread-Topic: [PATCH AUTOSEL for 4.4 138/167] Fix loop device flush before
 configure v3
Thread-Index: AQHTv5x9WY2xEyGkBkeHysJJyvvBNg==
Date: Mon, 19 Mar 2018 16:08:15 +0000
Message-ID: <20180319160513.16384-138-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0888;7:cCSHU0k8OfT1z+NvWc80NC36WndekHZviOAs0u3Tm4sCCXLqa5Lv4dR4aKrFPq9Sjd9ZHsSYXnYLdUxonhb8H+eSwpLXREqOUbTfUIYFY6YsZ/rL8+N4TlmwBFTLA1FLJBYMxi94MUg1qUpyQYv5Q7QERGywMPt7eDTZ6Dn9xEwuXz5t7969T8tUJupBM8EQ4S8hrD4jw2OKCtolLf27RndSh98wDQ/LiJqCLf2FFO9nVhVqwQUb4V25XuUzVQXV;20:V15jRsCxW0BBi9F/TcNjxrPPxZwDVakbeaOR38wqs13vcmEthYgMufh/QoXXcrTV9TMpY7I2rhZYnlWTDenphRL0nV9RrxL0edhyYbWOgOUWbU1lqYiAgbm5S2M7PJQgquhxxFlvtEMBzBX9WCIDhIDpsigIXRsnjdyJ6iXNyyU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 417761ac-73cb-4ef5-2b6e-08d58db3f812
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0888;
x-ms-traffictypediagnostic: DM5PR2101MB0888:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0888DEE10EF6827D530F45B4FBD40@DM5PR2101MB0888.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(26323138287068)(89211679590171)(67672495146484);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0888;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0888;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(366004)(39380400002)(376002)(189003)(199004)(54534003)(6486002)(72206003)(106356001)(86362001)(3660700001)(6436002)(68736007)(53936002)(107886003)(8936002)(81166006)(8676002)(81156014)(2906002)(6116002)(4326008)(6512007)(1076002)(86612001)(66066001)(25786009)(7736002)(3846002)(305945005)(5660300001)(99286004)(5250100002)(110136005)(478600001)(36756003)(54906003)(2501003)(6506007)(186003)(26005)(14454004)(6666003)(2900100001)(316002)(2950100002)(102836004)(10290500003)(3280700002)(97736004)(76176011)(10090500001)(22452003)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0888;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: BXX39PbsrVh0pKeGP8lXov/BYVJB5mqonXP+E671H7d+Fd8rc2FuY51Cvea1qFhC3t6U0/Kxeazaz26ZztnyVjQwjsEASs48xf4L+on6X8jcSWXmXHdfZRznKxya3UubNP/AOZkqJsRtjK4nxN76JNgvGkOskIfw27kbQjiHjw1rTz3AOlASFT9ah+gw5ielnFjLL3HmgkYkHTQ+4yVYs1hDdkWUA48v5SMkuk3KDmTmoIWLVuBaV0ZoEQ8Mh5aF/34yBoQrJ4rS2d7Z07jpFyf6Y3atMDQALcym11eM98/SkKcnLT3KnW3QZ1vCS26PiD/k935Nfn9Dts2FwJQgeQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 417761ac-73cb-4ef5-2b6e-08d58db3f812
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:08:15.9274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0888
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: James Wang <jnwang@suse.com>

[ Upstream commit 6460495709aeb651896bc8e5c134b2e4ca7d34a8 ]

While installing SLES-12 (based on v4.4), I found that the installer
will stall for 60+ seconds during LVM disk scan.  The root cause was
determined to be the removal of a bound device check in loop_flush()
by commit b5dd2f6047ca ("block: loop: improve performance via blk-mq").

Restoring this check, examining ->lo_state as set by loop_set_fd()
eliminates the bad behavior.

Test method:
modprobe loop max_loop=3D64
dd if=3D/dev/zero of=3Ddisk bs=3D512 count=3D200K
for((i=3D0;i<4;i++))do losetup -f disk; done
mkfs.ext4 -F /dev/loop0
for((i=3D0;i<4;i++))do mkdir t$i; mount /dev/loop$i t$i;done
for f in `ls /dev/loop[0-9]*|sort`; do \
	echo $f; dd if=3D$f of=3D/dev/null  bs=3D512 count=3D1; \
	done

Test output:  stock          patched
/dev/loop0    18.1217e-05    8.3842e-05
/dev/loop1     6.1114e-05    0.000147979
/dev/loop10    0.414701      0.000116564
/dev/loop11    0.7474        6.7942e-05
/dev/loop12    0.747986      8.9082e-05
/dev/loop13    0.746532      7.4799e-05
/dev/loop14    0.480041      9.3926e-05
/dev/loop15    1.26453       7.2522e-05

Note that from loop10 onward, the device is not mounted, yet the
stock kernel consumes several orders of magnitude more wall time
than it does for a mounted device.
(Thanks for Mike Galbraith <efault@gmx.de>, give a changelog review.)

Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: James Wang <jnwang@suse.com>
Fixes: b5dd2f6047ca ("block: loop: improve performance via blk-mq")
Signed-off-by: Jens Axboe <axboe@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/block/loop.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 1c36de9719e5..d02afeb11197 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -623,6 +623,9 @@ static int loop_switch(struct loop_device *lo, struct f=
ile *file)
  */
 static int loop_flush(struct loop_device *lo)
 {
+	/* loop not yet configured, no running thread, nothing to flush */
+	if (lo->lo_state !=3D Lo_bound)
+		return 0;
 	return loop_switch(lo, NULL);
 }
=20
--=20
2.14.1
