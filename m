Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id pohwNzMvHlvIXgAAmS7hNA
	; Mon, 11 Jun 2018 08:13:48 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C1D0F607A4; Mon, 11 Jun 2018 08:13:48 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="F4WGqK/W"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1C68E60791;
	Mon, 11 Jun 2018 08:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1C68E60791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754144AbeFKINp (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 04:13:45 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:52203 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754039AbeFKINn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:13:43 -0400
Received: by mail-it0-f66.google.com with SMTP id n7-v6so9330858itn.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 01:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=naRPeXZHrCh/GeFuNRWkZVSdhp0Q1xMrypMje1D7e2o=;
        b=F4WGqK/W0p7mrVBNGD2bW81NuKWZgh0V2SYA5xw6buttxTa+hY5/sbl6a2xqogs/MI
         yro17dMvbiJcKYjY9Q9WPavDjedXMAm7PXT8JVbsIJoUUeEbhD+K5bywUYEjfdA0Dr2x
         cgUV4FqWWX3hMYaWuPIkM8hxCuQWMUFQaH23M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=naRPeXZHrCh/GeFuNRWkZVSdhp0Q1xMrypMje1D7e2o=;
        b=PiJ+G9LqkXprmtP9sXzZLwPMlXSa1c9S6RA9+ptSIJ90ObeBcK7qrt6J93J4Fv/36x
         499Du4seRiZinLpFYqsK4mPQmO2vHFrWb7ayp2WCofObxEWPQrDIiN4fxPLwY8OyDLsh
         yr6j0vKYxwqJyz27vmpmrM/YnjI0sa2dj8vCNHfKph9t7SwkWpmTjXNsauxSk528Z7mM
         i3OJghDX4nK7DNEi34FKWzuTFuTS+kjiNjPxFjPnyb3V41cs2SOzkJEv5UQQqiF56K6Q
         c3rJbASVpDa9QlihNfDFx3KNA2Dezs6fkl5oRXFFJzHTnypGd13Lt44/ZZirozXrirlE
         3xTA==
X-Gm-Message-State: APt69E2r9fxDskqxso81WQANfpurub7qTeQxJGyHrLmsG5w4NZviFZqD
        5IhCISUlQmo8uyuG1j5MGA3Xs8u1qbM4u+7wn7/4cw==
X-Google-Smtp-Source: ADUXVKKYVB5mbMOQnXrUFso/vj8uNJtJFr7a5yNgsON8L+DYN8NVpJNm0TXU2gpaJ9jJ0DcmYRIOZMmHJdH7BzIWqU8=
X-Received: by 2002:a24:298e:: with SMTP id p136-v6mr9307807itp.42.1528704822738;
 Mon, 11 Jun 2018 01:13:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 01:13:42
 -0700 (PDT)
In-Reply-To: <CACT4Y+Zh8eWPLTrVyOufeXd6LMcUdQr8Q07OWWGTTgwOYT6Gvg@mail.gmail.com>
References: <001a11449aa2faf11805643af581@google.com> <CACT4Y+YOmbZGdBbFpmjRJXABGe1tD=F+3na77DwoPCEaROADyw@mail.gmail.com>
 <20180202221829.tdiji2332t7orcxj@gmail.com> <CACT4Y+afpDQ7A3caRmskML06h8Q6+NkVAn6HtV93ExPec-g2pA@mail.gmail.com>
 <20180526072203.GA724@sol.localdomain> <CACT4Y+Zh8eWPLTrVyOufeXd6LMcUdQr8Q07OWWGTTgwOYT6Gvg@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 11 Jun 2018 10:13:42 +0200
Message-ID: <CAKv+Gu-RXe3baYUWw1dvBJdD7MBuB6Zg6rN5rVYyotcQgTvmdg@mail.gmail.com>
Subject: Re: WARNING: kernel stack regs has bad 'bp' value (3)
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Eric Biggers <ebiggers3@gmail.com>,
        syzbot <syzbot+ffa3a158337bbc01ff09@syzkaller.appspotmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
        <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 June 2018 at 11:54, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Sat, May 26, 2018 at 9:22 AM, Eric Biggers <ebiggers3@gmail.com> wrote:
>> On Sat, May 12, 2018 at 10:43:08AM +0200, Dmitry Vyukov wrote:
>>> On Fri, Feb 2, 2018 at 11:18 PM, Eric Biggers <ebiggers3@gmail.com> wrote:
>>> > On Fri, Feb 02, 2018 at 02:57:32PM +0100, Dmitry Vyukov wrote:
>>> >> On Fri, Feb 2, 2018 at 2:48 PM, syzbot
>>> >> <syzbot+ffa3a158337bbc01ff09@syzkaller.appspotmail.com> wrote:
>>> >> > Hello,
>>> >> >
>>> >> > syzbot hit the following crash on upstream commit
>>> >> > 7109a04eae81c41ed529da9f3c48c3655ccea741 (Thu Feb 1 17:37:30 2018 +0000)
>>> >> > Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide
>>> >> >
>>> >> > So far this crash happened 4 times on net-next, upstream.
>>> >> > C reproducer is attached.
>>> >> > syzkaller reproducer is attached.
>>> >> > Raw console output is attached.
>>> >> > compiler: gcc (GCC) 7.1.1 20170620
>>> >> > .config is attached.
>>> >>
>>> >>
>>> >> From suspicious frames I see salsa20_asm_crypt there, so +crypto maintainers.
>>> >>
>>> >
>>> > Looks like the x86 implementations of Salsa20 (both i586 and x86_64) need to be
>>> > updated to not use %ebp/%rbp.
>>>
>>> Ard,
>>>
>>> This was bisected as introduced by:
>>>
>>> commit 83dee2ce1ae791c3dc0c9d4d3a8d42cb109613f6
>>> Author: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>> Date:   Fri Jan 19 12:04:34 2018 +0000
>>>
>>>     crypto: sha3-generic - rewrite KECCAK transform to help the
>>> compiler optimize
>>>
>>> https://gist.githubusercontent.com/dvyukov/47f93f5a0679170dddf93bc019b42f6d/raw/65beac8ddd30003bbd4e9729236dc8572094abf7/gistfile1.txt
>>
>> Note that syzbot's original C reproducer (from Feb 1) for this actually
>> triggered the warning through salsa20-asm, which I've just proposed to "fix" by
>> https://patchwork.kernel.org/patch/10428863/.  sha3-generic is apparently
>> another instance of the same bug, where the %rbp register is used for data.
>
>
> Mailed "crypto: don't optimize keccakf()" to fix this.
>
> Amusingly __optimize("O3") always lead to degraded performance as gcc does not
> inline across different optimizations levels, so keccakf() wasn't inlined
> into its callers and keccakf_round() wasn't inlined into keccakf().

That does not make sense. The -O3 definitely made the code run
slightly faster on AArch64, but I don't remember the exact numbers or
the compiler version.

In any case, it wasn't an improvement worth obsessing about compared
to the 14x speedup I got on A53 from rewriting the code itself.
