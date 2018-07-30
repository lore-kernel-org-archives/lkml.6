Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C418C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33AC720894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VpEExwqg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33AC720894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732024AbeG3V0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 17:26:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48846 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbeG3V0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 17:26:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IHoVBTpFqQn7X9RtLhUsvLGUpv7IPz/8PsXByKxVTZ8=; b=VpEExwqgmE3iDSOyT2YTtNQJko
        5XOgNdGDPb8YUMYBc/Ttkc0Zrd6M2mkNtsLdEJ1G0z0VUTTz/10HIrWypcQ86TeYRmCpoxGe57IMq
        S0a5zvmh3KF6Z/jGQEzFEp+ocBXXzNzWVOD8nNkdQMcwMvCndfmU8nNvR5Kr3OX3BQ3STPbcDTHY+
        31SPjvIMMo78f7SfG+q2xw5Ub19GxPMwZezuAJM/x4dpvSR6+cX2mSsmSc49qhpLhsCWh7osJgNEl
        5x308HGB0wNBCFEI6ZmMVfPjtGhJIoCMDXtziKVHJYcIxmS6FNCdXTssB/85P4aRNQ0co/Na4s/Bp
        PvdeeMDA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkEAl-00032z-47; Mon, 30 Jul 2018 19:49:39 +0000
Date:   Mon, 30 Jul 2018 12:49:38 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Pavel Machek <pavel@ucw.cz>, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 36/38] vfs: Add a sample program for the new mount API
 [ver #10]
Message-ID: <20180730194938.GA12962@bombadil.infradead.org>
References: <20180729113749.GA7333@amd>
 <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
 <153271292330.9458.14583488053811372222.stgit@warthog.procyon.org.uk>
 <25489.1532953411@warthog.procyon.org.uk>
 <20180730143104.GB24051@amd>
 <20180730180842.GA5544@bombadil.infradead.org>
 <CA+55aFwY1nQ0LG8CeC8chugWO40kOGKpovBOadpGOOMBinNhbg@mail.gmail.com>
 <20180730183847.GB5544@bombadil.infradead.org>
 <CA+55aFzpisX0+T_ipwUdOCXY+tkhe2Ao3KDZxx+UPpguVmirnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+55aFzpisX0+T_ipwUdOCXY+tkhe2Ao3KDZxx+UPpguVmirnQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 11:59:13AM -0700, Linus Torvalds wrote:
> On Mon, Jul 30, 2018 at 11:38 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > I wasn't proposing putting gettext in the kernel.  I was reacting to
> > Pavel saying "You can't return English strings from the kernel, you have
> > to translate numbers into any language's strings".
> 
> The problem with gettext() is that if you *don't* have the strings
> marked for translated at the source, you're going to have a hard time
> with anything but the simplest fixed strings.
> 
> When the kernel does something like
> 
>      mntinfo("Option %s can not take value %d", opt->name, opt->value);
> 
> a gettext() interface inside the kernel (which really would be nasty)
> would have seen the format string and the values independently and
> would have generated the translation database from that.
> 
> But once the string has been generated, it can now be thousands of
> different strings, and you can't just look them up from a table any
> more.
> 
> Real examples from David's patch-series:
> 
>                 errorf(fc, "%s: Lookup failure for '%s'",
>                        desc->name, param->key);
> 
>                 errorf(fc, "%s: Non-blockdev passed to '%s'",
>                        desc->name, param->key);
> 
> which means that by the time user space sees it, you can't just "look
> up the string". The string will have various random key names etc in
> it.

That's fair, it becomes a good deal more complex than gettext() can
cope with.  Someone sufficiently determined could regex-match the
"Non-blockdev passed to", and translate that.  If they really want to
sell a computer system to the Office québécois de la langue française.

> But the alternative to pass things as format strings and raw data, and
> having all the rules for a "good gettext interface" are worse. It gets
> very ugly very quickly.

Yes, catching all the corner cases gets ridiculously hard, particularly
plurals.
https://www.gnu.org/software/gettext/manual/html_node/Plural-forms.html#Plural-forms
really makes my brain hurt, and makes me glad I work on simple things
like OS kernels.

> So I really think the best option is "Ignore the problem". The system
> calls will still continue to report the basic error numbers (EINVAL
> etc), and the extended error strings will be just that: extended error
> strings. Ignore them if you can't understand them.
> 
> That said, people have wanted these kinds of extended error
> descriptors forever, and the reason we haven't added them is that it
> generally is more pain than it is necessarily worth. I'm not actually
> at all convinced that has magically changed with the mount
> configuration thing.

I'm not convinced we want to do this either, but if there's anywhere we
do want to do it then mount seems like one of the few places it might be
worth doing.  The reasons that a mount failed are many, and it doesn't
seem like a good idea to introduce a new errno every time a network
filesystem finds a new failure mode.

I do think it might be worth marking the strings specially to indicate
"This is returned to userspace, do not adjust the spelling lightly".
I mean, we haven't even put the 'e' back on creat yet, so we're clearly
willing to live with bad spelling.
