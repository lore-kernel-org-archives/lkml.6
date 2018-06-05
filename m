Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751727AbeFEJCu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 05:02:50 -0400
Received: from pic75-3-78-194-244-226.fbxo.proxad.net ([78.194.244.226]:44460
        "EHLO mail.corsac.net" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751481AbeFEJCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 05:02:47 -0400
Date: Tue, 5 Jun 2018 10:54:51 +0200
From: Yves-Alexis Perez <corsac@corsac.net>
To: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        David Windsor <dwindsor@gmail.com>, Kees Cook <keescook@chromium.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Mateusz Jurczyk <mjurczyk@google.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        David Herrmann <dh.herrmann@gmail.com>, netdev@vger.kernel.org,
        Alexander Kappner <agk@godking.net>,
        Johannes Berg <johannes.berg@intel.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Freeze when using ipheth+IPsec+IPv6
Message-ID: <20180605085450.GA3506@scapa.corsac.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PmA2V3Z32TCmWXqI
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

since some kernels releases (I didn't test thorougly but at least 4.16
and 4.17) I have regular freezes in certain situations on my laptop.

It seems to happen when I:

- tether using my iPhone (involving ipheth)
- mount an IPsec tunnel over IPv4
- run evolution to fetch my mail (IMAP traffic over IPv6 inside the IPv4
  IPsec tunnel)

When I do that, the interface seems to freeze. Last time the mouse was
still moving so the kernel didn't completely crash, but the UI was
completely irresponsive. I managed to get the attached log from
/sys/fs/pstore with refcount_t stuff pointing to an underflow.

Since this doesn't happen if all three conditions aren't met, I've added
a lot of people to the CC: list, sorry for the noise.

I can try to add debugging here and there if needed, but any pointer to
where would be helpful. I'm especially puzzled about the presence of
net/unix/af_unix.c:491 unix_sock_destructor+0x97/0xc0 in the log.

Regards,
--=20
Yves-Alexis

--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-crash.txt"
Content-Transfer-Encoding: quoted-printable

Oops#1 Part8
<4>[ 2189.388649] ------------[ cut here ]------------
<4>[ 2189.388652] refcount_t: underflow; use-after-free.
<4>[ 2189.388691] WARNING: CPU: 3 PID: 30 at /home/corsac/projets/linux/lin=
ux/lib/refcount.c:187 refcount_sub_and_test+0x3e/0x50
<4>[ 2189.388692] Modules linked in: esp4 xfrm6_mode_tunnel xfrm4_mode_tunn=
el ipheth bnep rtsx_pci_sdmmc iwlmvm snd_hda_codec_realtek snd_hda_codec_ge=
neric snd_hda_codec_hdmi iwlwifi snd_hda_intel rtsx_pci snd_hda_codec snd_h=
wdep snd_hda_core snd_pcm thinkpad_acpi efivarfs input_leds
<4>[ 2189.388713] CPU: 3 PID: 30 Comm: ksoftirqd/3 Tainted: G              =
  T 4.17.0 #22
<4>[ 2189.388714] Hardware name: LENOVO 20CMCTO1WW/20CMCTO1WW, BIOS N10ET48=
W (1.27 ) 09/12/2017
<4>[ 2189.388718] RIP: 0010:refcount_sub_and_test+0x3e/0x50
<4>[ 2189.388720] RSP: 0000:ffff93e640dabdc0 EFLAGS: 00010282
<4>[ 2189.388722] RAX: 0000000000000000 RBX: ffff8d00bac82000 RCX: 00000000=
00000006
<4>[ 2189.388723] RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff8d01=
4dd95610
<4>[ 2189.388724] RBP: ffff8d00bac82144 R08: 00000000000003b3 R09: 00000000=
00000004
<4>[ 2189.388725] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8d01=
4dda1100
<4>[ 2189.388726] R13: 0000000000000000 R14: 909c6c76983bd4d2 R15: 13146644=
b16dc153
<4>[ 2189.388728] FS:  0000000000000000(0000) GS:ffff8d014dd80000(0000) knl=
GS:0000000000000000
<4>[ 2189.388729] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[ 2189.388731] CR2: 0000755942c8c000 CR3: 000000006620a004 CR4: 00000000=
003606e0
<4>[ 2189.388732] Call Trace:
<4>[ 2189.388738]  sock_wfree+0x40/0x60
<4>[ 2189.388743]  unix_destruct_scm+0x7b/0xa0
<4>[ 2189.388747]  skb_release_head_state+0x59/0x90
<4>[ 2189.388751]  skb_release_all+0x9/0x20
<4>[ 2189.388753]  __kfree_skb_defer+0x19/0x50
Oops#1 Part7
<4>[ 2189.388757]  net_tx_action+0xf0/0x2d0
<4>[ 2189.388760]  __do_softirq+0xdb/0x220
<4>[ 2189.388766]  ? sort_range+0x20/0x20
<4>[ 2189.388768]  run_ksoftirqd+0x1f/0x30
<4>[ 2189.388771]  smpboot_thread_fn+0x11f/0x1e0
<4>[ 2189.388775]  kthread+0x109/0x120
<4>[ 2189.388779]  ? kthread_create_worker_on_cpu+0x70/0x70
<4>[ 2189.388783]  ret_from_fork+0x35/0x40
<4>[ 2189.388785] Code: c9 75 0c f0 0f b1 16 75 27 85 d2 0f 94 c0 c3 80 3d =
ab 82 f4 00 00 75 15 48 c7 c7 b8 a5 fd bd c6 05 9b 82 f4 00 01 e8 22 13 d4 =
ff <0f> 0b 31 c0 c3 83 f8 ff 75 bf eb f6 66 0f 1f 44 00 00 48 89 fe=20
<4>[ 2189.388825] ---[ end trace b06d93f176d25117 ]---
<4>[ 2189.388848] WARNING: CPU: 3 PID: 30 at /home/corsac/projets/linux/lin=
ux/net/unix/af_unix.c:491 unix_sock_destructor+0x97/0xc0
<4>[ 2189.388849] Modules linked in: esp4 xfrm6_mode_tunnel xfrm4_mode_tunn=
el ipheth bnep rtsx_pci_sdmmc iwlmvm snd_hda_codec_realtek snd_hda_codec_ge=
neric snd_hda_codec_hdmi iwlwifi snd_hda_intel rtsx_pci snd_hda_codec snd_h=
wdep snd_hda_core snd_pcm thinkpad_acpi efivarfs input_leds
<4>[ 2189.388866] CPU: 3 PID: 30 Comm: ksoftirqd/3 Tainted: G        W     =
  T 4.17.0 #22
<4>[ 2189.388867] Hardware name: LENOVO 20CMCTO1WW/20CMCTO1WW, BIOS N10ET48=
W (1.27 ) 09/12/2017
<4>[ 2189.388869] RIP: 0010:unix_sock_destructor+0x97/0xc0
<4>[ 2189.388871] RSP: 0000:ffff93e640dabda8 EFLAGS: 00010286
<4>[ 2189.388872] RAX: 0000000000000000 RBX: ffff8d00bac82000 RCX: 00000000=
00000000
<4>[ 2189.388873] RDX: 0000000000000001 RSI: 0000000000000282 RDI: 00000000=
00000282
<4>[ 2189.388875] RBP: ffff8d00bac82000 R08: ffff8d0084796430 R09: ffff93e6=
40dabd50
<4>[ 2189.388876] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8d01=
4dda1100
<4>[ 2189.388877] R13: 0000000000000000 R14: 909c6c76983bd4d2 R15: 13146644=
b16dc153
Oops#1 Part6
<4>[ 2189.388879] FS:  0000000000000000(0000) GS:ffff8d014dd80000(0000) knl=
GS:0000000000000000
<4>[ 2189.388880] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[ 2189.388881] CR2: 0000755942c8c000 CR3: 000000006620a004 CR4: 00000000=
003606e0
<4>[ 2189.388882] Call Trace:
<4>[ 2189.388886]  __sk_destruct+0x1f/0x140
<4>[ 2189.388888]  unix_destruct_scm+0x7b/0xa0
<4>[ 2189.388891]  skb_release_head_state+0x59/0x90
<4>[ 2189.388894]  skb_release_all+0x9/0x20
<4>[ 2189.388894] ------------[ cut here ]------------
<4>[ 2189.388896] refcount_t: addition on 0; use-after-free.
<4>[ 2189.388898]  __kfree_skb_defer+0x19/0x50
<4>[ 2189.388901]  net_tx_action+0xf0/0x2d0
<4>[ 2189.388906] WARNING: CPU: 0 PID: 1094 at /home/corsac/projets/linux/l=
inux/lib/refcount.c:102 refcount_add+0x26/0x30
<4>[ 2189.388907] Modules linked in: esp4
<4>[ 2189.388910]  __do_softirq+0xdb/0x220
<4>[ 2189.388911]  xfrm6_mode_tunnel
<4>[ 2189.388915]  ? sort_range+0x20/0x20
<4>[ 2189.388915]  xfrm4_mode_tunnel ipheth
<4>[ 2189.388918]  run_ksoftirqd+0x1f/0x30
<4>[ 2189.388918]  bnep
<4>[ 2189.388920]  smpboot_thread_fn+0x11f/0x1e0
<4>[ 2189.388921]  rtsx_pci_sdmmc
<4>[ 2189.388924]  kthread+0x109/0x120
<4>[ 2189.388925]  iwlmvm
<4>[ 2189.388927]  ? kthread_create_worker_on_cpu+0x70/0x70
<4>[ 2189.388928]  snd_hda_codec_realtek
<4>[ 2189.388932]  ret_from_fork+0x35/0x40
<4>[ 2189.388932]  snd_hda_codec_generic snd_hda_codec_hdmi
<4>[ 2189.388933] Code:=20
<4>[ 2189.388935]  iwlwifi
<4>[ 2189.388936] e8 ff=20
<4>[ 2189.388937]  snd_hda_intel rtsx_pci
<4>[ 2189.388938] f0 f2 ff 5b be=20
<4>[ 2189.388941]  snd_hda_codec snd_hwdep
<4>[ 2189.388942] 00 02=20
<4>[ 2189.388944]  snd_hda_core
<4>[ 2189.388944] 00 00=20
<4>[ 2189.388945]  snd_pcm thinkpad_acpi
Oops#1 Part5
<4>[ 2189.388947] 48=20
<4>[ 2189.388947]  efivarfs input_leds
<4>[ 2189.388949] c7=20
<4>[ 2189.388951] c7=20
<4>[ 2189.388952] CPU: 0 PID: 1094 Comm: Xorg Tainted: G        W       T 4=
=2E17.0 #22
<4>[ 2189.388953] Hardware name: LENOVO 20CMCTO1WW/20CMCTO1WW, BIOS N10ET48=
W (1.27 ) 09/12/2017
<4>[ 2189.388954] 5c=20
<4>[ 2189.388957] RIP: 0010:refcount_add+0x26/0x30
<4>[ 2189.388958] c3=20
<4>[ 2189.388959] RSP: 0018:ffff93e64167bbe0 EFLAGS: 00010286
<4>[ 2189.388960] 7b=20
<4>[ 2189.388961] RAX: 0000000000000000 RBX: ffff93e64167bc18 RCX: 00000000=
00000000
<4>[ 2189.388963] RDX: ffff8d014dc1c540 RSI: ffff8d014dc15618 RDI: ffff8d01=
4dc15618
<4>[ 2189.388963] bd=20
<4>[ 2189.388965] RBP: ffffffffbd0d1570 R08: 00000000000003e6 R09: 00000000=
00000004
<4>[ 2189.388966] R10: ffff8d01449ee000 R11: 0000000000000001 R12: ffff93e6=
4167bc94
<4>[ 2189.388967] 5d e9=20
<4>[ 2189.388969] R13: 0000000000000000 R14: 0000000000000000 R15: ffff8d00=
bac82000
<4>[ 2189.388970] FS:  00007559523e76c0(0000) GS:ffff8d014dc00000(0000) knl=
GS:0000000000000000
<4>[ 2189.388971] 2c 91=20
<4>[ 2189.388973] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[ 2189.388975] CR2: 00007e917c21a000 CR3: 00000002431c8002 CR4: 00000000=
003606f0
<4>[ 2189.388976] 8d=20
<4>[ 2189.388977] Call Trace:
<4>[ 2189.388977] ff 48 89 ef=20
<4>[ 2189.388983]  sock_alloc_send_pskb+0x20c/0x230
<4>[ 2189.388984] e8 24 73=20
<4>[ 2189.388987]  unix_stream_sendmsg+0x2bf/0x3d0
<4>[ 2189.388988] 9f ff eb be=20
<4>[ 2189.388993]  sock_sendmsg+0x31/0x40
<4>[ 2189.388994] 0f=20
<4>[ 2189.388996]  sock_write_iter+0x88/0xf0
<4>[ 2189.388997] 0b 48 83=20
<4>[ 2189.389002]  do_iter_readv_writev+0x147/0x1a0
<4>[ 2189.389005] 7b=20
<4>[ 2189.389007]  do_iter_write+0x81/0x1a0
<4>[ 2189.389008] 70=20
<4>[ 2189.389010]  vfs_writev+0xd1/0x160
<4>[ 2189.389011] 00 74=20
Oops#1 Part4
<4>[ 2189.389013]  ? __sys_recvmsg+0x71/0xb0
<4>[ 2189.389016]  ? __fget+0x6f/0xb0
<4>[ 2189.389016] 8b <0f> 0b=20
<4>[ 2189.389019]  ? do_writev+0x5c/0xf0
<4>[ 2189.389021]  do_writev+0x5c/0xf0
<4>[ 2189.389022] 48 83 bb=20
<4>[ 2189.389025]  do_syscall_64+0x72/0x1c0
<4>[ 2189.389026] 60=20
<4>[ 2189.389029]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
<4>[ 2189.389029] 02 00=20
<4>[ 2189.389031] RIP: 0033:0x75594f801017
<4>[ 2189.389033] RSP: 002b:00007ffdf628f130 EFLAGS: 00000293
<4>[ 2189.389033] 00=20
<4>[ 2189.389034]  ORIG_RAX: 0000000000000014
<4>[ 2189.389035] 00=20
<4>[ 2189.389037] RAX: ffffffffffffffda RBX: 000000000000004b RCX: 00007559=
4f801017
<4>[ 2189.389037] 74=20
<4>[ 2189.389039] RDX: 0000000000000001 RSI: 00007ffdf628f430 RDI: 00000000=
0000004b
<4>[ 2189.389039] 89=20
<4>[ 2189.389041] RBP: 00007ffdf628f430 R08: 0000000000000000 R09: 0000616b=
576c78e0
<4>[ 2189.389041] 0f=20
<4>[ 2189.389043] R10: 0000000000000001 R11: 0000000000000293 R12: 00000000=
00000001
<4>[ 2189.389043] 0b=20
<4>[ 2189.389045] R13: 00007ffdf628f430 R14: 0000000000000020 R15: 0000616b=
57691c80
<4>[ 2189.389046] eb 85=20
<4>[ 2189.389047] Code:=20
<4>[ 2189.389048] 48=20
<4>[ 2189.389049] 00 00=20
<4>[ 2189.389050] 89=20
<4>[ 2189.389051] 00=20
<4>[ 2189.389052] de=20
<4>[ 2189.389053] 00=20
<4>[ 2189.389054] 5b=20
<4>[ 2189.389055] 00=20
<4>[ 2189.389055] 48=20
<4>[ 2189.389057] e8 8b=20
<4>[ 2189.389058] ---[ end trace b06d93f176d25118 ]---
<4>[ 2189.389059] ff ff ff 84 c0 74 01 c3 80 3d 76 83 f4 00 00 75 f6 48 c7 =
c7 58 a5 fd bd c6 05 66 83 f4 00 01 e8 ea 13 d4 ff <0f> 0b c3 0f 1f 80 00 0=
0 00 00 8b=20
<4>[ 2189.389090] WARNING: CPU: 3 PID: 30 at /home/corsac/projets/linux/lin=
ux/net/unix/af_unix.c:492 unix_sock_destructor+0xa3/0xc0
<4>[ 2189.389090] Modules linked in:
<4>[ 2189.389091] 07=20
<4>[ 2189.389092]  esp4
<4>[ 2189.389093] 8d 50=20
Oops#1 Part3
<4>[ 2189.389094]  xfrm6_mode_tunnel
<4>[ 2189.389095] 01 85=20
<4>[ 2189.389097]  xfrm4_mode_tunnel
<4>[ 2189.389097] c0 74=20
<4>[ 2189.389099]  ipheth
<4>[ 2189.389100] 35 85=20
<4>[ 2189.389101]  bnep rtsx_pci_sdmmc
<4>[ 2189.389103] d2=20
<4>[ 2189.389104]  iwlmvm
<4>[ 2189.389106] ---[ end trace b06d93f176d25119 ]---
<4>[ 2189.389106]  snd_hda_codec_realtek snd_hda_codec_generic snd_hda_code=
c_hdmi iwlwifi snd_hda_intel rtsx_pci snd_hda_codec snd_hwdep snd_hda_core =
snd_pcm thinkpad_acpi efivarfs input_leds
<4>[ 2189.389116] CPU: 3 PID: 30 Comm: ksoftirqd/3 Tainted: G        W     =
  T 4.17.0 #22
<4>[ 2189.389117] Hardware name: LENOVO 20CMCTO1WW/20CMCTO1WW, BIOS N10ET48=
W (1.27 ) 09/12/2017
<4>[ 2189.389119] RIP: 0010:unix_sock_destructor+0xa3/0xc0
<4>[ 2189.389121] RSP: 0000:ffff93e640dabda8 EFLAGS: 00010286
<4>[ 2189.389123] RAX: 0000000000000000 RBX: ffff8d00bac82000 RCX: 00000000=
00000000
<4>[ 2189.389124] RDX: 0000000000000001 RSI: 0000000000000282 RDI: 00000000=
00000282
<4>[ 2189.389126] RBP: ffff8d00bac82000 R08: ffff8d0084796430 R09: ffff93e6=
40dabd50
<4>[ 2189.389127] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8d01=
4dda1100
<4>[ 2189.389128] R13: 0000000000000000 R14: 909c6c76983bd4d2 R15: 13146644=
b16dc153
<4>[ 2189.389130] FS:  0000000000000000(0000) GS:ffff8d014dd80000(0000) knl=
GS:0000000000000000
<4>[ 2189.389131] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[ 2189.389133] CR2: 0000755942c8c000 CR3: 000000006620a004 CR4: 00000000=
003606e0
<4>[ 2189.389134] Call Trace:
<4>[ 2189.389138]  __sk_destruct+0x1f/0x140
<4>[ 2189.389141]  unix_destruct_scm+0x7b/0xa0
<4>[ 2189.389145]  skb_release_head_state+0x59/0x90
<4>[ 2189.389148]  skb_release_all+0x9/0x20
<4>[ 2189.389150]  __kfree_skb_defer+0x19/0x50
<4>[ 2189.389153]  net_tx_action+0xf0/0x2d0
Oops#1 Part2
<4>[ 2189.389155]  __do_softirq+0xdb/0x220
<4>[ 2189.389159]  ? sort_range+0x20/0x20
<4>[ 2189.389163]  run_ksoftirqd+0x1f/0x30
<4>[ 2189.389165]  smpboot_thread_fn+0x11f/0x1e0
<4>[ 2189.389168]  kthread+0x109/0x120
<4>[ 2189.389171]  ? kthread_create_worker_on_cpu+0x70/0x70
<4>[ 2189.389174]  ret_from_fork+0x35/0x40
<4>[ 2189.389176] Code: c7 c7 5c c3 7b bd 5d e9 2c 91 8d ff 48 89 ef e8 24 =
73 9f ff eb be 0f 0b 48 83 7b 70 00 74 8b 0f 0b 48 83 bb 60 02 00 00 00 74 =
89 <0f> 0b eb 85 48 89 de 5b 48 c7 c7 60 78 05 be 5d e9 31 74 92 ff=20
<4>[ 2189.389222] ---[ end trace b06d93f176d2511a ]---
<6>[ 2189.389224] unix: Attempt to release alive unix socket: 000000003dc67=
149
<1>[ 2190.401779] BUG: unable to handle kernel paging request at ffffffffbd=
3e3680
<6>[ 2190.401785] PGD 6620c067 P4D 6620c067 PUD 6620d063 PMD 652000e1=20
<4>[ 2190.401790] Oops: 0003 [#1] PREEMPT SMP PTI
<4>[ 2190.401792] Modules linked in: esp4 xfrm6_mode_tunnel xfrm4_mode_tunn=
el ipheth bnep rtsx_pci_sdmmc iwlmvm snd_hda_codec_realtek snd_hda_codec_ge=
neric snd_hda_codec_hdmi iwlwifi snd_hda_intel rtsx_pci snd_hda_codec snd_h=
wdep snd_hda_core snd_pcm thinkpad_acpi efivarfs input_leds
<4>[ 2190.401806] CPU: 2 PID: 4119 Comm: evolution Tainted: G        W     =
  T 4.17.0 #22
<4>[ 2190.401808] Hardware name: LENOVO 20CMCTO1WW/20CMCTO1WW, BIOS N10ET48=
W (1.27 ) 09/12/2017
<4>[ 2190.401813] RIP: 0010:queued_spin_lock_slowpath+0xe4/0x1a0
<4>[ 2190.401815] RSP: 0018:ffff93e642373c60 EFLAGS: 00010282
<4>[ 2190.401817] RAX: ffffffffbd3e3680 RBX: 0000000000000008 RCX: ffff8d01=
4dd20880
<4>[ 2190.401818] RDX: 0000000000001084 RSI: 0000000042161000 RDI: ffff8d00=
bac82340
<4>[ 2190.401820] RBP: ffff8d00bac82340 R08: 00000000000c0000 R09: ffff8d01=
42385000
<4>[ 2190.401821] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8d01=
42385000
Oops#1 Part1
<4>[ 2190.401823] R13: 0000000000000000 R14: ffff8d00bac82000 R15: ffff8d01=
44916800
<4>[ 2190.401825] FS:  0000746978d9bf80(0000) GS:ffff8d014dd00000(0000) knl=
GS:0000000000000000
<4>[ 2190.401827] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[ 2190.401829] CR2: ffffffffbd3e3680 CR3: 00000001844d6005 CR4: 00000000=
003606e0
<4>[ 2190.401830] Call Trace:
<4>[ 2190.401835]  unix_stream_sendmsg+0x1df/0x3d0
<4>[ 2190.401839]  sock_sendmsg+0x31/0x40
<4>[ 2190.401842]  sock_write_iter+0x88/0xf0
<4>[ 2190.401846]  do_iter_readv_writev+0x147/0x1a0
<4>[ 2190.401848]  do_iter_write+0x81/0x1a0
<4>[ 2190.401851]  vfs_writev+0xd1/0x160
<4>[ 2190.401854]  ? __fget+0x6f/0xb0
<4>[ 2190.401857]  ? do_writev+0x5c/0xf0
<4>[ 2190.401859]  do_writev+0x5c/0xf0
<4>[ 2190.401863]  do_syscall_64+0x72/0x1c0
<4>[ 2190.401866]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
<4>[ 2190.401868] RIP: 0033:0x746973a7c017
<4>[ 2190.401870] RSP: 002b:00007ffd99341b60 EFLAGS: 00000293 ORIG_RAX: 000=
0000000000014
<4>[ 2190.401872] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007469=
73a7c017
<4>[ 2190.401873] RDX: 0000000000000003 RSI: 00007ffd99341d10 RDI: 00000000=
00000004
<4>[ 2190.401875] RBP: 00007ffd99341d10 R08: 0000000000000000 R09: 00000000=
00000000
<4>[ 2190.401876] R10: 00000000000000b0 R11: 0000000000000293 R12: 00000000=
00000003
<4>[ 2190.401878] R13: 00007ffd99341c94 R14: 000060ed17d42a98 R15: 00007ffd=
99341c98
<4>[ 2190.401880] Code: 89 c2 c1 e2 10 85 d2 0f 84 cc 00 00 00 c1 ea 12 83 =
e0 03 83 ea 01 48 c1 e0 04 48 63 d2 48 05 80 08 02 00 48 03 04 d5 80 54 06 =
be <48> 89 08 8b 41 08 85 c0 75 09 f3 90 8b 41 08 85 c0 74 f7 4c 8b=20
<1>[ 2190.401909] RIP: queued_spin_lock_slowpath+0xe4/0x1a0 RSP: ffff93e642=
373c60
<4>[ 2190.401910] CR2: ffffffffbd3e3680
<4>[ 2190.401912] ---[ end trace b06d93f176d2511b ]---

--ZGiS0Q5IWpPtfppv--

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE8vi34Qgfo83x35gF3rYcyPpXRFsFAlsWT9cACgkQ3rYcyPpX
RFvDvwf/ZYLeHSNcsy3zbYv+eIOj7mnsjNqmooHpNqm/7qYZFWyhPE7ZZfV18ljW
VybYVzvLQeF6H3ckQ5vgf1AjK9wj/AU+ljKEU+mNbBB2dcH1Y8fj3gNkru9ZSPE6
zzB6X3CqPXLxgA+ceHwatgXbKDqByPsAGc4ArWPUKeCKSoG4zSLAWDyxaJfDVMHi
Teb9uYg2DINRi9o+H8nj8pgA76c6KrRRvjFHqpHFN+PHv+eK5blOQFVGm6TWinNP
LNbKF8fRLg+1nZmU43UFLTpDRxxku6oqfel7PXr/CiA5NNwtO2DW6LqzD7qP1aOj
iLyk+5G5Dq5nE/w68Ae57yG0QU2oUw==
=qeX1
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
