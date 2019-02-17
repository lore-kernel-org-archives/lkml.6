Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F529C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C4C217D9
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="lB3HPcTL";
	dkim=pass (1024-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="lB3HPcTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfBQXkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 18:40:21 -0500
Received: from fallback13.mail.ru ([94.100.179.30]:38000 "EHLO
        fallback13.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfBQXkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 18:40:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail;
        h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date; bh=sBlfSc+pcjRs/EHzZl5cv2iB4NVpJCTExYZkQQo9gus=;
        b=lB3HPcTLfMqrFP2MatnB3eKa/D6YzE6y/G0oThPnsaCzLpiM9LHhcHQe54cOu6NoIL3coEzJIJP8rp3rwlBIbGXO70NUkumaWp7LTwvxQNJbbShDRNOEpL6912Sgh5ODGMBzNuixp35oFLWXfetPRhtnlOyQRNcz5z0RvqNNx2w=;
Received: from [10.161.64.42] (port=49756 helo=smtp34.i.mail.ru)
        by fallback13.m.smailru.net with esmtp (envelope-from <slyfox@inbox.ru>)
        id 1gvW2i-0004dF-Eb
        for linux-kernel@vger.kernel.org; Mon, 18 Feb 2019 02:40:16 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail;
        h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date; bh=sBlfSc+pcjRs/EHzZl5cv2iB4NVpJCTExYZkQQo9gus=;
        b=lB3HPcTLfMqrFP2MatnB3eKa/D6YzE6y/G0oThPnsaCzLpiM9LHhcHQe54cOu6NoIL3coEzJIJP8rp3rwlBIbGXO70NUkumaWp7LTwvxQNJbbShDRNOEpL6912Sgh5ODGMBzNuixp35oFLWXfetPRhtnlOyQRNcz5z0RvqNNx2w=;
Received: by smtp34.i.mail.ru with esmtpa (envelope-from <slyfox@inbox.ru>)
        id 1gvW2W-0008DU-4I; Mon, 18 Feb 2019 02:40:04 +0300
Date:   Sun, 17 Feb 2019 23:39:57 +0000
From:   Sergei Trofimovich <slyfox@inbox.ru>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: 5.0.0-rc6+: Oops at boot: RIP: 0010:__memmove+0x81/0x1a0 /
 vt_do_kdgkb_ioctl+0x34d/0x440 (race at reenter?)
Message-ID: <20190217233957.2a38d0af@sf>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/hC5V_Dycw0lipgjlZEbfA00"; protocol="application/pgp-signature"
X-77F55803: E14BCC6235C710295A78504BD2AC29413D18B887867A1A826C6742534F912EAB75DF9CE939FDCFA5E8697BF39D2A51B3
X-7FA49CB5: 0D63561A33F958A5829D5F9EB2851787E9DFCEAA09504DF5457A8BC609F645078941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249FA31AF570DAA8E083AA81AA40904B5D9CF19DD082D7633A0E7DDDDC251EA7DABD81D268191BDAD3D78DA827A17800CE7C69C5C0DDE134364CD04E86FAF290E2D40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE7BCE7509F642C2B6CF7DC21D0BE44328775ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF5797B92FCB1594A39500306258E7E6ABB4E4A6367B16DE6309
X-Mailru-Sender: 8A2FA48DD8FD9C2B10BBEF7DB3CB145FFDD87B33F7B78CEEF80B8B86EC206DE07DCC2443F5992A76B0C293124EE1F8E466FEC6BF5C9C28D9BE1658B246A3ACF810B29241573AA60767EA787935ED9F1B
X-Mras: OK
X-77F55803: 5241C2F38277A35D7F9F52485CB584D7271FD7DF62800FDC089DA90677212B83DDB1F83CD7ABF1FC035B8B102850E303BC77B4210FEEA50D
X-7FA49CB5: 0D63561A33F958A55FBD1520A28DCA57D6A118F359EC4AC9B07B4DCDE73FCB6B8941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F93F060FBA3C93C613B503F486389A921A5CC5B56E945C8DA
X-Mailru-MI: 800
X-Mailru-Sender: A5480F10D64C90056DE2D996C7A19556C93FE09636A08353DDB1F83CD7ABF1FCE23824BA0C9766A738F48B1DF051BE983DDE9B364B0DF28966D7C7C3F77E58D71B4ECFBB0E18FD14AE208404248635DF
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hC5V_Dycw0lipgjlZEbfA00
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

[ Copying as is from https://bugzilla.kernel.org/show_bug.cgi?id=3D202605
  and sending to LKML. Greg, Jiri, can you clarify mailing
  list im  MAINTAINERS as well?
      https://github.com/torvalds/linux/blob/master/MAINTAINERS#L15527
  mentions no list for tty/vt/. ]

Kernel Oops
  [   38.739241] Oops: 0003 [#1] PREEMPT SMP
  [   38.739243] CPU: 6 PID: 388 Comm: loadkeys Tainted: G         C       =
 5.0.0-rc6-00153-g5ded5871030e #91
  [   38.739244] Hardware name: Gigabyte Technology Co., Ltd. To be filled =
by O.E.M./H77M-D3H, BIOS F12 11/14/2013
  [   38.739249] RIP: 0010:__memmove+0x81/0x1a0
happes on a fresh vanilla master kernel roughly at boot
(before tty login prompt):
  $ uname -r
  5.0.0-rc6-00153-g5ded5871030e

The kernel page fault happens at 'loadkeys start'.
I suspect some kind of race at reenter of vt_do_kdgkb_ioctl(KDSKBSENT):
    https://github.com/torvalds/linux/blob/master/drivers/tty/vt/keyboard.c=
#L1986

The oops trace looks similar to the following reports (no details besides O=
ops)
    https://bugzilla.kernel.org/show_bug.cgi?id=3D194589
    https://bugzilla.kernel.org/show_bug.cgi?id=3D202111

[   38.044921] IPv6: ADDRCONF(NETDEV_CHANGE): br0: link becomes ready
[   38.533196] usb 1-1.2: r8712u: CustomerID =3D 0x0000
[   38.533200] usb 1-1.2: r8712u: MAC Address from efuse =3D 00:0d:81:a9:09=
:90
[   38.533203] usb 1-1.2: r8712u: Loading firmware from "rtlwifi/rtl8712u.b=
in"
[   38.533331] usbcore: registered new interface driver r8712u
[   38.736178] BUG: unable to handle kernel paging request at ffff9c8735448=
000
[   38.737215] #PF error: [PROT] [WRITE]
[   38.737216] PGD 288a05067 P4D 288a05067 PUD 288a07067 PMD 7f60c2063 PTE =
80000007f5448161
[   38.739241] Oops: 0003 [#1] PREEMPT SMP
[   38.739243] CPU: 6 PID: 388 Comm: loadkeys Tainted: G         C        5=
.0.0-rc6-00153-g5ded5871030e #91
[   38.739244] Hardware name: Gigabyte Technology Co., Ltd. To be filled by=
 O.E.M./H77M-D3H, BIOS F12 11/14/2013
[   38.739249] RIP: 0010:__memmove+0x81/0x1a0
[   38.739251] Code: 4c 89 4f 10 4c 89 47 18 48 8d 7f 20 73 d4 48 83 c2 20 =
e9 a2 00 00 00 66 90 48 89 d1 4c 8b 5c 16 f8 4c 8d 54 17 f8 48 c1 e9 03 <f3=
> 48 a5 4d 89 1a e9 0c 01 00 00 0f 1f 40 00 48 89 d1 4c 8b 1e 49
[   38.739252] RSP: 0018:ffffa1b9002d7d08 EFLAGS: 00010203
[   38.745857] RAX: ffff9c873541af43 RBX: ffff9c873541af43 RCX: 00000c6f105=
cd6bf
[   38.745858] RDX: 0000637882e986b6 RSI: ffff9c8735447ffb RDI: ffff9c87354=
47ffb
[   38.745859] RBP: ffff9c8739cd3800 R08: ffff9c873b802f00 R09: 00000000fff=
ff73b
[   38.745860] R10: ffffffffb82b35f1 R11: 00505b1b004d5b1b R12: 00000000000=
00000
[   38.745861] R13: ffff9c873541af3d R14: 000000000000000b R15: 00000000000=
0000c
[   38.745862] FS:  00007f450c390580(0000) GS:ffff9c873f180000(0000) knlGS:=
0000000000000000
[   38.745863] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   38.745864] CR2: ffff9c8735448000 CR3: 00000007e213c002 CR4: 00000000000=
606e0
[   38.745865] Call Trace:
[   38.745871]  vt_do_kdgkb_ioctl+0x34d/0x440
[   38.745875]  vt_ioctl+0xba3/0x1190
[   38.745879]  ? __bpf_prog_run32+0x39/0x60
[   38.745882]  ? mem_cgroup_commit_charge+0x7b/0x4e0
[   38.762583]  tty_ioctl+0x23f/0x920
[   38.762586]  ? preempt_count_sub+0x98/0xe0
[   38.762590]  ? __seccomp_filter+0x67/0x600
[   38.762594]  do_vfs_ioctl+0xa2/0x6a0
[   38.762597]  ? syscall_trace_enter+0x192/0x2d0
[   38.762599]  ksys_ioctl+0x3a/0x70
[   38.762601]  __x64_sys_ioctl+0x16/0x20
[   38.762604]  do_syscall_64+0x54/0xe0
[   38.772513]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   38.772515] RIP: 0033:0x7f450c2bb427
[   38.772517] Code: 00 00 00 75 0c 48 c7 c0 ff ff ff ff 48 83 c4 18 c3 e8 =
8d d2 01 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 b8 10 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 da 0c 00 f7 d8 64 89 01 48
[   38.772518] RSP: 002b:00007fffbcedd348 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[   38.772519] RAX: ffffffffffffffda RBX: 000000000000000b RCX: 00007f450c2=
bb427
[   38.772520] RDX: 00007fffbcedd360 RSI: 0000000000004b49 RDI: 00000000000=
00003
[   38.772521] RBP: 00007fffbcedd361 R08: 00007f450c389c40 R09: 000055cbef2=
494a0
[   38.772522] R10: 0000000000000000 R11: 0000000000000246 R12: 000055cbef2=
412b0
[   38.772522] R13: 00007fffbcedd360 R14: 000000000000000b R15: 00000000000=
00003
[   38.772525] Modules linked in: snd_hda_codec_hdmi bridge r8712u(C) stp l=
lc snd_hda_codec_via snd_hda_codec_generic snd_hda_intel snd_hda_codec x86_=
pkg_temp_thermal dummy kvm_intel snd_hwdep snd_hda_core snd_pcm snd_timer k=
vm snd atl1c soundcore irqbypass xfs tun nf_conntrack_ftp nf_conntrack nf_d=
efrag_ipv6 nf_defrag_ipv4 loop fuse binfmt_misc ipv6
[   38.779196] r8712u 1-1.2:1.0 wl0: renamed from wlan0
[   38.779240] CR2: ffff9c8735448000
[   38.790894] ---[ end trace 8116e48ba19076a0 ]---
[   38.790897] RIP: 0010:__memmove+0x81/0x1a0
[   38.790898] Code: 4c 89 4f 10 4c 89 47 18 48 8d 7f 20 73 d4 48 83 c2 20 =
e9 a2 00 00 00 66 90 48 89 d1 4c 8b 5c 16 f8 4c 8d 54 17 f8 48 c1 e9 03 <f3=
> 48 a5 4d 89 1a e9 0c 01 00 00 0f 1f 40 00 48 89 d1 4c 8b 1e 49
[   38.790899] RSP: 0018:ffffa1b9002d7d08 EFLAGS: 00010203
[   38.790900] RAX: ffff9c873541af43 RBX: ffff9c873541af43 RCX: 00000c6f105=
cd6bf
[   38.790901] RDX: 0000637882e986b6 RSI: ffff9c8735447ffb RDI: ffff9c87354=
47ffb
[   38.790902] RBP: ffff9c8739cd3800 R08: ffff9c873b802f00 R09: 00000000fff=
ff73b
[   38.790903] R10: ffffffffb82b35f1 R11: 00505b1b004d5b1b R12: 00000000000=
00000
[   38.790904] R13: ffff9c873541af3d R14: 000000000000000b R15: 00000000000=
0000c
[   38.790905] FS:  00007f450c390580(0000) GS:ffff9c873f180000(0000) knlGS:=
0000000000000000
[   38.790906] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   38.790907] CR2: ffff9c8735448000 CR3: 00000007e213c002 CR4: 00000000000=
606e0
[   38.790908] BUG: sleeping function called from invalid context at includ=
e/linux/percpu-rwsem.h:34
[   38.790909] in_atomic(): 0, irqs_disabled(): 1, pid: 388, name: loadkeys
[   38.790911] CPU: 6 PID: 388 Comm: loadkeys Tainted: G      D  C        5=
.0.0-rc6-00153-g5ded5871030e #91
[   38.790911] Hardware name: Gigabyte Technology Co., Ltd. To be filled by=
 O.E.M./H77M-D3H, BIOS F12 11/14/2013
[   38.790912] Call Trace:
[   38.790917]  dump_stack+0x67/0x90
[   38.822550]  ? wake_up_klogd+0x10/0x70
[   38.822553]  ___might_sleep.cold.17+0xd4/0xe4
[   38.822556]  exit_signals+0x1c/0x200
[   38.822558]  do_exit+0xa8/0xb90
[   38.822560]  ? ksys_ioctl+0x3a/0x70
[   38.822562]  rewind_stack_do_exit+0x17/0x20

I suspect my system runs multiple loadkeys instances in parallel
and that triggers an Oops.

I noticed that vt_do_kdgkb_ioctl() uses global variable to optimise
func_table re-allocation. Even comment hints at lack of locking:

    /* FIXME: This one needs untangling and locking */
    int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int =
perm)

    https://github.com/torvalds/linux/blob/master/drivers/tty/vt/keyboard.c=
#L2084

Could that be it?

func_table[] is a global array pointers to to initially statically and later
dynamically allocated buffer.
    https://github.com/torvalds/linux/blob/master/drivers/tty/vt/defkeymap.=
c_shipped#L191

Thanks!

--=20

  Sergei

--Sig_/hC5V_Dycw0lipgjlZEbfA00
Content-Type: application/pgp-signature
Content-Description: Цифровая подпись OpenPGP

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQKTBAEBCgB9FiEE+g11JqJ4cL44QkmN7V5F4G8qwpMFAlxp8M1fFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEZB
MEQ3NTI2QTI3ODcwQkUzODQyNDk4REVENUU0NUUwNkYyQUMyOTMACgkQ7V5F4G8q
wpMvog//TOhW5TJrDS2O5qrz4IPIzYEFIJGSz8o2esDWth967M6w3ArveuR8Wrxn
KkB1AtPNTe/a8EaHnu1bQ4h051eciUhKQUTdyTFx/SYsZRlWUoectV/nJVmcKYKP
ae4Z6AeUdcDKjzv0z7uAzRDUWweC8g6CTDsvUl6pDNPxKSLk48x+5EEjJKOP8X+K
6kGiqJlI5Hq+R7APj6QTlyQR/TTwaVonzysYhQ+Yxf1KC++roK/y9MSA6p4OlKa6
nS8mjoAL2h3d8jAnmL9Vm4lMz5eAVlot0dPw5RKmaNcTg+y+Y8WTF6AR5qAESuB7
TKV698L2k6AypE/GFxEnKQTM5mpdr8fWaKobT5QjPpnuibGxNRpCF6ETFS+soMNq
rtcIvUX3njhebIt/g2yFV3XdLcpA+GiN/KzsLv3+YknGLRzjGpmRsJh9ao/iH8v/
ydbdejSmLTTRnqNHxxAXniDvmg87jpglTwbUWaWwm8pnZ++sq/CJCSwG9tMcQu1A
M9J5V9OHflHsnQ/Z4LHfPkhPjwKy+etIiayY1BBplr7pOsxtSTK58CoeM+5iN7Zo
RErU8UvbquPAXC2TlBk77GGtLzLDyF8CDMOveV7zEgeGm8xC0f1oscgb9aFqN95t
AFaD8QUhzEmQ+0jfNdURHN0sSUflarnqcJxJqozlpspe60Y0RAc=
=rLy7
-----END PGP SIGNATURE-----

--Sig_/hC5V_Dycw0lipgjlZEbfA00--
