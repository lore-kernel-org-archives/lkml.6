Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520122105-2-12319126450870898815
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520122104; b=nvVRsk+ue/upsDVU6ygbwOnXdALAg1P2D222Ll7t9LwJxtD
    CTR5TYQ+g/wVglnvDy2IBSvUdqICcMiAKJGlipoQBlx6VSvUnpFYi9bzHqNK3vWM
    JFaGx4XOFj/R7G5Rf7zX0BEpM1Sucjmo2drsAY4uWooHPD2Mb/FYqPZKj58a3mXW
    viVBvIA6jGCyLv9RYn8qEUMmB/ZkibAdx+XdXJc+UZv0eYe5Vyo6G88c5T6TSb3q
    dQ+WhwOO+coxscDqlflsz3DWNtDSxlGjsIe89pMSeGLQE03D1afbSX3DZR3zi9Dl
    5oF25EoAfyg1qC0MJxGzQ2XhY5sF3jI+ytTV6EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122104; bh=pwFiuQ
    55WRC8uybvG3PKqAHxo4uWi8rkET+azixbcgA=; b=CNH57skrcoOvZKSaaR6ye4
    /XX2HoawFRQbVjZ/eUNW3Z5pxuoNu4pXoR6wuGddsiRyWRWazBANpHt0GJ6S3Dcl
    fczcMMaNZ4tvYzSSp5dixZyjS1FWHLNC2US4DpsJKcBAGsbRhUyKWhJNa5RLhi6w
    zTfIVgLBrfMkCzeq9CXycj1hbE+/5VM+5B7mFNnAVlSFgM06W7XZaRXg6Vvh2ItZ
    AU8KMC6Ui1eKSWwvDGU1A6q73EIZs8mspWx/E+HpxHHdG2W9cAK6PadcO31e4NXh
    zvU7DhWHc0RByQS+bXOqXSTy6ylGNk9q21GquMywHssaMO2cVY444t405KRCjdZQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mJQz7IkR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mJQz7IkR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932474AbeCDAIE (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:08:04 -0500
Received: from mail-sn1nam01on0122.outbound.protection.outlook.com ([104.47.32.122]:11440
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932936AbeCCWbH (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:31:07 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Gabriel Krisman Bertazi <krisman@collabora.co.uk>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 009/219] drm: qxl: Don't alloc fbdev if
 emulation is not supported
Thread-Topic: [PATCH AUTOSEL for 4.9 009/219] drm: qxl: Don't alloc fbdev if
 emulation is not supported
Thread-Index: AQHTsz7jYndRGsvLwkWT80iGGC8QnQ==
Date: Sat, 3 Mar 2018 22:28:00 +0000
Message-ID: <20180303222716.26640-9-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:AyvhCF8H83m4vGu7wzHdlNiViZPmkGKCfrO2uE0ET8G/2cbqxeXKvd9ko9BKikS0m13mCg8pa61PWMyllmrDC4NZEQeeSHgvIeJONOEFUvExBePoMOyRI1BTdzFh4JwTd6yWCKDOllFvQAsXkJW4S+fEORIKfp8l/g/36vhPA8Pcg5zumTo9KrVS+3+SQDTwy8nfwK4FyMeD8msWW6K9VYx1GGMTPwE52QejmZVbtCNHAdJenwb2DjrSpbGMw7Qt
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f8bcf307-cdfd-484c-292b-08d58156723c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09701EB1CDCF22AFD2C05442FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(86362001)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(966005)(7736002)(8676002)(6512007)(6306002)(81156014)(305945005)(72206003)(59450400001)(6436002)(53936002)(6116002)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 8C4dgXo6vPRU6i+V9CZ+Ulmn0bW+iB4ukvslLvpK6lhH2cD+tfkyA93caLqvAd84VSnUXh3dg68vISU+1Od3391pnsX/op/zFr7SYJUJXWYBo27IP/oStlqpQ2w3g9NgD0Q5/s+vl9uw5mbHfj6SsRpMvhm0uNE/R3Mgrgapy/I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8bcf307-cdfd-484c-292b-08d58156723c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:00.4787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Gabriel Krisman Bertazi <krisman@collabora.co.uk>

[ Upstream commit 861078381ba56b56808113736000d9e7ead349c8 ]

If fbdev emulation is disabled, the QXL shutdown path will try to clean
a framebuffer that wasn't initialized, hitting the Oops below.  The
problem is that even when FBDEV_EMULATION is disabled we allocate the
qfbdev strutucture, but we don't initialize it.  The fix is to stop
allocating the memory, since it won't be used.  This allows the existing
verification in the cleanup hook to do it's job preventing the oops.

Now that we don't allocate the unused fbdev structure, we need to be
careful when dereferencing it in the PM suspend hook.

[   24.284684] BUG: unable to handle kernel NULL pointer dereference at 000=
00000000002e0
[   24.285627] IP: mutex_lock+0x18/0x30
[   24.286049] PGD 78cdf067
[   24.286050] PUD 7940f067
[   24.286344] PMD 0
[   24.286649]
[   24.287072] Oops: 0002 [#1] SMP
[   24.287422] Modules linked in: qxl
[   24.287806] CPU: 0 PID: 2328 Comm: bash Not tainted 4.10.0-rc5+ #97
[   24.288515] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.9.3-20161025_171302-gandalf 04/01/2014
[   24.289681] task: ffff88007c4c0000 task.stack: ffffc90001b58000
[   24.290354] RIP: 0010:mutex_lock+0x18/0x30
[   24.290812] RSP: 0018:ffffc90001b5bcb0 EFLAGS: 00010246
[   24.291401] RAX: 0000000000000000 RBX: 00000000000002e0 RCX: 00000000000=
00000
[   24.292209] RDX: ffff88007c4c0000 RSI: 0000000000000001 RDI: 00000000000=
002e0
[   24.292987] RBP: ffffc90001b5bcb8 R08: fffffffffffffffe R09: 00000000000=
00001
[   24.293797] R10: ffff880078d80b80 R11: 0000000000011400 R12: 00000000000=
00000
[   24.294601] R13: 00000000000002e0 R14: ffffffffa0009c28 R15: 00000000000=
00060
[   24.295439] FS:  00007f30e3acbb40(0000) GS:ffff88007fc00000(0000) knlGS:=
0000000000000000
[   24.296364] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   24.296997] CR2: 00000000000002e0 CR3: 0000000078c7b000 CR4: 00000000000=
006f0
[   24.297813] Call Trace:
[   24.298097]  drm_framebuffer_cleanup+0x1f/0x70
[   24.298612]  qxl_fbdev_fini+0x68/0x90 [qxl]
[   24.299074]  qxl_modeset_fini+0xd/0x30 [qxl]
[   24.299562]  qxl_pci_remove+0x22/0x50 [qxl]
[   24.300025]  pci_device_remove+0x34/0xb0
[   24.300507]  device_release_driver_internal+0x150/0x200
[   24.301082]  device_release_driver+0xd/0x10
[   24.301587]  unbind_store+0x108/0x150
[   24.301993]  drv_attr_store+0x20/0x30
[   24.302402]  sysfs_kf_write+0x32/0x40
[   24.302827]  kernfs_fop_write+0x108/0x190
[   24.303269]  __vfs_write+0x23/0x120
[   24.303678]  ? security_file_permission+0x36/0xb0
[   24.304193]  ? rw_verify_area+0x49/0xb0
[   24.304636]  vfs_write+0xb0/0x190
[   24.305004]  SyS_write+0x41/0xa0
[   24.305362]  entry_SYSCALL_64_fastpath+0x1a/0xa9
[   24.305887] RIP: 0033:0x7f30e31d9620
[   24.306285] RSP: 002b:00007ffc54b47e68 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000001
[   24.307128] RAX: ffffffffffffffda RBX: 00007f30e3497600 RCX: 00007f30e31=
d9620
[   24.307928] RDX: 000000000000000d RSI: 0000000000da2008 RDI: 00000000000=
00001
[   24.308727] RBP: 000000000070bc60 R08: 00007f30e3498760 R09: 00007f30e3a=
cbb40
[   24.309504] R10: 0000000000000073 R11: 0000000000000246 R12: 00000000000=
00001
[   24.310295] R13: 0000000000000000 R14: 0000000000000000 R15: 00007ffc54b=
47f34
[   24.311095] Code: 0e 01 e9 7b fe ff ff 66 90 66 2e 0f 1f 84 00 00 00 00 =
00
55 48 89 e5 53 48 89 fb e8 83 e8 ff ff 65 48 8b 14 25 40 c4 00 00 31 c0 <3e=
>
48 0f b1 13 48 85 c0 74 08 48 89 df e8 66 fd ff ff 5b 5d c3
[   24.313182] RIP: mutex_lock+0x18/0x30 RSP: ffffc90001b5bcb0
[   24.313811] CR2: 00000000000002e0
[   24.314208] ---[ end trace 29669c1593cae14b ]---

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Link: http://patchwork.freedesktop.org/patch/msgid/20170227203330.18542-1-k=
risman@collabora.co.uk
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/qxl/qxl_fb.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_fb.c b/drivers/gpu/drm/qxl/qxl_fb.c
index 2cd879a4ae15..cdbb6e625f05 100644
--- a/drivers/gpu/drm/qxl/qxl_fb.c
+++ b/drivers/gpu/drm/qxl/qxl_fb.c
@@ -387,9 +387,11 @@ static const struct drm_fb_helper_funcs qxl_fb_helper_=
funcs =3D {
=20
 int qxl_fbdev_init(struct qxl_device *qdev)
 {
+	int ret =3D 0;
+
+#ifdef CONFIG_DRM_FBDEV_EMULATION
 	struct qxl_fbdev *qfbdev;
 	int bpp_sel =3D 32; /* TODO: parameter from somewhere? */
-	int ret;
=20
 	qfbdev =3D kzalloc(sizeof(struct qxl_fbdev), GFP_KERNEL);
 	if (!qfbdev)
@@ -423,6 +425,8 @@ fini:
 	drm_fb_helper_fini(&qfbdev->helper);
 free:
 	kfree(qfbdev);
+#endif
+
 	return ret;
 }
=20
@@ -438,6 +442,9 @@ void qxl_fbdev_fini(struct qxl_device *qdev)
=20
 void qxl_fbdev_set_suspend(struct qxl_device *qdev, int state)
 {
+	if (!qdev->mode_info.qfbdev)
+		return;
+
 	drm_fb_helper_set_suspend(&qdev->mode_info.qfbdev->helper, state);
 }
=20
--=20
2.14.1
