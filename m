Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C54C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6FC259D9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O59xRPRe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F6FC259D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752942AbeGBQsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 12:48:13 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:39698 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752554AbeGBQsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 12:48:11 -0400
Received: by mail-it0-f67.google.com with SMTP id p185-v6so12825029itp.4;
        Mon, 02 Jul 2018 09:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=atKdLrITNE12YTlBdgYTs04GPS3Q4TWQSdXTcUAQMUM=;
        b=O59xRPRePMTCdIlDbiRw3dXdXEi6R5fTQbYp4Kj9CqA4Ha+zgiV0ZI1B/F0AP/+U6L
         FDcSdAXZLHPaDeel+CSE6ooxn5/jBuJRidnNgwyxZc0YhGDbo55mJ4XKjWHG/Ej/6DMj
         83Tn4Zptf/0ZAfYnpaAO7CexaghlaIcOZ7v4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=atKdLrITNE12YTlBdgYTs04GPS3Q4TWQSdXTcUAQMUM=;
        b=B1udHCxBzOC++IT1GiGtPuzxoiJz3XXFygBN6yDD/N0nTEoXM/9/AfpmUPuyWBgzO0
         ZGaWXfAwjkLo7e6j6UA03LSVk+unLqXOzK7EKXtyKRpG+zldpewEaD6WkQQ6fGtXglhd
         FY7ay/rqh6hUH4yzkB07vsEqowiIxLv74BnTyadaYPT/wRT1iJ3i23iAvAMOM0Pb7bW3
         nPA9OazzX1WNrsFrOqJxhdx03BJ9PiWrJmGYREfO6lXkp5qdKX/LJYN4aBP6N+Fhz56f
         1n4FUcmou4Bgx6jfEMg1MaJxXV5v06LIQ2bqgJnP4yBWTJMVy458yxhZEi5L1Acr521P
         o5og==
X-Gm-Message-State: APt69E3HQtWyi7MLEcgZ2vp2XC9BXWFO00Xiual6pSJ+r4DRciy1GtRJ
        WK2Tc/xGCxEkdZXUL6cYj+P3o5dXCyj3sN7mI4w=
X-Google-Smtp-Source: AAOMgpcBGMUzqE3hV7RH0zjvcsIONX9zzEZXIrfaS6AMtPzHvVsc0w5v1O1ZbHkgq6vPNTWsQ5FYcGvPAkZfmVIcWvU=
X-Received: by 2002:a24:8046:: with SMTP id g67-v6mr6413761itd.16.1530550090106;
 Mon, 02 Jul 2018 09:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180701160757.138608453@linuxfoundation.org> <CAMuHMdVcSkXAmuD2qsc0mk9pDx_Fd0Q_peBmZY6Mpfkq6gMQZg@mail.gmail.com>
 <20180702102413.GB16825@kroah.com>
In-Reply-To: <20180702102413.GB16825@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Jul 2018 09:47:59 -0700
Message-ID: <CA+55aFzwn3M0q8Ps6VTKK98693P7verOAEggJ7AsR6CEgk6VGA@mail.gmail.com>
Subject: Re: [PATCH 4.9 000/101] 4.9.111-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 3:24 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 02, 2018 at 11:57:36AM +0200, Geert Uytterhoeven wrote:
> >
> > > Pseudo-Shortlog of commits:
> >
> > Given you do publish a git tree with these changes, is there any specific reason
> > you're not using a real shortlog? Sorting and grouping would make it
> > easier to see
> > which patches of mine you have backported.
>
> Many years ago Linus wanted it in this type of format as it was easier
> to see what was being applied to the trees.

I think you refer to an old email of mine where I said:

 "I think Greg has a script he uses, so I'm cc'ing him here too. i'm not
  sure I really like his one-liner format, but I'm not sure what the
  right format would be. I *think* the format I'd prefer would be a
  two-liner one (with a newline in between), something like

     git log --abbrev=12 --format="%h %aN <%aE>%n    %s%n"

  but that's more of a "maybe something along those lines.." than anything else"

Note that "maybe something along those lines", and in fact the format
Greg uses doesn't have the commit ID in it, so it's more like

    git log --format="%aN <%aE>%n    %s%n"

I forget what the original format Greg used was, but I don't think it
was "shortlog".  This is from almost a decade ago, and I couldn't
actually find any of Greg's emails with the original format that I
found to be inconvenient. I think it was something really dense and
incomprehensible based on my " i'm not sure I really like his
one-liner format", but..

Maybe just "shortlog" would be better. I agree that it's likely easier
for authors to see what commits got done from them, thanks to the
author grouping.

            Linus
