Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1E2E5C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 04:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70C4208B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 04:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0XkzNzOB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70C4208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754468AbeFMEsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 00:48:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754399AbeFMEsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 00:48:00 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D12320693;
        Wed, 13 Jun 2018 04:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528865279;
        bh=eG1HDAEJVOkxdzsCNQ9zZJqUqK3ooAGWnZEfzEl9xhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0XkzNzOBO99HlASbkgtBawt8tKw4tEG8gAns6wL9tmxj2moNgKo7cXqpfACVALBxX
         qkn6AoB3YqiYfwydlWYL7U0aPx9tsbuK/pFIM6isIwk1URV0gpkZB17ZfRjyrfm7Sc
         T1MgYQK6Wn0pGPBdy7m/AOvWdOkFcqKwtxv8xERU=
Date:   Wed, 13 Jun 2018 06:47:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wanpeng Li <kernellwp@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM list <kvm@vger.kernel.org>
Subject: Re: [GIT PULL] KVM changes for 4.18 merge window
Message-ID: <20180613044738.GA353@kroah.com>
References: <1528812229-53043-1-git-send-email-pbonzini@redhat.com>
 <CA+55aFwvE5G7MV7AV4naAXdbFoszc4JNKEj_QtYqpLFfa2RXtA@mail.gmail.com>
 <CA+55aFza9udpsCY=_YuBoshgVoXSce-Ja-nsqRbm5eJ6MgXK1g@mail.gmail.com>
 <CANRm+Cx194zWU0TwoiCaiTy+3tuHp4Ki1mk2VUfv5-z00j23jA@mail.gmail.com>
 <CA+55aFywZ0aX6u-JO8=GciDm9stwXOmXU4oG-u0K8i+o3qLwvg@mail.gmail.com>
 <CA+55aFxZNyHoytCNV89tPP0TWEiR_-nOja-HA5i4zY446VFCVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxZNyHoytCNV89tPP0TWEiR_-nOja-HA5i4zY446VFCVA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 08:26:46PM -0700, Linus Torvalds wrote:
> On Tue, Jun 12, 2018 at 8:00 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Yeah, the biusection seems to actually be diving into Greg's device pulls.
> >
> > Odd. I'm not seeing why that would break kvm, but maybe there's
> > something in the device core layer that really messed it up.
> >
> > I'll continue to bisect to see.
> 
> Ok, so commit 95cde3c59966 ("debugfs: inode: debugfs_create_dir uses
> mode permission from parent") breaks lkvm, and I think qemu-kvm too.
> 
> The commit looks like the RightThing(tm) to do, but we do not break
> existing work-flows, no matter how much we'd like to.  So it gets
> reverted.
> 
> Greg, Thomas, perhaps some alternative model? I'm not sure exactly
> what kvm needs from debugfs.

I don't know either, I have a revert of that patch sitting in my queue
waiting to send to you for 4.18-rc1.  I didn't realize it was causing
breakage for others, or I would have sent it to you now.  You can revert
it yourself now if you want, so we can fix this problem now and work on
figuring out what is so "odd" about kvm's debugfs files.

thanks,

greg k-h
