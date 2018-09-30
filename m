Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BE1C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 11:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF0720833
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 11:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lkcl.net header.i=@lkcl.net header.b="mT3lsW3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF0720833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lkcl.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbeI3SUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 14:20:16 -0400
Received: from lkcl.net ([217.147.94.29]:44330 "EHLO lkcl.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727991AbeI3SUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 14:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lkcl.net; s=201607131;
        h=Content-Type:To:Subject:Message-ID:Date:From:References:In-Reply-To:MIME-Version; bh=TQqR/JFe0NMF+kyQ9io9+xfdw17KuS1qx1rgEbZVKHE=;
        b=mT3lsW3AKYa+/4SUYJaOFAMgtQsUA34z4gcL76KSpkHNk2LjUG9iiMpt4ra2G6r+MnqRtUL4IIs8Vzat9XzIZ0qN8f3x4QMeulDxJUc5lpJP1aG5CI0QZRu0xHDmnHakJP5Qw6REHuGxGs1fbJbTmMlyohQWSTOZpKKDap3u37Q=;
Received: from mail-lj1-f176.google.com ([209.85.208.176])
        by lkcl.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <lkcl@lkcl.net>)
        id 1g6aCD-0003Dx-QL
        for linux-kernel@vger.kernel.org; Sun, 30 Sep 2018 11:47:33 +0000
Received: by mail-lj1-f176.google.com with SMTP id v6-v6so489987ljc.11
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 04:47:18 -0700 (PDT)
X-Gm-Message-State: ABuFfoimvkYZaLIYmMBNLQFRcYbv+PJWhoPvQVlvE3L6yGvgDj5ExDe9
        X2HwKItgqNxHa+WnEQP8SSjadvIuwZ7aM4CsdkI=
X-Google-Smtp-Source: ACcGV63EmQYZgFkcEpC20COam6+AT07gM2OyxgWVei6l7kEEg7AQFoV2dxI5+6d2ceLoHGSJyzcegsFRbQcwoZpZcgY=
X-Received: by 2002:a2e:87da:: with SMTP id v26-v6mr4032220ljj.13.1538308032720;
 Sun, 30 Sep 2018 04:47:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:5909:0:0:0:0:0 with HTTP; Sun, 30 Sep 2018 04:47:12
 -0700 (PDT)
In-Reply-To: <CAPweEDwKzoxoVFSNbSnsHtqNhxB+AbdjD9XMXW0MEwNPGdr3Xg@mail.gmail.com>
References: <CAPweEDwKzoxoVFSNbSnsHtqNhxB+AbdjD9XMXW0MEwNPGdr3Xg@mail.gmail.com>
From:   Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Date:   Sun, 30 Sep 2018 12:47:12 +0100
X-Gmail-Original-Message-ID: <CAPweEDwSkOkVSwJxKbO-hkSoAw3LtNvOTwRRbFJPjDQAxhiGwg@mail.gmail.com>
Message-ID: <CAPweEDwSkOkVSwJxKbO-hkSoAw3LtNvOTwRRbFJPjDQAxhiGwg@mail.gmail.com>
Subject: Re: Linux 4.19-rc4 released, an apology, and a maintainership note
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://linux.slashdot.org/story/18/09/27/1529236/linus-torvalds-on-linuxs-code-of-conduct#comments

linus: ah... um... okay so this is beginning to remind me of dr who
films, the comedy film "the world's end", and various other b-movie
horror shows where people were taken over through mind-control or
replaced.

so i apologise, i'm going to stop pussy-footing around and ask HAVE
YOU FUCKING LOST IT, GET YOUR HEAD OUT YOUR ARSE, STOP FEELING SORRY
FOR YOURSELF AND GET BACK TO BEING AN ENGINEER, YOU ARE ON A
CHEARRRRGEUUH YOU SORRY LITTLE PROGRAMMERRRRR

*cough*.  enough NLP-esque shock tactics with a bit of comedy thrown
in to take the sting out of it... allow me to return to rational
insights.

(1) you apologised for your behaviour, and it's fantastic that you
recognised that there was a problem and asked for help.  however, you
*may* be feeling a little guilty, and it's clearly knocked your
confidence, and that unfortunately has allowed political correctness
to "creep in" where we know it never, ever belongs: in engineering.

the next thing you know, the fucking guilt-ridden morons who want the
words "master" and "slave" erased from the history books will be
telling you that we have to change SPI's "MOSI" and "MISO" to...
god... i dunno... "ROWI and RIWO" - "requestor" and "worker" or
something incredibly stupid:

Requestor: "i'm awfully sorry, if you wouldn't mind, if it's not too
much trouble mr worker, when you have the time and you're not on your
union-mandated break, could you deal with this bit-change for me?"

(2) more and more people are raising the fact that the change was made
without consultation.  this *is* going to bite everyone.  i strongly,
strongly suggest reverting it: i made the point very clear that it
wasn't the actual CoC that was the problem, it was that you, yourself,
were not really obeying it (so nobody else could, either).

(3) let's look at what toxic documents named "codes of conduct" look
like from an engineering perspective:

#define BEHAVIOUR_GOOD() ((~BEHAVIOUR_BAD) == 0)
#define BEHAVIOUR_BAD BEHAVIOUR_SEXIST | BEHAVIOUR_RACIST |
                                            BEHAVIOUR_NAZI |
BEHAVIOUR_UNPLEASANT |
                                            BEHAVIOUR_RELIGIOUS_EXTREMIST ....
#define BEHAVIOUR_RELIGIOUS_EXTREMIST \
                                            BEHAVIOUR_ANTI_CHRISTIAN \
                                            BEHAVIOUR_ANTI_MUSLIM \
                                            ...
....
....
#define BEHAVIOUR_ANTI_MUSLIM 0x1
#define BEHAVIOUR_ANTI_CHRISTIAN 0x2
...
...
...
// oops fuck we're gonna run out of bits extremely quickly....

do you see where that's going?  do you get the point already?  if an
engineer proposed the above patch to create the toxic CoC document
that insidiously crept in recently, you and pretty much everyone would
think that the submitter had a fucking screw loose and needed
psychiatric help.

these toxic documents do not have to spell it out, but they *imply*
that there are (deep breath...) spics, wocs, niggers, honky white
bastards, chinks kooks and their mothers too all trying to ATTACK the
project, and we'd better make sure that they're all excluded,
otherwise we're all in trouble, eh?

i apologise for using these words: if you are a decent human being you
should by now feeling physically sick to your stomach at having read
that paragraph, that those words were even used... yet they're not
actually *in* that toxic document, but they don't have to be: people
are still thinking them.  like the "don't think of a pink elephant"
our subconscious mind cannot help by strip out the "don't".

bottom line: the *entire linux kernel project* has now been
*completely poisoned* by that document.

put another way: an engineer would go, "wtf??" and would say "we don't
need to fill every single bit in the bitfield and then invert it for
god's sake!  just say "good behaviour is expected" and be done with
it!!"

so why not say, instead of that absolute god-awful list, "everyone is
welcome; everyone belongs".  you see the difference?  you see how
simple and empowering that is?  it's INVITING people to participate,
and it's pretty obvious that if someone feels *UN*welcome, the rules
have been broken and they can raise it as an issue.  rather than
absolutely terrifying and sickening absolutely everybody.

the analogy is the story of mother theresa being invited to an
"anti-war" rally.  she declined... and said, "if ever you hold a PEACE
rally, i'd be delighted to attend".

so come on, linus: wake up, man.  just because this is outside of your
area of expertise does not mean that you have to let go of the reins.
*get a grip*.  use your engineering expertise, apply it to the
problem, work with *EVERYONE* and work out an *ACCEPTABLE* solution.

warmest,

l.
