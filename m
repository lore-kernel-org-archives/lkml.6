Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19346C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 13:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B44A206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 13:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="YQNZ9tdO";
	dkim=pass (1024-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="YQNZ9tdO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbfBXNWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 08:22:30 -0500
Received: from fallback17.m.smailru.net ([94.100.176.130]:52740 "EHLO
        fallback17.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbfBXNW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 08:22:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date; bh=qq8OIOzUFsRkFv8i3ihcUPuhmmMl1qw4Xz8Uj/s6R64=;
        b=YQNZ9tdOzsnr/pAxASXd72CwJBNoSDi6uvpR88nq13M8/frXSvYFTJOYMjFLolYwMZcIV64Pvgbo0DhfUsQfA10TF5MS6PqtnZ2qtk8kLNUXGzZlhaTNmZiFnO9FjvOzg/ko2c10MeNKjj+nMXhgs8a512WCimMgUdSW8DJ/mA4=;
Received: from [10.161.25.37] (port=58918 helo=smtp60.i.mail.ru)
        by fallback17.m.smailru.net with esmtp (envelope-from <slyfox@inbox.ru>)
        id 1gxtjZ-0000st-EJ
        for linux-kernel@vger.kernel.org; Sun, 24 Feb 2019 16:22:21 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date; bh=qq8OIOzUFsRkFv8i3ihcUPuhmmMl1qw4Xz8Uj/s6R64=;
        b=YQNZ9tdOzsnr/pAxASXd72CwJBNoSDi6uvpR88nq13M8/frXSvYFTJOYMjFLolYwMZcIV64Pvgbo0DhfUsQfA10TF5MS6PqtnZ2qtk8kLNUXGzZlhaTNmZiFnO9FjvOzg/ko2c10MeNKjj+nMXhgs8a512WCimMgUdSW8DJ/mA4=;
Received: by smtp60.i.mail.ru with esmtpa (envelope-from <slyfox@inbox.ru>)
        id 1gxtjT-0005PM-LN; Sun, 24 Feb 2019 16:22:16 +0300
Date:   Sun, 24 Feb 2019 13:22:08 +0000
From:   Sergei Trofimovich <slyfox@inbox.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
Subject: Re: 5.0.0-rc6+: Oops at boot: RIP: 0010:__memmove+0x81/0x1a0 /
 vt_do_kdgkb_ioctl+0x34d/0x440 (race at reenter?)
Message-ID: <20190224132208.0b9b1889@sf>
In-Reply-To: <20190218083810.GA24924@kroah.com>
References: <20190217233957.2a38d0af@sf>
        <20190218083810.GA24924@kroah.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/lW5I2VOD8YD/=tYA/5AKyfg"; protocol="application/pgp-signature"
X-77F55803: 257C4F86AB09C89C5A78504BD2AC2941988784FC6C4AE31FD6542554A888DE784C1A54171386350499E10948D769CAEB1146A390A9D05390
X-7FA49CB5: 0D63561A33F958A56E312CDAC9C9C522D0EF182D991662F26C9C283C6EAC9FAB8941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249668B94F0A65C3A0C3AA81AA40904B5D9CF19DD082D7633A0E7DDDDC251EA7DABD81D268191BDAD3D78DA827A17800CE7C69C5C0DDE134364CD04E86FAF290E2D40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE7193B768C8DE1254CF9D7E3C14B6359E175ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF5797B92FCB1594A39500306258E7E6ABB4E4A6367B16DE6309
X-Mailru-Sender: 8A2FA48DD8FD9C2B48EDC8DE00DFF84F3054B12A856768B01068E31641EB1555CBE8C9F27F311A76B0C293124EE1F8E466FEC6BF5C9C28D9BE1658B246A3ACF810B29241573AA60767EA787935ED9F1B
X-Mras: OK
X-77F55803: E8DB3678F13EF3E07F9F52485CB584D7271FD7DF62800FDCF89715E79958812B9F119844D83F633CE7CD47DBD3E8B7D77B1631F87F284D1B
X-7FA49CB5: 0D63561A33F958A50A2EDDCF3DB296FEF0CA977B3CC22F74DCFF150050F863BF8941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F93F060FBA3C93C613B503F486389A921A5CC5B56E945C8DA
X-Mailru-MI: 800
X-Mailru-Sender: A5480F10D64C9005631A4012884FA163DED648F4385A85C39F119844D83F633C1C741AFE0338E12238F48B1DF051BE983DDE9B364B0DF28966D7C7C3F77E58D71B4ECFBB0E18FD14AE208404248635DF
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lW5I2VOD8YD/=tYA/5AKyfg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 18 Feb 2019 09:38:10 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Sun, Feb 17, 2019 at 11:39:57PM +0000, Sergei Trofimovich wrote:
> > [ Copying as is from https://bugzilla.kernel.org/show_bug.cgi?id=3D2026=
05
> >   and sending to LKML. Greg, Jiri, can you clarify mailing
> >   list im  MAINTAINERS as well?
> >       https://github.com/torvalds/linux/blob/master/MAINTAINERS#L15527
> >   mentions no list for tty/vt/. ]
> >=20
> > Kernel Oops
> >   [   38.739241] Oops: 0003 [#1] PREEMPT SMP
> >   [   38.739243] CPU: 6 PID: 388 Comm: loadkeys Tainted: G         C   =
     5.0.0-rc6-00153-g5ded5871030e #91
> >   [   38.739244] Hardware name: Gigabyte Technology Co., Ltd. To be fil=
led by O.E.M./H77M-D3H, BIOS F12 11/14/2013
> >   [   38.739249] RIP: 0010:__memmove+0x81/0x1a0
> > happes on a fresh vanilla master kernel roughly at boot
> > (before tty login prompt):
> >   $ uname -r
> >   5.0.0-rc6-00153-g5ded5871030e
> >=20
> > The kernel page fault happens at 'loadkeys start'.
> > I suspect some kind of race at reenter of vt_do_kdgkb_ioctl(KDSKBSENT):
> >     https://github.com/torvalds/linux/blob/master/drivers/tty/vt/keyboa=
rd.c#L1986
> >=20
> > The oops trace looks similar to the following reports (no details besid=
es Oops)
> >     https://bugzilla.kernel.org/show_bug.cgi?id=3D194589
> >     https://bugzilla.kernel.org/show_bug.cgi?id=3D202111
> >=20
> > [   38.044921] IPv6: ADDRCONF(NETDEV_CHANGE): br0: link becomes ready
> > [   38.533196] usb 1-1.2: r8712u: CustomerID =3D 0x0000
> > [   38.533200] usb 1-1.2: r8712u: MAC Address from efuse =3D 00:0d:81:a=
9:09:90
> > [   38.533203] usb 1-1.2: r8712u: Loading firmware from "rtlwifi/rtl871=
2u.bin"
> > [   38.533331] usbcore: registered new interface driver r8712u
> > [   38.736178] BUG: unable to handle kernel paging request at ffff9c873=
5448000
> > [   38.737215] #PF error: [PROT] [WRITE]
> > [   38.737216] PGD 288a05067 P4D 288a05067 PUD 288a07067 PMD 7f60c2063 =
PTE 80000007f5448161
> > [   38.739241] Oops: 0003 [#1] PREEMPT SMP
> > [   38.739243] CPU: 6 PID: 388 Comm: loadkeys Tainted: G         C     =
   5.0.0-rc6-00153-g5ded5871030e #91
> > [   38.739244] Hardware name: Gigabyte Technology Co., Ltd. To be fille=
d by O.E.M./H77M-D3H, BIOS F12 11/14/2013
> > [   38.739249] RIP: 0010:__memmove+0x81/0x1a0
> > [   38.739251] Code: 4c 89 4f 10 4c 89 47 18 48 8d 7f 20 73 d4 48 83 c2=
 20 e9 a2 00 00 00 66 90 48 89 d1 4c 8b 5c 16 f8 4c 8d 54 17 f8 48 c1 e9 03=
 <f3> 48 a5 4d 89 1a e9 0c 01 00 00 0f 1f 40 00 48 89 d1 4c 8b 1e 49
> > [   38.739252] RSP: 0018:ffffa1b9002d7d08 EFLAGS: 00010203
> > [   38.745857] RAX: ffff9c873541af43 RBX: ffff9c873541af43 RCX: 00000c6=
f105cd6bf
> > [   38.745858] RDX: 0000637882e986b6 RSI: ffff9c8735447ffb RDI: ffff9c8=
735447ffb
> > [   38.745859] RBP: ffff9c8739cd3800 R08: ffff9c873b802f00 R09: 0000000=
0fffff73b
> > [   38.745860] R10: ffffffffb82b35f1 R11: 00505b1b004d5b1b R12: 0000000=
000000000
> > [   38.745861] R13: ffff9c873541af3d R14: 000000000000000b R15: 0000000=
00000000c
> > [   38.745862] FS:  00007f450c390580(0000) GS:ffff9c873f180000(0000) kn=
lGS:0000000000000000
> > [   38.745863] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   38.745864] CR2: ffff9c8735448000 CR3: 00000007e213c002 CR4: 0000000=
0000606e0
> > [   38.745865] Call Trace:
> > [   38.745871]  vt_do_kdgkb_ioctl+0x34d/0x440
> > [   38.745875]  vt_ioctl+0xba3/0x1190
> > [   38.745879]  ? __bpf_prog_run32+0x39/0x60
> > [   38.745882]  ? mem_cgroup_commit_charge+0x7b/0x4e0
> > [   38.762583]  tty_ioctl+0x23f/0x920
> > [   38.762586]  ? preempt_count_sub+0x98/0xe0
> > [   38.762590]  ? __seccomp_filter+0x67/0x600
> > [   38.762594]  do_vfs_ioctl+0xa2/0x6a0
> > [   38.762597]  ? syscall_trace_enter+0x192/0x2d0
> > [   38.762599]  ksys_ioctl+0x3a/0x70
> > [   38.762601]  __x64_sys_ioctl+0x16/0x20
> > [   38.762604]  do_syscall_64+0x54/0xe0
> > [   38.772513]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > [   38.772515] RIP: 0033:0x7f450c2bb427
> > [   38.772517] Code: 00 00 00 75 0c 48 c7 c0 ff ff ff ff 48 83 c4 18 c3=
 e8 8d d2 01 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 b8 10 00 00 00 0f 05=
 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 da 0c 00 f7 d8 64 89 01 48
> > [   38.772518] RSP: 002b:00007fffbcedd348 EFLAGS: 00000246 ORIG_RAX: 00=
00000000000010
> > [   38.772519] RAX: ffffffffffffffda RBX: 000000000000000b RCX: 00007f4=
50c2bb427
> > [   38.772520] RDX: 00007fffbcedd360 RSI: 0000000000004b49 RDI: 0000000=
000000003
> > [   38.772521] RBP: 00007fffbcedd361 R08: 00007f450c389c40 R09: 000055c=
bef2494a0
> > [   38.772522] R10: 0000000000000000 R11: 0000000000000246 R12: 000055c=
bef2412b0
> > [   38.772522] R13: 00007fffbcedd360 R14: 000000000000000b R15: 0000000=
000000003
> > [   38.772525] Modules linked in: snd_hda_codec_hdmi bridge r8712u(C) s=
tp llc snd_hda_codec_via snd_hda_codec_generic snd_hda_intel snd_hda_codec =
x86_pkg_temp_thermal dummy kvm_intel snd_hwdep snd_hda_core snd_pcm snd_tim=
er kvm snd atl1c soundcore irqbypass xfs tun nf_conntrack_ftp nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 loop fuse binfmt_misc ipv6
> > [   38.779196] r8712u 1-1.2:1.0 wl0: renamed from wlan0
> > [   38.779240] CR2: ffff9c8735448000
> > [   38.790894] ---[ end trace 8116e48ba19076a0 ]---
> > [   38.790897] RIP: 0010:__memmove+0x81/0x1a0
> > [   38.790898] Code: 4c 89 4f 10 4c 89 47 18 48 8d 7f 20 73 d4 48 83 c2=
 20 e9 a2 00 00 00 66 90 48 89 d1 4c 8b 5c 16 f8 4c 8d 54 17 f8 48 c1 e9 03=
 <f3> 48 a5 4d 89 1a e9 0c 01 00 00 0f 1f 40 00 48 89 d1 4c 8b 1e 49
> > [   38.790899] RSP: 0018:ffffa1b9002d7d08 EFLAGS: 00010203
> > [   38.790900] RAX: ffff9c873541af43 RBX: ffff9c873541af43 RCX: 00000c6=
f105cd6bf
> > [   38.790901] RDX: 0000637882e986b6 RSI: ffff9c8735447ffb RDI: ffff9c8=
735447ffb
> > [   38.790902] RBP: ffff9c8739cd3800 R08: ffff9c873b802f00 R09: 0000000=
0fffff73b
> > [   38.790903] R10: ffffffffb82b35f1 R11: 00505b1b004d5b1b R12: 0000000=
000000000
> > [   38.790904] R13: ffff9c873541af3d R14: 000000000000000b R15: 0000000=
00000000c
> > [   38.790905] FS:  00007f450c390580(0000) GS:ffff9c873f180000(0000) kn=
lGS:0000000000000000
> > [   38.790906] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   38.790907] CR2: ffff9c8735448000 CR3: 00000007e213c002 CR4: 0000000=
0000606e0
> > [   38.790908] BUG: sleeping function called from invalid context at in=
clude/linux/percpu-rwsem.h:34
> > [   38.790909] in_atomic(): 0, irqs_disabled(): 1, pid: 388, name: load=
keys
> > [   38.790911] CPU: 6 PID: 388 Comm: loadkeys Tainted: G      D  C     =
   5.0.0-rc6-00153-g5ded5871030e #91
> > [   38.790911] Hardware name: Gigabyte Technology Co., Ltd. To be fille=
d by O.E.M./H77M-D3H, BIOS F12 11/14/2013
> > [   38.790912] Call Trace:
> > [   38.790917]  dump_stack+0x67/0x90
> > [   38.822550]  ? wake_up_klogd+0x10/0x70
> > [   38.822553]  ___might_sleep.cold.17+0xd4/0xe4
> > [   38.822556]  exit_signals+0x1c/0x200
> > [   38.822558]  do_exit+0xa8/0xb90
> > [   38.822560]  ? ksys_ioctl+0x3a/0x70
> > [   38.822562]  rewind_stack_do_exit+0x17/0x20
> >=20
> > I suspect my system runs multiple loadkeys instances in parallel
> > and that triggers an Oops.
> >=20
> > I noticed that vt_do_kdgkb_ioctl() uses global variable to optimise
> > func_table re-allocation. Even comment hints at lack of locking:
> >=20
> >     /* FIXME: This one needs untangling and locking */
> >     int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, =
int perm)
> >=20
> >     https://github.com/torvalds/linux/blob/master/drivers/tty/vt/keyboa=
rd.c#L2084
> >=20
> > Could that be it? =20
>=20
> That could be it, care to add a lock to handle this?

Will try.

> And why does your system run loadkeys in parallel?

It comes from systemd which spawns 'systemd-vconsole-setup'
once per each vtcon at start:
    https://github.com/systemd/systemd/blob/883eb9be985fd86d9cabe967eeeab91=
cdd396a81/src/vconsole/90-vconsole.rules.in#L12

My system has two vtcon "devices":
  # cat /sys/devices/virtual/vtconsole/vtcon0/name
  (S) dummy device
  # cat /sys/devices/virtual/vtconsole/vtcon1/name
  (M) frame buffer device

Both trigger 'systemd-vconsole-setup' at exactly same time.

I guess multiple vtcons is i915-specific framebuffer setup:
    drivers/gpu/drm/i915/i915_drv.c:                ret =3D do_take_over_co=
nsole(&dummy_con, 0, MAX_NR_CONSOLES - 1, 1);

This is a dmesg output with a tiny debug path applied to make
sure loadkeys is the only user of vt_do_kdgkb_ioctl() calls:

--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1996,6 +1996,14 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __use=
r *user_kdgkb, int perm)
        int i, j, k;
        int ret;
=20
+       printk("In vt_do_kdgkb_ioctl(%d=3D%s)/cpu=3D%d/comm=3D%s(%d)\n",
+               cmd, (cmd =3D=3D KDGKBSENT)
+                       ? "KDGKBSENT"
+                       : ((cmd =3D=3D KDSKBSENT)
+                               ? "KDSKBSENT"
+                               : "UNKNOWN"),
+               hard_smp_processor_id(), current->comm, task_pid_nr(current=
));
+
        if (!capable(CAP_SYS_TTY_CONFIG))
                perm =3D 0;

Feb 24 12:06:35 sf systemd-vconsole-setup[343]: Executing "/usr/bin/loadkey=
s -q -C /dev/tty1 -u ru4"...
Feb 24 12:06:35 sf systemd-vconsole-setup[344]: /usr/bin/setfont succeeded.
Feb 24 12:06:35 sf systemd-vconsole-setup[344]: Executing "/usr/bin/loadkey=
s -q -C /dev/tty1 -u ru4"...
Feb 24 12:06:35 sf systemd-vconsole-setup[343]: Successfully forked off '(l=
oadkeys)' as PID 423.
Feb 24 12:06:35 sf systemd-vconsole-setup[344]: Successfully forked off '(l=
oadkeys)' as PID 424.
...
Feb 24 12:06:35 sf kernel: ^[[0;1;39m^[[0;1;39mIn vt_do_kdgkb_ioctl(19273=
=3DKDSKBSENT)/cpu=3D5/comm=3Dloadkeys(424)
Feb 24 12:06:35 sf kernel: ^[[0;1;39m^[[0;1;39mIn vt_do_kdgkb_ioctl(19273=
=3DKDSKBSENT)/cpu=3D2/comm=3Dloadkeys(423)
<many more of these. interleave sometimes>
...
Feb 24 12:06:35 sf systemd-vconsole-setup[343]: /usr/bin/loadkeys succeeded.
Feb 24 12:06:35 sf systemd-vconsole-setup[344]: UTF-8 kbdmode enabled on /d=
ev/tty9
Feb 24 12:06:35 sf systemd-vconsole-setup[344]: Font and unimap successfull=
y copied to /dev/tty9
Feb 24 12:06:35 sf systemd-vconsole-setup[343]: UTF-8 kbdmode enabled on /d=
ev/tty9
Feb 24 12:06:35 sf systemd-vconsole-setup[343]: Font and unimap successfull=
y copied to /dev/tty9
Feb 24 12:06:35 sf systemd-vconsole-setup[344]: UTF-8 kbdmode enabled on /d=
ev/tty12
Feb 24 12:06:35 sf systemd-vconsole-setup[344]: Font and unimap successfull=
y copied to /dev/tty12
Feb 24 12:06:35 sf systemd-vconsole-setup[343]: UTF-8 kbdmode enabled on /d=
ev/tty12
Feb 24 12:06:35 sf systemd-vconsole-setup[343]: Font and unimap successfull=
y copied to /dev/tty12

--=20

  Sergei

--Sig_/lW5I2VOD8YD/=tYA/5AKyfg
Content-Type: application/pgp-signature
Content-Description: Цифровая подпись OpenPGP

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQKTBAEBCgB9FiEE+g11JqJ4cL44QkmN7V5F4G8qwpMFAlxymoFfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEZB
MEQ3NTI2QTI3ODcwQkUzODQyNDk4REVENUU0NUUwNkYyQUMyOTMACgkQ7V5F4G8q
wpNj9RAAxHWBljFNvk4NKtBKFADiwZSOUA+dV8da0ZFTHnVZHjyekBUMO8R67630
x4L8JCtEIqHgGleOUhJtDnvGtk7bLmab9ZC7uB0fhPzKmu6KO1nAjQbgvo1n42qS
Mqhdehkf2jzIMqbhJDHWSyP4l/DfGVVX/5I/YcUIBO/FOQPJG7C5NQSB6d+iRL8j
SZ0Lb724cEeWCtJiR4AD+kENRupdt2ymTDtt84NPXJcdiXMv27mEmQ87sOUlLjHt
zIDm75XDNFKGu5bS5X5p5mOXrSL44pMdRGI5KcUMFyfHHFSqWTYXaQDwo6i2iabQ
jnNt29mXGGirQuEB2zYYlitxPLm2MbNSmv1ZvIQnKbnvkFUYr8vX+KQ2L/yyy+rt
bnqnAa1klLHz60Dc1cmY5zf5V6I5yJoe2nVPYOyni+F6wUqQ4UzISu2BlRfxINk/
OUFv5jhFFFLo6ysok9jAE8aat5aQ1q0Uhb77EyDkasQhskJd5lRdNfdbuwp3udwv
zddfsRTaWAPi9qK/ElvsZCUPExFEsPpxui1UkAIf/C0dqgg1JN1tRuKsAXIeYA56
iSSWsx0lek4MftEQHfB4yagEzbMMS/B8j/qg6HkBB8N48rVUPB72cRFCsSx87UKy
ISCejDrQaKqti88k7iugy8n/T7aQNdP0ebfg5LTHJlIOvnumk00=
=jjsZ
-----END PGP SIGNATURE-----

--Sig_/lW5I2VOD8YD/=tYA/5AKyfg--
