Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521475797-2-5158594264711055346
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521475796; b=dqBq+WLkqAokPx6d9gPKXU6FNw1yCNSTbhiFTfH3ZqpcEuc
    N1wt+X8CbTmx2bX0Vc0NGvIPpNjg1fLMFkYFKLlx/Gua5QY+mdfjBAf2OmC43A0B
    NHRdCHvlYv99REL9ULaK3mHVkoMqiO0uXfvXC83eLwNXrWyiJlUucdcBNBQKP+Sk
    JwOzXgG2ervANDYLp4r/wa31NFymQ5f5I94svLHPqXqjjefkczCci2Wc5Z8eWcI0
    c7Wau+3AS70Pm1ZP0OM0wiPdVHM/scrD6qZmeEdLx3Roh0TEJAWD200BH3RpPtu0
    nvIPcGUjhPP5Gh6dDou6+NrZDzUGiCDyjgNxwdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475796; bh=zVUWzI
    YmEC5yqQlRiHdIrqpDQWW6SJrYMNZVnzYRemU=; b=aadw1AVrfNp2qBF4qOsYjP
    cPlNw0QIuhe9I6NRU/1LElM6njrpJQMGLAn3ksCc0KpWvQ/im/sFVbqOOj9d91a5
    sQrxg2CLMoYDV7HKSQSYd7MXK2Si7on6luomO1ovVSSpUhfqzrUB/P1fdkz68eIk
    L0WkPCTC10tLj4s3aOULb4eNXVR+Mk0YTnkBsTCh463hUbkKQO6uXJAdajyrR6R/
    LFDa5FSSM9C+jz3WcRa30Yw6Tgzspv5W/KkC56M5VxkjumrmlAks22yCi6ui85p3
    t5RExEwB+Kwv5dntjcWHTCqYPhJR6tm6nKUgzdSa89IIcEhgcQ1D1AK7CoJClKOw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kyXek/m9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepuddtieejudenucevlhhushhtvghrufhiiigvpeduvdej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kyXek/m9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepuddtieejudenucevlhhushhtvghrufhiiigvpeduvdej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966518AbeCSQJt (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:09:49 -0400
Received: from mail-sn1nam01on0124.outbound.protection.outlook.com ([104.47.32.124]:21024
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966441AbeCSQJU (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:09:20 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 088/167] media: videobuf2-core: don't go out
 of the buffer range
Thread-Topic: [PATCH AUTOSEL for 4.4 088/167] media: videobuf2-core: don't go
 out of the buffer range
Thread-Index: AQHTv5xXWe5gu8coakiypHsvsYDg1A==
Date: Mon, 19 Mar 2018 16:07:12 +0000
Message-ID: <20180319160513.16384-88-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:YEiAiBwcRZ0VFzE/DzsngzP/FyGUnd+0TgsQt9jOt1mkVT6Rac9VaOEZx9JVbYBDcaEdbxUBMVsNL9SsdKQBFFpceFFulOU2rrqpRoha89UMBlxlczO87VR6DuUqiUUTxjJjfNEbPNCx5lJwS/Ta3GijEcpz2hEAtClb2KdFqtntuUJtifYwa5YRUm1bEl7ir0+VXC+tQEjfkjCGwfcXv9BOgY1o6OQIlLmltij3BzcJ1HBaUC0k8CETVklWqzzY;20:4Vj7kdIf8X6NDx6uf6HEBPyzbuE0jcDBpGpktmh9aczfXAXPdmp7SovFcktdKWWzdWEV6lfB8Wkq5jhrV/dcmIU9U8otsL0SECyuUqlu6pvNnyGhsVkSVvS8bKiKITguPqs5ZVs8yRl6BerKqmYWGJ6glrZu/foqYouUMF68/ls=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 71086874-2fa1-4014-0c19-08d58db3bec4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0902935EF63122BDBE827D24FBD40@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(396003)(39380400002)(376002)(199004)(189003)(4326008)(305945005)(7736002)(66066001)(105586002)(316002)(8676002)(25786009)(8936002)(6666003)(2950100002)(5660300001)(97736004)(81166006)(81156014)(3280700002)(22452003)(99286004)(186003)(2906002)(76176011)(5250100002)(59450400001)(54906003)(10090500001)(110136005)(6116002)(2900100001)(3846002)(2501003)(1076002)(86612001)(107886003)(106356001)(6436002)(6512007)(575784001)(86362001)(53936002)(6506007)(6486002)(26005)(14454004)(10290500003)(102836004)(68736007)(3660700001)(478600001)(72206003)(36756003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: jedTgzpWH1gI48XVddDbtCdVmm1Yn3nIGr3BDxsk+1GccMx8wEDSb5qckUCVEf+Nlq97sU3cKTK6pVaTG2xmOm+PCtYOsnUmDsJ12FsV+sID7eJnnp6i7TPqi1C9XyqRT10XOwehUbaTKJltwPGIPczI0dxKEK6oZzCWZ9aNd0irOTP1HLqCKkv3H8B6mEft+PsktROYxOv3C5sP1UWZ/6JMuL9oDtEkyeafy3UC4LRCIk0p/7I5v+MRbmy9+aEyiH4Twv25ubaZqZUHbqrgFdJwPUo0fX19XlaCJtsT4qydhlrHSJqekZutPgoOSic39Lun8uwav57F2bjYDYZWiA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71086874-2fa1-4014-0c19-08d58db3bec4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:12.3223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mauro Carvalho Chehab <mchehab@s-opensource.com>

[ Upstream commit df93dc61b0d8b19a5c9db545cf3fcc24f88dfde4 ]

Currently, there's no check if an invalid buffer range
is passed. However, while testing DVB memory mapped apps,
I got this:

   videobuf2_core: VB: num_buffers -2143943680, buffer 33, index -214394364=
7
   unable to handle kernel paging request at ffff888b773c0890
   IP: __vb2_queue_alloc+0x134/0x4e0 [videobuf2_core]
   PGD 4142c7067 P4D 4142c7067 PUD 0
   Oops: 0002 [#1] SMP
   Modules linked in: xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masq=
uerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4=
 xt_conntrack nf_conntrack tun bridge stp llc ebtable_filter ebtables ip6ta=
ble_filter ip6_tables bluetooth rfkill ecdh_generic binfmt_misc rc_dvbsky s=
p2 ts2020 intel_rapl x86_pkg_temp_thermal dvb_usb_dvbsky intel_powerclamp d=
vb_usb_v2 coretemp m88ds3103 kvm_intel i2c_mux dvb_core snd_hda_codec_hdmi =
crct10dif_pclmul crc32_pclmul videobuf2_vmalloc videobuf2_memops snd_hda_in=
tel ghash_clmulni_intel videobuf2_core snd_hda_codec rc_core mei_me intel_c=
state snd_hwdep snd_hda_core videodev intel_uncore snd_pcm mei media tpm_ti=
s tpm_tis_core intel_rapl_perf tpm snd_timer lpc_ich snd soundcore kvm irqb=
ypass libcrc32c i915 i2c_algo_bit drm_kms_helper
   e1000e ptp drm crc32c_intel video pps_core
   CPU: 3 PID: 1776 Comm: dvbv5-zap Not tainted 4.14.0+ #78
   Hardware name:                  /NUC5i7RYB, BIOS RYBDWi35.86A.0364.2017.=
0511.0949 05/11/2017
   task: ffff88877c73bc80 task.stack: ffffb7c402418000
   RIP: 0010:__vb2_queue_alloc+0x134/0x4e0 [videobuf2_core]
   RSP: 0018:ffffb7c40241bc60 EFLAGS: 00010246
   RAX: 0000000080360421 RBX: 0000000000000021 RCX: 000000000000000a
   RDX: ffffb7c40241bcf4 RSI: ffff888780362c60 RDI: ffff888796d8e130
   RBP: ffffb7c40241bcc8 R08: 0000000000000316 R09: 0000000000000004
   R10: ffff888780362c00 R11: 0000000000000001 R12: 000000000002f000
   R13: ffff8887758be700 R14: 0000000000021000 R15: 0000000000000001
   FS:  00007f2849024740(0000) GS:ffff888796d80000(0000) knlGS:000000000000=
0000
   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
   CR2: ffff888b773c0890 CR3: 000000043beb2005 CR4: 00000000003606e0
   Call Trace:
    vb2_core_reqbufs+0x226/0x420 [videobuf2_core]
    dvb_vb2_reqbufs+0x2d/0xc0 [dvb_core]
    dvb_dvr_do_ioctl+0x98/0x1d0 [dvb_core]
    dvb_usercopy+0x53/0x1b0 [dvb_core]
    ? dvb_demux_ioctl+0x20/0x20 [dvb_core]
    ? tty_ldisc_deref+0x16/0x20
    ? tty_write+0x1f9/0x310
    ? process_echoes+0x70/0x70
    dvb_dvr_ioctl+0x15/0x20 [dvb_core]
    do_vfs_ioctl+0xa5/0x600
    SyS_ioctl+0x79/0x90
    entry_SYSCALL_64_fastpath+0x1a/0xa5
   RIP: 0033:0x7f28486f7ea7
   RSP: 002b:00007ffc13b2db18 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
   RAX: ffffffffffffffda RBX: 000055b10fc06130 RCX: 00007f28486f7ea7
   RDX: 00007ffc13b2db48 RSI: 00000000c0086f3c RDI: 0000000000000007
   RBP: 0000000000000203 R08: 000055b10df1e02c R09: 000000000000002e
   R10: 0036b42415108357 R11: 0000000000000246 R12: 0000000000000000
   R13: 00007f2849062f60 R14: 00000000000001f1 R15: 00007ffc13b2da54
   Code: 74 0a 60 8b 0a 48 83 c0 30 48 83 c2 04 89 48 d0 89 48 d4 48 39 f0 =
75 eb 41 8b 42 08 83 7d d4 01 41 c7 82 ec 01 00 00 ff ff ff ff <4d> 89 94 c=
5 88 00 00 00 74 14 83 c3 01 41 39 dc 0f 85 f1 fe ff
   RIP: __vb2_queue_alloc+0x134/0x4e0 [videobuf2_core] RSP: ffffb7c40241bc6=
0
   CR2: ffff888b773c0890

So, add a sanity check in order to prevent going past array.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/v4l2-core/videobuf2-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/v4l2-core/videobuf2-core.c b/drivers/media/v4l2-=
core/videobuf2-core.c
index 3dc9ed2e0774..bb1e19f7ed5a 100644
--- a/drivers/media/v4l2-core/videobuf2-core.c
+++ b/drivers/media/v4l2-core/videobuf2-core.c
@@ -205,6 +205,10 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum=
 vb2_memory memory,
 	struct vb2_buffer *vb;
 	int ret;
=20
+	/* Ensure that q->num_buffers+num_buffers is below VB2_MAX_FRAME */
+	num_buffers =3D min_t(unsigned int, num_buffers,
+			    VB2_MAX_FRAME - q->num_buffers);
+
 	for (buffer =3D 0; buffer < num_buffers; ++buffer) {
 		/* Allocate videobuf buffer structures */
 		vb =3D kzalloc(q->buf_struct_size, GFP_KERNEL);
--=20
2.14.1
