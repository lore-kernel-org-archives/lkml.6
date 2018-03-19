Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521497192-2-15630550626451639121
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
    t=1521497191; b=uB8jVODGvHj5JCY+B1WC5rd7OpoyU//o3mEOHa8Rko/q3te
    GtCUnoSOjS0HJB+Vl1JMkD6rskbg7AUPFe6RdeW8RrwPl21FUtj1KSUvlDHeevlm
    wKy+rrp9onhy72k8Ccmc32TCQkErtJad9WN5SAyNpjjM1LZvXeaSoKzBSqB4G6Vr
    l6lwKRyIQ+q5I/AxfV7EDastLDAltDPy/rUQ0fzT1F/110OHipz2LwziWVHFSgM0
    VbwdwB/1EjEIi1570Si6Uc2gwzPNLTY4P0qGAWDTLlTmBrs851VrCkYaVKCrUTu4
    g4TlT/V6sQA/e/HdGKgvEPoJ0IBriQqa0erhKdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497191; bh=E89FAM
    Pz7O0ox7QG+WuBvQ4Dhr3u1e5ldWtQs6dVabs=; b=B4Dnam8zCBIELTiGls0fbo
    k/VJveEAjX+LCSzPQwoezzwyK4+8miH9WC56j23WE9MESNVPJZhJPfTQmlkG7dBe
    3I00nKGHIUe6cVJWZNYADFzckbWSubgmUpgQlM/rIxxAfDyt+pABH9GrlHP1fFlh
    OGsGL/xmme9n29VvMIB/gtnqANCzi4v08DKJU4Eh26K9mJIdImTMSNd8veAkv7Fr
    tJz7j3CEfWXF3dD3PzySdRZAkw1aqVO8Yisdy3XUj6NP1rZqcx0rKGgM87OdHk4G
    9Nu+nAPTuw1Rc3NDlo8LI876ZUXkTPbET0d/VUuByRyFYqZu2hzy+N/uSU+qOhEw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NXwAYUWC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutdejtdehnecuvehluhhsthgvrhfuihiivgepleef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NXwAYUWC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutdejtdehnecuvehluhhsthgvrhfuihiivgepleef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936231AbeCSWGZ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:06:25 -0400
Received: from mail-co1nam03on0099.outbound.protection.outlook.com ([104.47.40.99]:16428
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934319AbeCSPzF (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:55:05 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 27/97] media: videobuf2-core: don't go out of
 the buffer range
Thread-Topic: [PATCH AUTOSEL for 4.14 27/97] media: videobuf2-core: don't go
 out of the buffer range
Thread-Index: AQHTv5qi+1YQ+IDCNkiBie2CPO/4cQ==
Date: Mon, 19 Mar 2018 15:54:59 +0000
Message-ID: <20180319155411.12348-27-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0982;7:Ig1/VEUc7dmMN4gc9kIxSULwS4Z3z/erDwQffZU+r698DWHkYFdWEpXtOEY8/i29Og2Q2A/627IF7sQt822Zafh3uCUWlqLMSv30wkrrVniQgwqpaI1bAkNS8jQhuJpoO+2HhQbwr79nY6aFyXBgEub7WC22KW4ktyvTbfJWYxahiOPyaUfl5oI5TlqnptBGwv2NOMeOWCrzWrqJRXQkPSfsrj9T4VPWh7pZmtqCxkqb9Q1vTMcfhZMWP4zDP/L9;20:xSK8u1To3enh+Ira9SHTV8dlMmek8+49yTzVuOTXdN3o3GnnapCG/CtREJZ2bpU0DHkJ2PRogDV2JW9LlS2yQQKOZLAh4wKGDW1rd7CNgvMStKQ8IoBycxvGqxiWKoQQSn6MaG7sG+HI3T/ZuYJSi/LS7qMyEvJDwLstpeD3lH8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a05710d1-5714-49aa-f406-08d58db1c54f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0982;
x-ms-traffictypediagnostic: DM5PR2101MB0982:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0982D041B9110409780CC1B0FBD40@DM5PR2101MB0982.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0982;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0982;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(376002)(346002)(199004)(189003)(1076002)(106356001)(316002)(36756003)(76176011)(8936002)(81156014)(81166006)(22452003)(8676002)(3660700001)(59450400001)(2906002)(2900100001)(97736004)(305945005)(7736002)(53936002)(3280700002)(5660300001)(99286004)(107886003)(2501003)(5250100002)(2950100002)(10290500003)(25786009)(72206003)(3846002)(478600001)(54906003)(6116002)(4326008)(105586002)(14454004)(110136005)(6512007)(6506007)(10090500001)(102836004)(66066001)(68736007)(186003)(86612001)(6486002)(26005)(6436002)(86362001)(575784001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0982;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: YYE/z04PyyxwSh3QMhd3/Cc25fU7FBjejxrtytC6+DzHre8lIu+oKvBFm7Hznf8jYdywYoBtOmZWP7/bsmEZdYDb3hlgMUQRLsxFUbLJBhgQv3sMDCUqh6JPqEfCGGC4Bb2fedHPpM4DKPgqWKf2cG3wMwLZfJSCugGywDiLPh4naZ1h5Y/e+xuJTRdd9bsTyWtH/ZNaZBUWRzeP/AEVJB4KAksI6xgTDm0uzHr3WmJfTNw0I4kbRH3Gh+BQOQapP4S7im/gn4OPG/aR5NGOhPp++FbzxjtdDRTihqFIffkO8iGLWZ2TL/ePAHEtGKf/t2VkhnFvRjM7fvmFUuqTqw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a05710d1-5714-49aa-f406-08d58db1c54f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:54:59.9790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0982
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
index cb115ba6a1d2..6d9adcaa26ba 100644
--- a/drivers/media/v4l2-core/videobuf2-core.c
+++ b/drivers/media/v4l2-core/videobuf2-core.c
@@ -332,6 +332,10 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum=
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
