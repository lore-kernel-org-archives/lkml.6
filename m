Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12C2C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 09:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A992087E
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 09:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/mldqbx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A992087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932657AbeFPJ6z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 05:58:55 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45326 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932420AbeFPJ6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 05:58:53 -0400
Received: by mail-oi0-f67.google.com with SMTP id 188-v6so10914518oid.12;
        Sat, 16 Jun 2018 02:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wIjdKLkKqG0JElXVOGQtJzZwCofmiEOgHYoq7clmQss=;
        b=L/mldqbx4sjqqao/LoLkZsHEc0bdpIZqB4fiMumnAV6y8eNrRu1KPFhkBfO+4IVrHn
         6w4w3AetaYsFUlhRtL0m0Wjvo36z2fSL2ztSl7hDxg/FuOowwoGHYOGfmUXEeY/3EdnS
         DI35IlDu+OvweYzCJJQ+6qgTlDpB3JRMCpwq7X20qqbiqkQ/IBXtRFJ45uipfd2ShXDz
         Rkmxs2+/Iv63SaXcqShSgW4mtKiaHrM2NXX6a0NV5IWdcYo+lGtHQuXBFrR8aylnzlY8
         JprF4WBoVH1YDhg2dXJWRJdvt8xaV3OhBg/RJ7Ddh0i7UeF1wlTlQkk+0VMzbmRP3NTK
         0Fxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wIjdKLkKqG0JElXVOGQtJzZwCofmiEOgHYoq7clmQss=;
        b=A9zuCx+0HkNNLX4yLnHZiM5NlLtpXn3v/a3FseLAf1Nx4C+rAFb+3bIZN2IZPAk1Rz
         5sfWlIxNx2Glb2rPcLMcpBne78YfpLtVb9VgG/+vLL7iDI1L1eH2ULEAdaRwqMpTtxpx
         ZSCA6nXZkLvpB46r4DaWoLyRYkSOOjuhhMUrMKQt7ILFk2+9r8wwEUGhZLbMbL0lN5y6
         fEjjrFfr5eXGvi1AYZspWgdBraYUNlwnouY2rzx+vftDINwtUz9rFOkz5275YZ11rmhJ
         pM0a+t9i3CCqCRLf2EVWBy+a2gq/qu4OOKlW2cgRUJ9nkBxWXyfWDfEFVwedq5ecvBoQ
         GnzA==
X-Gm-Message-State: APt69E1M4po0pz6muxCzrlz2bYltgh/K0rtzFAL1xDAgH/tm9oBtBZm7
        hG4fXX2d+9c7Iurn8+sUw2zpB1fSvg3fte+oR5k=
X-Google-Smtp-Source: ADUXVKJGgC+uNNyB/mtI8sTuXQxzPbIkScbljBhgS9GcII4Di2s3U6FFnB2IEgD+CRfLf1Odg/dJ44s8kAMoeXIpfSE=
X-Received: by 2002:aca:54d7:: with SMTP id i206-v6mr2899726oib.73.1529143132508;
 Sat, 16 Jun 2018 02:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAE5jQCfP1Z0oTBz_V0QkFwFqtJgekUMD2HZR=qA2oWxPvZrzsQ@mail.gmail.com>
 <20180603184955.zrowxp4y3ij66y5n@eaf> <20180608152557.GB11958@amd>
 <CAE5jQCeCOK5zoH4KbyP+hiMKp4MpkjJN1efzquoXCfPPXoj9Nw@mail.gmail.com> <20180612213521.2ona4vtnuu64hs6t@eaf>
In-Reply-To: <20180612213521.2ona4vtnuu64hs6t@eaf>
From:   Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Date:   Sat, 16 Jun 2018 12:58:41 +0300
Message-ID: <CAE5jQCdOS4mAUKa6jTOro+ghNKoQ_dQwyyBPP=LHE=khd5dQQg@mail.gmail.com>
Subject: Re: Mounting corrupted HFS+ causes kernel NULL pointer dereference
To:     "Ernesto A. Fernandez" <ernesto.mnd.fernandez@gmail.com>
Cc:     pavel@ucw.cz, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> but was the original issue solved?
Yes, after removing the suggested line and applying patch [2] on top
of v4.17, when I try to mount the original FS image, mount just
returns Invalid argument, no kernel NULL pointer dereferences anymore:

mount: mounting /dev/sda on /mnt failed: Invalid argument
[    4.840690] exe (993) used greatest stack depth: 12872 bytes left

Thank you!

=D1=81=D1=80, 13 =D0=B8=D1=8E=D0=BD. 2018 =D0=B3. =D0=B2 0:35, Ernesto A. F=
ern=C3=A1ndez
<ernesto.mnd.fernandez@gmail.com>:
>
> Hi:
>
> On Tue, Jun 12, 2018 at 09:43:26PM +0300, Anatoly Trosinenko wrote:
> > Hello,
> >
> > > [1] https://www.spinics.net/lists/linux-fsdevel/msg125241.html
> > > [2] https://www.spinics.net/lists/linux-fsdevel/msg126499.html
> >
> > If I get it right, the first patch is already upstreamed in some
> > modified form and cannot be applied on top of vanilla v4.17.
>
> The first part of the patchset was already picked up, but your report
> is related to the second part, which is the link at [1]. It should
> still apply.
>
> > When I
> > apply the second one I get
> >
> > $ patch -p1 < ../hfsplus-2.patch
> > patching file fs/hfsplus/dir.c
> > patching file fs/hfsplus/hfsplus_fs.h
> > patching file fs/hfsplus/inode.c
> > patching file fs/hfsplus/super.c
> > Hunk #3 FAILED at 567.
> > Hunk #4 succeeded at 586 (offset 1 line).
> > 1 out of 4 hunks FAILED -- saving rejects to file fs/hfsplus/super.c.re=
j
> > $ cat fs/hfsplus/super.c.rej
> > --- fs/hfsplus/super.c
> > +++ fs/hfsplus/super.c
> > @@ -567,11 +547,6 @@ static int hfsplus_fill_super(struct super_block
> > *sb, void *data, int silent)
> >         sbi->nls =3D nls;
> >         return 0;
> >
> > -out_put_hidden_dir:
> > -       iput(sbi->hidden_dir);
> > -out_put_root:
> > -       dput(sb->s_root);
> > -       sb->s_root =3D NULL;
> >  out_put_alloc_file:
> >         iput(sbi->alloc_file);
> >  out_close_attr_tree:
>
> That's because a patch by Tetsuo Handa added a call to
> cancel_delayed_work_sync() after the out_put_hidden_dir tag. Just remove
> that line before applying the patch.
>
> >
> > Looks, like manually removing this hunk cannot change anything
> > (because of previous return), so just left as is.
>
> Ok, that should be enough for testing. The rest of your mail seems like a
> separate bug report, though. I'll take a look at it, but was the original
> issue solved?
>
> >
> > Now, when mounting the attached hfsplus_16mb_segv to /mnt and
> > performing `dd if=3D/dev/zero of=3D/mnt/xyz bs=3D567879 count=3D1` I ge=
t
> >
> > [    1.646451] BUG: unable to handle kernel NULL pointer dereference
> > at 0000000000000043
> > [    1.646666] PGD 1d4d2067 P4D 1d4d2067 PUD 1d4bc067 PMD 0
> > [    1.646870] Oops: 0000 [#1] SMP NOPTI
> > [    1.647002] Modules linked in:
> > [    1.647209] CPU: 0 PID: 991 Comm: init Not tainted 4.17.0+ #1
> > [    1.647291] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > BIOS 1.10.2-1ubuntu1 04/01/2014
> > [    1.647456] RIP: 0010:hfsplus_bnode_put+0x9/0xc0
> > [    1.647522] RSP: 0018:ffffb750409b7a58 EFLAGS: 00000282
> > [    1.647607] RAX: ffffa3b31e713000 RBX: 000000000a000000 RCX: 0000000=
011000000
> > [    1.647696] RDX: 0000000000000000 RSI: ffffffff85ca56d0 RDI: fffffff=
ffffffffb
> > [    1.647787] RBP: ffffa3b31d473288 R08: 0000000000000000 R09: ffffb75=
0409b7960
> > [    1.647877] R10: 0000000000000000 R11: ffffa3b31df0e618 R12: ffffb75=
0409b7ad0
> > [    1.647967] R13: ffffa3b31d473180 R14: ffffa3b31d432a00 R15: 0000000=
00000000a
> > [    1.648089] FS:  0000000001dd48c0(0000) GS:ffffa3b31f800000(0000)
> > knlGS:0000000000000000
> > [    1.648192] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    1.648268] CR2: 0000000000000043 CR3: 000000001d4c4000 CR4: 0000000=
0000006f0
> > [    1.648406] Call Trace:
> > [    1.648883]  hfsplus_brec_find+0x3c/0x150
> > [    1.648970]  ? hfsplus_brec_remove+0x160/0x160
> > [    1.649037]  hfsplus_ext_read_extent.part.6+0xba/0x190
> > [    1.649118]  ? clean_bdev_aliases+0x81/0x1d0
> > [    1.649178]  hfsplus_file_extend+0x16b/0x3a0
> > [    1.649238]  hfsplus_get_block+0x60/0x250
> > [    1.649293]  ? hfsplus_file_extend+0x3a0/0x3a0
> > [    1.649352]  __block_write_begin_int+0x134/0x550
> > [    1.649414]  ? hfsplus_file_extend+0x3a0/0x3a0
> > [    1.649476]  ? percpu_counter_add_batch+0x48/0x60
> > [    1.649537]  ? hfsplus_file_extend+0x3a0/0x3a0
> > [    1.649596]  block_write_begin+0x3f/0xa0
> > [    1.649652]  cont_write_begin+0x232/0x330
> > [    1.649713]  ? hfsplus_file_extend+0x3a0/0x3a0
> > [    1.649776]  hfsplus_write_begin+0x2f/0x70
> > [    1.649834]  ? hfsplus_file_extend+0x3a0/0x3a0
> > [    1.649902]  generic_perform_write+0xb1/0x1b0
> > [    1.649965]  __generic_file_write_iter+0xfd/0x190
> > [    1.650031]  generic_file_write_iter+0xe1/0x1e0
> > [    1.650095]  __vfs_write+0xfc/0x160
> > [    1.650148]  vfs_write+0xa8/0x190
> > [    1.650196]  ksys_write+0x4d/0xb0
> > [    1.650245]  do_syscall_64+0x43/0xf0
> > [    1.650301]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [    1.650465] RIP: 0033:0x486804
> > [    1.650510] RSP: 002b:00007ffd156ba4e8 EFLAGS: 00000246 ORIG_RAX:
> > 0000000000000001
> > [    1.650611] RAX: ffffffffffffffda RBX: 0000000001dd48a0 RCX: 0000000=
000486804
> > [    1.650695] RDX: 000000000008aa47 RSI: 00007ff996f60010 RDI: 0000000=
000000001
> > [    1.650779] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000=
00000000a
> > [    1.650863] R10: 00000000000001b6 R11: 0000000000000246 R12: 00007ff=
996f60010
> > [    1.650946] R13: 000000000008aa47 R14: 00007ff996f60010 R15: 0000000=
000000000
> > [    1.651058] Code: 39 5a 68 77 ce 48 89 ef 5b 5d e9 03 c7 ef ff 0f
> > 1f 00 48 85 ff 74 04 3e ff 47 48 f3 c3 0f 1f 44 00 00 48 85 ff 74 5b
> > 41 54 55 53 <8b> 47 48 48 8b 2f 85 c0 0f 84 89 00 00 00 49 89 fc 48 8d
> > 75 6c
> > [    1.651492] RIP: hfsplus_bnode_put+0x9/0xc0 RSP: ffffb750409b7a58
> > [    1.651583] CR2: 0000000000000043
> > [    1.651851] ---[ end trace d164982d45c0eb53 ]---
> >
> > (full log attached)
> >
> > And when I mount hfsplus_16mb_hang and perform `echo > /mnt/xyz`, it ha=
ngs.
> >
> > PS: Please excuse me, if these patches just became slightly outdated
> > and I didn't managed to apply them properly.
> > =D0=BF=D1=82, 8 =D0=B8=D1=8E=D0=BD. 2018 =D0=B3. =D0=B2 18:25, Pavel Ma=
chek <pavel@ucw.cz>:
> > >
> > > On Sun 2018-06-03 15:49:56, Ernesto A. Fern=C3=A1ndez wrote:
> > > 1;2802;0c> Hi, thank you for your report.
> > > >
> > > > On Sun, Jun 03, 2018 at 06:52:19PM +0300, Anatoly Trosinenko wrote:
> > > > > How to reproduce:
> > > > > 1. Take kernel source v4.17-rc7
> > > > > 2. Compile it with the config attached
> > > > > 3. Unpack and mount the attached FS image as hfsplus.
> > > >
> > > > We are aware of this issue and I've sent some patches [1][2]. It's =
hard
> > > > to get reviewers interested in hfsplus, so I don't know when it wil=
l be
> > > > fixed.
> > >
> > > I guess Anatoly can still test the patches, and add Tested-by tags if
> > > they help. No guarantees, but that may make it easier to get the patc=
hes
> > > merged.
> > >
> > > Thanks,
> > >                                                                 Pavel
> > >
> > > > [1] https://www.spinics.net/lists/linux-fsdevel/msg125241.html
> > > > [2] https://www.spinics.net/lists/linux-fsdevel/msg126499.html
> > >
> > > --
> > > (english) http://www.livejournal.com/~pavelmachek
> > > (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/hors=
es/blog.html
> >
> >
> >
> > --
