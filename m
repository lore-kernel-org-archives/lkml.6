Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3522C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64310208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m7XLxZS1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64310208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732069AbeGaNsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 09:48:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47836 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729723AbeGaNsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 09:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=t+RXml8lvMCusowmNwZIGxbHQcNLPzIvdPKUb12CpNE=; b=m7XLxZS1c2ws/XKCRE8M8oAiZM
        W6DSTbwuIN8AjYs9T9MnnNisbNf6mnfQpz1LXyGEdoq01GqnoZ4zXRHkgmYG8AjIxplNalzL/YoMr
        FaEFArO0h3CziY7pNzzou4PHuYnBafSyi4sMy9EsK8EuJfoHmR7lUmj8lw3iB4Srv9tN88O8mZe8V
        TEwbyhaYzpQmYvWpQNVFrpxrzZ6YDiHClSlIke6Dt6fwScEMIa+rCy/ouY76KnBesJXqvF/4gyiSb
        uY2c0fCHb9cGY98N7VcugsFwe5ako3dfj6uqm6zODsnz1Xx5GODhTJs6OZjojbUQ0tDJiceX2Vnua
        vCjYyCqQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkTRQ-0003iL-S1; Tue, 31 Jul 2018 12:07:52 +0000
Date:   Tue, 31 Jul 2018 05:07:52 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     David Howells <dhowells@redhat.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 36/38] vfs: Add a sample program for the new mount API
 [ver #10]
Message-ID: <20180731120752.GA23378@bombadil.infradead.org>
References: <20180730180842.GA5544@bombadil.infradead.org>
 <CA+55aFwY1nQ0LG8CeC8chugWO40kOGKpovBOadpGOOMBinNhbg@mail.gmail.com>
 <20180730183847.GB5544@bombadil.infradead.org>
 <CA+55aFzpisX0+T_ipwUdOCXY+tkhe2Ao3KDZxx+UPpguVmirnQ@mail.gmail.com>
 <20180730194938.GA12962@bombadil.infradead.org>
 <20180730210209.GY21725@thunk.org>
 <20180730235849.GA19692@bombadil.infradead.org>
 <20180731005802.GB21725@thunk.org>
 <18974.1533031913@warthog.procyon.org.uk>
 <20180731113422.GA22939@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180731113422.GA22939@amd>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 01:34:22PM +0200, Pavel Machek wrote:
> On Tue 2018-07-31 11:11:53, David Howells wrote:
> > Pavel Machek <pavel@ucw.cz> wrote:
> > > Proposal is "message %s foo %s\0param 1\0param2\0", only strings
> > > allowed.
> > 
> > I think that's too strict and you will need to allow integer values, IP
> > addresses and possibly other things also.  It could certainly have a limited
> > set (e.g. no kernel pointers).
> 
> I'd always use strings at kernel->user interface. Yes, we should
> support integers and IP addresses in kernel, but I'd convert them to
> strings before passing them to userspace.

Then you haven't solved the translation problem at all; you've just made
the in-kernel implementation harder.  One example from the gettext docs:

  In Polish we use e.g. plik (file) this way:

    1 plik
    2,3,4 pliki
    5-21 plików
    22-24 pliki
    25-31 plików

Your proposal means that userspace needs to detect "%s file", determine
if the corresponding string consists of ^[0-9]*$, then parse the string
to figure out which of the plik* words is the correct one to use.

In my preferred solution of just sending the damned english string,
it's no more complex to regex match the string for "[0-9]* file", and
choose the appropriate plik* translation.

