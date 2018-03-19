Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3230508-1521475765-2-6107846183170804576
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
    t=1521475764; b=IeO9ccJzYZHd5mbct5uArMkZzSzFqoj1AQsCODJnrcKYYS4
    DZNomCss410v+rUf1SYm0tQisKIkgbfcNPzQb9S/h3C10qP7kW5SEiyzuIm0MDgJ
    OmHmHV+fCjCNb1WFVz8OeQDnccMb72TB81CltnOoF0xavaSI19PKtfaVxTTBrt+0
    MZvbT0ybFA1ePHRSw7oKPua+zuOkMiYg083pN9QK+1tArQXNg0DdqgW/EAwwfYVF
    ansl7K3WVT77Q8M8ax4IVh/kAZR/b/3aKFTuEfdGu88Nuy/m8icJoZAqI0RF3ClJ
    u+yyW0e5o4YS88Ub7kJfLU6J+cdZatFYFNxkHuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475764; bh=HdQuuP
    Xn7LpTPS6vgUiXmtqpoDsqGTvVAjfm3F4WQX8=; b=WR8celcvR+RyZGFK2i2SJ1
    jv/iYYV1P9six0dQHqXyDYObcbDDfc2zEQkhkKJWKJ6Lec/87x7EsSlxwUFDH3Iv
    X+ZW4wTvRC/OhW2o4zqmrunq/qXzHSyYBf9Myr15i0KesrC9i2B869KJ/6rdhpR2
    9foHpnYGz8vxt6lGbjyWAvnOZN++KZ/2Nd9bj4figM4CGQOX3f1qfTUTs1iKz2wQ
    dpQiUhzzLwuK80oyixJBWSW9KaElDuqnqJMJIVEWkb7LanKJI4c4XyE04nBh7iKY
    3JNOimaZ1z5Nir3QhV9Cp8MXR3sA3U3kfmZUAQg6rKdpwwLO+/LMnt0+xrFfbRvQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=C40X6ABN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleeltdejnecuvehluhhsthgvrhfuihiivgepkeei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=C40X6ABN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleeltdejnecuvehluhhsthgvrhfuihiivgepkeei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966443AbeCSQJV (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:09:21 -0400
Received: from mail-sn1nam01on0111.outbound.protection.outlook.com ([104.47.32.111]:20373
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966394AbeCSQJI (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:09:08 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Yi Zeng <yizeng@asrmicro.com>, Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 083/167] thermal: power_allocator: fix one
 race condition issue for thermal_instances list
Thread-Topic: [PATCH AUTOSEL for 4.4 083/167] thermal: power_allocator: fix
 one race condition issue for thermal_instances list
Thread-Index: AQHTv5xTgR9uug1u/EyleCDVXprv5A==
Date: Mon, 19 Mar 2018 16:07:06 +0000
Message-ID: <20180319160513.16384-83-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:F30KcN3JKOD/VsKuOQqtnNtxW0a8XX3ve4Jany36g6i9yvz+5gtHDDtNgu2OqDkkOk7NKcEET+kqVItHtbexBNYmQV/6INVIlLgzzx0ok+ub+j0oLeVv6diNqm25SRzGlPDkL5Q9Jhzw/yWz+gl55SOj77Pn2o2uhs6aK9Bik92ODKAeBpK0PMc63nyCjDYK7b0/DdVTalvuT6lTmdmjUoJk5yLrlSIr4ZjHxndKdpQ2GsnhT9MQtYSqiOhf7U5m;20:OzjgXeNrpP30N5D0bYW8DDsDSFWPXx5A9/9uYwnUWjpZ6/LTNJlLC5XPqomzqiHFjjhL/+NUBySDTpZ6/kKhHwLlSFU5VLgVZHQ0EhLNtMh1sA+/fyskTK+LeuU42u5QX05XFKE3PiUSyINgHUswdbqb4XrJrUeBHL8y/nOAir4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 12f01040-eabd-441f-29ce-08d58db3bd4f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB090265B04502C16ED9F535DBFBD40@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(396003)(39380400002)(376002)(199004)(189003)(51234002)(4326008)(305945005)(7736002)(66066001)(105586002)(316002)(8676002)(25786009)(8936002)(2950100002)(5660300001)(97736004)(81166006)(81156014)(3280700002)(22452003)(99286004)(186003)(2906002)(76176011)(5250100002)(59450400001)(54906003)(10090500001)(110136005)(6116002)(2900100001)(3846002)(2501003)(1076002)(86612001)(107886003)(106356001)(6436002)(6512007)(575784001)(86362001)(53936002)(6506007)(6486002)(26005)(14454004)(10290500003)(102836004)(68736007)(3660700001)(478600001)(72206003)(36756003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 0Lhpk3vrKM1iElkGelUQyUGt8cWB718+05ivBxJk2Qju2lGUl3zLHpomlYvWSmtQqO7TnV0/pSEkPFUN9VVwasjfPtkxzCxYnnUh1+xgNt1iY7BPu5BQILvtJbYbJR/KegnJGA9i6HMGVuIVNIsqur4G+Hxb+x6TVMC2M8JcT0f5GiqFNKMRzjslGkIu02I+59qPNLqYgAO5UE3HGvZHAWyxGAzJR1RckPDDR61cbktTZCrgI1EEWCCFh9iCRfA56wersZeFwYF0WWDvr6bSHK9ySOmlDm+3majo+1Exa2TVY65zxc5bRjPF6PVVtiAQHgDiOkn1bFsb+JrC/cERVQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f01040-eabd-441f-29ce-08d58db3bd4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:06.2100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Yi Zeng <yizeng@asrmicro.com>

[ Upstream commit a5de11d67dcd268b8d0beb73dc374de5e97f0caf ]

When invoking allow_maximum_power and traverse tz->thermal_instances,
we should grab thermal_zone_device->lock to avoid race condition. For
example, during the system reboot, if the mali GPU device implements
device shutdown callback and unregister GPU devfreq cooling device,
the deleted list head may be accessed to cause panic, as the following
log shows:

[   33.551070] c3 25 (kworker/3:0) Unable to handle kernel paging request a=
t virtual address dead000000000070
[   33.566708] c3 25 (kworker/3:0) pgd =3D ffffffc0ed290000
[   33.572071] c3 25 (kworker/3:0) [dead000000000070] *pgd=3D00000001ed2920=
03, *pud=3D00000001ed292003, *pmd=3D0000000000000000
[   33.581515] c3 25 (kworker/3:0) Internal error: Oops: 96000004 [#1] PREE=
MPT SMP
[   33.599761] c3 25 (kworker/3:0) CPU: 3 PID: 25 Comm: kworker/3:0 Not tai=
nted 4.4.35+ #912
[   33.614137] c3 25 (kworker/3:0) Workqueue: events_freezable thermal_zone=
_device_check
[   33.620245] c3 25 (kworker/3:0) task: ffffffc0f32e4200 ti: ffffffc0f32f0=
000 task.ti: ffffffc0f32f0000
[   33.629466] c3 25 (kworker/3:0) PC is at power_allocator_throttle+0x7c8/=
0x8a4
[   33.636609] c3 25 (kworker/3:0) LR is at power_allocator_throttle+0x808/=
0x8a4
[   33.643742] c3 25 (kworker/3:0) pc : [<ffffff8008683dd0>] lr : [<ffffff8=
008683e10>] pstate: 20000145
[   33.652874] c3 25 (kworker/3:0) sp : ffffffc0f32f3bb0
[   34.468519] c3 25 (kworker/3:0) Process kworker/3:0 (pid: 25, stack limi=
t =3D 0xffffffc0f32f0020)
[   34.477220] c3 25 (kworker/3:0) Stack: (0xffffffc0f32f3bb0 to 0xffffffc0=
f32f4000)
[   34.819822] c3 25 (kworker/3:0) Call trace:
[   34.824021] c3 25 (kworker/3:0) Exception stack(0xffffffc0f32f39c0 to 0x=
ffffffc0f32f3af0)
[   34.924993] c3 25 (kworker/3:0) [<ffffff8008683dd0>] power_allocator_thr=
ottle+0x7c8/0x8a4
[   34.933184] c3 25 (kworker/3:0) [<ffffff80086807f4>] handle_thermal_trip=
.part.25+0x70/0x224
[   34.941545] c3 25 (kworker/3:0) [<ffffff8008680a68>] thermal_zone_device=
_update+0xc0/0x20c
[   34.949818] c3 25 (kworker/3:0) [<ffffff8008680bd4>] thermal_zone_device=
_check+0x20/0x2c
[   34.957924] c3 25 (kworker/3:0) [<ffffff80080b93a4>] process_one_work+0x=
168/0x458
[   34.965414] c3 25 (kworker/3:0) [<ffffff80080ba068>] worker_thread+0x13c=
/0x4b4
[   34.972650] c3 25 (kworker/3:0) [<ffffff80080c0a4c>] kthread+0xe8/0xfc
[   34.979187] c3 25 (kworker/3:0) [<ffffff8008084e90>] ret_from_fork+0x10/=
0x40
[   34.986244] c3 25 (kworker/3:0) Code: f9405e73 eb1302bf d102e273 54ffc46=
0 (b9402a61)
[   34.994339] c3 25 (kworker/3:0) ---[ end trace 32057901e3b7e1db ]---

Signed-off-by: Yi Zeng <yizeng@asrmicro.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/thermal/power_allocator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allo=
cator.c
index 1246aa6fcab0..737635f0bec0 100644
--- a/drivers/thermal/power_allocator.c
+++ b/drivers/thermal/power_allocator.c
@@ -523,6 +523,7 @@ static void allow_maximum_power(struct thermal_zone_dev=
ice *tz)
 	struct thermal_instance *instance;
 	struct power_allocator_params *params =3D tz->governor_data;
=20
+	mutex_lock(&tz->lock);
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 		if ((instance->trip !=3D params->trip_max_desired_temperature) ||
 		    (!cdev_is_power_actor(instance->cdev)))
@@ -532,6 +533,7 @@ static void allow_maximum_power(struct thermal_zone_dev=
ice *tz)
 		instance->cdev->updated =3D false;
 		thermal_cdev_update(instance->cdev);
 	}
+	mutex_unlock(&tz->lock);
 }
=20
 /**
--=20
2.14.1
