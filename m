Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026A4C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FDB2083E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JgSmAbWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6FDB2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732378AbeGaXDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 19:03:36 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:46460 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731121AbeGaXDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 19:03:36 -0400
Received: by mail-io0-f196.google.com with SMTP id i18-v6so14284678ioj.13;
        Tue, 31 Jul 2018 14:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xv4JhoRvC+bTbHgghEfRcNfiewdFqJF8KNzW3UgO7iA=;
        b=JgSmAbWfCUetheNMv79ulr7Q7hJz9n2q47zIPfnDl4sCn6UFRnEc3Z+jISt3Pj4zmw
         nqpFkZObc8l3kUGVhdJCNNSQIXUAMIeqJLGmDF8r7cCs57FtcYk2ArFlWVMWzCnCJopp
         FK9ED3XroPcAqVq4AtCb67YZiJIuYzHLbwixs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xv4JhoRvC+bTbHgghEfRcNfiewdFqJF8KNzW3UgO7iA=;
        b=uWooK+GSN/d49PXY7xZnc359OZX/L/XBtWcWuBdwoFjNHjGJGqJhRTZ3Jv4Ru1YG5v
         3CV51SxBjy0gvqga2nIeJ1JGkpxXUUXBV+OLR9LNrWjnKUAUPJdq3X+FY3RRjVwrfEv5
         fj5SB2TzVk+bumKlNQibRBhoJL8v9dO2Q8brb+psekKivQGmHvI0sl9JkmkyXAN31YNM
         1rnX4hQ8Jf9vbhqER938oYeUbcNB6hbPegpqOvo2ARwyBb3Wzz2CJnup47mq1wkqJwZa
         mNkS5D3rtgwS1NKuqd1gAnB8iwR02nFpTS2vzCZjpphjHS9VcmGYnj0BiWNu0VuuG5md
         QYqg==
X-Gm-Message-State: AOUpUlHZ/u3+5aoEiDF+ItQXN1I+WEzp9E1IyUW22LyTplmV5PoylE28
        NlkBDICFKCEF60oTRkbp3oBJFKT60NjOveRA/7I=
X-Google-Smtp-Source: AAOMgpcfNs/wOiZp7E8OaTyITC4Qh5bSNBodxcchn7RErhKFOTU8Uf/7T1IxzOEdoWoZcksTO8rMLtmL94Zh6kxChuE=
X-Received: by 2002:a6b:7a05:: with SMTP id h5-v6mr1247530iom.238.1533072080570;
 Tue, 31 Jul 2018 14:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180730183847.GB5544@bombadil.infradead.org> <CA+55aFzpisX0+T_ipwUdOCXY+tkhe2Ao3KDZxx+UPpguVmirnQ@mail.gmail.com>
 <20180730194938.GA12962@bombadil.infradead.org> <20180730210209.GY21725@thunk.org>
 <20180730235849.GA19692@bombadil.infradead.org> <20180731005802.GB21725@thunk.org>
 <18974.1533031913@warthog.procyon.org.uk> <20180731113422.GA22939@amd>
 <20180731120752.GA23378@bombadil.infradead.org> <4951.1533042037@warthog.procyon.org.uk>
 <20180731193905.GA28700@amd> <22672.1533070815@warthog.procyon.org.uk>
In-Reply-To: <22672.1533070815@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 31 Jul 2018 14:21:09 -0700
Message-ID: <CA+55aFx9yo-n=d5G4-xHB8PCy_8BkCQP2L+C_QvuediufZzHvQ@mail.gmail.com>
Subject: Re: [PATCH 36/38] vfs: Add a sample program for the new mount API
 [ver #10]
To:     David Howells <dhowells@redhat.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Matthew Wilcox <willy@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 2:00 PM David Howells <dhowells@redhat.com> wrote:
>
> IIRC, Windows DLL translation tables get around this by having format-string
> tables with numbered parameter substitution markers.

That's what gettext() does too.

It's one of the reasons I *really* don't want to have this be an issue
at all in the kernel. It's just too painful and nasty for words.
People get it wrong all the time.

And even when you do it, you have issues with plural endings (which
also have markers so that you *can* get it right, and nobody ever
does) etc etc.

Really. No translation. No design for translation. It's a nasty nasty
rat-hole, and it's a pain for everybody.

There's another reason I _fundamentally_ don't want translations for
any kernel interfaces. If I get an error report, I want to be able to
just 'git grep" it. Translations make that basically impossible.

So the fact is, I want simple English interfaces. And people who have
issues with that should just not use them. End of story. Use the
existing error numbers if you want internationalization, and live with
the fact that you only get the very limited error number.

It's really that simple.

                   Linus
