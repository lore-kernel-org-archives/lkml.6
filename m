Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D927AC64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C71E20652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mc+V7jwf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C71E20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbeJCELT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:11:19 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44781 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeJCELT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:11:19 -0400
Received: by mail-pf1-f196.google.com with SMTP id r9-v6so432216pff.11;
        Tue, 02 Oct 2018 14:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ObQSEbjb8kqcK3nc6R1ek7eGS1GKB1OUVmlz4oJH/EU=;
        b=Mc+V7jwfowCw4RhhC2Q8wXapF7Oa/4n+BBtkmvKH7gMwzM96q+7FBV2DiCN491yvxU
         C/NBY5kew/VPLfNcsa3FQx9OIfT4q86r+ZFFO6tt2cpZtoVpLNH0YTvt8WXxCvED4XTX
         YxWGGsiINds8YL3vyPK2IX6VnGWsABKGxjNZQkuCrpGvme01CP3BViYYwVQkikPVuiWQ
         Z5RWBOBx2vLo4L8Bfj/ARv0A0M2g/+o+qHSg2w98/zJLT+HhDXALV9g0bjO1p7fIKhN1
         3RB8g/+HRyhgVSGcKnv0x7LX2hVClOm3y/XwW2isoSsfYCAkMrxzBSbkMZl9ZY22LZzk
         oESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ObQSEbjb8kqcK3nc6R1ek7eGS1GKB1OUVmlz4oJH/EU=;
        b=mbB3VNH+3U4pKhIKZ1XYNEpYqyX4rYDVDiFJm8hwpYylT+FUOeWXejkl+7Mx8bxqT3
         7yzpIHYQtRlyS4Y09Nqa4q1IUW3lO0A4/xFJTTWx4/PxfRiJ9TRLHlciGuufaE7JdyTv
         pHlDNL4UYE0z/iy8FxIBtr1rSUXI2aDYuw0/Ya21T9enxoyrbHkA4ZUPk+qEMYnkZuwM
         O36qOf/R+nieS9CKePb7a7KA+vravE0NeoArPVwommG8KGGfmWIcBvOYNFFxclSf9AwR
         L1gdoaAVrG7USqDF+gGhd6Akng/5R5zmfOJtxyxkbjWPWuMwWzlclUgkZbW/T+la7u4U
         X0AQ==
X-Gm-Message-State: ABuFfogG/pdyvn+Vkh+K/lWkg/ANdgHPhr1oXjcpzbHHLnE2fwXsDI+x
        C6AcAnZU97rd8RCS4l0gPr5YTF1vXhjuqY4ibY0=
X-Google-Smtp-Source: ACcGV63U2+Te4Rr1EDkDTYBCZC1lWt8yHimdnXqiFrNMSQKsdBQT113OFx3Yr+0RCCHHuocngYojmNt7TMW+w66qfBA=
X-Received: by 2002:a62:3995:: with SMTP id u21-v6mr18204751pfj.116.1538515558092;
 Tue, 02 Oct 2018 14:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <ad6b338c900a17c4ecb1655a42b954221f242be2.1538480816.git.rfreire@redhat.com>
 <CAH2r5mtu9XbQfR=QevDqu36ZRYah1hrRGSQyynCfr82PRyunwQ@mail.gmail.com>
 <194690850.32402710.1538508513975.JavaMail.zimbra@redhat.com>
 <CAH2r5ms814MUNWVZNfCTuSO2LQZsmCs5N1nwgdVuhxtMctRE3Q@mail.gmail.com> <697659653.32427271.1538515234390.JavaMail.zimbra@redhat.com>
In-Reply-To: <697659653.32427271.1538515234390.JavaMail.zimbra@redhat.com>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 2 Oct 2018 16:25:46 -0500
Message-ID: <CAH2r5muV-vC6twZbNQQ3DHoXJTdaUwhzZi7YH+rhxr0BiMseJQ@mail.gmail.com>
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

It is an interesting question - my gut reaction is that messages that
need more immediate attention should be logged as KERN_ERR (similar to
cifs_dbg(VFS ...) but given how easy it is now to use dynamic tracing
and better to read, if a developer would need it ... probably best to
use ftrace (trace-cmd).  Note that xfs has more than 570 (!) dynamic
trace point callouts now vs. fewer than 30 for xfs_notice
On Tue, Oct 2, 2018 at 4:20 PM Rodrigo Freire <rfreire@redhat.com> wrote:
>
> Hi Steve o/
>
> I personally like more a pr_info() instead of a cifs_dbg (which wraps to a
> pr_warn). But in order to keep in line with the general CIFS coding style
> I stuck to cifs_dbg
>
> But I would happily rewrite the cifs_dbg to pr_info a v3: That would be
> good enough too.
>
> Ah for what is worth my test/target systems are CentOS/Red Hat Enterprise
> Linux.
>
> Thoughts?
>
> Thanks!
>
> - RF.
>
> ----- Original Message -----
> > From: "Steve French" <smfrench@gmail.com>
> > To: rfreire@redhat.com
> > Cc: "LKML" <linux-kernel@vger.kernel.org>, "Steve French"
> > <sfrench@samba.org>, "CIFS" <linux-cifs@vger.kernel.org>, "Pavel Shilovsky"
> > <piastryyy@gmail.com>
> > Sent: Tuesday, October 2, 2018 5:35:49 PM
> > Subject: Re: [PATCH v2] CIFS: Print message when attempting a mount
>
> > I noticed that on at least the first system I looked at (Ubuntu 18.04)
> > it defaults to KERN_WARNING (ie 4) so wouldn't have shown a KERN_INFO
> > which is level 6 (as the mount example from ext4) by default
> > or the xfs_notice (which is level 5)
>
> > https://elinux.org/Debugging_by_printing
>
> > On Tue, Oct 2, 2018 at 2:28 PM Rodrigo Freire <rfreire@redhat.com> wrote:
> > >
> > > Hi Steve,
> > >
> > > ----- Original Message -----
> > > > From: "Steve French" <smfrench@gmail.com>
> > > > To: rfreire@redhat.com
> > > > Cc: "LKML" <linux-kernel@vger.kernel.org>, "Steve French"
> > > > <sfrench@samba.org>, "CIFS" <linux-cifs@vger.kernel.org>, "Pavel
> > > > Shilovsky"
> > > > <piastryyy@gmail.com>
> > > > Sent: Tuesday, October 2, 2018 4:17:02 PM
> > > > Subject: Re: [PATCH v2] CIFS: Print message when attempting a mount
> > > >
> > > > Are you sure that these aren't logged by the automounter (for ext4,
> > > > xfs etc.). When I looked in my dmesg logs I didn't find matching log
> > > > entries in the file systems themselves. Do you have an example?
> > >
> > > I'm positive about it. Check it out:
> > >
> > > [rfreire@rf ~]$ cd git/upstream/fs/ext4/
> > > [rfreire@rf ext4]$
> > > [rfreire@rf ext4]$
> > > [rfreire@rf ext4]$ grep -r "mounted filesystem with"
> > > super.c: ext4_msg(sb, KERN_INFO, "mounted filesystem with%s. "
> > >
> > >
> > > [rfreire@rf ext4]$ dmesg | grep mount
> > > [ 21.550897] EXT4-fs (dm-1): mounted filesystem with ordered data mode.
> > > Opts: (null)
> > > [ 22.216213] EXT4-fs (dm-1): re-mounted. Opts: discard
> > > [ 22.598267] EXT4-fs (sda1): mounted filesystem with ordered data mode.
> > > Opts: (null)
> > > [ 22.605225] EXT4-fs (sdc): mounted filesystem without journal. Opts:
> > > discard
> > > [ 24.029161] EXT4-fs (dm-2): mounted filesystem with ordered data mode.
> > > Opts: (null)
> > > [ 24.047777] EXT4-fs (dm-4): mounted filesystem without journal. Opts:
> > > (null)
> > >
> > > XFS sample dmesg (from
> > > https://www.reddit.com/r/archlinux/comments/40b9r9/xfs_partition_is_mounted_during_boot_and_then/):
> > >
> > > [ 2.764491] XFS (sdb1): Mounting V5 Filesystem
> > > [ 3.200886] XFS (sdb1): Ending clean mount
> > > [ 5.384218] XFS (sdb1): Unmounting Filesystem
> > >
> > > Relevant code:
> > >
> > > [rfreire@rf ~]$ cd ../xfs
> > >
> > > [rfreire@rf xfs]$ grep "Mounting V" *.c
> > > xfs_log.c: xfs_notice(mp, "Mounting V%d Filesystem",
> > >
> > >
> > > > On the idea of adding cifsFYI logging here - I slightly prefer using
> > > > ftrace (trace-cmd, ie dynamic tracing) so there is less overhead and
> > > > easier to turn on/off following the example of xfs, f2fs, nfs, nfsd
> > > > etc.
> > >
> > > Remember that cifsFYI already exists; I just moved it inside a if clause
> > > to print it only when running under debug. (they way it is originally).
> > >
> > > > On Tue, Oct 2, 2018 at 6:57 AM Rodrigo Freire <rfreire@redhat.com> wrote:
> > > > >
> > > > > Currently, no messages are printed when mounting a CIFS filesystem and
> > > > > no debug configuration is enabled.
> > > > >
> > > > > However, a CIFS mount information is valuable when troubleshooting
> > > > > and/or forensic analyzing a system and finding out if was a CIFS
> > > > > endpoint mount attempted.
> > > > >
> > > > > Other filesystems such as XFS, EXT* does issue a printk() when mounting
> > > > > their filesystems.
> > >
> > >
> > > > --
> > > > Thanks,
> > >
> > > Thank You! o/
>
> > --
> > Thanks,
>
> > Steve



-- 
Thanks,

Steve
