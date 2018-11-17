Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5521C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 14:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA632080C
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 14:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA632080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieldses.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbeKRAUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 19:20:42 -0500
Received: from fieldses.org ([173.255.197.46]:53522 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbeKRAUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 19:20:42 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 508FFBD1; Sat, 17 Nov 2018 09:03:56 -0500 (EST)
Date:   Sat, 17 Nov 2018 09:03:56 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>, NeilBrown <neilb@suse.com>,
        syzbot <syzbot+a4a3d526b4157113ec6a@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: KASAN: use-after-free Read in locks_delete_block
Message-ID: <20181117140356.GA29895@fieldses.org>
References: <000000000000222b58057a7d9f39@google.com>
 <9d9ad7f2781bf15af4bd6ccc9feee35c7cd17979.camel@kernel.org>
 <87bm6svhhl.fsf@notabene.neil.brown.name>
 <b49e02d54460c79c4e5472983f6b9390005881b8.camel@kernel.org>
 <CACT4Y+Z3zM0z9PScAKjyjspu35B-6OgTT_qEwc+AB_MFzJkL0A@mail.gmail.com>
 <87bm6pewnm.fsf@notabene.neil.brown.name>
 <CACT4Y+Ysn70kTSgp_KZ5aRGuiNK0wUcqbjAH8xBJ8MqV+mFyqQ@mail.gmail.com>
 <c76712278e2d7f5c4c8cfbab687a941bf493b0c6.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c76712278e2d7f5c4c8cfbab687a941bf493b0c6.camel@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2018 at 08:33:27AM -0500, Jeff Layton wrote:
> Thanks for the explanation, Dmitry. I've added the tag to the patch in
> my tree. It should show up in linux-next soon.
> 
> I still find it a little misleading to say that syzbot reported a bug
> when it actually found a bug inside an earlier version of the patch, but
> I'll just learn to get over it.

The usual tag for someone that found a bug in an earlier version of a
patch would be Reviewed-by:.  Is there any reason we can't use that
here?  The "syzbot+..." email should be enough on its own, I can't see a
reason why their scripts would need to require a particular tag.  Or
maybe we could use Tested-by:, or some other tag made up for this case?

I do worry that someone who sees "Reported-by:..." might for example
mistakenly assume that it would help to backport that patch if they see
a similar-looking oops.

--b.
