Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF1AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC6E208A6
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BC6E208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732260AbeGaPOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 11:14:23 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:44696 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729723AbeGaPOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 11:14:23 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fkUmW-0006tW-0O; Tue, 31 Jul 2018 13:33:44 +0000
Date:   Tue, 31 Jul 2018 14:33:43 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 36/38] vfs: Add a sample program for the new mount API
 [ver #10]
Message-ID: <20180731133343.GI30522@ZenIV.linux.org.uk>
References: <20180730183847.GB5544@bombadil.infradead.org>
 <CA+55aFzpisX0+T_ipwUdOCXY+tkhe2Ao3KDZxx+UPpguVmirnQ@mail.gmail.com>
 <20180730194938.GA12962@bombadil.infradead.org>
 <20180730210209.GY21725@thunk.org>
 <20180730235849.GA19692@bombadil.infradead.org>
 <20180731005802.GB21725@thunk.org>
 <18974.1533031913@warthog.procyon.org.uk>
 <20180731113422.GA22939@amd>
 <20180731120752.GA23378@bombadil.infradead.org>
 <20180731122801.GA14972@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180731122801.GA14972@amd>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 02:28:01PM +0200, Pavel Machek wrote:
> > Your proposal means that userspace needs to detect "%s file", determine
> > if the corresponding string consists of ^[0-9]*$, then parse the string
> > to figure out which of the plik* words is the correct one to use.
> 
> Have you actually used computer set in slavic language?

I have.

> Receiving "5
> soubor(u) zkopirovano" is still preferable to message in english.

*snort*

How about "5 pilník(u)"?  And yes, I've seen an equivalent "translation"
to Russian ("этот вызов возвращает рукоятку напильника"[1]).  For real.
Granted, they tend to recognize that one these days, but if I ever
get too optimistic about i18n... hopes, all I need to do is to run
with LANG=ru_RU.UTF8 for an hour or so and those delusions will go
away.

_Very_ often the best strategy of figuring out WTF does a completely inane
message mean is to try and guess what English sentence could've been
mistranslated that way.  And that's relatively benign case - much worse
is when message *does* make sense, but has critically different meaning.

I don't know about .cz translation quality, but .ru translations tend to be
atrocious.  And even when they are not wrong... they are clumsy - wrong
word order, unnatural syntax in general, unidiomatic constructs all over
the place...  BTW, slavic is not the worst in that respect - there the
wrong word order will usually just fuck the flow, but for something with
*fixed* word order you'll get worse than distraction for readers.
Sure, you can use the things like %2$s in translated formats, but
seeing how brittle and rife with limitations that is... maintaining such
translations is going to be paiful as hell.

[1] amusingly enough, it _is_ a cognate of "file" - just the wrong omonym
used.  Not that cognate of the right omonym would've been any better ("žíla"
for Lat. "filum", which gave Eng. "file" by way of 'sheaf of documents strung
together')
