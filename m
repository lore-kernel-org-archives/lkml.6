Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520121405-2-11619426011295424861
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
    t=1520121405; b=kJ7hwNOPkXRHt3u/HzMmFRs1zKvWdU3zQp7BZeYFg3+Mxfe
    tKwa92GUDP0Ude2jvXx9wZmVgqoxkiOG+WYlMUW3I5mC7hNltOVxZxFIJXrHArri
    hlwFZDX5GItn8IusbZDmmRwvLgwWf6ZBCLv6sbBoc7I9OuH2iKyV+buT1qUngKZ9
    PcvPC4kSECbt6VY0ucE+ERGHjWxKqcLNpr83IzOMFs/rElTvm7mEwM1WYPDYaL68
    +4/Upqqr3P/gdR0D5Jc7wJhtIn8DGyjaRErodkAUJZN1sWiIUqcDBrzEPJR+wuz1
    89BRbhZIvBTbCd3PjG+LZcF4/a7CsC2ndJaBgqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121405; bh=qByOSP
    4vFOuGafcsS8XP3EhsszFv3K5S6+izYL7vRQ8=; b=iypuvX4wJZ47lF/bea4Yuf
    1QFtO8tvhYKi7TqbdT4ubD4eVdGdsiuc+4Xuaq+rANxP9XEArCm77B/vWQL5LWGq
    bHqO9p7H8HF1sNRZ7ew6B5fYGtMcgg2hQWTK8JAOY0qFFhJ/FU/fp1dpq88dbCWo
    4q6jbjohVCvYfgcHt1l/MVInRVHYffWnyUWUOfrE9gihaHsIJ+QqMe11rlaA8gls
    dRqoDf+fuqNIAqoR0i4AmazBo4LkA6AhykNqJwJ1hg/PVqU/fuBpmHXTXpvt23oK
    ltx3m+LLeoVGkSSqJEpud4ytBAfuuliZTpjA98BhzPPtkGCC5ThzQc9jkJh2iEIw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=d3SW8unV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=d3SW8unV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933854AbeCCWc3 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:32:29 -0500
Received: from mail-by2nam01on0120.outbound.protection.outlook.com ([104.47.34.120]:24496
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932419AbeCCWcV (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:32:21 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Anton Sviridenko <anton@corp.bluecherry.net>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 053/219] [media] solo6x10: release vb2 buffers
 in solo_stop_streaming()
Thread-Topic: [PATCH AUTOSEL for 4.9 053/219] [media] solo6x10: release vb2
 buffers in solo_stop_streaming()
Thread-Index: AQHTsz7ycBp8RaPA+UqsDR1FyAc+bA==
Date: Sat, 3 Mar 2018 22:28:26 +0000
Message-ID: <20180303222716.26640-53-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1036;7:yxwzo17cbBkNfblzFzLvF6NdwIcmnUAKFrg/nJRgd4N3BfisegEfl2NM/H9bYknZ9SuApAHWosDmQo9M6hFQy4LuaXlFtAyAMJeof+FjgQkUAZ2eXMWHvR0IOCgpiV2h+PSsrEUY2VKMDLO4AN3yEMiS0nJ0eo4vMy1ZQLg6voUTDd6guTJCRlzugC0FbiQ9XIuMohIK6mgezjO4j7v4cvkPgDtzRgzxp2jusZAWa45c8f/4qqrF1NA+Rfz8H7Bf
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 288607c9-8c5b-4934-9788-08d581569d32
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1036;
x-ms-traffictypediagnostic: MW2PR2101MB1036:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10361F4D5647B3DB848E0084FBC40@MW2PR2101MB1036.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(95692535739014);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1036;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1036;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(346002)(376002)(39860400002)(199004)(189003)(10290500003)(81166006)(5660300001)(107886003)(8936002)(81156014)(3846002)(6506007)(2906002)(8676002)(3280700002)(59450400001)(72206003)(76176011)(4326008)(478600001)(6116002)(6486002)(53936002)(1076002)(68736007)(6512007)(102836004)(2501003)(66066001)(3660700001)(5250100002)(6436002)(105586002)(86612001)(36756003)(316002)(7736002)(97736004)(26005)(186003)(110136005)(305945005)(22452003)(86362001)(99286004)(6666003)(25786009)(106356001)(2900100001)(14454004)(54906003)(10090500001)(2950100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1036;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 4dRRMLMnilBbWLZMH+ZNXsYq9NwygvliY3Q3CGyFCfZNpSMeOfjw81133Vo8AdgoKycGz/tt8qPE0dsYucQ24dzFX4jae3TFETu1eDTTRf5l9VHY6gcNd+gVOlhJrSBZvvJGvRUcEvaXfXh7XIa1JLMjocYsXgCaX326qZJmJ6E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 288607c9-8c5b-4934-9788-08d581569d32
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:26.7444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1036
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Anton Sviridenko <anton@corp.bluecherry.net>

[ Upstream commit 6e4c8480bd2eb95309ad3c875e11d2cad98f9188 ]

Fixes warning that appears in dmesg after closing V4L2 userspace
application that plays video from the display device
(first device from V4L2 device nodes provided by solo, usually /dev/video0
when no other V4L2 devices are present). Encoder device nodes are not
affected. Can be reproduced by starting and closing

ffplay -f video4linux2  /dev/video0

[ 8130.281251] ------------[ cut here ]------------
[ 8130.281256] WARNING: CPU: 1 PID: 20414 at drivers/media/v4l2-core/videob=
uf2-core.c:1651 __vb2_queue_cancel+0x14b/0x230
[ 8130.281257] Modules linked in: ipt_MASQUERADE nf_nat_masquerade_ipv4 ipt=
able_nat solo6x10 x86_pkg_temp_thermal vboxpci(O) vboxnetadp(O) vboxnetflt(=
O) vboxdrv(O)
[ 8130.281264] CPU: 1 PID: 20414 Comm: ffplay Tainted: G           O    4.1=
0.0-gentoo #1
[ 8130.281264] Hardware name: ASUS All Series/B85M-E, BIOS 2301 03/30/2015
[ 8130.281265] Call Trace:
[ 8130.281267]  dump_stack+0x4f/0x72
[ 8130.281270]  __warn+0xc7/0xf0
[ 8130.281271]  warn_slowpath_null+0x18/0x20
[ 8130.281272]  __vb2_queue_cancel+0x14b/0x230
[ 8130.281273]  vb2_core_streamoff+0x23/0x90
[ 8130.281275]  vb2_streamoff+0x24/0x50
[ 8130.281276]  vb2_ioctl_streamoff+0x3d/0x50
[ 8130.281278]  v4l_streamoff+0x15/0x20
[ 8130.281279]  __video_do_ioctl+0x25e/0x2f0
[ 8130.281280]  video_usercopy+0x279/0x520
[ 8130.281282]  ? v4l_enum_fmt+0x1330/0x1330
[ 8130.281285]  ? unmap_region+0xdf/0x110
[ 8130.281285]  video_ioctl2+0x10/0x20
[ 8130.281286]  v4l2_ioctl+0xce/0xe0
[ 8130.281289]  do_vfs_ioctl+0x8b/0x5b0
[ 8130.281290]  ? __fget+0x72/0xa0
[ 8130.281291]  SyS_ioctl+0x74/0x80
[ 8130.281294]  entry_SYSCALL_64_fastpath+0x13/0x94
[ 8130.281295] RIP: 0033:0x7ff86fee6b27
[ 8130.281296] RSP: 002b:00007ffe467f6a08 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[ 8130.281297] RAX: ffffffffffffffda RBX: 00000000d1a4d788 RCX: 00007ff86fe=
e6b27
[ 8130.281297] RDX: 00007ffe467f6a14 RSI: 0000000040045613 RDI: 00000000000=
00006
[ 8130.281298] RBP: 000000000373f8d0 R08: 00000000ffffffff R09: 00007ff8600=
01140
[ 8130.281298] R10: 0000000000000243 R11: 0000000000000246 R12: 00000000000=
00000
[ 8130.281299] R13: 00000000000000a0 R14: 00007ffe467f6530 R15: 0000000001f=
32228
[ 8130.281300] ---[ end trace 00695dc96be646e7 ]---

Signed-off-by: Anton Sviridenko <anton@corp.bluecherry.net>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/pci/solo6x10/solo6x10-v4l2.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/media/pci/solo6x10/solo6x10-v4l2.c b/drivers/media/pci=
/solo6x10/solo6x10-v4l2.c
index b4be47969b6b..e17d6b945c07 100644
--- a/drivers/media/pci/solo6x10/solo6x10-v4l2.c
+++ b/drivers/media/pci/solo6x10/solo6x10-v4l2.c
@@ -341,6 +341,17 @@ static void solo_stop_streaming(struct vb2_queue *q)
 	struct solo_dev *solo_dev =3D vb2_get_drv_priv(q);
=20
 	solo_stop_thread(solo_dev);
+
+	spin_lock(&solo_dev->slock);
+	while (!list_empty(&solo_dev->vidq_active)) {
+		struct solo_vb2_buf *buf =3D list_entry(
+				solo_dev->vidq_active.next,
+				struct solo_vb2_buf, list);
+
+		list_del(&buf->list);
+		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
+	}
+	spin_unlock(&solo_dev->slock);
 	INIT_LIST_HEAD(&solo_dev->vidq_active);
 }
=20
--=20
2.14.1
