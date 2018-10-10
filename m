Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E30C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40CD9214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S5rC8UuF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40CD9214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbeJJWOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:14:48 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:54618 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbeJJWOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:14:47 -0400
Received: by mail-it1-f195.google.com with SMTP id l191-v6so8438911ita.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 07:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/zt3J7yi+WcuHkC/u33aXoSlzeEXln7OK2wVN6j0xBo=;
        b=S5rC8UuFg25n09mnlVHyyStP0kbLLXN5OX+a64v9j3sqrE4vh5L+duJvSNNUaCGPOg
         oqNqBCFbYBBDwqmBeCirKKJSK6PKszD+4hZjy7eS1Hw9onWxE8kVMXMCPA6clyzfHnPR
         gcnVRpYxlZKxQhyXIGqdmlgjgrNCBn9nhYPtHx112T1Npd4rD64oEhJuPnjpf09kM0yv
         B6uu0GRuDJusRyJ2pHMiSdIy47xXk3mhEEfg2NOCd1DK5n2sn1btdTkjilLDATZhHFyh
         XUC35cej2QyhJE7BHxpBMW3yR7mLCIoPNiIOnzNmNTszGtUZT5+kJtkWRAxnffAWzG1E
         /1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/zt3J7yi+WcuHkC/u33aXoSlzeEXln7OK2wVN6j0xBo=;
        b=nYcZtt8JExrXS1QHtnnTVk+JlVFnFTuD7AHRsjL8lPRiwcAlSI22sbQcZjSw0EoWa/
         VBe3TMRfafWzBckcxEqUQjHkVd3WGidgNiZE7ULcCJCPHmNLUra86oXznoyoDSOsEG5v
         Kq/Mf/GnVDSGq6xfS7RexSN0Kr4zTOUZ95EJbOLZxpqfhJFnSgLKr7xjpQloWBBoYYq1
         4lIoR0psavRcq3i5hRxwqdxB0CET1472ADZXfJ/hAtuC/S8Z6MmYHicRd5+9STbakGFH
         i0wOAFr4zkSxyIgY4fo4pcSFNPXGFkuGCQPNKvW3WVj4KHwxms2rB5yDlJjrY2zu0iIA
         uVQQ==
X-Gm-Message-State: ABuFfoi1x/jpV7TOzNbo76Lgih3lL9NUnTG5GuKYD2DjKe/DWww+n8DQ
        K5WbltEq42a/fZCmaTHlsEDnk1bfjCtrAXQ+CvX1xA==
X-Google-Smtp-Source: ACcGV62n4VIoOXuJXYpco9PnaluhGCMM5F4jBmN5oHhwXKN/VTwQR9HBizi6AwC/HVs1fqkLeKiPL3/TUmSmMbkCO3k=
X-Received: by 2002:a02:55c1:: with SMTP id e184-v6mr25786170jab.35.1539183134711;
 Wed, 10 Oct 2018 07:52:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Wed, 10 Oct 2018 07:51:54
 -0700 (PDT)
In-Reply-To: <20181010144059.GA20918@nautica>
References: <000000000000ca61cd0571178677@google.com> <000000000000fddb150577c15af6@google.com>
 <20181009020949.GA29622@nautica> <CACT4Y+bv5dWx0JwCzTPD3mWJRaMHOtRVcvpV5fdQ5KS7zAF_fA@mail.gmail.com>
 <20181010144059.GA20918@nautica>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 10 Oct 2018 16:51:54 +0200
Message-ID: <CACT4Y+Zx5nDN-H8WfC4WtgK7YeAWZig9WsDr1J4DXZBZb+vgWQ@mail.gmail.com>
Subject: Re: BUG: corrupted list in p9_read_work
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        syzbot <syzbot+2222c34dc40b515f30dc@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        netdev <netdev@vger.kernel.org>,
        Ron Minnich <rminnich@sandia.gov>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 4:40 PM, Dominique Martinet
<asmadeus@codewreck.org> wrote:
> Dmitry Vyukov wrote on Wed, Oct 10, 2018:
>> How can they be faked?
>> If we could create a private rdma/virtio stub instance per test
>> process, then we could I think easily use that instance for 9p. But is
>> it possible?
>
> "RDMA" itself can be faked pretty easily nowadays, there's a "rxe"
> driver that is soft RDMA over ethernet and can run over anything.
>
> The problem is that you can't just give the client a file like trans fd;
> you'd need to open an ""rdma socket"" (simplifying wording a bit), and
> afaik there is no standard tool for it ; or rather, the problem is that
> RDMA is packet based so even if there were you can't just write stuff
> in a fd and hope it'll work, so you need a server.
>
> If you're interested, 9p is trivial enough that I could provide you with
> a trivial server that works like your file (just need to reimplement
> something that parses header to packetize it properly; so you could
> write to its stdin for example) ; that'd require some setup in the VM
> (configure rxe and install that tool), but it would definitely be
> possible.
> What do you think ?

I would like to hear more details.
Opening a socket is not a problem. Why do we need a tool for this?
I don't understand the problem with "packet-based" and what does it
mean to have a separate server? Any why?
We definitely don't want to involve a separate third-party server,
that's very problematic for multiple reasons. But we can have a chunk
of custom C code inside of syzkaller.
What exactly setup we need?

I guess it will make things simpler if you provide some kind of "hello
world" C program that mounts 9p/rdma. I don't need exact messages
(they will be same as with pipe transport, right?) nor actual server
implementation, but just the place where to inject these packets.
