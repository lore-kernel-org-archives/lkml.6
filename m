Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994A2C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 428E4208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="KsnY2ARl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 428E4208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731905AbeGaCft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 22:35:49 -0400
Received: from imap.thunk.org ([74.207.234.97]:45048 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728607AbeGaCft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 22:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Z3VtPvRTvnvNIXpZTQXay+fzLC/aOV8GnaEf6im2iIo=; b=KsnY2ARl1g4bmBkRY2UHMF74/Y
        YkVfnPJNQHTQz+n/by+tsE2z0pwPIHJYNm1BkDRUqwv4Ien6XpSU8QZR6CQyiS0z8UuFnfWGN5Loy
        3ichEohDhDCTjXlcGV+D55aBtu4xOHyd5HsI8QZvbd7l1oS13oaPOPsEqEqLLlPECTbI=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fkIzE-0000W8-21; Tue, 31 Jul 2018 00:58:04 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A4A437A614C; Mon, 30 Jul 2018 20:58:02 -0400 (EDT)
Date:   Mon, 30 Jul 2018 20:58:02 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 36/38] vfs: Add a sample program for the new mount API
 [ver #10]
Message-ID: <20180731005802.GB21725@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <153271292330.9458.14583488053811372222.stgit@warthog.procyon.org.uk>
 <25489.1532953411@warthog.procyon.org.uk>
 <20180730143104.GB24051@amd>
 <20180730180842.GA5544@bombadil.infradead.org>
 <CA+55aFwY1nQ0LG8CeC8chugWO40kOGKpovBOadpGOOMBinNhbg@mail.gmail.com>
 <20180730183847.GB5544@bombadil.infradead.org>
 <CA+55aFzpisX0+T_ipwUdOCXY+tkhe2Ao3KDZxx+UPpguVmirnQ@mail.gmail.com>
 <20180730194938.GA12962@bombadil.infradead.org>
 <20180730210209.GY21725@thunk.org>
 <20180730235849.GA19692@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730235849.GA19692@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 04:58:49PM -0700, Matthew Wilcox wrote:
> 
> Way to poison the well by calling it VMS-style error reporting!  As I
> understand it though, VMS reported errors in English with an error code
> that could be looked up in The Wall of documentation.  I'd see David's
> proposal as closer to plan9-style error reporting.

And I'm quite happy with David's proposal.  What I was trying to
strongly argue against (and, yes, I was using some dirty pool when I
called it VMS-style error reporting) was trying to do something more
structured and more I18N friendly.

> But I think it has been a real problem.  I mean, look at ext4.
> 
>                 if (test_opt2(sb, EXPLICIT_DELALLOC)) {
>                         ext4_msg(sb, KERN_ERR, "can't mount with "
>                                  "both data=journal and delalloc");
>                         goto failed_mount;
> ...

... and in practice it's not been a problem, because a *vanishingly*
small number of users actually try to use the more advanced features
of most file systems.  And those that do, can look at dmesg output,
and they can darned will do it in English.

Doing returning something like %FSEXT4-E-NODJNLDELALLOC followed by
English text, so that people who don't know English can look up
%FSEXT4-E-NODJNLDELALLOC in The Wall of 3-ring binders of
documentation is just silly.  And saying we should remove all English
text and returning the text string %FSEXT4-E-NODJNLDELALLOC so that
people don't speak English aren't "disadvantaged" is even sillier.

So to be clear --- I think David's proposal of just returning "Error:"
followed by English text is just fine[1], and doing more than that is
overdesign.  The advantage of dmesg is that it's well understood by
everyone that dmesg is English text meant for experts[2].  The problem
once we move away from dmesg, this tends to cause the I18N brigade to
start agitating for something more complicated.  And if the only
choices were some complex I18N horror through a system call, or just
leaving the (English) text messages in dmesg, I'd vote for dmesg for
sure.

[1] I'd prefer "E: ", "I: ", etc., instead of "Error: " and "Info: "
but that's bike-shedding.

[2] Actually, some 8-9 years ago some Japenese firms tried to push for
VMS-style messages in dmesg.  The only difference is that the message
codes would be looked-up on-line, but aside from not killing as many
trees, it was pretty much the same design.  So my mentioning VMS-style
messages wasn't just being unfair; these sorts of bad ideas seem to
have a habit of coming back like a bad penny, and it's best to give
them the kibosh as quickly as possible.

					- Ted
