Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557F5C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC0E21471
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC0E21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbeJCEFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:05:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43298 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727040AbeJCEFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:05:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9071AC02E618;
        Tue,  2 Oct 2018 21:20:34 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D4BC611D7;
        Tue,  2 Oct 2018 21:20:34 +0000 (UTC)
Received: from zmail19.collab.prod.int.phx2.redhat.com (zmail19.collab.prod.int.phx2.redhat.com [10.5.83.22])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 6D7B21809546;
        Tue,  2 Oct 2018 21:20:34 +0000 (UTC)
Date:   Tue, 2 Oct 2018 17:20:34 -0400 (EDT)
From:   Rodrigo Freire <rfreire@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Pavel Shilovsky <piastryyy@gmail.com>
Message-ID: <697659653.32427271.1538515234390.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAH2r5ms814MUNWVZNfCTuSO2LQZsmCs5N1nwgdVuhxtMctRE3Q@mail.gmail.com>
References: <ad6b338c900a17c4ecb1655a42b954221f242be2.1538480816.git.rfreire@redhat.com> <CAH2r5mtu9XbQfR=QevDqu36ZRYah1hrRGSQyynCfr82PRyunwQ@mail.gmail.com> <194690850.32402710.1538508513975.JavaMail.zimbra@redhat.com> <CAH2r5ms814MUNWVZNfCTuSO2LQZsmCs5N1nwgdVuhxtMctRE3Q@mail.gmail.com>
Subject: Re: [PATCH v2] CIFS: Print message when attempting a mount
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.10.122.13, 10.4.195.28]
Thread-Topic: CIFS: Print message when attempting a mount
Thread-Index: vT5l2hbRmXbxUpiZj0RtYL1C8uaHZw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 02 Oct 2018 21:20:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve o/

I personally like more a pr_info() instead of a cifs_dbg (which wraps to a
pr_warn). But in order to keep in line with the general CIFS coding style
I stuck to cifs_dbg

But I would happily rewrite the cifs_dbg to pr_info a v3: That would be
good enough too.

Ah for what is worth my test/target systems are CentOS/Red Hat Enterprise
Linux.

Thoughts?

Thanks!

- RF.

----- Original Message ----- 
> From: "Steve French" <smfrench@gmail.com>
> To: rfreire@redhat.com
> Cc: "LKML" <linux-kernel@vger.kernel.org>, "Steve French"
> <sfrench@samba.org>, "CIFS" <linux-cifs@vger.kernel.org>, "Pavel Shilovsky"
> <piastryyy@gmail.com>
> Sent: Tuesday, October 2, 2018 5:35:49 PM
> Subject: Re: [PATCH v2] CIFS: Print message when attempting a mount

> I noticed that on at least the first system I looked at (Ubuntu 18.04)
> it defaults to KERN_WARNING (ie 4) so wouldn't have shown a KERN_INFO
> which is level 6 (as the mount example from ext4) by default
> or the xfs_notice (which is level 5)

> https://elinux.org/Debugging_by_printing

> On Tue, Oct 2, 2018 at 2:28 PM Rodrigo Freire <rfreire@redhat.com> wrote:
> >
> > Hi Steve,
> >
> > ----- Original Message -----
> > > From: "Steve French" <smfrench@gmail.com>
> > > To: rfreire@redhat.com
> > > Cc: "LKML" <linux-kernel@vger.kernel.org>, "Steve French"
> > > <sfrench@samba.org>, "CIFS" <linux-cifs@vger.kernel.org>, "Pavel
> > > Shilovsky"
> > > <piastryyy@gmail.com>
> > > Sent: Tuesday, October 2, 2018 4:17:02 PM
> > > Subject: Re: [PATCH v2] CIFS: Print message when attempting a mount
> > >
> > > Are you sure that these aren't logged by the automounter (for ext4,
> > > xfs etc.). When I looked in my dmesg logs I didn't find matching log
> > > entries in the file systems themselves. Do you have an example?
> >
> > I'm positive about it. Check it out:
> >
> > [rfreire@rf ~]$ cd git/upstream/fs/ext4/
> > [rfreire@rf ext4]$
> > [rfreire@rf ext4]$
> > [rfreire@rf ext4]$ grep -r "mounted filesystem with"
> > super.c: ext4_msg(sb, KERN_INFO, "mounted filesystem with%s. "
> >
> >
> > [rfreire@rf ext4]$ dmesg | grep mount
> > [ 21.550897] EXT4-fs (dm-1): mounted filesystem with ordered data mode.
> > Opts: (null)
> > [ 22.216213] EXT4-fs (dm-1): re-mounted. Opts: discard
> > [ 22.598267] EXT4-fs (sda1): mounted filesystem with ordered data mode.
> > Opts: (null)
> > [ 22.605225] EXT4-fs (sdc): mounted filesystem without journal. Opts:
> > discard
> > [ 24.029161] EXT4-fs (dm-2): mounted filesystem with ordered data mode.
> > Opts: (null)
> > [ 24.047777] EXT4-fs (dm-4): mounted filesystem without journal. Opts:
> > (null)
> >
> > XFS sample dmesg (from
> > https://www.reddit.com/r/archlinux/comments/40b9r9/xfs_partition_is_mounted_during_boot_and_then/):
> >
> > [ 2.764491] XFS (sdb1): Mounting V5 Filesystem
> > [ 3.200886] XFS (sdb1): Ending clean mount
> > [ 5.384218] XFS (sdb1): Unmounting Filesystem
> >
> > Relevant code:
> >
> > [rfreire@rf ~]$ cd ../xfs
> >
> > [rfreire@rf xfs]$ grep "Mounting V" *.c
> > xfs_log.c: xfs_notice(mp, "Mounting V%d Filesystem",
> >
> >
> > > On the idea of adding cifsFYI logging here - I slightly prefer using
> > > ftrace (trace-cmd, ie dynamic tracing) so there is less overhead and
> > > easier to turn on/off following the example of xfs, f2fs, nfs, nfsd
> > > etc.
> >
> > Remember that cifsFYI already exists; I just moved it inside a if clause
> > to print it only when running under debug. (they way it is originally).
> >
> > > On Tue, Oct 2, 2018 at 6:57 AM Rodrigo Freire <rfreire@redhat.com> wrote:
> > > >
> > > > Currently, no messages are printed when mounting a CIFS filesystem and
> > > > no debug configuration is enabled.
> > > >
> > > > However, a CIFS mount information is valuable when troubleshooting
> > > > and/or forensic analyzing a system and finding out if was a CIFS
> > > > endpoint mount attempted.
> > > >
> > > > Other filesystems such as XFS, EXT* does issue a printk() when mounting
> > > > their filesystems.
> >
> >
> > > --
> > > Thanks,
> >
> > Thank You! o/

> --
> Thanks,

> Steve
