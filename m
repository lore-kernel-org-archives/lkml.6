Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CA8C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7312C20854
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaa8Sjzq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7312C20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeJZCfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 22:35:42 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38842 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbeJZCfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 22:35:42 -0400
Received: by mail-pl1-f195.google.com with SMTP id p7-v6so4221376plk.5;
        Thu, 25 Oct 2018 11:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=X2kPJV9EVw0/eSps+Z2zYyG7lQVYX01gJphXzvi2wPU=;
        b=jaa8SjzqVgu3Kx/ZZ8DMzavk0zLOtQ4VBDhZWu/WtO2nW1ngyfOlk7rpEWiwkRDc4n
         qETafkLPzNkmEieOl6Aw7Yp5ywbfcl438FY770bbg4nIXJnfg1r9bWjP+ZwzrLF87hc7
         wa7QNLxfgK0g9k9xuIknMREgYMU5mAqbM10xIK9GIzB4jI2qfKjhvncuTmyR6evrpXb/
         elrYPy0PPnA/ANUaUexE+DMCibqWBKuJqZ5M1rs/hSBV35Al0hYmUcarjK+8sBCK3W8x
         CNqJQTRrgMNPdf2XdI5Ue6p5tcOTW2av+8VTNYMfO5jFd6BlMeL1s8ARGAIcOejm0flv
         pQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=X2kPJV9EVw0/eSps+Z2zYyG7lQVYX01gJphXzvi2wPU=;
        b=AJE3y5d7BL4dHJny3irOj/q7e4LILNTs5avt+KI6OX5LFT99pGq1qZsY959+43mcg+
         e1teadaLzCe4x/SlG5WlE8YJf2lKiFW6TxGrGFr5h9hFz0KdkDJramqXWIXspLGat9bx
         F6MA54KBki5xBdq4KLkav9AnQcxari5vlcEJ2v6wwepEGH9Ie8rpdLIURWRchPZuU4eu
         OTd9Zw1ppVdPwNUMw4bKXFcpb/FLzFUwZjK3TKIk2jTZKzBsXllrCgZTthLePZ5k5Sfx
         0buHN3xfluyYBUe3tzNvvHFoaRamEK+l73CMw9Kj03hNtFRpXya2IgO4of1Rjv6Xq2US
         Ct1w==
X-Gm-Message-State: AGRZ1gL48gIAvdsOLuPu14FMu++EphzjUbZTTjyUtiPcDR5ukj0etXP0
        Z9vip9s+MIqE3Mh66XX+DVM=
X-Google-Smtp-Source: AJdET5cBH9a5CTM1lyKmAG/8IjLpE5OYhlSHBwuRMdqW+8u6Ud8/C0owZMpe1gAzzeqSaCqXI7+2Tg==
X-Received: by 2002:a17:902:2907:: with SMTP id g7-v6mr194795plb.201.1540490512828;
        Thu, 25 Oct 2018 11:01:52 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id d126-v6sm25493741pgc.32.2018.10.25.11.01.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 11:01:52 -0700 (PDT)
Date:   Thu, 25 Oct 2018 23:31:44 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Slawomir Stepien <sst@poczta.fm>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: iio: ad2s1210: Switch to the gpio descriptor
 interface
Message-ID: <20181025180139.GA8340@nishad>
References: <20181024145051.GA18490@nishad>
 <20181025064356.GA18633@x220.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181025064356.GA18633@x220.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 08:43:56AM +0200, Slawomir Stepien wrote:
> On paź 24, 2018 20:20, Nishad Kamdar wrote:
> > Use the gpiod interface instead of the deprecated old non-descriptor
> > interface.
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> > Changes in v4:
> >  - Add spaces after { and before } in gpios[]
> >    initialization.
> >  - Check the correct pointer for error.
> >  - Align the dev_err msg to existing format in the code.
> > Changes in v3:
> >  - Use a pointer to pointer for gpio_desc in
> >    struct ad2s1210_gpio as it will be used to
> >    modify a pointer.
> >  - Use dot notation to initialize the structure.
> >  - Use a pointer variable to avoid writing gpios[i].
> > Changes in v2:
> >  - Use the spi_device struct embedded in st instead
> >    of passing it as an argument to ad2s1210_setup_gpios().
> >  - Use an array of structs to reduce redundant code in
> >    in ad2s1210_setup_gpios().
> >  - Remove ad2s1210_free_gpios() as devm API is being used.
> > ---
> >  drivers/staging/iio/resolver/ad2s1210.c | 92 ++++++++++++++-----------
> >  drivers/staging/iio/resolver/ad2s1210.h |  3 -
> >  2 files changed, 50 insertions(+), 45 deletions(-)
> 
> Looks good to me.
> 
> Reviewed-by: Slawomir Stepien <sst@poczta.fm>
> 
> -- 
> Slawomir Stepien
Hi,

Thanks for the review.

I was thinking of adding the device tree support to this file as well.

Can you please tell me if I can submit the new patch in a patchset with
this patch as the first and the one adding device tree support as the second?

Thanks and regards,
Nishad
