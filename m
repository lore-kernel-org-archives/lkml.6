Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C511C476E8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886D221471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 886D221471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732354AbeGLQDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 12:03:48 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:39224 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbeGLQDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 12:03:47 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fdduT-0000aW-4j; Thu, 12 Jul 2018 15:53:37 +0000
Date:   Thu, 12 Jul 2018 16:53:37 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: vfs / overlayfs conflict resolution for linux-next
Message-ID: <20180712155337.GU30522@ZenIV.linux.org.uk>
References: <20180711021136.GN30522@ZenIV.linux.org.uk>
 <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
 <CA+55aFxc7M9g+jqVnMHAsK350Ty1tQ9AghuJhBug+FPA6=XQrw@mail.gmail.com>
 <20180711152555.GR30522@ZenIV.linux.org.uk>
 <20180711161540.GS30522@ZenIV.linux.org.uk>
 <20180712124326.GA19272@ZenIV.linux.org.uk>
 <CA+55aFwyOHvwV4qkmM1kRYQ+4brWbLSHaXE8GPV41u5Sj-AG4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwyOHvwV4qkmM1kRYQ+4brWbLSHaXE8GPV41u5Sj-AG4Q@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 08:05:26AM -0700, Linus Torvalds wrote:
> On Thu, Jul 12, 2018 at 5:43 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > A question regarding the customs in such situations - are previous
> > Reviewed-by/Acked-by normally kept across rebases like that?
> 
> Yeah, unless there were big changes, keep the reviewed/acked-by lines.
> 
> Otherwise you'd never be able to handle different people giving
> slightly different feedback about separate issues.

OK...  Miklos, I've pushed #ovl-candidate, with equivalent of the beginning
of your branch.  I'm *not* saying that I've no remaining issues
with your series - this is just how I'd prefer to resolve that group
of conflicts.

Everything past "vfs: simplify dentry_open()" could live on top of that
one, or its equivalent.

I'm going to put #work-open3 into -next, let's figure out what to do with
the conflicts; what I can promise is never-rebased status for #for-ovl
(the beginning of #work-open3 merged into #ovl-candidate).
