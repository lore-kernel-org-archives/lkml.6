Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1DCC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 23:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC782148E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 23:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="t073I0FZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC782148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbeKUKbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 05:31:21 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:33423 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbeKUKbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 05:31:21 -0500
Received: by mail-it1-f194.google.com with SMTP id p11-v6so11335115itf.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 15:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K+V8ZvX/sE2Ng9LqVg+JXWQvvuhFQ9PTiXLdWDFcD8c=;
        b=t073I0FZfj2yeINs0TRymIP7q2dIjQjw9Uz/efim4RplqG6U5TD41wX6eso12B4mPJ
         yS3IeppdR6YpKrNE6DkmmkrOm+lQAjhciFUQMUZFVWaIUrQOiVV0X1nlL1pSjwKZBwnh
         6oHtZQu4QHKopazQPEfpbKGkdXvFoYe7/fxdmEuK56jvhp1OaYgouWCkJpuhz0cm9xZc
         GP6GE1DCkOiQCxdiqx3sRcxc/4MpMrLLxubr4cQnSBdskrkKa4MnSPOE6sZeRMi56cHY
         JNKtVF3QZ2iJlWevmNLNcY0AoxLXaOMy9AGmo+8lDute0cr7ZtjzuVZNEqsyelek8bXB
         gYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K+V8ZvX/sE2Ng9LqVg+JXWQvvuhFQ9PTiXLdWDFcD8c=;
        b=G5LJaYYewaJQ7wt/wf205chciRiA/E2Hw7RGlxChgd9pHWrVtrrsoyGhTQrJVQ4FKs
         V1G0Oj2TRXb5x1L02d8XhAnASkMznzehbS9qUVpyo3r8QYfUgdx6B7MiKuQIEH89XqTF
         MEdk/DaCv+dllTRWuVfYS6+PlFOT1P5WuuXLY6sUpQBXVjDGeeHqzHH/fO3Kv6QI/Ciw
         cHpfXSfJsQ7cUu9/+sHEVgdCNrY1MEXafhlqSJGduCsSEmBQQC3yogiGrTFsBLw3WKyF
         Wf0HzvtsAIiDtRDqUUFQo4H2exBYOEBQyBB/kSQfI7uNsVnAHksiJ5w779EdlNRam5Gl
         X7Ag==
X-Gm-Message-State: AA+aEWb669iYXUf42KQ3fxuItqBxRnk11PlrGt1CkkKxAels4vnE7iP2
        eRt2drcmU3DEHs5BUPZ1QdgNd8WBVEE8LCvtjGEhEQ==
X-Google-Smtp-Source: AFSGD/XhEu9EJl6eDeLlXOAvCakZxCtB/13MK9WQ76q8v9OZeODAOPdtogxv86KVRDja4c5tZtDc0HeLYrdzcaT9ebY=
X-Received: by 2002:a24:338e:: with SMTP id k136-v6mr3635534itk.86.1542758371997;
 Tue, 20 Nov 2018 15:59:31 -0800 (PST)
MIME-Version: 1.0
References: <20181118042540.12697-1-matheus.bernardino@usp.br>
 <20181118042540.12697-2-matheus.bernardino@usp.br> <f250fa3a01b51d59979e7a2e3e42cc34d02aa52e.camel@analog.com>
In-Reply-To: <f250fa3a01b51d59979e7a2e3e42cc34d02aa52e.camel@analog.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 20 Nov 2018 21:59:19 -0200
Message-ID: <CAHd-oW4mq1HnTqr_XZt7cktTgy_ytH=ARg+d3ac+Q5bSdbciUQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] staging:iio:ad2s90: Add device tree support
To:     Alexandru Ardelean <alexandru.Ardelean@analog.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Victor Colombo <victorcolombo@gmail.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, kernel-usp@googlegroups.com,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 6:09 AM Ardelean, Alexandru
<alexandru.Ardelean@analog.com> wrote:
>
> On Sun, 2018-11-18 at 02:25 -0200, Matheus Tavares wrote:
> > This patch adds device tree support to ad2s90 with standard
> > device tree id table.
> >
>
> Hey,
>
> Comment inline
>
> > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > ---
> > Changes in v2:
> >  - none
> >
> >  drivers/staging/iio/resolver/ad2s90.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/staging/iio/resolver/ad2s90.c
> > b/drivers/staging/iio/resolver/ad2s90.c
> > index 3e257ac46f7a..6ffbac66b837 100644
> > --- a/drivers/staging/iio/resolver/ad2s90.c
> > +++ b/drivers/staging/iio/resolver/ad2s90.c
> > @@ -107,6 +107,12 @@ static int ad2s90_probe(struct spi_device *spi)
> >       return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
> >  }
> >
> > +static const struct of_device_id ad2s90_of_match[] = {
> > +     { .compatible = "adi,ad2s90", },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(of, ad2s90_of_match);
> > +
> >  static const struct spi_device_id ad2s90_id[] = {
> >       { "ad2s90" },
> >       {}
> > @@ -116,6 +122,7 @@ MODULE_DEVICE_TABLE(spi, ad2s90_id);
> >  static struct spi_driver ad2s90_driver = {
> >       .driver = {
> >               .name = "ad2s90",
> > +             .of_match_table = of_match_ptr(ad2s90_of_match),
>
> I think you need to remove the of_match_ptr().
> There was a comment from Jonathan on another thread about this.
> See:
>    https://patchwork.kernel.org/patch/10682963/
>

Hm, got it, thanks!

I don't understand much about ACPI yet, and I had understood the
"of_match_ptr" as a guard. Could someone point me in which cases it
should be used? Or is it obsolete?

Matheus

> So,
> +               .of_match_table = of_match_ptr(ad2s90_of_match),
>
> becomes
> > +             .of_match_table = ad2s90_of_match,
>
> >       },
> >       .probe = ad2s90_probe,
> >       .id_table = ad2s90_id,
>
> --
> You received this message because you are subscribed to the Google Groups "Kernel USP" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-usp+unsubscribe@googlegroups.com.
> To post to this group, send email to kernel-usp@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kernel-usp/f250fa3a01b51d59979e7a2e3e42cc34d02aa52e.camel%40analog.com.
> For more options, visit https://groups.google.com/d/optout.
