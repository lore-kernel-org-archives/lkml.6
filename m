Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0D4C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA06B20857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA06B20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeIEQMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 12:12:44 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39404 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbeIEQMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 12:12:43 -0400
Received: by mail-yw1-f67.google.com with SMTP id m62-v6so2495469ywd.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 04:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8FHqLnxkzoMrMFgMukwdYSWdKfR3UQNGNZqGAZXzaic=;
        b=lHwInj0kd+o++LjSIy5moFqzppmoZydDKwZCcaBbKp0r4GYl0KgdLT6I4lGVZqdvtI
         oCdTXmnCNdNfFInq3dlutj88WxMnaayaKBracFOQCdsyPiVwGaR/iKwmwfgWQ799GHnk
         UdLuE8PjT1e2R1766PKRg8d5POKEx4OqsHO8icvKPf3lGzaRy90VoBwMacO0r+JCTjT7
         O5P5Bp4dHinYQkCmlCMv7gzK3lUlWt0pTLdtgFL6ENKkkOHyxsIbuqcW1f/XJj3WqH2F
         s2GGeyXv/FReFZIMJ4KJ4osJEDx6+6O96df3b6frqWsisIi03WDRPyYgDOtAhI7oJTf+
         Wrsw==
X-Gm-Message-State: APzg51Dg6C9tZjxs+3jpBZFPUjt8ab7hn6CnGxpi8+9ufbxOTJldtjux
        lxu0jWn3+xgb47geEdhC8ZGrWSdbOmQ=
X-Google-Smtp-Source: ANB0Vdadf7jmycS/tpjLxYnJoFanBYfB9eT5v7vCnWM3R7rVBBzrLtdn/gzlVDLNsTjw9w05Tm06WA==
X-Received: by 2002:a0d:c584:: with SMTP id h126-v6mr20084774ywd.425.1536147769165;
        Wed, 05 Sep 2018 04:42:49 -0700 (PDT)
Received: from tleilax.poochiereds.net (cpe-2606-A000-1100-DB-0-0-0-E2E.dyn6.twc.com. [2606:a000:1100:db::e2e])
        by smtp.gmail.com with ESMTPSA id h68-v6sm626646ywc.7.2018.09.05.04.42.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 04:42:48 -0700 (PDT)
Message-ID: <5fec9eccdb2e7418d7c594ce353557ed1c394d96.camel@redhat.com>
Subject: Re: POSIX violation by writeback error
From:   Jeff Layton <jlayton@redhat.com>
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     =?UTF-8?Q?=E7=84=A6=E6=99=93=E5=86=AC?= <milestonejxd@gmail.com>,
        R.E.Wolff@bitwizard.nl, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Date:   Wed, 05 Sep 2018 07:42:46 -0400
In-Reply-To: <1959947.mKHFU3S0Eq@merkaba>
References: <CAJDTihz-rFb2SGaxZsQnXGnee_2qW_ynhPe=tZ4yzQBSV_KQ1g@mail.gmail.com>
         <CAJDTihw7T8WLme09W8VHCRfiALq4fxg1ZsywcSjn6hXsAw5wRw@mail.gmail.com>
         <cd137e88c9e882200c08c7336aa7b5a1c84a7ba3.camel@redhat.com>
         <1959947.mKHFU3S0Eq@merkaba>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-09-05 at 09:37 +0200, Martin Steigerwald wrote:
> Jeff Layton - 04.09.18, 17:44:
> > > - If the following read() could be served by a page in memory, just
> > > returns the data. If the following read() could not be served by a
> > > page in memory and the inode/address_space has a writeback error
> > > mark, returns EIO. If there is a writeback error on the file, and
> > > the request data could not be served
> > > by a page in memory, it means we are reading a (partically)
> > > corrupted
> > > (out-of-data)
> > > file. Receiving an EIO is expected.
> > 
> > No, an error on read is not expected there. Consider this:
> > 
> > Suppose the backend filesystem (maybe an NFSv3 export) is really r/o,
> > but was mounted r/w. An application queues up a bunch of writes that
> > of course can't be written back (they get EROFS or something when
> > they're flushed back to the server), but that application never calls
> > fsync.
> > 
> > A completely unrelated application is running as a user that can open
> > the file for read, but not r/w. It then goes to open and read the file
> > and then gets EIO back or maybe even EROFS.
> > 
> > Why should that application (which did zero writes) have any reason to
> > think that the error was due to prior writeback failure by a
> > completely separate process? Does EROFS make sense when you're
> > attempting to do a read anyway?
> > 
> > Moreover, what is that application's remedy in this case? It just
> > wants to read the file, but may not be able to even open it for write
> > to issue an fsync to "clear" the error. How do we get things moving
> > again so it can do what it wants?
> > 
> > I think your suggestion would open the floodgates for local DoS
> > attacks.
> 
> I wonder whether a new error for reporting writeback errors like this 
> could help out of the situation. But from all I read here so far, this 
> is a really challenging situation to deal with.
> 
> I still remember how AmigaOS dealt with this case and from an usability 
> point of view it was close to ideal: If a disk was removed, like a 
> floppy disk, a network disk provided by Envoy or even a hard disk, it 
> pops up a dialog "You MUST insert volume <name of volume> again". And if 
> you did, it continued writing. That worked even with networked devices. 
> I tested it. I unplugged the ethernet cable and replugged it and it 
> continued writing.
> 
> I can imagine that this would be quite challenging to implement within 
> Linux. I remember there has been a Google Summer of Code project for 
> NetBSD at least been offered to implement this, but I never got to know 
> whether it was taken or even implemented. If so it might serve as an 
> inspiration. Anyway AmigaOS did this even for stationary hard disks. I 
> had the issue of a flaky connection through IDE to SCSI and then SCSI to 
> UWSCSI adapter. And when the hard disk had connection issues that dialog 
> popped up, with the name of the operating system volume for example.
> 
> Every access to it was blocked then. It simply blocked all processes 
> that accessed it till it became available again (usually I rebooted  in 
> case of stationary device cause I had to open case or no hot plug 
> available or working). 
> 
> But AFAIR AmigaOS also did not have a notion of caching writes for 
> longer than maybe a few seconds or so and I think just within the device 
> driver. Writes were (almost) immediate. There have been some 
> asynchronous I/O libraries and I would expect an delay in the dialog 
> popping up in that case.
> 
> It would be challenging to implement for Linux even just for removable 
> devices. You have page dirtying and delayed writeback – which is still 
> an performance issue with NFS of 1 GBit, rsync from local storage that 
> is faster than 1 GBit and huge files, reducing dirty memory ratio may 
> help to halve the time needed to complete the rsync copy operation. And 
> you would need to communicate all the way to userspace to let the user 
> know about the issue.
> 

You may be interested in Project Banbury:

http://www.wil.cx/~willy/banbury.html

> Still, at least for removable media, this would be almost the most 
> usability friendly approach. With robust filesystems (Amiga Old 
> Filesystem and Fast Filesystem was not robust in case of sudden write 
> interruption, so the "MUST" was mean that way) one may even offer 
> "Please insert device <name of device> again to write out unwritten data 
> or choose to discard that data" in a dialog. And for removable media it 
> may even work as blocking processes that access it usually would not 
> block the whole system. But for the operating system disk? I know how 
> Plasma desktop behaves during massive I/O operations. It usually just 
> completely stalls to a halt. It seems to me that its processes do some 
> I/O almost all of the time … or that the Linux kernel blocks other 
> syscalls too during heavy I/O load.
> 
> I just liked to mention it as another crazy idea. But I bet it would 
> practically need to rewrite the I/O subsystem in Linux to a great 
> extent, probably diminishing its performance in situations of write 
> pressure. Or maybe a genius finds a way to implement both. :)
> 
> What I do think tough is that the dirty page caching of Linux with its 
> current standard settings is excessive. 5% / 10% of available memory 
> often is a lot these days. There has been a discussion reducing the 
> default, but AFAIK it was never done. Linus suggested in that discussion 
> to about what the storage can write out in 3 to 5 seconds. That may even 
> help with error reporting as reducing dirty memory ratio will reduce the 
> memory pressure and so you may choose to add some memory allocations for 
> error handling. And the time till you know its not working may be less.
> 
-- 
Jeff Layton <jlayton@redhat.com>

