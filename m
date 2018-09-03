Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4155AC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5AB20645
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvcUjdDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5AB20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbeICPgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 11:36:35 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:39521 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbeICPgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 11:36:35 -0400
Received: by mail-qt0-f195.google.com with SMTP id o15-v6so185989qtk.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 04:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=crIWCQFxI9eJ+RvLRvmEh6JFIxaKLsAkDu07sKgUYxM=;
        b=FvcUjdDDg1vT1go+pWO1HXIkWDZ1nLTe928SQx+vUXbs8NaB3bMwyseIxL/fbrlfy3
         55zm/DbS44izKCcLKUvdT7UFD14krLUjtU8bsOfWVV5DGFzhiW7mJWy0FpkT+P2JqC9g
         h6bIgleKWHWqp3wdRnEZwCzK+Zk+9mfErtssWq7jhVdImCJb5VnXCM+30eT+/FfzWtZZ
         XRV8NNgZm+RPxnhsrsVXrB5MWXrvUHIGGcWfwosUPu1Szvw0Yx7P5Bi7KLrJjYsy+RcU
         lfS8TefIShagkh05AfGyscwfRljpRQz24NinntbMaEd0ZOU5w8YZrWXDQTDXdfQXkUP9
         l5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=crIWCQFxI9eJ+RvLRvmEh6JFIxaKLsAkDu07sKgUYxM=;
        b=uMiBXFPC/GPoj6l+XfvG8Y/5U17bVcDCkd1SsDHB8b3szY8De+jnia2n5aa1e2xX9X
         n5cBkLt0mzm4qk0rsMxoUJYSdFgqMnLRZe8OVWQfJw2KNuaGNnMy8m/QeKXmP3dk7tLP
         nU75ZjmONOr1gM+dvD42IFv3vAJCetyfvp4UQh64cqI+kgkPYlexit4do2Gp0W6rsBot
         mOK5zpw/Oh+WhNEkKWRGG8mNTTaJeRflFYAeKlxo/y3L29hxvgOTdxtob05Jz114jnIr
         QcT3Lor8P5xhiD+6CFikuGLVEf9AsT1lx/QIRULMpO9W2aciqr2fqxos8CCpuYaw8i0k
         9MSg==
X-Gm-Message-State: APzg51DGk/Jy2GQY/fNT9dDmNm+dUn/VQvtWsIfNYsTiVFnBJKh6k8Cr
        /V8aJbDzmb8AK3m8uloGlth2dmBtVpGkfQvKBoE=
X-Google-Smtp-Source: ANB0VdbxiEtmNBmjErlTrgAC66deN4toswtfLpvTtuVH7gPWAS1Z9/jEIqgdLReZTRmPiJeH0uijL5pKWDaj9Sngo84=
X-Received: by 2002:ac8:350f:: with SMTP id y15-v6mr26175327qtb.241.1535973413211;
 Mon, 03 Sep 2018 04:16:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:34a7:0:0:0:0:0 with HTTP; Mon, 3 Sep 2018 04:16:32 -0700 (PDT)
In-Reply-To: <CAK8P3a2cDhJ_jJwDZwfZV+iKeY4Vwu_PjPp3UPcQjWmrWJGdww@mail.gmail.com>
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
 <a1d6922dea4f80be097fdb912a545727ff96f1b1.camel@perches.com>
 <CAKwvOd=kePHrDA7NJKyu8aiXVt7iRsxXNRe3tkG3rp-c0xpO5A@mail.gmail.com>
 <CANiq72kA=hdg00FeWovJcXpY54hJx-bLYy_Cpd9PsOdTEYHGog@mail.gmail.com>
 <CAKwvOdmYcF3M1kb6B6jAYfL40P56tG_DOsx_cpLDF-Z2+ceGQQ@mail.gmail.com> <CAK8P3a2cDhJ_jJwDZwfZV+iKeY4Vwu_PjPp3UPcQjWmrWJGdww@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 3 Sep 2018 13:16:32 +0200
Message-ID: <CANiq72=XMm03cMg2bWTt3yyhnW=yFHx+Qrpf8B=v=MR=E6iLrQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] Compiler Attributes: remove unused attributes
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 2, 2018 at 9:54 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Aug 31, 2018 at 11:27 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
>> On Fri, Aug 31, 2018 at 1:23 PM Miguel Ojeda
>>
>> > I guess that
>> > is breaking ARM clang builds at the moment (didn't check)?
>>
>> Huh?
>
> 32-bit ARM has a number of problems with clang at the moment,
> one of them is the lack of a __naked definition, which causes it
> fail building if any of these files are enabled:

+1 This is what I was referring to.

Cheers,
Miguel
