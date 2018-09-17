Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F618ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 02:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3CA214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 02:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lkcl.net header.i=@lkcl.net header.b="iInJB+8L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF3CA214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lkcl.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbeIQIYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:24:30 -0400
Received: from lkcl.net ([217.147.94.29]:54285 "EHLO lkcl.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbeIQIYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:24:30 -0400
X-Greylist: delayed 2592 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Sep 2018 04:24:30 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lkcl.net; s=201607131;
        h=Content-Type:To:Subject:Message-ID:Date:From:MIME-Version; bh=siHSVRnP5GYn74LhsHuVXnnUK9Kqq/kVOqu+Oh8Db7M=;
        b=iInJB+8L16XDroWkg2cQkkKK0z9zEpah5VjbSJGc6sGC0aXRcQIocr4ZCSgR8SoI9JWTdm1OQ1dDHoy4lYWwzKE10v/8t322SLCj6ebTIh3fp5fnfzKuxEJOURTAwHQIxI14foqjd0WdO8j4voljSlnyQQRWN4Q+yulIV/v9+XE=;
Received: from mail-io1-f46.google.com ([209.85.166.46])
        by lkcl.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <lkcl@lkcl.net>)
        id 1g1j59-0006CJ-CE
        for linux-kernel@vger.kernel.org; Mon, 17 Sep 2018 02:16:11 +0000
Received: by mail-io1-f46.google.com with SMTP id l14-v6so10213075iob.7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 19:15:55 -0700 (PDT)
X-Gm-Message-State: APzg51BigAuhAagy8qAbb+tn1T2kiHcOe64qi4dcSHPlkHsn/rjyuiR0
        XLnXnaMPn4EF9t/mfA2Gzq9TA0Ll0Slse+PJjIM=
X-Google-Smtp-Source: ANB0VdY8qrDecXNeZ0Jcat7aAKR/hJsqGy+RuHup7rp50wsHg/pbBgB3HeYDJsFH1mY8DA0VNlSVn34T9d13eav/aAU=
X-Received: by 2002:a6b:3902:: with SMTP id g2-v6mr19031400ioa.168.1537150549109;
 Sun, 16 Sep 2018 19:15:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:1543:0:0:0:0:0 with HTTP; Sun, 16 Sep 2018 19:15:48
 -0700 (PDT)
From:   Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Date:   Mon, 17 Sep 2018 03:15:48 +0100
X-Gmail-Original-Message-ID: <CAPweEDwKzoxoVFSNbSnsHtqNhxB+AbdjD9XMXW0MEwNPGdr3Xg@mail.gmail.com>
Message-ID: <CAPweEDwKzoxoVFSNbSnsHtqNhxB+AbdjD9XMXW0MEwNPGdr3Xg@mail.gmail.com>
Subject: Re: Linux 4.19-rc4 released, an apology, and a maintainership note
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi linus,

just saw the note on slashdot.  i just wanted to say how amazed,
relieved and delighted i was to see what you wrote.  that you
recognised that you needed to reflect, *sought feedback*, and, most
importantly, were willing and able to discuss that and ask publicly.
as the longest-serving contributor with the highest expertise, on
*the* world's largest software project by a long, long margin, your
words have a staggeringly-high "weight", so it is absolutely inspiring
(and a huge relief).

you therefore deserve a thoughtful answer.  however, i thought it best
to also provide some "immediate" feedback, as well.  as someone who
has had... *deep breath*... an extremely difficult time in the
software libre world due to holding strict ethical values with high
integrity, i have had to do one hell of a lot of research into
resources to help with communication and dealing with conflict.
whilst they are not actually the real underlying concept, they're
guides and tools that are at least intellectually understandable, if
that makes any sense:

* the bill of ethics - https://www.titanians.org/the-bill-of-ethics/
* the titanian's "code of honour" -
https://www.titanians.org/titanian-code-of-honor/
* the "conflict resolution network" - http://www.crnhq.org/ (see "12
skills summary")
* powerful non-defensive communication - http://pndc.com/
* "Invisible Dynamics" - https://www.amazon.co.uk/dp/3896704915
  (specifically the page outlining the 6 systemic laws of organisations:
   page 23 i *think*.  my copy unfortunately is in storage).
* the "MASH" actor who is teaching scientists to communicate:
https://motherboard.vice.com/en_us/article/mgbwkn/how-a-former-mash-actor-is-teaching-scientists-to-be-extroverts

last on the list (and i prefer not to provide a link as it may need
explanation, and the website is too specific / slightly mis-directing)
if you're specifically considering some sort of "coach" to work with,
do contact me off-list and i can recommend someone who has helped me,
who also has experience helping businesses and organisations, not just
individuals.

it's very late here, so i will put some thought into a more
comprehensive reply over the next couple of days: the main thing that
i wanted to get across straight away was that i am responding
precisely because your message resonates with, and is basically
indicative of, ethical behaviour.  as in, just the very act of asking
for constructive feedback is an absolute and fundamental requirement
for anyone wishing to call their behaviour "ethical".  why? because if
you're not asking others for *outside* help in evaluating if you are
acting ethically, how the hell can you ever tell if your behaviour is
"good" or "bad"??

as in: you absolutely cannot tell if you are "on-target" to reach a
goal if you don't have any kind of feedback loop!  it's real simple,
and yet so many people go through life completely unconscious of,
unaware of, and unable to discuss or even think about, this absolutely
simple and fundamental requirement!

and that alone is really, *really* important.  we have way, *way* too
many software libre projects increasing in importance that are also
operating completely unethically, yet they *genuinely* believe that
just because the source is "open", everything must automatically be
"fine".  i won't give examples: there's just simply too many.

so what you've said that you intend to do, here, is not just about
you: you've created a key pivotal moment that will show other projects
why it's not just about the code: it's about people, and
communication.  it always has been.

*thumbs-up*.

l.
