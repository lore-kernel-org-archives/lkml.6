Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827928-1521496092-2-15219543587445998916
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: AXB_X_FF_SEZ_S 3.299, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES rosk.us-asciien,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521496091; b=C3FY7kaPU616ZnUz2RQP1L4KP9RNbYkJYn06AmiXKrGbXYz
    VKHUDsDEuLPitmRqHIaA5YgG0jSlnkTpt8YChxxruiWixXxClBboGG/m7u2Fb7P1
    aqJ9kBfvtA3fBeeVfNwbNm0Y6/zHlTbn6p7xNN4/51CCphMvFscjrNoKUryc/ogO
    GvigKdr4Fk6MuqSgQXUZ1MRwbMNLP54YS0VE2jysMCGlC2xZLFBQpYnOOSJeXzKN
    SeZ4ncfY7q0DOSaDjdTBMsK4gEvOrunt6OQSC1b4Xn7ZG9diatn/2Lg2MbMBmHqb
    IDUv3va8tyX5e82QRaRS4Q2FOe1NX1HLeL2MujA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496091; bh=ijRhO0
    AVIKh794sgFqebKNvp3cHWWFl3TJFuEWwIQdA=; b=X0wd24QfjjJ3tzULx4CMWy
    1OBCU1Qo94nVzqPOe9P+lLSLqzrzruGewtkGZGURooHlNjxSVqsmXZiBcRwoPz4b
    I2SEYL6l9MV0L6YH03RS1h39dMcpEfgoM6IOmelpstMuS6ynSXYaAWwh7IPYVOiE
    VXFplbnQS2/4QizHVfIRwDZV+kRFi4Ofa+nFGAnQQcz0q9x7qeiWABMHF+WWweL4
    eWvI/isvo690h2Wv9xvtrKL3GZ4MAh5eh2ZIFuQXY9FONLUd/0vcRSVzf3OI3dpC
    APfsXYCtbg1pA0TObwUCqcVog4rvvgmtzqBLNO4g9evQPu+thuA4REnRJna8i15A
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MGf45Qzo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduheehheejnecuvehluhhsthgvrhfuihiivgephedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MGf45Qzo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduheehheejnecuvehluhhsthgvrhfuihiivgephedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933989AbeCSVsI (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:48:08 -0400
Received: from mail-bn3nam01hn0209.outbound.protection.outlook.com ([104.47.33.209]:24416
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934739AbeCSP6O (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:58:14 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Rabin Vincent <rabinv@axis.com>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 016/281] ubi: fastmap: Fix slab corruption
Thread-Topic: [PATCH AUTOSEL for 4.9 016/281] ubi: fastmap: Fix slab
 corruption
Thread-Index: AQHTv5sTmQtnbC6phU6Sh5XLE/QqRg==
Date: Mon, 19 Mar 2018 15:58:08 +0000
Message-ID: <20180319155742.13731-16-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0726;7:wfM4TC04iv+utxkfydobI3OCVV8KqyXw92Kv+1M9/qKArsqxDOR7J6ZQor289SkRK4e95iYFAna1u6yTLME9UjGg8bDsWeixIXlVhnOvtUv7B2/zB2WrcztR1nDIXun+kM8V1Hfmo7nb/TfQFS2VFjFyT+7qC9OUPn1jmPd80Ish/i3gRRADntBolGxWy7vFQf8CtuH/5O5hJ6JZyM9Aoekcv3AB0fCYpeHMLM1rR82hduE470zJGri7Ps5DoM2/;20:yRJ07EvtlfZ86l9L6yINJdpmWpTRzMDeNfzFNx0lkQ77orWs6zbd8JlaY1PfAM8Zp4galHROHIZQzGTWZMRwEdEmzmZMj5RXqEJp3b232O1NmFXIXy6v3qa5btxRo/eGkBR3a9osobFrAW1gZnMqkqq5/VY3LTXBh5kT20i5m/A=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6e3b2a88-922d-450c-cb42-08d58db23710
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0726;
x-ms-traffictypediagnostic: DM5PR2101MB0726:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07265754BAA8A9D638059C4EFBD40@DM5PR2101MB0726.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0726;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0726;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(346002)(39860400002)(39380400002)(396003)(366004)(376002)(199004)(189003)(6666003)(81166006)(5890100001)(22452003)(2906002)(3660700001)(10090500001)(102836004)(53936002)(26005)(316002)(14454004)(2950100002)(97736004)(54906003)(86362001)(575784001)(76176011)(110136005)(99286004)(105586002)(7736002)(10290500003)(66066001)(478600001)(5660300001)(86612001)(6512007)(81156014)(36756003)(305945005)(6506007)(6486002)(6436002)(72206003)(2900100001)(2501003)(5250100002)(59450400001)(186003)(1076002)(3846002)(25786009)(106356001)(8676002)(4326008)(8936002)(6116002)(3280700002)(68736007)(107886003)(22906009)(217873001)(505234006);DIR:OUT;SFP:1501;SCL:5;SRVR:DM5PR2101MB0726;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: JSa31lBtkldZ4dshulrXPcPOxmqL3gLCJeyIgTk8uPKcVSJk3EaLlYCl1aNfXeW8y33qlcEml870wBa8VwOy6pw8/jnRkh3+C2P8ptzYY4Qj7m5S+oEfug5nMUukkppBLPEEtO0Qa+3z//Ew0D912sRGWT9HsdhhXO6ovMwRaTeA0OKan3sx6ojLwEfNV0CBO/I4iOBEJI/2609jYWmC8WT2kLbzTqiie8kcKWwQa5vvRY03xiUIFN2tPxkRmSKoGz02Dj15Oth6eQ4A4knSUQtLVdbVESBvvBt0XyKsWxeKB1qESUykaU8qWddcGaImuEsbLGy4ZVAaF1d8DDfEC9D30sVUkRN3+qSMS+WasZSW4o+2wCT57ma5MIyE1iyX/vp21QHsE/1VMC5RnNoth9aWyGPwywKAwY5UCsBP3vAPoqElPM/XjlvJI7UPiOCl1PapZo3weFYpqJRE4TphtPpOly1D92yHdZiJygxF7LbOuF4vKVATtnNHgYOYmEyV
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3b2a88-922d-450c-cb42-08d58db23710
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:08.8609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0726
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Rabin Vincent <rabinv@axis.com>

[ Upstream commit 8a1435880f452430b41374d27ac4a33e7bd381ea ]

Booting with UBI fastmap and SLUB debugging enabled results in the
following splats.  The problem is that ubi_scan_fastmap() moves the
fastmap blocks from the scan_ai (allocated in scan_fast()) to the ai
allocated in ubi_attach().  This results in two problems:

 - When the scan_ai is freed, aebs which were allocated from its slab
   cache are still in use.

 - When the other ai is being destroyed in destroy_ai(), the
   arguments to kmem_cache_free() call are incorrect since aebs on its
   ->fastmap list were allocated with a slab cache from a differnt ai.

Fix this by making a copy of the aebs in ubi_scan_fastmap() instead of
moving them.

 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
 BUG ubi_aeb_slab_cache (Not tainted): Objects remaining in ubi_aeb_slab_ca=
che on __kmem_cache_shutdown()
 --------------------------------------------------------------------------=
---

 INFO: Slab 0xbfd2da3c objects=3D17 used=3D1 fp=3D0xb33d7748 flags=3D0x4000=
0080
 CPU: 1 PID: 118 Comm: ubiattach Tainted: G    B           4.9.15 #3
 [<80111910>] (unwind_backtrace) from [<8010d498>] (show_stack+0x18/0x1c)
 [<8010d498>] (show_stack) from [<804a3274>] (dump_stack+0xb4/0xe0)
 [<804a3274>] (dump_stack) from [<8026c47c>] (slab_err+0x78/0x88)
 [<8026c47c>] (slab_err) from [<802735bc>] (__kmem_cache_shutdown+0x180/0x3=
e0)
 [<802735bc>] (__kmem_cache_shutdown) from [<8024e13c>] (shutdown_cache+0x1=
c/0x60)
 [<8024e13c>] (shutdown_cache) from [<8024ed64>] (kmem_cache_destroy+0x19c/=
0x20c)
 [<8024ed64>] (kmem_cache_destroy) from [<8057cc14>] (destroy_ai+0x1dc/0x1e=
8)
 [<8057cc14>] (destroy_ai) from [<8057f04c>] (ubi_attach+0x3f4/0x450)
 [<8057f04c>] (ubi_attach) from [<8056fe70>] (ubi_attach_mtd_dev+0x60c/0xff=
8)
 [<8056fe70>] (ubi_attach_mtd_dev) from [<80571d78>] (ctrl_cdev_ioctl+0x110=
/0x2b8)
 [<80571d78>] (ctrl_cdev_ioctl) from [<8029c77c>] (do_vfs_ioctl+0xac/0xa00)
 [<8029c77c>] (do_vfs_ioctl) from [<8029d10c>] (SyS_ioctl+0x3c/0x64)
 [<8029d10c>] (SyS_ioctl) from [<80108860>] (ret_fast_syscall+0x0/0x1c)
 INFO: Object 0xb33d7e88 @offset=3D3720
 INFO: Allocated in scan_peb+0x608/0x81c age=3D72 cpu=3D1 pid=3D118
 	kmem_cache_alloc+0x3b0/0x43c
 	scan_peb+0x608/0x81c
 	ubi_attach+0x124/0x450
 	ubi_attach_mtd_dev+0x60c/0xff8
 	ctrl_cdev_ioctl+0x110/0x2b8
 	do_vfs_ioctl+0xac/0xa00
 	SyS_ioctl+0x3c/0x64
 	ret_fast_syscall+0x0/0x1c
 kmem_cache_destroy ubi_aeb_slab_cache: Slab cache still has objects
 CPU: 1 PID: 118 Comm: ubiattach Tainted: G    B           4.9.15 #3
 [<80111910>] (unwind_backtrace) from [<8010d498>] (show_stack+0x18/0x1c)
 [<8010d498>] (show_stack) from [<804a3274>] (dump_stack+0xb4/0xe0)
 [<804a3274>] (dump_stack) from [<8024ed80>] (kmem_cache_destroy+0x1b8/0x20=
c)
 [<8024ed80>] (kmem_cache_destroy) from [<8057cc14>] (destroy_ai+0x1dc/0x1e=
8)
 [<8057cc14>] (destroy_ai) from [<8057f04c>] (ubi_attach+0x3f4/0x450)
 [<8057f04c>] (ubi_attach) from [<8056fe70>] (ubi_attach_mtd_dev+0x60c/0xff=
8)
 [<8056fe70>] (ubi_attach_mtd_dev) from [<80571d78>] (ctrl_cdev_ioctl+0x110=
/0x2b8)
 [<80571d78>] (ctrl_cdev_ioctl) from [<8029c77c>] (do_vfs_ioctl+0xac/0xa00)
 [<8029c77c>] (do_vfs_ioctl) from [<8029d10c>] (SyS_ioctl+0x3c/0x64)
 [<8029d10c>] (SyS_ioctl) from [<80108860>] (ret_fast_syscall+0x0/0x1c)
 cache_from_obj: Wrong slab cache. ubi_aeb_slab_cache but object is from ub=
i_aeb_slab_cache
 ------------[ cut here ]------------
 WARNING: CPU: 1 PID: 118 at mm/slab.h:354 kmem_cache_free+0x39c/0x450
 Modules linked in:
 CPU: 1 PID: 118 Comm: ubiattach Tainted: G    B           4.9.15 #3
 [<80111910>] (unwind_backtrace) from [<8010d498>] (show_stack+0x18/0x1c)
 [<8010d498>] (show_stack) from [<804a3274>] (dump_stack+0xb4/0xe0)
 [<804a3274>] (dump_stack) from [<80120e40>] (__warn+0xf4/0x10c)
 [<80120e40>] (__warn) from [<80120f20>] (warn_slowpath_null+0x28/0x30)
 [<80120f20>] (warn_slowpath_null) from [<80271fe0>] (kmem_cache_free+0x39c=
/0x450)
 [<80271fe0>] (kmem_cache_free) from [<8057cb88>] (destroy_ai+0x150/0x1e8)
 [<8057cb88>] (destroy_ai) from [<8057ef1c>] (ubi_attach+0x2c4/0x450)
 [<8057ef1c>] (ubi_attach) from [<8056fe70>] (ubi_attach_mtd_dev+0x60c/0xff=
8)
 [<8056fe70>] (ubi_attach_mtd_dev) from [<80571d78>] (ctrl_cdev_ioctl+0x110=
/0x2b8)
 [<80571d78>] (ctrl_cdev_ioctl) from [<8029c77c>] (do_vfs_ioctl+0xac/0xa00)
 [<8029c77c>] (do_vfs_ioctl) from [<8029d10c>] (SyS_ioctl+0x3c/0x64)
 [<8029d10c>] (SyS_ioctl) from [<80108860>] (ret_fast_syscall+0x0/0x1c)
 ---[ end trace 2bd8396277fd0a0b ]---
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
 BUG ubi_aeb_slab_cache (Tainted: G    B   W      ): page slab pointer corr=
upt.
 --------------------------------------------------------------------------=
---

 INFO: Allocated in scan_peb+0x608/0x81c age=3D104 cpu=3D1 pid=3D118
 	kmem_cache_alloc+0x3b0/0x43c
 	scan_peb+0x608/0x81c
 	ubi_attach+0x124/0x450
 	ubi_attach_mtd_dev+0x60c/0xff8
 	ctrl_cdev_ioctl+0x110/0x2b8
 	do_vfs_ioctl+0xac/0xa00
 	SyS_ioctl+0x3c/0x64
 	ret_fast_syscall+0x0/0x1c
 INFO: Slab 0xbfd2da3c objects=3D17 used=3D1 fp=3D0xb33d7748 flags=3D0x4000=
0081
 INFO: Object 0xb33d7e88 @offset=3D3720 fp=3D0xb33d7da0

 Redzone b33d7e80: cc cc cc cc cc cc cc cc                          .......=
.
 Object b33d7e88: 02 00 00 00 01 00 00 00 00 f0 ff 7f ff ff ff ff  ........=
........
 Object b33d7e98: 00 00 00 00 00 00 00 00 bd 16 00 00 00 00 00 00  ........=
........
 Object b33d7ea8: 00 01 00 00 00 02 00 00 00 00 00 00 00 00 00 00  ........=
........
 Redzone b33d7eb8: cc cc cc cc                                      ....
 Padding b33d7f60: 5a 5a 5a 5a 5a 5a 5a 5a                          ZZZZZZZ=
Z
 CPU: 1 PID: 118 Comm: ubiattach Tainted: G    B   W       4.9.15 #3
 [<80111910>] (unwind_backtrace) from [<8010d498>] (show_stack+0x18/0x1c)
 [<8010d498>] (show_stack) from [<804a3274>] (dump_stack+0xb4/0xe0)
 [<804a3274>] (dump_stack) from [<80271770>] (free_debug_processing+0x320/0=
x3c4)
 [<80271770>] (free_debug_processing) from [<80271ad0>] (__slab_free+0x2bc/=
0x430)
 [<80271ad0>] (__slab_free) from [<80272024>] (kmem_cache_free+0x3e0/0x450)
 [<80272024>] (kmem_cache_free) from [<8057cb88>] (destroy_ai+0x150/0x1e8)
 [<8057cb88>] (destroy_ai) from [<8057ef1c>] (ubi_attach+0x2c4/0x450)
 [<8057ef1c>] (ubi_attach) from [<8056fe70>] (ubi_attach_mtd_dev+0x60c/0xff=
8)
 [<8056fe70>] (ubi_attach_mtd_dev) from [<80571d78>] (ctrl_cdev_ioctl+0x110=
/0x2b8)
 [<80571d78>] (ctrl_cdev_ioctl) from [<8029c77c>] (do_vfs_ioctl+0xac/0xa00)
 [<8029c77c>] (do_vfs_ioctl) from [<8029d10c>] (SyS_ioctl+0x3c/0x64)
 [<8029d10c>] (SyS_ioctl) from [<80108860>] (ret_fast_syscall+0x0/0x1c)
 FIX ubi_aeb_slab_cache: Object at 0xb33d7e88 not freed

Signed-off-by: Rabin Vincent <rabinv@axis.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mtd/ubi/fastmap.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/ubi/fastmap.c b/drivers/mtd/ubi/fastmap.c
index c1f5c29e458e..b44c8d348e78 100644
--- a/drivers/mtd/ubi/fastmap.c
+++ b/drivers/mtd/ubi/fastmap.c
@@ -828,6 +828,24 @@ static int find_fm_anchor(struct ubi_attach_info *ai)
 	return ret;
 }
=20
+static struct ubi_ainf_peb *clone_aeb(struct ubi_attach_info *ai,
+				      struct ubi_ainf_peb *old)
+{
+	struct ubi_ainf_peb *new;
+
+	new =3D ubi_alloc_aeb(ai, old->pnum, old->ec);
+	if (!new)
+		return NULL;
+
+	new->vol_id =3D old->vol_id;
+	new->sqnum =3D old->sqnum;
+	new->lnum =3D old->lnum;
+	new->scrub =3D old->scrub;
+	new->copy_flag =3D old->copy_flag;
+
+	return new;
+}
+
 /**
  * ubi_scan_fastmap - scan the fastmap.
  * @ubi: UBI device object
@@ -847,7 +865,7 @@ int ubi_scan_fastmap(struct ubi_device *ubi, struct ubi=
_attach_info *ai,
 	struct ubi_vid_hdr *vh;
 	struct ubi_ec_hdr *ech;
 	struct ubi_fastmap_layout *fm;
-	struct ubi_ainf_peb *tmp_aeb, *aeb;
+	struct ubi_ainf_peb *aeb;
 	int i, used_blocks, pnum, fm_anchor, ret =3D 0;
 	size_t fm_size;
 	__be32 crc, tmp_crc;
@@ -857,9 +875,16 @@ int ubi_scan_fastmap(struct ubi_device *ubi, struct ub=
i_attach_info *ai,
 	if (fm_anchor < 0)
 		return UBI_NO_FASTMAP;
=20
-	/* Move all (possible) fastmap blocks into our new attach structure. */
-	list_for_each_entry_safe(aeb, tmp_aeb, &scan_ai->fastmap, u.list)
-		list_move_tail(&aeb->u.list, &ai->fastmap);
+	/* Copy all (possible) fastmap blocks into our new attach structure. */
+	list_for_each_entry(aeb, &scan_ai->fastmap, u.list) {
+		struct ubi_ainf_peb *new;
+
+		new =3D clone_aeb(ai, aeb);
+		if (!new)
+			return -ENOMEM;
+
+		list_add(&new->u.list, &ai->fastmap);
+	}
=20
 	down_write(&ubi->fm_protect);
 	memset(ubi->fm_buf, 0, ubi->fm_size);
--=20
2.14.1
