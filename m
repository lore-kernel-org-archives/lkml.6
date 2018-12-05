Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC0FC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CFD02083F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XQRmxA1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CFD02083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbeLEOYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:24:11 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:43679 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbeLEOYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:24:11 -0500
Received: by mail-vs1-f67.google.com with SMTP id x1so12135697vsc.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 06:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W9/iKsVpde2V2Et7J3sIMYUKDqYSqXKRQQWbaSLSum8=;
        b=XQRmxA1pB20uL2/ElRKIEU9uQiKxLPf07Dprt11PDi8AgWCo74HfPmRVFNCBibgsDz
         r4aL+QyG/9dC/itTox7LuRJc5YhSo2il3n9fOteJatEN3/uzv3FgTOqsi0N3WIBZQPf1
         47+405KoYxiL1QfppcpXWTAu/PrOKL1hoqzNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W9/iKsVpde2V2Et7J3sIMYUKDqYSqXKRQQWbaSLSum8=;
        b=VHmQZ0a6abeW0pQqvmkPEQWwBbNexLxsk+F1WgUZwjqXnxY+NfKx7ayLcPY6Hx4/eS
         dqJXttu4xREeA2kgVN5yfKQqju3zSaJkk2eU1RtNgqIHz/wNUXVN1kie8Z73SrB0uvS3
         lvchKYWnIDrEWZJ1SqJfh9dEooEPt62SyacnEzC/itMfIYwp7GEQzHayq5JbdYKU+eym
         QfNnB5NG9vqruH+aXxheBNp1oifxkj0bnWWhSTk9C46Hj999eN2K+R4H94/B7rCUxhK7
         36LaHB6THX83EeWRq4QmZ+cSy9NPHBn6w6ppBNZYAl11PRa7IonoVYCwKkfAv9KzFkZm
         tRvA==
X-Gm-Message-State: AA+aEWZc4A6d+sjUu3x886+mMMseB3kFFMsO/Bl8kmy1+IIsxYPI/i0B
        9kk/n0aQOPxqlc0lAOsTrUAhtFIVu8kncQ3XeqNczI0D
X-Google-Smtp-Source: AFSGD/Wunv4Lo7JWEVD6KycDxYREJTH33HihWzvREVapUqZ5SJ14L4hsr5rmzU7LN7Y58vIoeKggi53ISu2HhwjfQcQ=
X-Received: by 2002:a67:7685:: with SMTP id r127mr10762107vsc.35.1544019849310;
 Wed, 05 Dec 2018 06:24:09 -0800 (PST)
MIME-Version: 1.0
References: <1541583041-17461-1-git-send-email-ludovic.Barre@st.com>
 <1541583041-17461-2-git-send-email-ludovic.Barre@st.com> <CAPDyKFpLTEwrBagJrd98Zyrd_pwJa9Zkgsi+geZainQV+OgpOQ@mail.gmail.com>
In-Reply-To: <CAPDyKFpLTEwrBagJrd98Zyrd_pwJa9Zkgsi+geZainQV+OgpOQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 5 Dec 2018 15:23:33 +0100
Message-ID: <CAPDyKFp06tiMVgKyKLLKKwGtDPkAKuGWo=NaS+j=3oWGq-UV_A@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] mmc: mmci: send stop command if sbc error issue
To:     Ludovic Barre <ludovic.Barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018 at 10:42, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On 7 November 2018 at 10:30, Ludovic Barre <ludovic.Barre@st.com> wrote:
> > From: Ludovic Barre <ludovic.barre@st.com>
> >
> > Refer to "4.15 set block count command" of sd specification:
> > Host needs to issue CMD12 if any error is detected in
> > the CMD18 and CMD25 operations.
> >
> > In sbc case, the data->stop is fill by framework.
> >
> > Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> > ---
> >  drivers/mmc/host/mmci.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> > index 82bab35..13fa640 100644
> > --- a/drivers/mmc/host/mmci.c
> > +++ b/drivers/mmc/host/mmci.c
> > @@ -1190,11 +1190,10 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
> >                         /* The error clause is handled above, success! */
> >                         data->bytes_xfered = data->blksz * data->blocks;
> >
> > -               if (!data->stop || host->mrq->sbc) {
> > +               if (!data->stop || (host->mrq->sbc && !data->error))
> >                         mmci_request_end(host, data->mrq);
> > -               } else {
> > +               else
> >                         mmci_start_command(host, data->stop, 0);
>
> This looks correct to me!
>
> Although, just wanted to double check that you tested this for a case
> where we have host->mrq->sbc set and got an error in data->error? I
> guess it can be tricky, so I was thinking of manually trying to
> instruct the code, to set an error in data->error, at some point to
> trigger this code. That would at least give us some confidence that it
> works as expected.

I did some manual tests to trigger the error path. As far as I can
tell, it works as expected and I observes that the core is able to
recover and re-send the request.

[...]

So, I have added my tested-by tag and applied this for next. Thanks!

In regards to patch2/2 I am awaiting your update.

Kind regards
Uffe
