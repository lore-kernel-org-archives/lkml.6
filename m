Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3B8C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 01:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15542253B6
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 01:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KK22kDNn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15542253B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752658AbeFYBr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 21:47:58 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:38412 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752554AbeFYBrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 21:47:55 -0400
Received: by mail-oi0-f68.google.com with SMTP id e135-v6so3856527oib.5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 18:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=POMMmtp2z1ifj405vfCCgyXAuJT33SY+dQ3U70fZftg=;
        b=KK22kDNnB4fuyUy9fJE1VfGvHI42D1Fg6YzZHBy7QD3DZlrcoD3Za5THxqr1CP0B94
         WuTVW1g8VCloFSDqxuPcgnRWzDl2QpRBemIopSmDAPAGexgiVp4Xh/1gbycQ2bhnbpUH
         B1lR/FvuQbHhVQsvpmIecrQM7zaK5pIJ1d6yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=POMMmtp2z1ifj405vfCCgyXAuJT33SY+dQ3U70fZftg=;
        b=gnDPWUL/82XtxavgwFvzpNl27f0M+hoEVqSrRvShc3PVMOQ2FpVGHduKZ9eRIDQwd9
         YcU/4eTbE46nb00qB4V0GdUymsxbGGp9GaoYu78v1ffTBALkre7GkEWPEWVlLYPt3BsB
         7UWQyaRqVUgBgFiTt0Q1+lOQUhYU/lx8grAE521h0IZ51fvOlmBctPaV9GWOxMBfes9I
         q+QBMYN435gJL+dljYYJWhX0LvyuTv0pBJxRRiBYJjE5ifHPqrvJYUt05ljmoyPWmehQ
         nraiWDOuBGg2n2nw2dwAvn3TSRU2PuI7/ugIm7qaKD23DqDbG5Ys3q0gRjS/TPgOLvsh
         T5GQ==
X-Gm-Message-State: APt69E02xbqhsvTmyDe8vflG6XqlrfwPukGXC2Or17h0QNd0ejlZJR8l
        e8O4cdsQYQfpy6XRn8rTODXC0+8eGQt5+hybiKJUJw==
X-Google-Smtp-Source: ADUXVKIMHd28aD6dLD0o2P7FWFWf4wHQ8aeDBzdKne8ap7K/9Ign2tOoCjlSdjCKlGBWXXB2aeCbnaF7Mc06S3taLn8=
X-Received: by 2002:aca:6a8c:: with SMTP id f134-v6mr6210195oic.350.1529891275270;
 Sun, 24 Jun 2018 18:47:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2d44:0:0:0:0:0 with HTTP; Sun, 24 Jun 2018 18:47:54
 -0700 (PDT)
In-Reply-To: <20180624144734.62f28908@archlinux>
References: <900586c7a4ce55818ab330c738f306c7452191ef.1529550463.git.baolin.wang@linaro.org>
 <95836d610301133ffdac1efa86d7daf4cecb97b7.1529550463.git.baolin.wang@linaro.org>
 <20180622151338.00003622@huawei.com> <CAMz4kuJUeDjTVJqNc4cNv=LwR1HkuFap4vBF7CCcrxNqnTHa-A@mail.gmail.com>
 <20180624143009.48cf14f8@archlinux> <20180624144734.62f28908@archlinux>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 25 Jun 2018 09:47:54 +0800
Message-ID: <CAMz4kuJb4aRxNKXYkDJ5vQQgFRN+87_br2gp1BtTLji0dp8XHQ@mail.gmail.com>
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

Hi Jonathan,

On 24 June 2018 at 21:47, Jonathan Cameron <jic23@jic23.retrosnub.co.uk> wrote:
> On Sun, 24 Jun 2018 14:30:09 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>
>> On Sun, 24 Jun 2018 17:13:00 +0800
>> Baolin Wang <baolin.wang@linaro.org> wrote:
>>
>> > Hi Jonathan,
>> >
>> > On 22 June 2018 at 22:13, Jonathan Cameron <jonathan.cameron@huawei.com> wrote:
>> > > On Thu, 21 Jun 2018 11:14:05 +0800
>> > > Baolin Wang <baolin.wang@linaro.org> wrote:
>> > >
>> > >> From: Freeman Liu <freeman.liu@spreadtrum.com>
>> > >>
>> > >> The Spreadtrum SC27XX PMICs ADC controller contains 32 channels,
>> > >> which is used to sample voltages with 12 bits conversion.
>> > >>
>> > >> [Baolin Wang did lots of improvements]
>> > >>
>> > >> Signed-off-by: Freeman Liu <freeman.liu@spreadtrum.com>
>> > >> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> > >
>> > > One trivial missed bit of cleanup inline.  I'll sort that
>> > > when applying if no one else points anything out before I get back to my
>> > > development machine.
>> >
>> > Thanks.
>>
>> Applied to the togreg branch of iio.git and pushed out as testing
>> for the autobuilders to play with it.
> Sorry, backed out for now.  My togreg tree is non rebasing and
> this is dependant on some stuff that only went in during the merge
> window.
>
> I'll send a pull request to GregKH fairly soon and after that do
> the merge back into my tree to pick that hwspin lock stuff up.
>
> So this will be a week or two before I can apply it without issues.
>
> Give me a poke if I seem to have forgotten about it.

OK. Many thanks for your help.

-- 
Baolin Wang
Best Regards
