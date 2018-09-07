Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8432FC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE5E2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="sOnxnz2s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE5E2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbeIGSJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 14:09:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38133 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbeIGSJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 14:09:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id w11-v6so15002681wrc.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 06:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U37lJ+prfQJVQLgrPWTUPiIbn6AtqisWG8MdHj+iU+w=;
        b=sOnxnz2sq437gQTSAS2lO+BoIMOJCwJD3OmovVoUrO45654BIBCM9rDbIOknPAW36a
         FMys2yNuIG7V6dITkdolwx+Nagdz3k7WIoy7iypeIDnAUQKwTN1FN25t2nOCr7zhtniM
         EDSZcovS/V2yBGIOfdKgAD4VruioNGG2WIBXDViZVnQBJw3nqgHhFpaVDxorGdFm9mns
         McG6BDqCe7hLXqSWFRAGbQ1siX2km93GaPKRa8Iunt5Wae+F9RvvyEeEMMgqPXaU15HW
         pCRed8UifAUBxnQm3IPZnhVgH7bu97mWvKWSOUVoVyY4WM8aHQ80HyOADkOXtHUYSXo6
         /Qcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=U37lJ+prfQJVQLgrPWTUPiIbn6AtqisWG8MdHj+iU+w=;
        b=Eq+dwaTi4Xpf/lQuESJz9NJevIYuNsyIN8XKKwAaVnlacA+AoQvq3yXE53yoeQFpge
         3ISKc5dVCMUlH7g/icqh6+n3ecXDlQcBwoSHbeb/q/q72o1CjPsScIWhfRTDvF9R4atY
         RJWkzzHzQuxEEZ2rpXVZG+qjmcVsEsUsNwFkiWEI75fY/fE/ApKV7DbSctRORGm4QuMT
         +HGPTTvPBENSlgOeusM3NtskPpNsxP4bEbmGBWx5YuAZMmSMsrwyr+Qgc+Ka+ugf3Ypi
         m5daVZwlLTJEbSyC5E2psJTDEY4mg44etGhnGClpkQfEg4hZ8iGcapCsaG9xht0199fW
         3LGA==
X-Gm-Message-State: APzg51BkuM9y9CBYDT3kzTDo9cxtVfU0S/mDhLq77ZrdMHUpkQZPwaYI
        6k8rFQwh+C+hhvRDLReDvHncgg==
X-Google-Smtp-Source: ANB0VdazuOexZXZIucuLfBmSyAWumCgwq2Pm6BGgdAJOC41l6Tn56sG7BQZGIUlsFlP/iDgsAs4XVQ==
X-Received: by 2002:adf:9a46:: with SMTP id z64-v6mr5920857wrb.109.1536326910502;
        Fri, 07 Sep 2018 06:28:30 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at. [212.186.191.219])
        by smtp.gmail.com with ESMTPSA id w4-v6sm13282416wro.24.2018.09.07.06.28.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 06:28:29 -0700 (PDT)
Date:   Fri, 7 Sep 2018 15:28:28 +0200
From:   Lars Ellenberg <lars.ellenberg@linbit.com>
To:     Valentin Vidic <Valentin.Vidic@CARNet.hr>
Cc:     drbd-user@lists.linbit.com, Jens Axboe <axboe@kernel.dk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-block@vger.kernel.org, xen-devel@lists.xenproject.org,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Subject: Re: [DRBD-user] [PATCH] xen-blkback: Switch to closed state after
 releasing the backing device
Message-ID: <20180907132828.GC11834@soda.linbit>
Mail-Followup-To: Valentin Vidic <Valentin.Vidic@CARNet.hr>,
        drbd-user@lists.linbit.com, Jens Axboe <axboe@kernel.dk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-block@vger.kernel.org, xen-devel@lists.xenproject.org,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
References: <20180829065214.23546-1-Valentin.Vidic@CARNet.hr>
 <20180905103649.edugijsjx4v2fbxd@mac.bytemobile.com>
 <20180905162756.GA26705@gavran.carpriv.carnet.hr>
 <20180907120337.GB11834@soda.linbit>
 <20180907121348.GM26705@gavran.carpriv.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907121348.GM26705@gavran.carpriv.carnet.hr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 02:13:48PM +0200, Valentin Vidic wrote:
> On Fri, Sep 07, 2018 at 02:03:37PM +0200, Lars Ellenberg wrote:
> > Very frequently it is *NOT* the "original user", that "still" holds it
> > open, but udev, or something triggered-by-udev.
> > 
> > So double-checking the udev rules,
> > or the "lvm global_filter" settings may help.
> > You could instrument DRBD to log current->{pid,comm} on open and close,
> > so you can better detect who the "someone" is in the message above.
> 
> Don't think there is anything else holding the device open, because it
> is possible to change state to Secondary a few seconds later. But I will
> try to print those values in case anything interesting comes up.
> 
> > Adding a small retry loop in the script may help as well.
> 
> Yes, that is an option, but it would still leave those nasty "State
> change failed" messages in the log. I guess there is no way to check
> the value of DRBD device->open_cnt from userspace?

We don't expose that, no.
But even if we did, that would not be racefree :-)

The last (or even: any?) "close" of a block device that used to be open
for WRITE triggeres a udev "change" event, thus a udev run,
and the minimal action will be some read-only open and ioctl from
(systemd-)udev itself, more likely there also will be blkid and possibly
pvscan and similar actions. All of them should be read-only openers,
and all of them should be "short".
But they will race with the drbd demotion.

You can watch that happen with
# udevadm monitor &
then open and close for write:
# : > /dev/sda
(or any other block device ...)

To excercise the drbd vs udev race,
(you can leave the udevadm monitor running if you want):
## clear dmesg
# dmesg -c > /dev/null
## promote
# drbdadm primary s0 ;
## open/close for write
# : > /dev/drbd0 ;
## the close has triggered a udev run,
## which will now race with demotion,
## which will "sometimes" fail:
# drbdadm secondary s0 ;
## wait a bit, and retry
# sleep 1; drbdadm secondary s0 ; dmesg

### --- example output on some test box right now: ----------------
@root@ava:~# udevadm monitor &
...
monitor will print the received events for:
UDEV - the event which udev sends out after rule processing
KERNEL - the kernel uevent
...
@root@ava:~# dmesg -c > /dev/null; drbdadm primary s0 ; : > /dev/drbd0 ; drbdadm secondary s0  ; sleep 1; drbdadm secondary s0 ; dmesg
KERNEL[609638.990320] change   /devices/virtual/block/drbd0 (block)
KERNEL[609638.991364] change   /devices/virtual/block/drbd0 (block)
UDEV  [609639.008879] change   /devices/virtual/block/drbd0 (block)
0: State change failed: (-12) Device is held open by someone
Command 'drbdsetup-84 secondary 0' terminated with exit code 11
UDEV  [609639.011652] change   /devices/virtual/block/drbd0 (block)
KERNEL[609640.017356] change   /devices/virtual/block/drbd0 (block)
KERNEL[609640.018074] change   /devices/virtual/block/drbd0 (block)
[609613.882751] block drbd0: role( Secondary -> Primary )
[609613.889998] block drbd0: State change failed: Device is held open by someone
[609613.894280] block drbd0:   state = { cs:WFConnection ro:Primary/Unknown ds:UpToDate/Outdated r----- }
[609613.897609] block drbd0:  wanted = { cs:WFConnection ro:Secondary/Unknown ds:UpToDate/Outdated r----- }
[609614.909537] block drbd0: role( Primary -> Secondary )
[609614.909662] block drbd0: 0 KB (0 bits) marked out-of-sync by on disk bit-map.
UDEV  [609640.024588] change   /devices/virtual/block/drbd0 (block)
UDEV  [609640.028731] change   /devices/virtual/block/drbd0 (block)
@root@ava:~#
### --------------------------------------------------------------

Obviously change s0 and drbd0 appropriately; to exactly hit the time
window where udev has it open may be tricky, and on a busy system even
the sleep 1 can be not enough (so even the second invocation may fail
still), on an idle system udev may already be done, or may not even have
started yet when the first "secondary" runs.

Your best bet is to review your udev rules,
and make sure "drbd*" will not be looked at
by blkid or pvscan or similar.

See also: https://github.com/systemd/systemd/commit/fee854ee8ccde
respectively https://github.com/systemd/systemd/issues/9371
to get rid even of the unconditional open by systemd-udevd itself.

Note,
I'm not saying blkback has no issue; I don't know.
I'm just pointing out that there are other things
that may cause the same effects.

    Lars

