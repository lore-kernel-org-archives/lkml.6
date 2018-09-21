Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A14FECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA4921566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKF6Gwn+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA4921566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391148AbeIUWXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:23:50 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:38135 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388909AbeIUWXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:23:50 -0400
Received: by mail-lj1-f180.google.com with SMTP id p6-v6so12216942ljc.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 09:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0qZuSNRjTgYirOzOAIQG/TiFiArsyn9V+cq/LV9yDT0=;
        b=JKF6Gwn+yqtrkXTlzed277AefSJsnn0QCr5gm6GruTz2rEkFHDVp1U0yZDcd45q+DB
         A6DepYii71nftsY+Ulu+uWv5p7sHkJpypYr3bkgfglfMaSFB+2u8fb8fkhXU5absCtza
         wWWL2F1Yv8vD7cChA5obRRt09HtQuUE8wJY9Yd+e1LUKyFOwUzYs+XxzZSEePR4av6z9
         zZ6Jn4jrLh/jeqkZ9aMZqJ3d/01/LliJhtDvv/0GUi3Zg74IAPDogyD6RoIDkA6AfoJj
         3AVr5TFEikKh0pZ4pYJE7iEqn4A1h14v4U3ZFkwnN4PdyUBa2Ob4SU28vM9ZzdQstv76
         oX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0qZuSNRjTgYirOzOAIQG/TiFiArsyn9V+cq/LV9yDT0=;
        b=trMd0B8uvzPdsxlLx84FOxbSZVuIdjojNybE7ldoUyzF9WxNNPynUbs3LRdkL3L0rv
         WRcyLLBA8L7vFtpkqIfIuYXLE42sb8jRQqGoMPF5k9wS2e+4fEF1a+oGKLRMh+KFb7Qf
         ZhzGuLzG7uo+i++xJKnuZ6mf+yJs6VtOR6qI2NfbUVbB4vY9UvM9AXAsRBEsm0JrTIdF
         h0kxtpAXaCf2Z8W+E2jJV8nSZGR+caU68vJIt6EcsNm6DoWiauMrqGBxjbrummQEvs7o
         MtkBkK183Y08NquCLVeqTJKvf5iyeQfzjaH9DVYvvPGtieus4K6cbiDzIY9LAR7hYSJv
         qFMQ==
X-Gm-Message-State: APzg51Duwje4tXwEM+68M44H+Ipt2j82uouOM5IzwYM6NpTRMbvZq5/T
        ZlrAvFQaLjI7jMEjB6P1e4edUuA99FKqge9Fi6YISw==
X-Google-Smtp-Source: ANB0VdY0idYwoIByR3nQ3EFxcV5mdJLTFX/aRZ8jaPXpVpyjoXd1BHdCkXOYVdqEphuP3LWHm1ctH8jAS5TXt3y/I6M=
X-Received: by 2002:a2e:752:: with SMTP id i18-v6mr2444453ljd.118.1537547648632;
 Fri, 21 Sep 2018 09:34:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:278e:0:0:0:0:0 with HTTP; Fri, 21 Sep 2018 09:34:07
 -0700 (PDT)
In-Reply-To: <87zhwbj8xe.fsf@redhat.com>
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
 <20180919081812.020f19e3@lwn.net> <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
 <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
 <93b77a9a-12c3-6f7d-d2c3-0e0d7875a28b@cantab.net> <589966d9cd0ddccc88f33fcb7975bb4464be7696.camel@surriel.com>
 <87zhwbj8xe.fsf@redhat.com>
From:   "\\0xDynamite" <dreamingforward@gmail.com>
Date:   Fri, 21 Sep 2018 11:34:07 -0500
Message-ID: <CAMjeLr-mWag=iO=CoNHeK9pkCu4y6vZUp03_zpJOG+e=n85j+g@mail.gmail.com>
Subject: Re: Code of Conduct: Let's revamp it.
To:     "Frank Ch. Eigler" <fche@redhat.com>
Cc:     Rik van Riel <riel@surriel.com>, Edward Cree <ec429@cantab.net>,
        Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ahem...

Of course, the linux community, like ALL communities, needs more
political correctness, because we wouldn't want others to feel left
out merely because they are wrong.   FALSE || TRUE = more
participation and diversity!

>Our Pledge
>In the interest of fostering an open and welcoming environment, we as
>contributors and maintainers pledge to making participation in our project and
>our community a harassment-free experience for everyone, regardless of age, body
>size, disability, ethnicity, sex characteristics, gender identity and
>expression, level of experience, education, socio-economic status, nationality,
>personal appearance, race, religion, or sexual identity and orientation.

As soon as you start to enumerate a list of communities that you're
including, you have set yourself up for failure, because you will,
LOGICALLY, leave out an endless number of groups that could
conceivably want to participate, too:  necrophiliacs (NO harm, NO
foul!), small animal lovers, balloon sculpturers, magicians, etc.
These people may feel ostracized when trying to participate, too.

No, all you need to do is say that everyone are invited to
participate, but that this is a kernel development community -- you
are expected to be able to code in C (is that exclusory?), know some
OS theory, done some research, etc. before bothering the participants
of the list, who do not have endless amounts of time.

Our Standards
=============

Examples of behavior that contributes to creating a positive environment
include:

>* Using welcoming and inclusive language

Something like:

Hello, thank you for contributing your code.  Of course, we'd love to
add your recipe for fruit cake into our code base.

>* Being respectful of differing viewpoints and experiences

Consider:
I respect that you think we should make linux include gay and
lesbian-friendly (or other minority group) themed fonts and logos,

>* Focusing on what is best for the community

When the community is made infinitely large, we'll be PERFECT!

>* Showing empathy towards other community members

Your pussy hurts?  Maybe you should have just accepted that your a boy!

I think Linus is perfectly fine in conduct.   I mean, this bullshit
pressure comes from corporations and other wierd places (<subtext>all
seeing eye</subtext>) that want to "help".  Do not even be fooled that
this is somehow become the accepted standard that EVERYONE BUT YOU is
accepting.  It is utterly political and based on POWER, not community.

Please, most of these people are still sitting on land that belonged
to the Native Americans who have never been given justice at all.  It
is an utter joke that these people actually think that they are
"politically correct".  They are as delusional as gunnuts who want to
carry assault rifles into Walmart.  Do not pander to them.  Consider
them TROLLS.

Mark Janssen
