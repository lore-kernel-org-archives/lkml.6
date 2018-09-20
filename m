Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A2BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0DA214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="fhaL9qut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C0DA214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731576AbeITG5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 02:57:22 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:44015 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbeITG5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 02:57:21 -0400
Received: by mail-lj1-f172.google.com with SMTP id m84-v6so6758074lje.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 18:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=19rk8UmuWQzDlyxxA3bF4BzOBrnhfqvM5aVdRIpovHU=;
        b=fhaL9qutV5QkRR1l6+oQ58QyTFIW57yRG5aSo8DAx1z6S6edBKFlr7ftznDud9xUve
         9JTL2hQMFtkf4ClLPm2r8Kb9kSk42aJtqFCL4cKQtZUv/LsGG/3SFyRcRnLha7zakfdb
         tW2dJe+TauukdpsEpGxlH5euwQVVSgTkJT+PIdihbs9IqrgGBrqrCs3iFHaYDIFDIRLR
         /YE2aSQwhZohWnqEu+Gb3/clgzQzwoNFGgyLQ7AKYba2q7WMtNJYNzmOv/qSQQ79r2ag
         BUyR8ZDTrwnSL+Eb/sGmZ5URZjtbr0xFjhq4BqCwIE4Y+v5QBKj5idTiU4D/RWHjxEHB
         q1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=19rk8UmuWQzDlyxxA3bF4BzOBrnhfqvM5aVdRIpovHU=;
        b=XDCXWs81VodDm5z27r+Zi/UO9rL8+BOG72vXu/k8dRoNjhVKl2W6OqfQd+YTXUtTEj
         1NYk+UHvv6CkCK60qdnBoiKhxL1o6FOrR6smQpEd5y6ruwcu7pNp5iFO/sYwnp98iT7N
         yCiXslStJMX5d4PGb0ACXOk4Z6Prnqm5TeZpgLXwgZUiiizQL3nOtDduHSh5v/+Sb5+u
         E3kbYk2Php7LPQ6BcnJjR3FnTAWzKId68TwFC3FtXzJw2tOkKnDdArIeOYeXrJ+SgRtp
         93BS9ac6XniRFLVbX5wwhJGOuUaMy51qp6eJwAHAz+VNIEtpUGq8Yx56FyklAjH7vmhi
         twxQ==
X-Gm-Message-State: APzg51ALD7y2IMXQ62LLrV5a2Pr93SycNWIV9PODTAHBYShNtzb1aIxs
        CUP+6Q4ncw2E5ZISG7OdRMKA/4Y9BpHAfvvtuCsetw==
X-Google-Smtp-Source: ANB0Vda38wIGpl9YsABC9iwttjdWF8uJGNgQXqh9jjEr6uKDSmROcfE+2Kpa7WHA85N5OThxhWa4ui0jHkfKHk74UZI=
X-Received: by 2002:a2e:40c:: with SMTP id 12-v6mr24952065lje.146.1537406201337;
 Wed, 19 Sep 2018 18:16:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:eac3:0:0:0:0:0 with HTTP; Wed, 19 Sep 2018 18:16:40
 -0700 (PDT)
X-Originating-IP: [79.140.208.123]
In-Reply-To: <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
 <20180919081812.020f19e3@lwn.net> <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
From:   Olof Johansson <olof@lixom.net>
Date:   Thu, 20 Sep 2018 02:16:40 +0100
Message-ID: <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
Subject: Re: Code of Conduct: Let's revamp it.
To:     Edward Cree <ec429@cantab.net>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'd like to clarify that I am replying here in my personal capacity,
and not on behalf of the TAB or anyone else.

On Thu, Sep 20, 2018 at 12:35 AM, Edward Cree <ec429@cantab.net> wrote:
> On 19/09/18 15:18, Jonathan Corbet wrote:
>> I'd like to address just this part, speaking only for myself.
>> The LF is not in the position of arbitrating anything here.  The body
>> charged with that is the LF Technical Advisory Board, which is a
>> different thing.
>
> Thank you for clarifying that.
>
> Jon, you're a good person, and I trust you not to harass developers.
>  I'm not expecting you, or gregkh, or hpa to launch a dastardly plot
>  to boot an innocent developer off the project.

I would be very surprised if any of my peers on the TAB ever had those
intentions, and I know I would not have them myself.

> But there are too many ways this can go wrong, maybe not now or next
>  week but in five or ten years, when maybe a different kind of person
>  is on the TAB, or maybe external pressure is brought to bear on TAB
>  members.

This is an important topic, and something that will need consideration.

One thing to keep in mind is that we all want what is best for Linux,
to make the best possible kernel. None of this has changed that.

I personally find it unlikely that relevant pressure could be applied
on TAB members; I don't find it a prestigious role such that it is
worth holding on to against my own values or best judgement.

> (Some people are speculating that pressure has already
>  been brought to bear on Linus, although I'd like to stress that if
>  he feels that changing the way he communicates is best for the
>  project then I for one thoroughly respect that.)

We should let Linus speak for himself and his motivations when he's
back, if he wants to. He has shown to be *extremely* resilient to
outside pressure for the entire history of the project, and to
speculate over his motives now doesn't do any good.

> Or maybe some manipulative extrovert will manage to whip up a media
>  storm about some developer's innocuous remarks, the court of public
>  opinion will immediately convict, other developers will be caught
>  in a preference falsification cascade as no-one wants to take the
>  risk of defending them.  Are you, and the other members of the TAB,
>  strong enough to hold back the lynch mobs when you know the guy
>  hasn't done anything wrong?  Do you really want to take on the
>  responsibility to do that, perhaps time and time again?  And can
>  you be sure that you won't fall for a misleading framing by some
>  charismatic sociopath of a fight you missed the start of?

There is a lot of focus in several discussions right now on punishment
and what will be done to those who violate the code of conduct. I'm
much more interested in figuring out what we can do to help mediate in
case of disagreements such that all parties can get along and work
together. That's the end goal for me. It's what the last document
tried to encourage, but as the commit message says, it wasn't showing
to be an effective approach so a new one is worth trying out.

Another common counter argument is that the code of conduct is
imposing what's appropriate thoughts and opinions on everybody. I can
see how that kind of environment _could_ be implemented with the same
code of conduct as a base, but it doesn't have to be and I know I
would fight strongly against that. I much prefer all be free to have
their opinions, but at the same time be respectful of each other when
we communicate. There are extreme edge cases but they're theoretical
at this point.

Disagreements are fine to have, and in many cases they lead to better
solutions in the end. What's not OK to me is when they veer off of the
path of respectful and productive discussion.

> Given that possibility, I think it is important for the kernel
>  community to continue to send a strong signal that divisive identity
>  politics are not welcome here; and I think that to adopt a Code of
>  Conduct that contains in its opening sentence a laundry-list of
>  protected classes (and was written by a, shall we say, divisive
>  figure with a history of identity politics advocacy) sends precisely
>  the opposite signal.

There is a list in the first paragraph, but the preceding words say
that it should be a *harassment-free experience for everyone*. That
part of the paragraph is to me the most important part.

Also, it doesn't particularly matter to me personally who wrote the
text, as much as what is in it, and how we apply it. Just as I might
not agree with everything that FSF or Richard Stallman says or does
but still approve of the GPL as a license.

> Linux is too important to civilisation to allow it to be turned into
>  just another battlefield for the American culture war; commit
>  8a104f8b5867 seems like an invitation to both armies to take up
>  positions on our fertile farmland.  The only rule that gives no
>  comfort to discriminatory political abusers (on either side) is=E2=80=94
>  ye shall judge by their code alone.

Your above argument that the Code of Conduct is problematic because of
who wrote it seems to contradict your statement that we shall judge by
code (or text) alone.

I don't know of anyone who is looking to make code less important. I
sure am not. To me, this is about how we treat each other when we
discuss said code and other things around it (such as how we run the
project).


Finally, I'd like to comment on your initial concern that you already
have to work hard on communication, and that this makes you fearful of
consequences if you fail to get it right. I'd like to say that you've
been doing a great job at it, well done. Also:
 1) I searched for your address in the mailing lists archives I have
here, and from what I see, I have zero concerns with any of what I've
read.
 2) Even if that's not the case, I'm of the strong opinion that we
should assume good intentions by default, and help out and mediate in
case something comes up.

When it comes to on-topic mailing list behavior, I can construct
extreme situations that I think should be addressed harder than
de-escalation and mediation from the start, but we've had very little
of that in our community so far. Often it gets bad over time or after
a series of back-and-forth, and if we can help de-escalate or get
people to cool off, that'd resolve a lot of it.


-Olof
