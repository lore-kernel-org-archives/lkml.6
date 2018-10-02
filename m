Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5838AC64EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D76F821471
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaCg0AbF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76F821471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeJCDVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:21:11 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:40073 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbeJCDVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:21:10 -0400
Received: by mail-pl1-f177.google.com with SMTP id 1-v6so2300746plv.7;
        Tue, 02 Oct 2018 13:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YLrmKJtp6GKL1S7p2pOk3yDWXcgLB5j+lVKCzJWJcjk=;
        b=gaCg0AbFgvonjsKEBwQgNPpmMursDNxMtdFLn9k1bFSnSo4AG+KTN5T86UBo6N+2BS
         WcRo/MXq3mv7kQ+4p498Xn2TRN2K/GxZ3EHTld3MFGtjUMGwrtXE18ubVYbdRfJvfB24
         ZvHuSn4k1ETrY7AGgzeAUSjbudZ2GhcN49dA7dbZvuaaIRIuDrB6DcXv0VxeEkYx7qUR
         bhEFwEzqn7fPsHHE+uK/Luz8MKl/1qkFUSX3Oo1wRn4h82wFhZZVD+P5dBe5vo4gaNBB
         3LPUUIL+tUoYJKAAEyq/t38TuJnwkXhPz1/LE4ZhxiaxzvJZaISEc+vGtTgOzIwrB9YE
         HL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YLrmKJtp6GKL1S7p2pOk3yDWXcgLB5j+lVKCzJWJcjk=;
        b=m+QMAxVepoRskYOB7kNAttK3kaQw3GOLWAnhkHTd0BVDSx83fcbCMz2/+pMPm6ziL+
         kgcB34BeHYM1DkIUhk8KM+6rlRb0AXb/3qot4N0OuRJbriDHLxAGb5OMH41Sr41+AM/S
         Lpxjw12gGH/XJDfTMe7wZSrj8C2HIoZP6qQD9xeaLk+9P/zrc65znndtDbfB0n+fBKbV
         J1Xp41NaA8WeQXjFv29dEZwrJER+VKnnLGXT1uUpvdcvLl3zkauSX6Aqw9FMS3siJ6ER
         SDY8ndwOANUGeLFSmew/EP335bBraBKoffoilJAi0ml6bo2Sbo22c6cHSNpH9lhVdIgX
         VYOQ==
X-Gm-Message-State: ABuFfoj/T4TIKb3f8BMjpnD33x599Ig5zU1hoj1MfuWE4kUcnmsY6EWy
        caKkZ2jOfQAgVNPlok82gG+6v4TJoOjUIC3GzJ4=
X-Google-Smtp-Source: ACcGV626FBnwPeCDyjlhQJCCRNMpl4WjIsdesCI/74Oftgftka4z060Lu2lec7hr2C8yvweDn7S3pblJ0xtt1Oev4dI=
X-Received: by 2002:a17:902:bd85:: with SMTP id q5-v6mr2159987pls.73.1538512560676;
 Tue, 02 Oct 2018 13:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <ad6b338c900a17c4ecb1655a42b954221f242be2.1538480816.git.rfreire@redhat.com>
 <CAH2r5mtu9XbQfR=QevDqu36ZRYah1hrRGSQyynCfr82PRyunwQ@mail.gmail.com> <194690850.32402710.1538508513975.JavaMail.zimbra@redhat.com>
In-Reply-To: <194690850.32402710.1538508513975.JavaMail.zimbra@redhat.com>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 2 Oct 2018 15:35:49 -0500
Message-ID: <CAH2r5ms814MUNWVZNfCTuSO2LQZsmCs5N1nwgdVuhxtMctRE3Q@mail.gmail.com>
Subject: Re: [PATCH v2] CIFS: Print message when attempting a mount
To:     rfreire@redhat.com
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Pavel Shilovsky <piastryyy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that on at least the first system I looked at (Ubuntu 18.04)
it defaults to KERN_WARNING (ie 4) so wouldn't have shown a KERN_INFO
which is level 6 (as the mount example from ext4) by default
or the xfs_notice (which is level 5)

https://elinux.org/Debugging_by_printing

On Tue, Oct 2, 2018 at 2:28 PM Rodrigo Freire <rfreire@redhat.com> wrote:
>
> Hi Steve,
>
> ----- Original Message -----
> > From: "Steve French" <smfrench@gmail.com>
> > To: rfreire@redhat.com
> > Cc: "LKML" <linux-kernel@vger.kernel.org>, "Steve French"
> > <sfrench@samba.org>, "CIFS" <linux-cifs@vger.kernel.org>, "Pavel Shilovsky"
> > <piastryyy@gmail.com>
> > Sent: Tuesday, October 2, 2018 4:17:02 PM
> > Subject: Re: [PATCH v2] CIFS: Print message when attempting a mount
> >
> > Are you sure that these aren't logged by the automounter (for ext4,
> > xfs etc.). When I looked in my dmesg logs I didn't find matching log
> > entries in the file systems themselves. Do you have an example?
>
> I'm positive about it. Check it out:
>
> [rfreire@rf ~]$ cd git/upstream/fs/ext4/
> [rfreire@rf ext4]$
> [rfreire@rf ext4]$
> [rfreire@rf ext4]$ grep -r "mounted filesystem with"
> super.c:                ext4_msg(sb, KERN_INFO, "mounted filesystem with%s. "
>
>
> [rfreire@rf ext4]$ dmesg | grep mount
> [   21.550897] EXT4-fs (dm-1): mounted filesystem with ordered data mode. Opts: (null)
> [   22.216213] EXT4-fs (dm-1): re-mounted. Opts: discard
> [   22.598267] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
> [   22.605225] EXT4-fs (sdc): mounted filesystem without journal. Opts: discard
> [   24.029161] EXT4-fs (dm-2): mounted filesystem with ordered data mode. Opts: (null)
> [   24.047777] EXT4-fs (dm-4): mounted filesystem without journal. Opts: (null)
>
> XFS sample dmesg (from https://www.reddit.com/r/archlinux/comments/40b9r9/xfs_partition_is_mounted_during_boot_and_then/):
>
> [ 2.764491] XFS (sdb1): Mounting V5 Filesystem
> [ 3.200886] XFS (sdb1): Ending clean mount
> [ 5.384218] XFS (sdb1): Unmounting Filesystem
>
> Relevant code:
>
> [rfreire@rf ~]$ cd ../xfs
>
> [rfreire@rf xfs]$ grep "Mounting V" *.c
> xfs_log.c:              xfs_notice(mp, "Mounting V%d Filesystem",
>
>
> > On the idea of adding cifsFYI logging here - I slightly prefer using
> > ftrace (trace-cmd, ie dynamic tracing) so there is less overhead and
> > easier to turn on/off following the example of xfs, f2fs, nfs, nfsd
> > etc.
>
> Remember that cifsFYI already exists; I just moved it inside a if clause
> to print it only when running under debug. (they way it is originally).
>
> > On Tue, Oct 2, 2018 at 6:57 AM Rodrigo Freire <rfreire@redhat.com> wrote:
> > >
> > > Currently, no messages are printed when mounting a CIFS filesystem and
> > > no debug configuration is enabled.
> > >
> > > However, a CIFS mount information is valuable when troubleshooting
> > > and/or forensic analyzing a system and finding out if was a CIFS
> > > endpoint mount attempted.
> > >
> > > Other filesystems such as XFS, EXT* does issue a printk() when mounting
> > > their filesystems.
>
>
> > --
> > Thanks,
>
> Thank You! o/



-- 
Thanks,

Steve
