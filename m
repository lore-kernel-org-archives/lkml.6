Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61483C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055952088E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OZMlMigM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 055952088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbeILXZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 19:25:05 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38452 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbeILXZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 19:25:04 -0400
Received: by mail-it0-f65.google.com with SMTP id p129-v6so4353293ite.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 11:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vVYZmYDQusgs5WEVYlrHbZm15KeJNj+KqWke29rz0Yo=;
        b=OZMlMigM6Mvsbl2TYqagohiWLeK2VOADJD9ggMPnEW7m5cPQTVr4nCXYlZIWZBjPTG
         LNrCysyX78Qp9z0jPnp0ND/Vv3UmUd7YOvkMqHZZeE636kMKGGGUAbge6vmfIVfvnOVp
         gVfaebjDQkj0eDx1pXOba+6jsZUkMR6kvqhIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vVYZmYDQusgs5WEVYlrHbZm15KeJNj+KqWke29rz0Yo=;
        b=SzRK+8vATfgd3mhSLsl/SiJRLuvcUurW2Btub2JL75h8WrLWxNFo2ZMgaF2dPex7GO
         lKEuXzI0iavfw9KvusACNFEgjHV3/plmOdDjXKp9C8k2GSH1zzFdTMorQXRDz8ZXNxtJ
         xPnub/rMs1JkSxTEqj3xQon3VoExKCcXTTjX/UQ6CpoNMGTIImgAy07hvccVR8MRFv00
         cG9o2bS0CReRbqkinwiylbOaiASelktmdGf+vjOuUop7aLjb2jjCCRxcxeMhMwvkG3fr
         1lxLhf+N6lsDG9HcRvyLeL9cvYYFWhx79sU0NmmJCu2YNOrKMGdZAVzlG6EFCcf93sEe
         zzOw==
X-Gm-Message-State: APzg51D6P/IHzAf88xMHfGczwylCy0vrWfvY2jUedNi+bhCH+uCygQS8
        uuFnJhNb06+1JGlxGUGCRABdKmbtbIfsD0JMzB00Jorp/YJ2ow==
X-Google-Smtp-Source: ANB0VdZCKlHZweyIqrkoHpRVn8u4xvnW8lngLhhklffZcMZRB7R4qCFY0OLWnwlJAOI+qKqQMx+hdLewXm+zqG+qdBA=
X-Received: by 2002:a02:4d1b:: with SMTP id l27-v6mr3152445jab.86.1536776361824;
 Wed, 12 Sep 2018 11:19:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 11:19:21
 -0700 (PDT)
In-Reply-To: <CAHmME9rxrC+CAR-xoXd-bZO1HYZ+TjvT_K4xgQwWXE53zi61xQ@mail.gmail.com>
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-3-Jason@zx2c4.com>
 <CAKv+Gu9nSeo4PFVrtjtqGQ32eqyxUp3xVCczZfu+dhFz5yLM0A@mail.gmail.com>
 <20180911220849.GC81235@gmail.com> <CAHmME9rxrC+CAR-xoXd-bZO1HYZ+TjvT_K4xgQwWXE53zi61xQ@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 12 Sep 2018 20:19:21 +0200
Message-ID: <CAKv+Gu9ZjX3A4bHHgRAkJtr+SKwti+d3dwE0fhGtmeQB_refqw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 September 2018 at 20:16, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Hi Eric,
>
> On Wed, Sep 12, 2018 at 12:08 AM Eric Biggers <ebiggers@kernel.org> wrote:
>> I'd strongly prefer the assembly to be readable too.  Jason, I'm not sure if
>> you've actually read through the asm from the OpenSSL implementations, but the
>> generated .S files actually do lose a lot of semantic information that was in
>> the original .pl scripts.
>
> The thing to keep in mind is that the .S was not directly and blindly
> generated from the .pl. We started with the output of the .pl, and
> then, particularly in the case of x86_64, worked with it a lot, and
> now it's something a bit different. We've definitely spent a lot of
> time reading that assembly.
>

Can we please have those changes as a separate patch? Preferably to
the .pl file rather than the .S file, so we can easily distinguish the
code from upstream from the code that you modified.

> I'll see if I can improve the readability with some register name
> remapping on ARM. No guarantees, but I'll play a bit and see if I can
> make it a bit better.
>
> Jason
