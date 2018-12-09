Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2795C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD762064D
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544355044;
	bh=GPt1KIS4gJzWl3mQn2Nqo+M6Nx/TfdYVEiAUDXY/ieM=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=Rvl83m6wb3D1Z1AfUkhmlwA3AnJ8eGdMXokdN7EFjg1LQOxiIb5lyaYAqDig8M+dU
	 vTlEO3gw4/BNtCfz3TdUq7zXMY7Ns2+K+l76n+ztLmq+i4rvZKpSpcvKZBN89c5i9R
	 NmFdVAPzvkkCPJ19AZLZK5puKVUd/K6H4Tk8vWf8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD762064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbeLILan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 06:30:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:37120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbeLILam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 06:30:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BBC12064D;
        Sun,  9 Dec 2018 11:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544355041;
        bh=GPt1KIS4gJzWl3mQn2Nqo+M6Nx/TfdYVEiAUDXY/ieM=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=Vcmnifi6kkgzZR3BZZnz1ulaHvNje7klk9VJxbjGG1unnA74Op/NaRU39WYIagErv
         akmGWB64Jtj5p8GG0SER1ZmUH5VXwxidDVGo7EBRd9almxJxYgCtMQSgaVIexKN3Y3
         K9wMioYZkK+PbK6NCo2KEbxFZZMSdat4f5ty/A2s=
Date:   Sun, 9 Dec 2018 12:30:39 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Laura Abbott <labbott@redhat.com>,
        stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Process for severe early stable bugs?
Message-ID: <20181209113039.GA10771@kroah.com>
References: <c04ea7b1-23f3-f1e0-4f31-07b62abdee24@redhat.com>
 <20181208115629.GA3288@kroah.com>
 <20181208171853.GA20708@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181208171853.GA20708@thunk.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2018 at 12:18:53PM -0500, Theodore Y. Ts'o wrote:
> On Sat, Dec 08, 2018 at 12:56:29PM +0100, Greg KH wrote:
> > A nice step forward would have been if someone could have at least
> > _told_ the stable maintainer (i.e. me) that there was such a serious bug
> > out there.  That didn't happen here and I only found out about it
> > accidentally by happening to talk to a developer who was on the bugzilla
> > thread at a totally random meeting last Wednesday.
> > 
> > There was also not an email thread that I could find once I found out
> > about the issue.  By that time the bug was fixed and all I could do was
> > wait for it to hit Linus's tree (and even then, I had to wait for the
> > fix to the fix...)  If I had known about it earlier, I would have
> > reverted the change that caused this.
> 
> So to be fair, the window between when we *know* what was the change
> that required reverting and the fix actually being available was very
> narrow.  For most of the 3-4 weeks when we were trying to track it
> down --- and the bug had been present in Linus's tree since
> 4.19-rc1(!) --- we had no idea exactly how big the problem was.
> 
> If you want to know about these sorts of things early --- at the
> moment the moment I and others at $WORK have been trying to track down
> a problem on a 4.14.x kernel which has symptoms that look ***eerily***
> similar to Bugzilla #201685.  There was another bug causing mysterious
> file system corruptions that may also be related that was noticed on
> an Ubuntu 4.13.x kernel which forced another team to fall back to a
> 4.4 kernel.  Both of these have caused file system corruptions that
> resulted in customer visible disruptions.  Ming Lei has now said that
> there is a theoretical bug which he now believes might be present in
> blk-mq starting in 4.11.
> 
> To make life even more annoying, starting in 4.14.63, disabling blk-mq
> is no longer even an *option* for virtio-scsi thanks to commit
> b5b6e8c8d3b4 ("scsi: virtio_scsi: fix IO hang caused by automatic irq
> vector affinity"), which was backported to 4.14 as of 70b522f163bbb32.
> We might try reverting that commit and then disabling blk-mq to see if
> it makes the problem go away.  But the problem happens very rarely ---
> maybe once a week across a population of 2500 or so VM's, so it would
> take a long time before we could be certain that any change would fix
> it in absence of a detailed root cause analysis or a clean repro that
> can be run in a test environment.
> 
> So now you know --- but it's not clear it's going to be helpful.
> Commit b5b6e8c8d3b4 was fixing another bug, so reverting it isn't
> necessarily the right thing, especially since we can't yet prove it's
> the cause of the problem.  It was "interesting" that we forced
> virtio-scsi to use blk-mq in the middle of a LTS kernel series,
> though.

Yes, this all was very helpful, thank you for the information I
appreciate it.

And I will watch out for these issues now.  It's a bit sad that these
are showing up in 4.14, but it seems that distros are only now starting
to really use that kernel version (or at least are only now starting to
report things from it), as it is a year old.  Oh well, can't do much
about that, I am more worried about the 4.19 issues like Laura was
talking about as that is the "canary" we need to watch out for more.

> P.P.P.S.  If I were king, I'd be asking for a huge number of kunit
> tests for block-mq to be developed, and then running them under a
> Thread Sanitizer.

Isn't that what xfs and fio is?  Aren't we running this all the time and
reporting those issues?  How did this bug not show up on those tests, is
it just because they didn't run long enough?

Because of those test suites, I was thinking that the block and
filesystem paths were one of the more well-tested things we had at the
moment, is this not true?

thanks,

greg k-h
