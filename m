Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA74C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A249A208A1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="BVRiGPEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A249A208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbeG3WjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 18:39:13 -0400
Received: from imap.thunk.org ([74.207.234.97]:44402 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728799AbeG3WjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 18:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=I0OXXUQ+HUkAoh85Px7CBSfmnfPizp8wN6b5Q3OhQXA=; b=BVRiGPEZQTylNbDLP/qqbO/IOs
        NPK0Bo+KYqYGhCMhKpG2teQWoyG1130QZDga2zm2kc6szrwAc6oA423R3C54Twz9vOt2XfPgAVSMd
        ZzIfmbNd+TAn5XKG9e6L/u0J/P3oAXmLWxpErPXpdD0q+OrDecvtjaC5ouEuCBik0qyQ=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fkFIx-0007XN-CL; Mon, 30 Jul 2018 21:02:11 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0382C7A614A; Mon, 30 Jul 2018 17:02:09 -0400 (EDT)
Date:   Mon, 30 Jul 2018 17:02:09 -0400
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
Message-ID: <20180730210209.GY21725@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180729113749.GA7333@amd>
 <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
 <153271292330.9458.14583488053811372222.stgit@warthog.procyon.org.uk>
 <25489.1532953411@warthog.procyon.org.uk>
 <20180730143104.GB24051@amd>
 <20180730180842.GA5544@bombadil.infradead.org>
 <CA+55aFwY1nQ0LG8CeC8chugWO40kOGKpovBOadpGOOMBinNhbg@mail.gmail.com>
 <20180730183847.GB5544@bombadil.infradead.org>
 <CA+55aFzpisX0+T_ipwUdOCXY+tkhe2Ao3KDZxx+UPpguVmirnQ@mail.gmail.com>
 <20180730194938.GA12962@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730194938.GA12962@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 12:49:38PM -0700, Matthew Wilcox wrote:
> > That said, people have wanted these kinds of extended error
> > descriptors forever, and the reason we haven't added them is that it
> > generally is more pain than it is necessarily worth. I'm not actually
> > at all convinced that has magically changed with the mount
> > configuration thing.
> 
> I'm not convinced we want to do this either, but if there's anywhere we
> do want to do it then mount seems like one of the few places it might be
> worth doing.  The reasons that a mount failed are many, and it doesn't
> seem like a good idea to introduce a new errno every time a network
> filesystem finds a new failure mode.

We've lived without VMS-style error reporting for a long time, and it
*that* much of a real problem.  Even with network file systems, I
don't think it's been that hard of a problem.

I'd also argue that if there was something super-complicated, the
right way to solve that problem is to push that processing into
userspace --- e.g., if President Trump and President Putin both have
to authenticate to the Nuclear Launch Codes server, then in
mount.pentagonfs, the relevant X.509 certificates would be sent to
server in the userspace process, and if there needs to be complex
error messages reflecting Certificate Revocation List handling, etc.,
mount.pentagonfs can use gettextfs so the program can be localized in
English and Russian.  Once the authentication is completed, then
mount.pentagonfs can pass the file descriptor for the network
connection into fsconfig.

So it might be that we're seriously over-thinking things.  Most of the
really complicated error messages are at connection setup time, and
that can be done in userspace, and then userspace can handle all of
that awful gettext, or VMS-style error messages, or whatever other
horrors the I18N community want to inflict on us.  :-)

	    	 	   	   - Ted
