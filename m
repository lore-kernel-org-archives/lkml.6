Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id m9MBDm5sGVt1SwAAmS7hNA
	; Thu, 07 Jun 2018 17:33:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 363196089E; Thu,  7 Jun 2018 17:33:41 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wp228TTT"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7B18C601B4;
	Thu,  7 Jun 2018 17:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7B18C601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934015AbeFGRdi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:33:38 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:44921 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933667AbeFGRdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:33:36 -0400
Received: by mail-pg0-f68.google.com with SMTP id p21-v6so5078148pgd.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 10:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PrUr8o/lcC1pFXf76FiPqNU8MJePHT+T/A5C/gSGCs0=;
        b=Wp228TTTqMTWWk6FM2a5V+poUTtxOOOUNYFC7e/eUQNZtrhTiPKzWg+6EllOzXOZ0P
         sJsLfy38wVljuv1KOWJjHb/DdVmW/ExrTafK2QOviOAL9vvmzFQycT2mAJ6sZ1Sk+CKP
         w/wKugPkPvv813lRWhsGsBR+fXIGbir3NpLHJ6TaN11Juqdy5lczA3FaPU2/Th13+QFZ
         /gpP5D+FMSPm79e+jobHgR8Cc7ExwV1exvUpj5WzyWmyhloEEBusN+CPMylYjMqxCXeO
         UtUCH1hHovDJ9YryntBcYDeCkNMOrrB1ljgBsxoYCuGMzU+m+Rjcs+5KGNxZfRJtgAD8
         xOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PrUr8o/lcC1pFXf76FiPqNU8MJePHT+T/A5C/gSGCs0=;
        b=ledMiWcy02JS/6ZADsrqEGcXnWS42VlIWb8IUH7CJzKvgmnrt+xO7EDCNA24PUexVb
         mSMZn9PgSV2bd7Qp1VC4r1XQTtRakWUf0hINGMq/VYihae0V6+tVVyxE2hsm7nKGYFaK
         +k83QtqOxybLkcbGTuxUCsshCjRILhpaMdE0eWiUvdwljySUbG/Ei8HwtVZNB+h7Ebpp
         0CqZz0ETOxuhAv96pZ6tXkq/C+zXo/ZvuyxjH2EkVnh4I9xMmmDFs8dpidom2JjsWGat
         /32N0iw5U4o2g5Oe/ezuTr29Aqe1+LKfIceNqav8Ljow23SRXUkLN009fL2MBY0J1JKs
         /fag==
X-Gm-Message-State: APt69E2hYXjwVVhUHWjzQHjY3GwE0A4w4OoqHaBD+O89h3RgmJ5mmGeg
        a7m6w0tdNGo4VU07J9bSJ3HtyK7zIbP6XSbNkOtFJA==
X-Google-Smtp-Source: ADUXVKLO5vxE4v/sGI7saYj0Cp1IyeVU8XcW4Ytv6nwzMyuaZFTx4uJUbwR0166Nmq0OIeLvgXqVKODFTTJoSxny9LE=
X-Received: by 2002:a63:a513:: with SMTP id n19-v6mr2286626pgf.381.1528392815376;
 Thu, 07 Jun 2018 10:33:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180605170532.170361-1-ndesaulniers@google.com>
 <20180605170532.170361-2-ndesaulniers@google.com> <202492204c2d5bd5ca27307cbca5e44673b739ed.camel@perches.com>
In-Reply-To: <202492204c2d5bd5ca27307cbca5e44673b739ed.camel@perches.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 7 Jun 2018 10:33:23 -0700
Message-ID: <CAKwvOdmqQWwTPO-jBHK_PgeVv6eax8hJ8XV+s=TJRc-+PH3h7Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] compiler-gcc.h: add gnu_inline to all inline declarations
To: joe@perches.com
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>, akataria@vmware.com,
        boris.ostrovsky@oracle.com, brijesh.singh@amd.com,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Greg KH <gregkh@linuxfoundation.org>, hpa@zytor.com,
        "J. Kiszka" <jan.kiszka@siemens.com>,
        jarkko.sakkinen@linux.intel.com, jgross@suse.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        kirill.shutemov@linux.intel.com, mingo@redhat.com,
        mjg59@google.com, Matthias Kaehlcke <mka@chromium.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        rostedt@goodmis.org, Thomas Gleixner <tglx@linutronix.de>,
        thomas.lendacky@amd.com, Thiebaud Weksteen <tweek@google.com>,
        linux-efi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        x86@kernel.org, virtualization@lists.linux-foundation.org,
        Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Greg Hackmann <ghackmann@google.com>, sedat.dilek@gmail.com,
        tstellar@redhat.com, Kees Cook <keescook@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        geert@linux-m68k.org, Will Deacon <will.deacon@arm.com>,
        mawilcox@microsoft.com, Arnd Bergmann <arnd@arndb.de>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 10:23 AM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2018-06-05 at 10:05 -0700, Nick Desaulniers wrote:
> And only set once along with:
>
> >  #define __always_inline      inline __attribute__((always_inline))
>
> And perhaps this __always_inline should be updated
> with gnu_inline as well
>

This should pick up the additional attributes from adding `inline` to
the redefinition.

Attributes can be combined via:

__attribute__((a)) __attribute__((b))

or

__attribute__((a, b))
-- 
Thanks,
~Nick Desaulniers
