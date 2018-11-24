Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB9AC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 20:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08DC20820
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 20:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIffzH79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B08DC20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbeKYHhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 02:37:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52989 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbeKYHhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 02:37:32 -0500
Received: by mail-wm1-f66.google.com with SMTP id r11-v6so14573682wmb.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 12:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nt6y6/RIIkqsdEHJA6ya3MkxHGoX7rIlscpsqVpprvM=;
        b=WIffzH79KTGwOWiCg+6WDnel8Bs62okj5NOc9SJ8LtmTWFSVlycd8ql+esCmwaUrtC
         wdAYZv6joKA0gq4TwEGqcjSYtksf2fxSaHvHyrSDxlIiAhX/JkUpTV1xD77e66t4vQRk
         EdzqdTLzS0hK+hwPVzxExNK7nuhluC2k4HQoRTe14FoUkO6AFFdLah1d0uVNBQbnKWs4
         LWybEoBQhIZJMt8z7fgY4vhp4zl9MR9x8/sD64sAlTie9+DeaLUr4AtTHsy0mUcw7q40
         U/HGgWM9HoNnLa5++Wpm5XStRmvZIZfjhhzbrL8+kE7PBSG9l75QtSTujYgU/tYE/t6e
         hv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nt6y6/RIIkqsdEHJA6ya3MkxHGoX7rIlscpsqVpprvM=;
        b=Uh2sGw+0FFL/BdcICmBp+vRiqFXwYzw5wqsL6TjHNOtKeF6I9xJFg6opBuwZ0ZN32V
         H/7EksV7bBxx6Dg/9NO/eCmojG6c31QqrpKJ2b2WjWjJEWj6xID3HQaGDJazB0Tin7Zz
         JiONpbfqrTMW0zfkCX6trArE1BdnEq5jqMN9aL1H4y6mrEeFpls+XcFpPOIytYy091TU
         jHsSAC3MCJvxiiWm9JOeCnXSF5AEeugFQiVfgi3gvw2KX3CsWB2PYHk1FfVKbQlH8p3u
         /K4Dih7+8FxygH/Bite6so764JzasdQKdaO4twahlj/Segt5FahoVBrJTo8vMYNOoy7r
         79FQ==
X-Gm-Message-State: AGRZ1gKEdQsT1bfGhefVwSxy5UyOej4g2vn/AQ2xzx6aa58pEtiLM660
        p4/mDl3FixHvJCPX5Bf5deuT+BzfBJRZIGytbtA=
X-Google-Smtp-Source: AJdET5d6Rwcsh9avP0eMI5XU98YVHXtm55jMbRf5WAPgDiXdZokOhpWAFy9Mi4at0oyJy5VHpVq3RmUu3RRfvU8lGOA=
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr17733882wma.19.1543092495049;
 Sat, 24 Nov 2018 12:48:15 -0800 (PST)
MIME-Version: 1.0
References: <20181019083020.14335-1-daniel.santos@pobox.com>
 <d2f16a3a-7237-6c4e-5ff8-43f05bdb7e0f@huawei.com> <11f65a20-dfca-0ddc-8c7f-58f29afe8c04@pobox.com>
 <436a7243-4a32-40cd-5c40-6cc7f44d26c5@pobox.com>
In-Reply-To: <436a7243-4a32-40cd-5c40-6cc7f44d26c5@pobox.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sat, 24 Nov 2018 21:48:02 +0100
Message-ID: <CAFLxGvwwgoBOWsp-Yxnmn9aKHTrft2gsUj1byRkNwT9o3MFCOg@mail.gmail.com>
Subject: Re: [PING 2] [PATCH] jffs2: Fix use of uninitialized delayed_work,
 lockdep breakage
To:     daniel.santos@pobox.com,
        Boris Brezillon <boris.brezillon@free-electrons.com>
Cc:     houtao1@huawei.com, LKML <linux-kernel@vger.kernel.org>,
        "linux-mtd @ lists . infradead . org" <linux-mtd@lists.infradead.org>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 4:32 PM Daniel Santos <daniel.santos@pobox.com> wrote:
>
> Ping 2!
>
> On 11/05/2018 03:38 PM, Daniel Santos wrote:
> > Ping.
> >
> > Daniel
> >
> > On 10/21/2018 07:32 PM, Hou Tao wrote:
> >> On 2018/10/19 16:30, Daniel Santos wrote:
> >>> jffs2_sync_fs makes the assumption that if CONFIG_JFFS2_FS_WRITEBUFFER
> >>> is defined then a write buffer is available and has been initialized.
> >>> However, this does is not the case when the mtd device has no
> >>> out-of-band buffer:
> >>>
> >>> int jffs2_nand_flash_setup(struct jffs2_sb_info *c)
> >>> {
> >>>         if (!c->mtd->oobsize)
> >>>                 return 0;
> >>> ...
> >>>
> >>> The resulting call to cancel_delayed_work_sync passing a uninitialized
> >>> (but zeroed) delayed_work struct forces lockdep to become disabled.
> >>>
> >>> [   90.050639] overlayfs: upper fs does not support tmpfile.
> >>> [   90.652264] INFO: trying to register non-static key.
> >>> [   90.662171] the code is fine but needs lockdep annotation.
> >>> [   90.673090] turning off the locking correctness validator.
> >>> [   90.684021] CPU: 0 PID: 1762 Comm: mount_root Not tainted 4.14.63 #0
> >>> [   90.696672] Stack : 00000000 00000000 80d8f6a2 00000038 805f0000 80444600 8fe364f4 805dfbe7
> >>> [   90.713349]         80563a30 000006e2 8068370c 00000001 00000000 00000001 8e2fdc48 ffffffff
> >>> [   90.730020]         00000000 00000000 80d90000 00000000 00000106 00000000 6465746e 312e3420
> >>> [   90.746690]         6b636f6c 03bf0000 f8000000 20676e69 00000000 80000000 00000000 8e2c2a90
> >>> [   90.763362]         80d90000 00000001 00000000 8e2c2a90 00000003 80260dc0 08052098 80680000
> >>> [   90.780033]         ...
> >>> [   90.784902] Call Trace:
> >>> [   90.789793] [<8000f0d8>] show_stack+0xb8/0x148
> >>> [   90.798659] [<8005a000>] register_lock_class+0x270/0x55c
> >>> [   90.809247] [<8005cb64>] __lock_acquire+0x13c/0xf7c
> >>> [   90.818964] [<8005e314>] lock_acquire+0x194/0x1dc
> >>> [   90.828345] [<8003f27c>] flush_work+0x200/0x24c
> >>> [   90.837374] [<80041dfc>] __cancel_work_timer+0x158/0x210
> >>> [   90.847958] [<801a8770>] jffs2_sync_fs+0x20/0x54
> >>> [   90.857173] [<80125cf4>] iterate_supers+0xf4/0x120
> >>> [   90.866729] [<80158fc4>] sys_sync+0x44/0x9c
> >>> [   90.875067] [<80014424>] syscall_common+0x34/0x58
> >>>
> >>> Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
> >>> ---
> >>>  fs/jffs2/super.c | 3 ++-
> >>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
> >>> index 793ad30970ff..cae4ecda3c50 100644
> >>> --- a/fs/jffs2/super.c
> >>> +++ b/fs/jffs2/super.c
> >>> @@ -101,7 +101,8 @@ static int jffs2_sync_fs(struct super_block *sb, int wait)
> >>>     struct jffs2_sb_info *c = JFFS2_SB_INFO(sb);
> >>>
> >>>  #ifdef CONFIG_JFFS2_FS_WRITEBUFFER
> >>> -   cancel_delayed_work_sync(&c->wbuf_dwork);
> >>> +   if (jffs2_is_writebuffered(c))
> >>> +           cancel_delayed_work_sync(&c->wbuf_dwork);
> >>>  #endif
> >>>
> >>>     mutex_lock(&c->alloc_sem);
> >>>
> >> Reviewed-by: Hou Tao <houtao1@huawei.com>

Boris, can you please queue up this patch?

-- 
Thanks,
//richard
