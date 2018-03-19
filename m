Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3230508-1521475711-2-14879650245685615713
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
    t=1521475710; b=dY1792fgytIIniV+Ph8hukBe1LbYiAoSt+czXghDoxYc/1+
    kt9tILB2iU6TQ3CQ2xpGhOMw0pC0/X0ppLTNjP6N6uV/m3QlLwDy2WFD4DJolKMT
    h4XHjuJfdy7jqZ48OGSX5D1tHUxCIs4TBoQ0srgSFPCWcrjomww4IkAN7tfAMM84
    LdcgjAwurIHbsJiBUk0I3mlpoBmeSYy+RT0AkJBWm1b2VlT5/Wt1FmEYU6QcvLAM
    34j3EkjjN+yl4GO47uHdNPPkgakLgBWWOY4RZribC50XStBzHsvwxvwmK+P5HIKN
    MO/Vhw3UMxatnvGsKU7VJaZ9Ab6NYSnsHjZ0qoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475710; bh=Rwm+Bu
    YCibpo8y/7Y+YkrGC9rybd3XB+mepLCGJIsJ0=; b=Fq4Nethi/5jzESJzJF0xDn
    ruj0vitiR2tATgt8kcWxq6Kh6cNr66GG1BFWgue6/i2js4VupE3/A4q4t4FffByo
    TIBbYEh2AXzyonaE1PzI84EloHThnGcLtLnAVKwjuv+PfL8OBFWinMFHbNQz2V/1
    zy3/U1LGnkkoPXTN1PFySayh3e4Qpyps/gjgujFPFHhm7eQEU27FNNeBL+sXP7kF
    g3fw6eumY9TlABQhE6pJSkmII3jB+DjEhvbcE6XHOcqcJOPKQ9IqsgZFq6IRwX8e
    b5ZSXZwd3PE2V+nALzfb45Mpre9XvXqSrMCbQ7UyKYrdcfRMOmEA2ZRyuksO+swQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jqKziJxD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeegkedvnecuvehluhhsthgvrhfuihiivgepfedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jqKziJxD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeegkedvnecuvehluhhsthgvrhfuihiivgepfedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966299AbeCSQI2 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:08:28 -0400
Received: from mail-dm3nam03on0131.outbound.protection.outlook.com ([104.47.41.131]:49502
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965811AbeCSQIT (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:08:19 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 047/167] USB: ene_usb6250: fix SCSI residue
 overwriting
Thread-Topic: [PATCH AUTOSEL for 4.4 047/167] USB: ene_usb6250: fix SCSI
 residue overwriting
Thread-Index: AQHTv5w3cI+dxQpNk0CtOspbydstGQ==
Date: Mon, 19 Mar 2018 16:06:19 +0000
Message-ID: <20180319160513.16384-47-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:QPiE84lmRuPx1Q8FGXj5wpHlvDRDPgUHZAVVh15KJ5X64SG3dQx6fYoN4/x1+C7nZhOh4ZWO35m2mfzdBqDheRvGLmPdPE0AUv2xmlO5yRbSlk0gp9bZxMawmKnYsh/al9uwtHQrs39Q3ik0RB+PAiKYS0WskqWd3d/S4tB9KbeRPwMLdGLIdnyBQ7ek0y7KD3pZyNbxCr2t2n7J7JMz/xKQryvxyqPAPT3nd0pelMt0U4SQCxWOqLntNGd0yVf+;20:UUiqzzmhkIOGoae4Sgf7ymFOpCRy3CtSJPlEJCkf1/Yto5lU7fJjCs0+/YlQoXw+abFY7tsAqdjtDNXf+Mfgt1wySYztJceKZ7D+FehP7AHbWUp9po/dJJnLO61UKSomFSQjrbTKjiJzLoF7pE7Mh3Af7JeQzajtMmzs8wAAisA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c5beafd1-fef0-4c9f-dd8c-08d58db3a075
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08058B7AD36B6814B62C422BFBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(35762410373642);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(575784001)(2950100002)(305945005)(186003)(86362001)(6506007)(3660700001)(5660300001)(6116002)(8936002)(3846002)(1076002)(26005)(7736002)(6486002)(2900100001)(6436002)(2906002)(86612001)(68736007)(81166006)(81156014)(10090500001)(102836004)(59450400001)(8676002)(14454004)(105586002)(107886003)(25786009)(478600001)(2501003)(5250100002)(53936002)(3280700002)(316002)(54906003)(4326008)(6512007)(72206003)(66066001)(22452003)(10290500003)(99286004)(76176011)(36756003)(97736004)(106356001)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: fg8h4cFbfl+f05R1u/UyT+UXQR4emty8de9L+Q4q7aJqAgJmp0xsp65/qd2toKg1VdSVHT+xWoRL+pl4GTy8Qq/03lc/wY7GHlSDP/yDkZPgGpwKpKOsYCKNntLMaPy/r+ycNmfOcDbIWJWI/bymmJTIglfTOQbKu9p5S2VroKVjRJsDsKnLe5fBMgYH0rvbXNScLCAyEwu/LxWrk6FbJKdWRwQz0MuAlfIYtS9y6ARqfgxusoldPF91Eg/takTprSY8NjjJV0T6+WzBHUGckPNDrIPbJFHUWMOQuZ8Ua8gfzn3yH4AS4Ji5FSegVuMa4G91bW993ZN0K7hkIknAmQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5beafd1-fef0-4c9f-dd8c-08d58db3a075
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:19.9302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alan Stern <stern@rowland.harvard.edu>

[ Upstream commit aa18c4b6e0e39bfb00af48734ec24bc189ac9909 ]

In the ene_usb6250 sub-driver for usb-storage, the SCSI residue is not
reported correctly.  The residue is initialized to 0, but this value
is overwritten whenever the driver sends firmware to the card reader
before performing the current command.  As a result, a valid READ or
WRITE operation appears to have failed, causing the SCSI core to retry
the command multiple times and eventually fail.

This patch fixes the problem by resetting the SCSI residue to 0 after
sending firmware to the device.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reported-and-tested-by: Andreas Hartmann <andihartmann@01019freenet.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/usb/storage/ene_ub6250.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/storage/ene_ub6250.c b/drivers/usb/storage/ene_ub6=
250.c
index eebfa09bccc1..962bb6376b0c 100644
--- a/drivers/usb/storage/ene_ub6250.c
+++ b/drivers/usb/storage/ene_ub6250.c
@@ -1953,6 +1953,8 @@ static int ene_load_bincode(struct us_data *us, unsig=
ned char flag)
 	bcb->CDB[0] =3D 0xEF;
=20
 	result =3D ene_send_scsi_cmd(us, FDIR_WRITE, buf, 0);
+	if (us->srb !=3D NULL)
+		scsi_set_resid(us->srb, 0);
 	info->BIN_FLAG =3D flag;
 	kfree(buf);
=20
--=20
2.14.1
