Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3980569-1521499368-2-3822025575151649481
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521499367; b=AmyTZP8Zon8CV5CcKgiuEUNPpb39NQKC1/nRQJo/eOg+LQX
    B7k/B5jTpbDrrcpBN049blnkkOj7KnIvPhR4BI+fRb4iDTQxzSZD6mvyfJwPNC4U
    N6/gS9zX/YbTn5sxMdwWbWI3qYWDQb/9nK8DdS5PX/XEqEDlUPz7yysjnhMSsps/
    Sx0jGFqXqOngvcVC7xh8iB0nsNU/1cZhSXJOhQ+dqa7zHjSEEDCQaZYonOMPtaYy
    /pRUUY4ld8F3gJSd/w7v2StTNPt71ztzITn7adLlYVzAtbr8fD4jGKcLM2qYhz/e
    QKmoxMwu/dTUUbqr515iMlBfEDAA117WHIJ2Sag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521499367; bh=jV0azy
    ZxtYwJD6d9XjIUfeiEtE10wpmQpilxM3/YCiE=; b=kByXi9CrzSx/e9y1RozmEQ
    dQv0ij7yn7f6qAAfrwKCYwHjcZSsZL+Ar30x8Lo33hBDye7S4eALt/Z0LSsEfYJ1
    g0BA37U3jJgp8434yES7fBoZp71GRVWU0UgA9CTLWQfSu7IxahBCxFTLy2i9sw9O
    20htUbYYuOLcWtfzppBfNjOEVVr6vDMxK+P3C4LqnuCSgVGEgn+LM/yPmK4N1SrM
    0VmbTc4zxuYzTf4051qzAw2/8/CzjkLXpVgwFMaXE6imBVbQCCiL5tlOmWXy1N9I
    zttaMevq26kL4Tda6Pwan3zjpw5G+jFq7RDcns5oaa3A+km50tArlHBiyQlRgh2Q
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TltfwMTS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggddtudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleelheeknecuvehluhhsthgvrhfuihiivgepheef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TltfwMTS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggddtudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleelheeknecuvehluhhsthgvrhfuihiivgepheef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933482AbeCSWmm (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:42:42 -0400
Received: from mail-by2nam01on0103.outbound.protection.outlook.com ([104.47.34.103]:19764
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755993AbeCSPrK (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:47:10 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Yi Zeng <yizeng@asrmicro.com>, Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 008/124] thermal: power_allocator: fix one
 race condition issue for thermal_instances list
Thread-Topic: [PATCH AUTOSEL for 4.15 008/124] thermal: power_allocator: fix
 one race condition issue for thermal_instances list
Thread-Index: AQHTv5mHaTOHdzkuvkyLNSdTBsCnZg==
Date: Mon, 19 Mar 2018 15:47:05 +0000
Message-ID: <20180319154645.11350-8-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:c9DxewogIfUgKDkQl9TuZZzcVkG8koMNUmx5xCbXJE0RGUthrKZEZ17CqRupOPwvkWHhO5lxsmpAbBJhYbRgGNTKMgKHpA3NEGRAiqAKtyYVwDFMvROdh8TjQlNHtqzLn/7IKfn9GdcvaF8k8/P+y2VOffsz6dUr1D4K2Qcw2sT6awv0aeaBxsTUQO06Lg2X4k4DqpOxyx3Do35ZPJISYruuzqtyZXcmLDjNy1dPIQMQaHot5v/0ZYXZuZH8/2Yv;20:vSQTeizyjL2dAHNBhXlD/IizD0VSdKt6bUP+ml7sS0IDa9FC0Y5ZFKK+ASqnycw018l4kdWze2if3LIsRtp/M4iF/Vo/L72+XKi0IAA/+Hg4Bklg/uratOaU27rxpIUUzG5l4iK68vlY6nozaIpLQOqUISF2fY8kFvkprlRHK5o=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 89fec1a2-4cad-4546-c61b-08d58db0aa40
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10138443139176965A4D19DFFBD40@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(376002)(39380400002)(189003)(51234002)(199004)(86612001)(316002)(26005)(72206003)(4326008)(25786009)(110136005)(10290500003)(86362001)(575784001)(59450400001)(54906003)(53936002)(36756003)(107886003)(3280700002)(14454004)(22452003)(6506007)(5660300001)(68736007)(99286004)(186003)(478600001)(76176011)(2950100002)(10090500001)(102836004)(6116002)(5250100002)(2501003)(97736004)(3660700001)(106356001)(81156014)(81166006)(8676002)(8936002)(7736002)(305945005)(2900100001)(105586002)(3846002)(1076002)(66066001)(6436002)(2906002)(6512007)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: v3tfC6n2ZsVXOZV8LitCWDsiLYpMRak9Ky3KNvLDoAgACRtsnxK9e5wUb8BpxV2z/06ZRTiX6K/EZiTSRXuhb9Ii4ARt5WmkwctWo/rRF4O2JnRKIRE0v9EaL8S/OfeO7uaaBNj2sECe0DRjcXJIP5gO7LPwZNKCloW0I3ULysFZ6ovZcWpLdyIcyciqMfPUbuchOeUPdCHvah1X7bD73atSVoFa6YBazTAiu7603fBAY0PiZtmOCRSpTY6yRk1zFF2oHroeJHQQgaD57hcSlIdjRhD2rHafb1g33cQih8FlcaWbxJhkCr7U2kfYRv6HDLqNnnXVqSKxfSPWjhDo8Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89fec1a2-4cad-4546-c61b-08d58db0aa40
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:05.1234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
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
index b4d3116cfdaf..3055f9a12a17 100644
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
@@ -534,6 +535,7 @@ static void allow_maximum_power(struct thermal_zone_dev=
ice *tz)
 		mutex_unlock(&instance->cdev->lock);
 		thermal_cdev_update(instance->cdev);
 	}
+	mutex_unlock(&tz->lock);
 }
=20
 /**
--=20
2.14.1
