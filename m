Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC65C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 21:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C0A20820
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 21:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09C0A20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbeKYIJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 03:09:43 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43226 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeKYIJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 03:09:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so15230638wrs.10;
        Sat, 24 Nov 2018 13:20:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9K8bOxJv3ckrE+VIJSJ0LJjb71TbkrvWZ4pLGxtphHc=;
        b=Cbe6dkarU+O/cua6ilKuyR+rOURdSi1DvAL4Tr1W5BAdgeZhsga+m4wSTRLNdmn93Z
         FDUkaiT7svA1NfC7IM42VnbXwFcWrFymtqXYS7S9k14AsPfZtRKc1pF6K1FVOmU/ZsLJ
         qj9Fyt9QiHT4rbG5l3+G/BqGYc/1YB792HPKDgNAQY2UQWe74ZgnN14cVOvmgR+yD5yY
         MCSmtr/RWrweNkqL5BvqQKf66sXJXeAFbNZ9IBgpC7vxkxsZoF5F56MvaNqDRsI1OmxB
         jfQSN4iwkqILvlL3Xh1CYmjYBFsfbj167+D0sqVLFNIhO3RbUT6s+Lw1EPUgzC/1ZPMd
         K33g==
X-Gm-Message-State: AA+aEWaB8Nfxhor0XEmOQLg3r1FNYjiR+1uUbe0tw5e6cTgIVADxZLc0
        UrGwUYNPt5Szr+GzK/SK/A==
X-Google-Smtp-Source: AFSGD/WqNkFtbOH7y/HzalMZe7Yvam1dugRV4ZQxlS1S0fd6UngnKujNzFqq90ZwWyoPxE8SSJU/bA==
X-Received: by 2002:a5d:5351:: with SMTP id t17mr18209302wrv.288.1543094422717;
        Sat, 24 Nov 2018 13:20:22 -0800 (PST)
Received: from box ([213.145.108.55])
        by smtp.gmail.com with ESMTPSA id a12sm22244650wrm.45.2018.11.24.13.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 24 Nov 2018 13:20:21 -0800 (PST)
Date:   Sat, 24 Nov 2018 23:20:14 +0200
From:   Slavomir Kaslev <kaslevs@vmware.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+ce18da013d76d837144d@syzkaller.appspotmail.com>,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        kgraul@linux.ibm.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, stranche@codeaurora.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in csum_and_copy_to_iter
Message-ID: <20181124211918.GA20435@box>
References: <0000000000001ecaa1057b6e4489@google.com>
 <20181124200357.GC2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181124200357.GC2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 08:03:57PM +0000, Al Viro wrote:
> On Sat, Nov 24, 2018 at 11:40:03AM -0800, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    edeca3a769ad Merge tag 'sound-4.20-rc4' of git://git.kerne..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=12bee26d400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=73e2bc0cb6463446
> > dashboard link: https://syzkaller.appspot.com/bug?extid=ce18da013d76d837144d
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ccd1f5400000
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+ce18da013d76d837144d@syzkaller.appspotmail.com
> 
> Caused by commit 95506588d2c1d72ca29adef8ae9bf771bcfb4ced
> Author: Slavomir Kaslev <kaslevs@vmware.com>
> Date:   Fri Nov 16 11:27:53 2018 +0200
> 
>     socket: do a generic_file_splice_read when proto_ops has no splice_read
> 
> exposing all ->recvmsg() instances to pipe-backed iov_iter as possible destination.
> It's not all that hard to fix (I'll probably have a candidate patch by tonight,
> it's just a matter of adding the only missing primitive), but... shouldn't that
> patch have sat in -next for at least some testing first?  Because it's very
> easy to reproduce - splice from e.g. UDP socket will step into it.  Sure, the
> sky is not falling (unless you set panic-on-WARN, that is); the damn thing
> would've failed anyway, but...

My bad for not sending the patch tagged as net-next, feel free to revert it.
