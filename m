Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773ADC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 19:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199E42083F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 19:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUjDW5aG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 199E42083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeIAX3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 19:29:04 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:41885 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbeIAX3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 19:29:04 -0400
Received: by mail-qt0-f194.google.com with SMTP id t39-v6so18073331qtc.8
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 12:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1VPm/W4Nmvxg9KLbOkc4wCZYnEjAPfkcTxm6onC6aRY=;
        b=dUjDW5aGndDCdQ4shqWLG4cZZ30r8/WXLZV3nCvF4fd+YLuEj8PLlzPSF66ynocv3U
         9BNzSH2c/1/4fkezSZpmAS9QJGo3r62kQbSG53t8Vcq/IWfel8u74BqncAsMdW74uUg+
         0aJxUMDvm5JrM7M9hzIeHfHId9hMyFLKwogOrANnJo0TxHhrGOPdVUo/yqvUKDu8faY9
         fNpo2scSNKPqo7Dv+idnE+gm7Y3jXs1FH0XzUC6PUALl46DwO/OhmFG+taZBJJI9Jqoh
         dXJ7LbS8NDV4Hq8bYL5nKpkjusAuweki+EAFxjmj4nNgLFJvgQZ7vcwcAmbhnC2ZIjO7
         oQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1VPm/W4Nmvxg9KLbOkc4wCZYnEjAPfkcTxm6onC6aRY=;
        b=Un53f8zG/NWTgxERzweVCKOCfzxaZcVdcTTgteHiCoaZUWYN0fvFoCIYR4HPdzg+K3
         5uBnuJxj1+psRgs/OlO3ZwBRe6C5rgFAe2FhVJZLU1WgOdOXvtHxmfMx4HsZpkIa9wBR
         J+T0PZc7M9pLF4gHwonNMYUaNg1Jr/rqL7B0uHHYLzlEuKSkd7buS/e6txumRvIUzLB7
         so3V4qT1CTUq7XHU7LtVEqutH76KNjsj5cR+cCGbZcNmgNCuYFU8/49ju6fHA+qggFrl
         aQZN8omXjwmtFHSuMn+8fwp5eJ3cIEPef9A4/AvuBLfkeb290BRhPc94C8dA/mtfPo2w
         W3rQ==
X-Gm-Message-State: APzg51BPV1EmkZME4yqeQTplQpFaaarlr6iLtHnCYhtnMPVKJ9QKqoUR
        HiqcznFnA9XSLLmp1T6GTrtvsw/yRPMTLjN1pTY=
X-Google-Smtp-Source: ANB0VdZNRoUv0G9fk4xi9DCjQr5924oATGyKlP56U1+9xOVNv43vhiGqeexcwBIQogu/bNBcmHmuFCqHXV4jzz8jzUQ=
X-Received: by 2002:a0c:87b1:: with SMTP id 46-v6mr4131393qvj.202.1535829365883;
 Sat, 01 Sep 2018 12:16:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:2291:0:0:0:0:0 with HTTP; Sat, 1 Sep 2018 12:15:45 -0700 (PDT)
In-Reply-To: <20180901183920.GA8341@kroah.com>
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
 <20180831170514.24665-7-miguel.ojeda.sandonis@gmail.com> <CAKwvOdmF7bPJvnf38HYvnzdo8vO4K5=qkFwdTqwNnKA6PUVwpQ@mail.gmail.com>
 <CANiq72mfuJ2=v8U9vUs1vJVEjY2sp7f-WbTRZRHNvgh+VbAgnA@mail.gmail.com> <20180901183920.GA8341@kroah.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 1 Sep 2018 21:15:45 +0200
Message-ID: <CANiq72k1AZLYq=LpNPchb-BWamz_zqe8VVv3haVdA4F0D-ttHw@mail.gmail.com>
Subject: Re: [PATCH 7/7] Compiler Attributes: use feature checks instead of
 version checks
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Sat, Sep 1, 2018 at 8:39 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Sat, Sep 01, 2018 at 03:38:13PM +0200, Miguel Ojeda wrote:
>> Hi Nick,
>>
>> On Sat, Sep 1, 2018 at 1:07 AM, Nick Desaulniers
>> <ndesaulniers@google.com> wrote:
>> > Overall, pretty happy with this patch.  Still some thoughts for a v3,
>> >> -#define __visible      __attribute__((externally_visible))
>> >> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
>> >> new file mode 100644
>> >> index 000000000000..a9dfafc8fd19
>> >> --- /dev/null
>> >> +++ b/include/linux/compiler_attributes.h
>> >> @@ -0,0 +1,226 @@
>> >
>> > New file needs an SPDX license identifier right?
>>
>> Yeah, but I wasn't sure of adding it, since the code I moved (even if
>> rearranged) from _types.h does not have it either. Any legal expert
>> here? Is _types.h it implicitly GPL 2? We should add the identifier to
>> both if so.
>
> It looks like we missed that file in the big "properly add SPDX
> identifiers to all files without a license" commit as it came in from a
> different tree.
>
> But yes, it is GPLv2 only implicitly, so you can add that.  I should
> sweep the tree again to see if anything else has been added accidentally
> with that same problem.
>

Thanks Greg! Will do for v3.

Cheers,
Miguel
