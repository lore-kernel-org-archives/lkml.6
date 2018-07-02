Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76649C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 02:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C4302502A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 02:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U1Mdv7sQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C4302502A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932895AbeGBCDy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 22:03:54 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43532 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932221AbeGBCDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 22:03:50 -0400
Received: by mail-oi0-f68.google.com with SMTP id 8-v6so8907793oin.10
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 19:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7jGiEKg0hL4hgpMfzHUFEbQbeOUbixI7fKw0e/6FANU=;
        b=U1Mdv7sQYrKhMBKZX0WjB+k1dQkuETAGH96fmPO/2el620A+1TIlIebjByTulZ5UnX
         69H4cQGcFOzNpoKkD2URYxYG5Ls1dERofDR5YZ+wKbzpn+d+tnJhHCELiUGgBZ0l4/sb
         Ei75GPAVaVzy7jJBTnPVQTaZGaxb3veaABpKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7jGiEKg0hL4hgpMfzHUFEbQbeOUbixI7fKw0e/6FANU=;
        b=ggMsSBhMHVJkMSING+72kaXmJli9IWtHkkM+TMwKu66kZ5d63+9pqmCY+Nutnb9Nza
         CNUSwWaIbUcdhEhRigCWtvcwxj30pejY4fn6Q3UvJdTHxWt6pC9H7eqFGaZqWoOVMp3Z
         pCikBOLNbfvYkx05DOPwWAAtSaHqLH4cFdE7pZwiscMYwEHoDYaDAKuOHm42STENWrY4
         uROA0Bsvv5WPAowq3oISuyJ2PkRPa063QPOCL5M0RF85DYxkApaGaZjHzDZ9wnNBNcVb
         CnlRH6x3GkiNAYd2Ksx+GbNjPypVZObJbs64MsE12VqT5Tcw9q5urVIzxmlwBhIL+b0v
         ng1g==
X-Gm-Message-State: APt69E207OPrRPyssME6nDx6nJDo8kMiwEUyu3py9zJh/bsvGbQjo18d
        seNISKAgJCsEz+swBr9cpJ8vaZBHdpjByL7qUu2BzQ==
X-Google-Smtp-Source: AAOMgpcGHbwmBxMXBxcrHErskxK3HkcOzWjg9EU1nlg4kB69yRwEwZVd5CSuIjAcTmUkz7YWpfoMncTEmZS2L/gFRMI=
X-Received: by 2002:aca:aacb:: with SMTP id t194-v6mr14225035oie.168.1530497030278;
 Sun, 01 Jul 2018 19:03:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Sun, 1 Jul 2018 19:03:49 -0700 (PDT)
In-Reply-To: <20180630190042.4962bff3@archlinux>
References: <900586c7a4ce55818ab330c738f306c7452191ef.1529550463.git.baolin.wang@linaro.org>
 <95836d610301133ffdac1efa86d7daf4cecb97b7.1529550463.git.baolin.wang@linaro.org>
 <20180622151338.00003622@huawei.com> <CAMz4kuJUeDjTVJqNc4cNv=LwR1HkuFap4vBF7CCcrxNqnTHa-A@mail.gmail.com>
 <20180624143009.48cf14f8@archlinux> <20180624144734.62f28908@archlinux>
 <CAMz4kuJb4aRxNKXYkDJ5vQQgFRN+87_br2gp1BtTLji0dp8XHQ@mail.gmail.com> <20180630190042.4962bff3@archlinux>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 2 Jul 2018 10:03:49 +0800
Message-ID: <CAMz4kuKAA=m=++MO3NLzQwNtC=ms8SoU9pvXDwqfb=pQWOw2ww@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: adc: Add Spreadtrum SC27XX PMICs ADC support
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        freeman.liu@spreadtrum.com, Mark Brown <broonie@kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 July 2018 at 02:00, Jonathan Cameron <jic23@jic23.retrosnub.co.uk> wrote:
> On Mon, 25 Jun 2018 09:47:54 +0800
> Baolin Wang <baolin.wang@linaro.org> wrote:
>
>> Hi Jonathan,
>>
>> On 24 June 2018 at 21:47, Jonathan Cameron <jic23@jic23.retrosnub.co.uk> wrote:
>> > On Sun, 24 Jun 2018 14:30:09 +0100
>> > Jonathan Cameron <jic23@kernel.org> wrote:
>> >
>> >> On Sun, 24 Jun 2018 17:13:00 +0800
>> >> Baolin Wang <baolin.wang@linaro.org> wrote:
>> >>
>> >> > Hi Jonathan,
>> >> >
>> >> > On 22 June 2018 at 22:13, Jonathan Cameron <jonathan.cameron@huawei.com> wrote:
>> >> > > On Thu, 21 Jun 2018 11:14:05 +0800
>> >> > > Baolin Wang <baolin.wang@linaro.org> wrote:
>> >> > >
>> >> > >> From: Freeman Liu <freeman.liu@spreadtrum.com>
>> >> > >>
>> >> > >> The Spreadtrum SC27XX PMICs ADC controller contains 32 channels,
>> >> > >> which is used to sample voltages with 12 bits conversion.
>> >> > >>
>> >> > >> [Baolin Wang did lots of improvements]
>> >> > >>
>> >> > >> Signed-off-by: Freeman Liu <freeman.liu@spreadtrum.com>
>> >> > >> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> >> > >
>> >> > > One trivial missed bit of cleanup inline.  I'll sort that
>> >> > > when applying if no one else points anything out before I get back to my
>> >> > > development machine.
>> >> >
>> >> > Thanks.
>> >>
>> >> Applied to the togreg branch of iio.git and pushed out as testing
>> >> for the autobuilders to play with it.
>> > Sorry, backed out for now.  My togreg tree is non rebasing and
>> > this is dependant on some stuff that only went in during the merge
>> > window.
>> >
>> > I'll send a pull request to GregKH fairly soon and after that do
>> > the merge back into my tree to pick that hwspin lock stuff up.
>> >
>> > So this will be a week or two before I can apply it without issues.
>> >
>> > Give me a poke if I seem to have forgotten about it.
>>
>> OK. Many thanks for your help.
>>
> Applied now with dependencies in place.  Applied to the togreg
> branch of iio.git and pushed out as testing for the autobuilders
> to play with it.

Thanks Jonathan.

---
Baolin Wang
Best Regards
