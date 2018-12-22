Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE72C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 20:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01FC92195D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 20:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNbh6UCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389847AbeLVU6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 15:58:12 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45657 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388396AbeLVU6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 15:58:11 -0500
Received: by mail-lf1-f68.google.com with SMTP id b20so6165041lfa.12
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 12:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H915YKffmipu2PzY2CpxH/kwDrQvisKAVYA+53xOKaQ=;
        b=aNbh6UCxt6VTlKMKBclKpXydbHDRmOCh0sHUk+mMgl5hycjlxQHxqMgfDM+gjUoedv
         cliM+lGIl3zzEBqY8DO//79WrlE52e29p30V6pwFM1X4JDA196Sasa0oFscJBvxI9A0k
         +fQSUtHLegrkQXH2b8+ZL2R96o5thMspo81/LGPehTg332cu9wHn1wNxUzYT3dIVRxcU
         FWms51AyFP+DZvS1RMckk7I6p7PiEyo/It3ERkZq0OZLeuhFIED5Za4amsD/mWXT5pbt
         +nbPh47nes0KUyyMFQcb1M2Q0m6OXX6tby+rM4f9enrc32D8KNKKaZMkRgoDG17hYQlB
         kNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H915YKffmipu2PzY2CpxH/kwDrQvisKAVYA+53xOKaQ=;
        b=Hd8aG0nVZWs49sorEFLFjQrm2C3WHeUERN4aDsprWuvIIajwgHDj/np1SSLf4cyHHc
         85u4dX2UiJC3TakDNtcG7y/xsDA94Ypv0JRyWbl1x6o4Ls/ob6K3P7hT374gmBM2Htct
         QYmb9NnGRZWBkYVMn81Ku3upo29dKNN4zXtfclvLTjulA8a5NLJ72CbtrcdN6rEP18ph
         m0SN2Jzk7YrIvC2ifCmMVs2ZQrGsmJacK63lg0k50PM5fJ0ZRYht7yePg2iaERj3BAro
         u1N9+mJUFmHHckR6UU6R7xave1eEOfeP6xb+43FKAWD5jzg2JIs+1Ff5qWFQxZkpDcLW
         Yn/A==
X-Gm-Message-State: AA+aEWbttNTRotqG2k01MEltctB43aB9THwhGJKi4W2Iz7VXWeTFZ6AL
        y3c//+gUM4fyzE8xwzOjadsvW9l29ipktf+f8A==
X-Google-Smtp-Source: AFSGD/V6Vt7xtBLUDtmH7m1e+UVz/uxUa79Z5DdSZ1WaFfTl3RFi08h3rQjHwCWqvOwLf0u6Okog9q/HXuVYe1oXDcI=
X-Received: by 2002:a19:c954:: with SMTP id z81mr3833422lff.150.1545512289138;
 Sat, 22 Dec 2018 12:58:09 -0800 (PST)
MIME-Version: 1.0
References: <e62d4c3a-b89b-2380-7b39-66733b389145@gmail.com>
In-Reply-To: <e62d4c3a-b89b-2380-7b39-66733b389145@gmail.com>
From:   Gabriel C <nix.or.die@gmail.com>
Date:   Sat, 22 Dec 2018 21:57:42 +0100
Message-ID: <CAEJqkggwbNP3Q+7AWr4i64CvAdCp15jVLOtUsnMo6rLk3ExTkA@mail.gmail.com>
Subject: Re: [BREAKAGE] Since 4.18, kernel sets SB_I_NODEV implicitly on
 userns mounts, breaking systemd-nspawn
To:     Ellie Reeves <ellierevves@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Seth Forshee <seth.forshee@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added some people to CC that might want to see this..

Am Sa., 22. Dez. 2018 um 19:14 Uhr schrieb Ellie Reeves <ellierevves@gmail.=
com>:
>
> Hi,
> first off, allow me to express that this is my first time ever writing
> on such a mailing list, and that if something is unclear or you would
> need more information, just let me know.
> I write to this list in hoping to see this change reverted. The linux
> kernel always said it would avoid breaking user namespace as much as
> possible, and yet this is what happens. I was hence very much surprised
> when my perfectly working containers on systemd-nspawn which makes use
> of userns by default, stopped working from one day to the next, till I
> identified the problem as being kernel >=3D 4.18. This container is in
> production, hence the annoyance it was. From one day to the next the
> container started failing with stranges problems:
>
> * nginx, dovecot, postgresql, and postfix complained about getting
> permission denied on /dev/null even though it appeared perfectly normal
> to me, the correct permissions, all that
> * /var was also acting very strangely, getting a lot of permission
> denied or operation not supported messages.
> * I could not delete a file that my user had the right to create, write
> to and read in /var, I needed root
>
> Here is the pull request that was made to systemd, along with a small
> amount of talk around the issue:
>
> https://github.com/systemd/systemd/pull/9483
>
> It was ultimately decided among the systemd folks to bail out of the
> issue, as shown in the news entry for systemd 240:
>
>          * KERNEL API BREAKAGE: Linux kernel 4.18 changed behaviour
> regarding
>            mknod() handling in user namespaces. Previously mknod() would
> always
>            fail with EPERM in user namespaces. Since 4.18 mknod() will
> succeed
>            but device nodes generated that way cannot be opened, and
> attempts to
>            open them result in EPERM. This breaks the "graceful
> fallback" logic
>            in systemd's PrivateDevices=3D sand-boxing option. This option=
 is
>            implemented defensively, so that when systemd detects it runs
> in a
>            restricted environment (such as a user namespace, or an
> environment
>            where mknod() is blocked through seccomp or absence of
> CAP_SYS_MKNOD)
>            where device nodes cannot be created the effect of
> PrivateDevices=3D is
>            bypassed (following the logic that 2nd-level sand-boxing is no=
t
>            essential if the system systemd runs in is itself already
> sand-boxed
>            as a whole). This logic breaks with 4.18 in container
> managers where
>            user namespacing is used: suddenly PrivateDevices=3D succeeds
> setting
>            up a private /dev/ file system containing devices nodes =E2=80=
=94 but
> when
>            these are opened they don't work.
>
>            At this point is is recommended that container managers utiliz=
ing
>            user namespaces that intend to run systemd in the payload
> explicitly
>            block mknod() with seccomp or similar, so that the graceful
> fallback
>            logic works again.
>
>            We are very sorry for the breakage and the requirement to chan=
ge
>            container configurations for newer kernels. It's purely
> caused by an
>            incompatible kernel change. The relevant kernel developers
> have been
>            notified about this userspace breakage quickly, but they chose=
 to
>            ignore it.
>
> Here's an email that was sent to lkml about the subject:
>
> https://lkml.org/lkml/2018/7/5/742
>
> I link also this, quoting the last of it:
>
> https://lkml.org/lkml/2018/7/5/701
>
> It has never been the case that mknod on a device node will guarantee
> that you even can open the device node.  The applications that regress
> are broken.  It doesn't mean we shouldn't be bug compatible, but we darn
> well should document very clearly the bugs we are being bug compatible wi=
th.
>
> I'm in the opinion that it is a kernel bug, and I quote someone from the
> systemd irc channel:
>
> ewb said applications were broken. But the rule is, if userspace breaks,
> its a bug. The kernel *has* to revert it. And honestly, this change
> doesn't make much sense. You can set nodev yourself but then you know
> mknod will not allow you to open the object. Here, the kernel does it
> without your knowledge
>
> Also, it seems that if this change is reverted, things that were fixed
> to work around the issue this breakage caused will not be broken again,
> they should simply go back to their previous way of working. I
> understand there may be security reason why this change was made in the
> first place, but it is not so big a problem is it ? I can mknode
> arbitrary devices in userns and open them as userns root. But my point
> is, several things broke. My *working* stuff was broken from one day to
> the next.
>
> I am not trying to pick a fight. I want to understand the reasoning
> behind this change in the first place, and I'm simply making an attempt
> at getting it reverted, because it is true that I don't much fancy
> blocking the mknode() syscall in every template unit on every machine we
> administer here, and that staying on kernel < 4.18 is not a good
> sollution either.
>
> I would also like to be personally CC'ed the comments or answers posted
> to this mailing list in response to this message.
>
> Thanks
