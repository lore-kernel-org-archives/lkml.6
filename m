Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69121C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38EAA20838
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxVJPSj6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393052AbfBMRa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:30:58 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39707 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388566AbfBMRa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:30:58 -0500
Received: by mail-lf1-f67.google.com with SMTP id m11so2414679lfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 09:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IX5fc9GiseTVOqj3NSbxo+dq4Rg06FdkulNe7qorIFM=;
        b=kxVJPSj60TPBNiwanaFQPKZ7neCCSGNYMdj37WHxUAJ8ananQWcwp2yB3Djl2GoUOr
         35+SSqsfen+hGi513v62v73x9CSzwfjGgCGWvS/DY6hF6Vh1UC17lVzY+2UXP8GdOTqR
         B5kJz7Xcjc4Q04ncL4Ysp2/LrtPdOeTqxGXBP8x1B9XUsxYCc+V+eUMfM0oLOJdsQpBn
         h67oUVgaABAVYC0aVZ2GuUAbikpWSFXbTYDLRGNfOmSw1ua1iY8z1cn8di6XrmubOx+V
         twNiveEwX7VWyOXuD/WVec2KJVXozQz+KiEJ2UpN/NjJ83ka1u/uPOYkLrTJ5ku4fpZN
         8s5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IX5fc9GiseTVOqj3NSbxo+dq4Rg06FdkulNe7qorIFM=;
        b=GNQX6IBg9mKftw5L2rlG5sKGUMI/gqVuTPOYHlkQNjnX2IqQJkcJY3h8K0XZrruuQA
         MUXVfW9s+6olUN+b8EH+Rl8249GUmlL6xF5lpBEIh2V8xPlmMx9tmaye3bmYaDsplYyb
         lNCBfVcMPpzJRj4jZjVIg9aPnwfnR9Ogc3ldhQX4mfXddhbPXTw+5rw/eVlC3cMK8KHt
         8VZyNB51hEf++2iTu0Vzjwjo5NI2PQVWgiz3MVx7uMdHIJ6/lMWn47o5CZGBGuZsGY9L
         Ifs+YBEhW9/+47HD5X/2PCjPVVmcr3UumumW6C8cqkMtmcHOyDrEufUYjmRPJWABhBZa
         oNBQ==
X-Gm-Message-State: AHQUAuZGzyAgkey2fEFGVwMX64TCc0ERXTLc/uOatsLHMDw9A56NrqVZ
        ZN1zUjBlpR4fiPHJGe50bpZEicQDIsCwN/gS7ag=
X-Google-Smtp-Source: AHgI3IZTExM9zN2cSP04M34VNLFkLkPWCR4j2HRBx6wMSH3vQdF4MHc+qOFj/3RCrn4Yg2OSpfHRGTDZqUwazZ7zQ0A=
X-Received: by 2002:a19:d619:: with SMTP id n25mr901014lfg.91.1550079056314;
 Wed, 13 Feb 2019 09:30:56 -0800 (PST)
MIME-Version: 1.0
References: <20190209000840.11018-1-miguel.ojeda.sandonis@gmail.com> <45be0d68-8382-64bc-dcd0-0e86462e6e66@redhat.com>
In-Reply-To: <45be0d68-8382-64bc-dcd0-0e86462e6e66@redhat.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 13 Feb 2019 18:30:45 +0100
Message-ID: <CANiq72kEupj5FeNHhgLnZv9esiexiWMc1DmZ-eZt9K26NS1Qbg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Clean the new GCC 9 -Wmissing-attributes warnings
To:     Laura Abbott <labbott@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Martin Sebor <msebor@gcc.gnu.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <james.morris@microsoft.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Borislav Petkov <bp@suse.de>, Matt Mullins <mmullins@fb.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        WANG Chao <chao.wang@ucloud.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 9, 2019 at 9:33 PM Laura Abbott <labbott@redhat.com> wrote:
>
> Tested-by: Laura Abbott <labbott@redhat.com>
>
> You can look at the full build logs at
> https://koji.fedoraproject.org/koji/taskinfo?taskID=326911 .
>
> Thanks,
> Laura

Thanks a lot for the tests, Laura!

I will send this for -rc7.

Cheers,
Miguel
