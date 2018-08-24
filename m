Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BA6C43615
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 01:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550872156B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 01:03:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 550872156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbeHXEfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 00:35:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbeHXEfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 00:35:31 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9C0920894;
        Fri, 24 Aug 2018 01:03:17 +0000 (UTC)
Date:   Thu, 23 Aug 2018 21:03:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+5702a7e6d4a13b3accd5@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: KASAN: slab-out-of-bounds Write in process_preds
Message-ID: <20180823210315.2449cf3e@vmware.local.home>
In-Reply-To: <CACT4Y+bSBgbSntkdEXFD+_aJZOrtMfm_WB0K7-psYVSVCg8vTg@mail.gmail.com>
References: <0000000000003723710569916833@google.com>
        <CACT4Y+Yz-zRdEKTJeSdK5QTqPtgsSqwoJ4WU8bcX+8RwXUAiSA@mail.gmail.com>
        <20180510102331.02ee1346@gandalf.local.home>
        <CACT4Y+bSBgbSntkdEXFD+_aJZOrtMfm_WB0K7-psYVSVCg8vTg@mail.gmail.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Aug 2018 07:13:13 -0700
Dmitry Vyukov <dvyukov@google.com> wrote:

> On Thu, May 10, 2018 at 7:23 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Thu, 10 May 2018 07:14:26 +0200
> > Dmitry Vyukov <dvyukov@google.com> wrote:
> >  
> >> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >> > Reported-by: syzbot+5702a7e6d4a13b3accd5@syzkaller.appspotmail.com
> >> > It will help syzbot understand when the bug is fixed. See footer for
> >> > details.
> >> > If you forward the report, please keep this part and the footer.  
> >>
> >>
> >> This was bisected to:
> >>
> >> commit 80765597bc587feae8dbc8ce97a0f32e12a6e625
> >> Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
> >> Date:   Fri Mar 9 13:19:28 2018 -0500
> >>
> >>     tracing: Rewrite filter logic to be simpler and faster  
> >
> > I could have told you that without the bisect ;-)
> >
> > I'll try to get some time to look into this.  
> 
> 
> It seems this was lost on kernel mailing lists, then re-reported after 2 months:
> https://bugzilla.kernel.org/show_bug.cgi?id=200019
> and then fixed.

Yeah, that time was quite busy for me. I guess I failed to get time to
look into it when it was first reported :-(

> 
> Since the fixing commit does not contain syzbot tag, need to tell it
> about the fix manually:
> 
> #syz fix: tracing: Check for no filter when processing event filters

Sorry about that. Thanks,

-- Steve
