Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0E6C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 19:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB2D7218C1
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 19:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cV41tJEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB2D7218C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbeHEVFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 17:05:45 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:34001 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbeHEVFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 17:05:45 -0400
Received: by mail-it0-f67.google.com with SMTP id d70-v6so10356558ith.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 12:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qix4fh1rqX3dwE3q59Q0yUZYFb9QOdrVEHW3P2Yh1fY=;
        b=cV41tJEvMTlvZKz5zGIa3Z1IoQD//tcZCyqQ3I57y5IdBoYkErB4DlbTvR/nQe3Kjl
         CJ0PBSMZfs/qngBAVB3DIeFBY6K1IMdyK5Y2GwWPNMQqvzVzTz5KgCo2YTh5YJcdl94G
         c6BNYKlx5L4kg1zJoT9YyMybPov9ZYAEl+m7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qix4fh1rqX3dwE3q59Q0yUZYFb9QOdrVEHW3P2Yh1fY=;
        b=njeGcdIX31YSn6mFXvsLjZwCbWlgFfMKhUabQ+ng+aCzEM/65Yx7RLY0xKC/V8W/Dn
         +xtTqHKUfNV16V2Plll0FoeK3wafIKvfK52w3zFq15XBDAIL13mMoezAYRDDMh777Md+
         ugGj8KS4yRVJBwbvaDrCPXBsdHrUEo+xHZUtlU9+DYwSskJU4/GbdE6bUgPn6mWmk9wH
         cuyZ8sb+wolyXalEcn8onHc+38nmZHaHFfUEUWHPsAzrVkkIhiYWufNRBm+f8erzAn1k
         JE2fW3t1c/9ANc+ilb0sZss0whJFp6ylEYp/hc60sVHNg0+iP3Y+DLBCD56Ty1b3LsuQ
         cMmg==
X-Gm-Message-State: AOUpUlHcOui7X00q/WjwyanhCKclxJqJ/6p5GbfjaO7n2nTaiMSvBLYd
        y69i8XZjTjLb6A7QVIQMuCrEpj2PmWNB35Mqp/vOoQ==
X-Google-Smtp-Source: AAOMgpdMV8RgwiP8YIRngGEQew0GkVHi6wHJLdCTYV7i9E8S0p5fTmuq21Loqx8ZMZ/khk1m7aALVhGTUE9glmElEKE=
X-Received: by 2002:a24:5242:: with SMTP id d63-v6mr13090461itb.138.1533495613623;
 Sun, 05 Aug 2018 12:00:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Sun, 5 Aug 2018 12:00:13 -0700 (PDT)
In-Reply-To: <20180805163139.GB27062@linux-l9pv.suse>
References: <20180805032119.20485-1-jlee@suse.com> <CAKv+Gu81vEGNggcWv1NyPJsMeK0HRi_DanH2+Z_4metoNG=txA@mail.gmail.com>
 <20180805163139.GB27062@linux-l9pv.suse>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sun, 5 Aug 2018 21:00:13 +0200
Message-ID: <CAKv+Gu8eW3Q0DhXN38qZ1nDJz8Hz7wJcWvLRSW3xm1qVt54AaA@mail.gmail.com>
Subject: Re: [PATCH 0/6][RFC] Add EFI secure key to key retention service
To:     joeyli <jlee@suse.com>
Cc:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Pavel Machek <pavel@ucw.cz>, Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 August 2018 at 18:31, joeyli <jlee@suse.com> wrote:
> On Sun, Aug 05, 2018 at 09:25:56AM +0200, Ard Biesheuvel wrote:
>> Hello Chun,yi,
>>
>> On 5 August 2018 at 05:21, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
>> > When secure boot is enabled, only signed EFI binary can access
>> > EFI boot service variable before ExitBootService. Which means that
>> > the EFI boot service variable is secure.
>> >
>>
>> No it, isn't, and this is a very dangerous assumption to make.
>>
>> 'Secure' means different things to different people. 'Secure boot' is
>> a misnomer, since it is too vague: it should be called 'authenticated
>> boot', and the catch is that authentication using public-key crypto
>> does not involve secrets at all. The UEFI variable store was not
>> designed with confidentiality in mind, and assuming [given the
>> reputation of EFI on the implementation side] that you can use it to
>> keep secrets is rather unwise imho.
>>
>
> I agreed with you. Especially I can't refute the part of EFI
> implementation, manufacturers can not be fully trusted.
>
> I am thinking a case... Some machines provide setup mode. If user
> earses all manufacturer's reloaded keys and only enrolls their own
> key. Which means that user fully controls the authentication
> environment. Then the EFI boot service varible can be trusted by
> the user.

This has nothing to do with trust but everything to do with confidentiality.

*Nothing* in the UEFI variable store stack has been designed or
implemented with confidentiality in mind. The contents of EFI
variables are readable in the clear from the SPI flash. Code that
handles variable store reads may leave unsanitized buffers behind. We
have efivarfs that needs to be modified to hide 'secret' variables,
but also, to kzfree() every allocation that is used in handling
varstore access etc etc.



> But this case is too strict for normal user.
>
> Thanks for your review and comments. I will think more about your
> suggestions.
>
> Joey Lee
