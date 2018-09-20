Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E890FECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9862087A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4YpzziG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C9862087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbeITV6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:58:17 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35367 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeITV6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:58:17 -0400
Received: by mail-qt0-f194.google.com with SMTP id j7-v6so9054985qtp.2;
        Thu, 20 Sep 2018 09:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tb327Kui/+MUJmD7N70Bb+VaKbAu9dHeg8c120SQu+k=;
        b=G4YpzziGfF7BToM7+ZYvkXtDdWwIQWTnRZOW8YxnbyOvyOl9epeXkuqwhxpJhPfD93
         prasY2UbMFiaJrfy8Y6SxlhYHPYrfNStoJqH0CP5WbkB/bedOGRnTD2+bqrATXAtJzUU
         6GukBjbxIjEtx4C3t5zu8TDZ+IGOUkMJ6q4xleSbeTL0i5LH1NI5cts/VYWmZT/elgT9
         tE5FGqHczCpTQbJ17tXBLNtwedcqjvzIyb1DubSX2K2Lq11Vlr0DIyfg5JCFvqQ4vb4i
         wkC72leSz8+zKL/ygEbQeHCX3FGrDVsBcP1BeeeeFUtc/7UCi+FCkU8OFh0gTh5xBhsT
         PGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tb327Kui/+MUJmD7N70Bb+VaKbAu9dHeg8c120SQu+k=;
        b=daV8tnsByxzTyLvbT+7AlBsyzwEoFg1R2CSCtSPoMOgaXV6JXI86sVK51TQrjh4ZUJ
         Nd1S9WIPpaLYv7C0yY5t+dwvX/f3l9csNFYcG5G2JTlPP3X7zQKx6cJqnYpIq5JSqwqK
         m02yg84bbjtBxz6B8N/9Y7l//3h6QhuXiw4ZFxzuLjmqNpc0DKsKt9Vt/EP2K231rUJB
         cVv0sQZc+rKRJQsfSVVoQ1otN6XyhUaHA2XXpyEMrq62XunkJgSlbuGEagJet8mSScSY
         9mz5W4AQWOCSmc0/exa439TphrSW3PegVmf1qs6rXvFJ8wXQtt2HbPYwH+2T+lyvme3g
         kyXw==
X-Gm-Message-State: APzg51C4BKhDIw/9DQyRkSqGqZs2BXv0FyQU9kxomGECe9war1hczE3g
        VwTWaylaVnsvQ2tDun2xGkbUuvKpWCcMy2pfXMU=
X-Google-Smtp-Source: ANB0VdYJkfR7YLEExi1wTF6T5ZwopSx7gxpdyrihmOe5PDATMM+5wi9vCCimwR38mPAxff4F7Yddzr1/nQz+2om33cM=
X-Received: by 2002:a0c:aac9:: with SMTP id g9-v6mr29310856qvb.78.1537460043797;
 Thu, 20 Sep 2018 09:14:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:7494:0:0:0:0:0 with HTTP; Thu, 20 Sep 2018 09:13:43
 -0700 (PDT)
In-Reply-To: <20180920135936.GA9117@kroah.com>
References: <20180918165542.4691-1-miguel.ojeda.sandonis@gmail.com>
 <20180920135748.GA7749@kroah.com> <20180920135936.GA9117@kroah.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 20 Sep 2018 18:13:43 +0200
Message-ID: <CANiq72=OqZWGophkgH4SQG-Zrdq_Ue=gTrC4mqLqH_F7_VtC+A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Compiler Attributes: (naked only, for v4.19)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-sparse@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 3:59 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Thu, Sep 20, 2018 at 03:57:48PM +0200, Greg Kroah-Hartman wrote:
>> On Tue, Sep 18, 2018 at 06:55:40PM +0200, Miguel Ojeda wrote:
>> > These two patches are the 5th and 6th of the Compiler Attributes series,
>> > which Stefan and Nick requested to go into v4.19 so that the clang ARM32
>> > build is fixed. The v5 of Compiler Attributes will have these two removed
>> > if this goes in.
>>
>> As these seem pretty "obvious" and they do fix a problem for one
>> system/compiler that we want to support, and because odds are I would
>> end up getting them submitted to the 4.19-stable tree eventually, I've
>> now applied them to the tree.

Seems the easiest way forward for everyone, indeed.

>
> Also, it passed my build tests, I didn't just throw these in without
> doing that :)

Thanks for double-checking! Sending in a bit the v5 of Compiler
Attributes rebased on this commit then.

Cheers,
Miguel
