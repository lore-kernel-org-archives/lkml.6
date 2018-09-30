Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B210C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 16:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 169DC206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 16:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lkcl.net header.i=@lkcl.net header.b="Liv0aUhu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 169DC206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lkcl.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbeI3XBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 19:01:47 -0400
Received: from lkcl.net ([217.147.94.29]:45995 "EHLO lkcl.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728192AbeI3XBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 19:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lkcl.net; s=201607131;
        h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From:References:In-Reply-To:MIME-Version; bh=pUNnv5LEQ2wqDcCrR2L+Fuo6hcL+IXSq9Wm4hx77ooE=;
        b=Liv0aUhuARu1DC/UoBHdYll7MwYmwituzsZ7ZoEfLUWqhTtpIi6FxNurr5DC0k9wSXEGQt/yr0bdd0P3rl1cGJeLC6519bYPfbGltLl7Wi2lU9Qoyf9vga5mzdCWGB71yd9R7wRXBekDaYnQaD/CmJ3a16jNHph2VxPBmKmQ3yQ=;
Received: from mail-lj1-f177.google.com ([209.85.208.177])
        by lkcl.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <lkcl@lkcl.net>)
        id 1g6eZg-0003Lu-Gs
        for linux-kernel@vger.kernel.org; Sun, 30 Sep 2018 16:28:04 +0000
Received: by mail-lj1-f177.google.com with SMTP id 63-v6so715356ljs.4
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 09:27:49 -0700 (PDT)
X-Gm-Message-State: ABuFfogJOzmnNk41HFD8jBC9DvSYEw77X4CXWfJXGrRDZaOtmPBVXSXg
        7zcn8RL/G8RcLYEw2vIFdKl3XYB5NxqFf7FbMfY=
X-Google-Smtp-Source: ACcGV60uSU2KTImtbYWBDWdnixsTeyVlk9KXESPHt7jYC+7exqIKPN97iQGwFjNFYvyRw1kgrN2/aGD+Sd8enUZ4YIw=
X-Received: by 2002:a2e:84a:: with SMTP id g10-v6mr4482868ljd.158.1538324863433;
 Sun, 30 Sep 2018 09:27:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:5909:0:0:0:0:0 with HTTP; Sun, 30 Sep 2018 09:27:42
 -0700 (PDT)
In-Reply-To: <8998740.bsg6g2nRDU@merkaba>
References: <2936237.GcMzexieOU@merkaba> <20180930120909.30469-1-lkcl@lkcl.net>
 <8998740.bsg6g2nRDU@merkaba>
From:   Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Date:   Sun, 30 Sep 2018 17:27:42 +0100
X-Gmail-Original-Message-ID: <CAPweEDxSHpBk7Hj4RdMKKPb05mxycE7JW2=pus6Zhdni+dKBkg@mail.gmail.com>
Message-ID: <CAPweEDxSHpBk7Hj4RdMKKPb05mxycE7JW2=pus6Zhdni+dKBkg@mail.gmail.com>
Subject: Re: Linux 4.19-rc4 released, an apology, and a maintainership note
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 3:07 PM, Martin Steigerwald <martin@lichtvoll.de> w=
rote:

> lkcl@lkcl.net - 30.09.18, 14:09:
>>  the third is how UNICEF trains teachers to treat children as human
>> beings.
>
> During releasing a lot of limiting "stuff" I found that probably nothing
> written or said can hurt my feelings unless I let it do so or even=E2=80=
=A6
> unless I choose (!) to feel hurt about it. So at times I am clear about
> this, I=C2=B4d say: "I have chosen to feel hurt about what you did."

 it's interesting to me to note that you use the word "releasing".
that's a keyword that i recognise from energy work, which,
surprisingly is increasingly being recognised and used by individuals
and businesses all over the world.  it seems that people are beginning
to recognise it's actually effective and no longer associated with
cloud-cuckoo-land "detached-from-reality" new age hippies.  i was
going to [privately] recommend someone who specifically works with
businesses and organisations to linus: i haven't heard from him yet.

> However in this human experience a lot of people, including myself,
> still hold on to a lot of limiting "stuff" which invites feeling hurt.
> We, as humankind, have a history of hurting each other.

 this is why i recommended http://pndc.com in my earlier post.  one of
the documents there points out that due to our still-remaining
"survival" instincts from millenia of evolution, words *literally* can
have the same effect on us as if we were actually physically and i
MEAN literally physically being attacked... [*IF WE CHOOSE* to be].

 where people have not yet learned the difference between "that was a
bad thing to do" and "YOU are bad" (and interpret those as being
exactly the same thing), we have a compound effect.  one person says
"that's a really dumb piece of code", the person hearing it interprets
it as "you're a fucking idiot", and has a LITERAL physical response to
the words [that you didn't actually say] as if you'd just punched them
in the mouth.

> During this releasing work I also learned about two key ingredients of
> successful relationships: Harmlessness and mutuality. I opted out of the
> hurting cycle as best I can. And so I choose to write in a way that
> moves around what from my own experience of feeling hurt I know could
> hurt others. I choose to write in a harmless way so to say. While still
> aiming to bring my point across. A very important ingredient for this is
> to write from my own experience.

 yes, absolutely.  that's pretty much word-for-word exactly the advice
given on the _other_ resource i recommended to linus,
http://www.crnhq.org/.  let me find it.... ok, "appropriate
assertiveness": http://www.crnhq.org/CR-Kit.aspx?rw=3Dc#assertiveness

 quote:

 " The essence of Appropriate Assertiveness is being able to state
your case without arousing the defences of the other person. The
secret of success lies in saying how it is for you rather than what
they should or shouldn't do. "The way I see it...", attached to your
assertive statement, helps. A skilled "I" statement goes even
further."

 and it goes on from there.

> Of course others can feel hurt about something I would not feel hurt
> about and I may not be aware that the other might feel hurt about. That
> is why in such a case it is important to give and receive feedback.
> Still when writing from my own experience without saying that anything
> is wrong with the other, it appears to be unlikely to trigger hurt. That
> is at least my experience so far.

 exactly.  i believe you may be interested to know of the next phases
in that: the crnhq's "appropriate assertiveness" advice has a really
good template for keeping things to "I", and at the same time
successfully getting the point across.  i won't quote all of it to
you.

 i believe crhnq is written by a guy who has stopped warring tribes
from centuries of killing each other (and i don't mean
metaphorically), so it's clearly effective.

 caveat: my only concern about these kinds of ways of thinking is,
sometimes you do actually genuinely need to give people a short, sharp
shock: that's part of NLP.  *after* the shock, you can be "nice" to
them: where previously they were pathologically unable to listen, a
shock gets them out of the psychosis that they were in.  it's also a
recognised medical treatment for people who are hysterical in disaster
/ emergency scenarios to shock them out of their screaming fit.  note:
not recommended without proper training!!

l.
