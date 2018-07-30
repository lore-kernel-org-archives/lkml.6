Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CDAC46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 06:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED1D20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 06:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED1D20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbeG3Hd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 03:33:58 -0400
Received: from nautica.notk.org ([91.121.71.147]:33382 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbeG3Hd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 03:33:58 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id AE7E8C009; Mon, 30 Jul 2018 08:00:36 +0200 (CEST)
Date:   Mon, 30 Jul 2018 08:00:21 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Tomas Bortoli <tomasbortoli@gmail.com>,
        David Miller <davem@davemloft.net>,
        v9fs-developer@lists.sourceforge.net,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH] 9p: fix Use-After-Free in p9_write_work()
Message-ID: <20180730060021.GA22926@nautica>
References: <20180729130248.29612-1-tomasbortoli@gmail.com>
 <20180729233336.GB28684@nautica>
 <CACT4Y+bf1NfCV9aTRCR_qwA0jWxhYDkR3CS8jQcJyvkYXCming@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+bf1NfCV9aTRCR_qwA0jWxhYDkR3CS8jQcJyvkYXCming@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov wrote on Mon, Jul 30, 2018:
> On Mon, Jul 30, 2018 at 1:33 AM, Dominique Martinet
> <asmadeus@codewreck.org> wrote:
> > Tomas Bortoli wrote on Sun, Jul 29, 2018:
> >> There is a race condition between p9_free_req() and p9_write_work().
> >> A request might still need to be processed while p9_free_req() is called.
> >>
> >> To fix it, flush the read/write work before freeing any request.
> >>
> >> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
> >> Reported-by: syzbot+467050c1ce275af2a5b8@syzkaller.appspotmail.com
> >
> > It looks like I have not received this report, I found it through google
> > in the lkml archives
> 
> But you should have been received it? Or not?
> We had some complaints that syzbot emails were not delivered, but in
> these cases they were not delivered to lkml,  and only to explicitly
> CCed people.

I'm not on lkml and the archives I found do not list who were Cc'd that
I can see - it might have tried to send a copy to v9fs-developer that is
held up in the moderation queue for all I know :/

I'm not complaining I didn't get a copy (if I ever find time to work on
these, I can work through the list on the website) - I just need to know
how to find the report corresponding to patchs being sent.


> > but Dmitry do you have a convenient-ish way of
> > finding the report on the syzkaller website with that reported-by tag?
> 
> Well, you can do:
> http://syzkaller.appspot.com/bug?extid=467050c1ce275af2a5b8

Thanks, for some reason I only thought of bug?id= which didn't work,
this is perfect.


Cheers,
-- 
Dominique
