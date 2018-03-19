Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357373-1521480163-2-14783128640205250772
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
    t=1521480163; b=cCFfMHR0BBaNwN1jsv8lxWLLNiXt/gW/Cdt6AA+U/xcqtTY
    A6ZOAhp68EfocB/O7fS+oaVI3bd/Awg7MBdNqacfy50bv8OcWn6E7CFY659S5D+i
    9VzamRUSZSZfN6yKJ4JPXRB9KpaM1bycypKqyFI81WrAXV8ZAL7TaJNJYNfIwJ8Y
    MISOyaat01Ct4FE+H6UaiWFIDd73ugiMY+3SWR67drpreccxjxr32GHYmniayiJz
    weMRFiLQ+Y2TEOLi7WPpZk9+1apC5mFHpPZev/jJabUo6hxt85Kyh8oxm4Qpwzbh
    nk17GLJk1bYpxclRKaeNFk4zbxrsW3DD0kn6i3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480163; bh=1N1+tF
    TzSgueViVUSQfubZ0q4vduE+HZGc5OjtBGIQQ=; b=woZaeANEPo01BTh2PCOWqd
    OX98EF/QLPJQWyVSY9YDbB9kMoMP46FGuYV7RfMQZ5pcytBBsK2dKSiF62ua/rkv
    G8O9AAzaUpcN9HBc02pe2Z+awVkzHLgHC1AkqOiai6T6eAai8wkDzjf6Z0aY4UDs
    m1gTl5YhZzR7OqCRWgVYqVRYrYPVIs25B4I1xdaM9IiOo+flitHlqA8oxVv/kE0p
    9Z0FG106aIlVjIUd5S0dzKBnSJSDG95HYw83WtWDLYgGjoy9CkiFivo/rttL+qOW
    /EexWrUpcc874dWbbvqnaluCdH4gWpNVURUibEtHtnDHf6E/RqfV+oWWcWxBxaSg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=L7KdNYy8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduvdeljedvnecuvehluhhsthgvrhfuihiivgepudeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=L7KdNYy8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduvdeljedvnecuvehluhhsthgvrhfuihiivgepudeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968055AbeCSRVs (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:21:48 -0400
Received: from mail-by2nam01on0128.outbound.protection.outlook.com ([104.47.34.128]:46817
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966392AbeCSQJG (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:09:06 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Lin Zhang <xiaolou4617@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 068/167] net: ieee802154: fix net_device
 reference release too early
Thread-Topic: [PATCH AUTOSEL for 4.4 068/167] net: ieee802154: fix net_device
 reference release too early
Thread-Index: AQHTv5xHaYiAIj+0jkypYaWDKvCjFg==
Date: Mon, 19 Mar 2018 16:06:46 +0000
Message-ID: <20180319160513.16384-68-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0965;7:pcU13+o4rzhq5fKtIFCW98yrJDL1/XUu0iPvq/MxTUDwwRK93R5lZWVX5N98xub5PKDeRncjW7EKFtkHqFuFbSXr/ZKx/QKNmPb5IAqIuI8lPfBh79C5wk71mzZng1m8S3PXLBHJ8UnM1dOK4Xnqjh9JM8dDpkn71u9h/5mbl9SP7Z3sarDR9Ht5J0ggTfJ6Ee+g4t1qv9XBlLinWZ+age9WqVB8FAtlh1H4cNKRFie14S+vJTSzWB8bzOltI4DV;20:4oJsNdCmc034Ko+pntSNNz96B4femKM06siNPs6kSseb67vEsZdAwu5Z4SSPmBSy5gpWVl8JWQY92LG2HSS1AWJFaEcf9v0HdHXxPtUsNqyHlqRAOX/exQryCqp5ms1nSTAhMi/5W9Cc0z7WdGX5WHMmgLC/BEoUdnP96e9NOv0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ffa3227c-0241-4212-0e59-08d58db3b89e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0965;
x-ms-traffictypediagnostic: DM5PR2101MB0965:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09650C3230B03C137EC17B3DFBD40@DM5PR2101MB0965.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0965;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0965;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39860400002)(376002)(39380400002)(189003)(199004)(25786009)(7736002)(6506007)(86362001)(575784001)(86612001)(10090500001)(478600001)(53936002)(39060400002)(6666003)(6512007)(36756003)(2950100002)(8936002)(110136005)(54906003)(105586002)(14454004)(107886003)(72206003)(10290500003)(316002)(102836004)(2501003)(59450400001)(5250100002)(99286004)(22452003)(305945005)(6436002)(6486002)(1076002)(76176011)(26005)(4326008)(186003)(97736004)(114624004)(106356001)(3660700001)(3846002)(6116002)(5660300001)(68736007)(2900100001)(8676002)(81166006)(81156014)(3280700002)(2906002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0965;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: vjtSnpHDp7uIos7uxHZVBea8q/w+cFv9d5DV/QfiBCSuSrTeMzSN3Zjm3R8QH84gV5r9gsldN4bsvZ4T45TCJtVUbiB1SoMiCoEW4mPPwnU9TBsrYV5VWUk+qrnVr8XgWr39Xyev5QdI6U976pxinz7vIG/uehc0EpPdXxC+ntGg4RgDBsz+d+ZkeBjCvVonEYAPmIS1CeGEw9N1TNkCpBwfjxG+nDGtsrcF3zNBOeIwaaJS8e95aHLDn/4aX5dAGWEzUCMl6BrV9aCopglx5lfEhP6uZYi1vtW9blkZlCR0h/k4Yj+zHlrhn+zq4UxUj9vbWViZ3Ej04CebUyXAqw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa3227c-0241-4212-0e59-08d58db3b89e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:46.5771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0965
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Lin Zhang <xiaolou4617@gmail.com>

[ Upstream commit a611c58b3d42a92e6b23423e166dd17c0c7fffce ]

This patch fixes the kernel oops when release net_device reference in
advance. In function raw_sendmsg(i think the dgram_sendmsg has the same
problem), there is a race condition between dev_put and dev_queue_xmit
when the device is gong that maybe lead to dev_queue_ximt to see
an illegal net_device pointer.

My test kernel is 3.13.0-32 and because i am not have a real 802154
device, so i change lowpan_newlink function to this:

        /* find and hold real wpan device */
        real_dev =3D dev_get_by_index(src_net, nla_get_u32(tb[IFLA_LINK]));
        if (!real_dev)
                return -ENODEV;
//      if (real_dev->type !=3D ARPHRD_IEEE802154) {
//              dev_put(real_dev);
//              return -EINVAL;
//      }
        lowpan_dev_info(dev)->real_dev =3D real_dev;
        lowpan_dev_info(dev)->fragment_tag =3D 0;
        mutex_init(&lowpan_dev_info(dev)->dev_list_mtx);

Also, in order to simulate preempt, i change the raw_sendmsg function
to this:

        skb->dev =3D dev;
        skb->sk  =3D sk;
        skb->protocol =3D htons(ETH_P_IEEE802154);
        dev_put(dev);
        //simulate preempt
        schedule_timeout_uninterruptible(30 * HZ);
        err =3D dev_queue_xmit(skb);
        if (err > 0)
                err =3D net_xmit_errno(err);

and this is my userspace test code named test_send_data:

int main(int argc, char **argv)
{
        char buf[127];
        int sockfd;
        sockfd =3D socket(AF_IEEE802154, SOCK_RAW, 0);
        if (sockfd < 0) {
                printf("create sockfd error: %s\n", strerror(errno));
                return -1;
        }
        send(sockfd, buf, sizeof(buf), 0);
        return 0;
}

This is my test case:

root@zhanglin-x-computer:~/develop/802154# uname -a
Linux zhanglin-x-computer 3.13.0-32-generic #57-Ubuntu SMP Tue Jul 15
03:51:08 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux
root@zhanglin-x-computer:~/develop/802154# ip link add link eth0 name
lowpan0 type lowpan
root@zhanglin-x-computer:~/develop/802154#
//keep the lowpan0 device down
root@zhanglin-x-computer:~/develop/802154# ./test_send_data &
//wait a while
root@zhanglin-x-computer:~/develop/802154# ip link del link dev lowpan0
//the device is gone
//oops
[381.303307] general protection fault: 0000 [#1]SMP
[381.303407] Modules linked in: af_802154 6lowpan bnep rfcomm
bluetooth nls_iso8859_1 snd_hda_codec_hdmi snd_hda_codec_realtek
rts5139(C) snd_hda_intel
snd_had_codec snd_hwdep snd_pcm snd_page_alloc snd_seq_midi
snd_seq_midi_event snd_rawmidi snd_req intel_rapl snd_seq_device
coretemp i915 kvm_intel
kvm snd_timer snd crct10dif_pclmul crc32_pclmul ghash_clmulni_intel
cypted drm_kms_helper drm i2c_algo_bit soundcore video mac_hid
parport_pc ppdev ip parport hid_generic
usbhid hid ahci r8169 mii libahdi
[381.304286] CPU:1 PID: 2524 Commm: 1 Tainted: G C 0 3.13.0-32-generic
[381.304409] Hardware name: Haier Haier DT Computer/Haier DT Codputer,
BIOS FIBT19H02_X64 06/09/2014
[381.304546] tasks: ffff000096965fc0 ti: ffffB0013779c000 task.ti:
ffffB8013779c000
[381.304659] RIP: 0010:[<ffffffff01621fe1>] [<ffffffff81621fe1>]
__dev_queue_ximt+0x61/0x500
[381.304798] RSP: 0018:ffffB8013779dca0 EFLAGS: 00010202
[381.304880] RAX: 272b031d57565351 RBX: 0000000000000000 RCX: ffff8800968f1=
a00
[381.304987] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8800968f1=
a00
[381.305095] RBP: ffff8e013773dce0 R08: 0000000000000266 R09: 0000000000000=
004
[381.305202] R10: 0000000000000004 R11: 0000000000000005 R12: ffff88013902e=
000
[381.305310] R13: 000000000000007f R14: 000000000000007f R15: ffff8800968f1=
a00
[381.305418] FS:  00007fc57f50f740(0000) GS: ffff88013fc80000(0000)
knlGS: 0000000000000000
[381.305540] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[381.305627] CR2: 00007fad0841c000 CR3: 00000001368dd000 CR4: 0000000000100=
7e0
[361.905734] Stack:
[381.305768]  00000000002052d0 000000003facb30a ffff88013779dcc0
ffff880137764000
[381.305898]  ffff88013779de70 000000000000007f 000000000000007f
ffff88013902e000
[381.306026]  ffff88013779dcf0 ffffffff81622490 ffff88013779dd39
ffffffffa03af9f1
[381.306155] Call Trace:
[381.306202]  [<ffffffff81622490>] dev_queue_xmit+0x10/0x20
[381.306294]  [<ffffffffa03af9f1>] raw_sendmsg+0x1b1/0x270 [af_802154]
[381.306396]  [<ffffffffa03af054>] ieee802154_sock_sendmsg+0x14/0x20 [af_80=
2154]
[381.306512]  [<ffffffff816079eb>] sock_sendmsg+0x8b/0xc0
[381.306600]  [<ffffffff811d52a5>] ? __d_alloc+0x25/0x180
[381.306687]  [<ffffffff811a1f56>] ? kmem_cache_alloc_trace+0x1c6/0x1f0
[381.306791]  [<ffffffff81607b91>] SYSC_sendto+0x121/0x1c0
[381.306878]  [<ffffffff8109ddf4>] ? vtime_account_user+x54/0x60
[381.306975]  [<ffffffff81020d45>] ? syscall_trace_enter+0x145/0x250
[381.307073]  [<ffffffff816086ae>] SyS_sendto+0xe/0x10
[381.307156]  [<ffffffff8172c87f>] tracesys+0xe1/0xe6
[381.307233] Code: c6 a1 a4 ff 41 8b 57 78 49 8b 47 20 85 d2 48 8b 80
78 07 00 00 75 21 49 8b 57 18 48 85 d2 74 18 48 85 c0 74 13 8b 92 ac
01 00 00 <3b> 50 10 73 08 8b 44 90 14 41 89 47 78 41 f6 84 24 d5 00 00
00
[381.307801] RIP [<ffffffff81621fe1>] _dev_queue_xmit+0x61/0x500
[381.307901]  RSP <ffff88013779dca0>
[381.347512] Kernel panic - not syncing: Fatal exception in interrupt
[381.347747] drm_kms_helper: panic occurred, switching back to text console

In my opinion, there is always exist a chance that the device is gong
before call dev_queue_xmit.

I think the latest kernel is have the same problem and that
dev_put should be behind of the dev_queue_xmit.

Signed-off-by: Lin Zhang <xiaolou4617@gmail.com>
Acked-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ieee802154/socket.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index a548be247e15..47b397264f24 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -302,12 +302,12 @@ static int raw_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t size)
 	skb->sk  =3D sk;
 	skb->protocol =3D htons(ETH_P_IEEE802154);
=20
-	dev_put(dev);
-
 	err =3D dev_queue_xmit(skb);
 	if (err > 0)
 		err =3D net_xmit_errno(err);
=20
+	dev_put(dev);
+
 	return err ?: size;
=20
 out_skb:
@@ -689,12 +689,12 @@ static int dgram_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t size)
 	skb->sk  =3D sk;
 	skb->protocol =3D htons(ETH_P_IEEE802154);
=20
-	dev_put(dev);
-
 	err =3D dev_queue_xmit(skb);
 	if (err > 0)
 		err =3D net_xmit_errno(err);
=20
+	dev_put(dev);
+
 	return err ?: size;
=20
 out_skb:
--=20
2.14.1
