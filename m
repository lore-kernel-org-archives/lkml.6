Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3763980-1521494084-2-9652764419949084341
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
    t=1521494083; b=QaP7Y0JmYWVh/ZkK3Jy3aMD6g2HEp07mLfzH4q2J9v+m67g
    4nFAQD/jwniR1yCeGnlIHYXiVQFRoulW7DwvI3lbiepsN6vp3GKzgUFxS5XEVZkV
    sPeYIjcdHBw3Zh/ntzOmvzUVoIqSnjowcbZxTLn8f0HAxhS4muML1B3fkdoOpIoX
    qQothNyVBsZjSiETTO0+DyyLmi0m/63JIMENjQzo+m/+PiNykUPSlN75qmt/bTAL
    X7MJZRqpndeiV8Z3fgV9ziyUW6oBH/pcDNwpAQN0B2yVLirbtGnq7rw2fmZZeVG3
    AwX9/ozt8+mYf5I1aG7izEnLFKVEeNIDkhmFcGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494083; bh=jV0azy
    ZxtYwJD6d9XjIUfeiEtE10wpmQpilxM3/YCiE=; b=rSS2zTwURnexbPIseHgMOG
    NOcYJF3W8+pCJJpjbPg2YuWDFgvum9fjqyFPmLkAQ+RbaYVLtzWnVuQOz+JR7uZ9
    Ay4zn7tgzM01z3hGDroP00POZ4Azy7M16uNs26iY46a5D9mKpTkVqlKGhcCxRJHb
    jPvOVImrRrdZ0N8laCrwQOy1aDF7HFRoUlxaP+Op+8dO8ammH0qteIaVKSBE6JYE
    72v6X0XhsEZ9uBsEqBY23KjAae1ARJY+YUNnRbnOkixVh9W2KiJUXI2gZ2Aq87Xo
    fvw6o9B7Ds9yL1HXgMOz4y8xTjxezMeGgaQGUNM6RX2uVJVM8xzwpmI8hf7mYKRQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oKPCIOuY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelledvleenucevlhhushhtvghrufhiiigvpedule;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oKPCIOuY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelledvleenucevlhhushhtvghrufhiiigvpedule;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933644AbeCSVOk (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:14:40 -0400
Received: from mail-co1nam03on0115.outbound.protection.outlook.com ([104.47.40.115]:65216
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934944AbeCSQBo (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:01:44 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Yi Zeng <yizeng@asrmicro.com>, Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 124/281] thermal: power_allocator: fix one
 race condition issue for thermal_instances list
Thread-Topic: [PATCH AUTOSEL for 4.9 124/281] thermal: power_allocator: fix
 one race condition issue for thermal_instances list
Thread-Index: AQHTv5thnylxEnIGhEeHpjztIbQpPw==
Date: Mon, 19 Mar 2018 16:00:20 +0000
Message-ID: <20180319155742.13731-124-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0933;7:V+m3STZJBPZ5VL6UF5/NepoYT/Dl/JUB03NxeT5+Y08LOLMZdgCS2vQxbnzoG7gk2G/NtBfeKvn9j85ig+9FtRHR/1HziLW8vaqjOB4tO19aDmCXycPZIXGmBugjVlYOTokFSIMTe+KhnYFoxADJ+xoldRi0Qf/dRKQQHsDubwKG9nAWbzD7gC9n9ZATPzqnm4/yemmiwaFrUxcMeGmx/uY8xhooX9o8R2TKpKlrfRe5QdorjdMhqvLf+upiS0J8;20:dJNkP8RVPeQM0nwPOe1uNGgug0ww7w1CPeyBp5H46O6z6Rsws7VDVEA4ZX4dmRH2pT2Gpx3vtUae57pZCWOh/4NbLuKAGOFgS7O85CUJtP6Z6AwsTKeOfGzY7hTYdTlSns2VgP3J50qek2MZrKWZtZc+rMzPzCvvezeWXDlosUo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e8738052-75f2-4c06-b360-08d58db2b4b0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0933;
x-ms-traffictypediagnostic: DM5PR2101MB0933:
x-microsoft-antispam-prvs: <DM5PR2101MB093399D930FF081FEC76CF06FBD40@DM5PR2101MB0933.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0933;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0933;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(346002)(376002)(51234002)(199004)(189003)(2501003)(72206003)(1076002)(66066001)(10290500003)(99286004)(10090500001)(7736002)(14454004)(6116002)(5660300001)(2906002)(97736004)(6666003)(6346003)(102836004)(575784001)(22452003)(86612001)(3660700001)(186003)(2900100001)(25786009)(478600001)(5250100002)(26005)(6486002)(6436002)(81156014)(81166006)(36756003)(4326008)(86362001)(76176011)(6512007)(8936002)(106356001)(3846002)(53936002)(105586002)(3280700002)(305945005)(68736007)(110136005)(2950100002)(54906003)(8676002)(107886003)(316002)(6506007)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0933;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: +yycYynOzx4KMVAe3Ld/QHLB6y7srIaeGGds8/1xRBYyD4zzYFU3CTPeRnHOJCv2eIC2aOZWCRE1h535qYXkcYOk3h7LX8Iu14yTcSaRdk7cuhwi4azPoBvTMwVLT1J+Yu2c849Ab0exeLa7qyA31SNARisedmubhXmItWkQQNCtkXhTnm3OcHZxqk9CLOsJOt1xdfWOeR5jVhgu1DO2rfubKVc8/JgWYa2Punqh7bEyusvwhynV9YXvWvqNj46gkK2SkezjwqBkARjreNMIhmjBOKGVJRw2SRhy/zlSQ4aV8OoDGJ7A7+nK7gz2T52jWmw54YG9xa8oV5qClOzq8Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8738052-75f2-4c06-b360-08d58db2b4b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:20.5544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0933
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
