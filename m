Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C99AC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 23:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA832150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 23:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smryyW12"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA832150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732329AbeITElN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:41:13 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:42007 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbeITElN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:41:13 -0400
Received: by mail-qt0-f194.google.com with SMTP id z8-v6so6760171qto.9;
        Wed, 19 Sep 2018 16:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qbSUPQRqa3B4lO113dE2veQeSWz9ghrO/P/n8MCXexo=;
        b=smryyW12V2itOEnwacPqe8Y7XjLnqQ3zM/Q1Bhah4Zo98HVINlCm1UveDfnETGhVs3
         j1DyWX7/6e1kSPauEV7Jv7erdQMdKnLgS6ndIZpOPgYgVCSoS1M6KtquU48NWzywIAbK
         XN0pQ/arx9ys918Xa+bC0IUQSYrNfeKxqEGr/LkLC1+Ds+XzGJrOhgWQ6rac2nkXOBML
         LbUpfYkTulgvdSduj7TxZncwiGXe7mvVvlJ4lZezV2zrln6eScQGMr/eGMkwV4kecrss
         652DIVAJ2WtU48E5ifqJzSvuxpYbWEvSCvC+FDeQfUoQNSFMFBkN6ZjoQ3mJIjXhBngt
         NPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qbSUPQRqa3B4lO113dE2veQeSWz9ghrO/P/n8MCXexo=;
        b=dlJtlR1OFPjnfSzkat3HmlXg5xJKPUOrJ679cZlz4Dj1+uP68ZdN1geetsuF/vUBPo
         khC4LXon5U8fNdZVACma61NVSKZ63sKmTeo3y8CZq/D2CslXtsInr2tOi30vRlcKFzsA
         PDkBEvAU3yGEpKs5unyNL1opgIo/knjJschET9HOMHg44J9YOb7YHCjHq9s9KnAMjkR5
         BW8pI4fBIl8FXVgkoHJq081Ht+GzwuWJ/ke7pSt+ZsmbtUDUb2vppFHIsvk4avYhFYZM
         pOZLBu0DmfeuGxt15RH9ScqZtZwQWnJoI5t9T/b2wOuNx0DwcVkMoxt0/KpD/ZgPqaML
         1xtg==
X-Gm-Message-State: APzg51Dq3UScvPtOdZya0KUOVpl8HPespTooPP9rP29oXsiJC5kqVA0K
        kgCfumziMMi87PF/2u2nZ0tQOUruYmJ58CyMLcA=
X-Google-Smtp-Source: ANB0VdabsS+wJ9qjr7GqM61eBUwjlAkPZG5gdNUzhyNhCf3oQ9j9Q9aVkjRgt9F+4lP968jZsr+QL4JQSLV98wj1jgs=
X-Received: by 2002:ac8:350f:: with SMTP id y15-v6mr26698230qtb.241.1537398062488;
 Wed, 19 Sep 2018 16:01:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:7494:0:0:0:0:0 with HTTP; Wed, 19 Sep 2018 16:00:41
 -0700 (PDT)
In-Reply-To: <20180919211458.GA8757@kroah.com>
References: <20180918165542.4691-1-miguel.ojeda.sandonis@gmail.com>
 <20180918165542.4691-3-miguel.ojeda.sandonis@gmail.com> <20180918173428.GA21591@kroah.com>
 <CANiq72=ZU61EaoWm2N4G1SZF0QUvzquULo50uEvDRU-hitOJVQ@mail.gmail.com> <20180919211458.GA8757@kroah.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 20 Sep 2018 01:00:41 +0200
Message-ID: <CANiq72kS_w7p3Xe9cDCjCA9j1u-zQ1-C4ZX7N8G+AbP4u7SG8w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Compiler Attributes: naked can be shared
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Stefan Agner <stefan@agner.ch>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-sparse@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 11:14 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Sep 18, 2018 at 08:56:04PM +0200, Miguel Ojeda wrote:
>> Hi Greg,
>>
>
>> Since Linus/Andrew/you
>> didn't comment on whether you wanted or not this for 4.19, we are
>> assuming they would go in for 4.20. However, Stefan/Nick/... wanted
>> this for 4.19 instead, they asked me to extract these patches two
>> separately for 4.19. I let them comment further on the status of Clang
>> on arm32.
>
> If these do not fix a regression, I don't see how they would be ready
> for 4.19-final.

Ok, I will wait a bit to send v5 until this is sorted out.

[CC'd Nick, Stefan, Arnd: I just noticed the Reviewed-by/... lines
were not picked as CC].

>
>> I am going to send a v5 of the entire series without these two
>> patches, based on -rc4 (or -next, which one do you prefer? I would say
>> these patches should be applied early in the -next branches, so that
>> everyone is ready for the change, given it "touches" every translation
>> unit).
>
> That's up to whomever takes these into their tree for linux-next
> inclusion.  If you are about to break everything, then you might
> consider changing your patches so they do not do that :)
>

Well, the series shouldn't break anything (famous last words :), even
if everyone includes those headers. So, in theory, they *could* be
applied anywhere, anytime; but given they are global changes...

Cheers,
Miguel
