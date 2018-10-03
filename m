Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6752BC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4A22064D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aah8Y+7j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD4A22064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeJDCY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 22:24:29 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43513 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbeJDCY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 22:24:29 -0400
Received: by mail-lj1-f196.google.com with SMTP id r8-v6so6186972ljc.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 12:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eHHFO7uyGZb6ZELU2tYiiFprW0N1KBjfUAohhvgAqSw=;
        b=Aah8Y+7jpxZkOt9INDubpwpWL4wwe9djLEd3LerXVZq99Va+PXsZvFkTn8q34b7KRj
         9WtRKDFQs6VEj5FCTOV0zQeULa4ZZrcY0LGsWbh7NDGsgJIkyYg79QdGAEaT8Wq1/aTa
         kVe6HEGzk8+qdFHSZu7vQ0XXBDnnMaiUa1PUL57nXestUYRZ3AwHrd5R7v0AhypyR+K/
         ASHml3jq4fQEwi/buZs4EmAZPCdiltm3RFyOThJSZBh6+LoY4tbK3unnY9GNLWlQ6p+M
         xmozBorx+aMp9YsNlZrDyaMYi62Ohrpmz5Q3s61YqpSt8Wn9qavQk76haOmIHH9+SskG
         0vpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eHHFO7uyGZb6ZELU2tYiiFprW0N1KBjfUAohhvgAqSw=;
        b=e2FMQMuUv1Bl43F/vrHV/hNd6Q3OOrKl6UmmNGC3sxACrgam71EIKdhyeCGA3rCHNC
         Tf6zN8TB12VmxMrYrw0yDnIqSpPilYofRkC1XUWNSUjcNqPBUwJd2+t0Bs0D+zceYonD
         h+UWLrOFSuESx7MXSd9+6GRc200zlRCWRKOchtbIS36mCu8bgq2zAFhnrvVTz4qPVpUb
         s+VPX6iMz6WIxfhvGIrwYv9cqOpfD+Q4X7GgkdzmpZ6GoW1yfdjMa0u3N8InX9xw8A3T
         orjGQI+n+ENUeXU02WX9cOOpo2XCPyppIsMN4ALxYaGMMKRN9B/kTfrLNiEawUpcivXo
         Us2w==
X-Gm-Message-State: ABuFfohEEhzXLqcqNWdolon1qn9X4/G+c3HEGn6fob+JFvsGi/D7nXBF
        f4fjap5efyH6j5O2+FTVJuEFiRpxKMejduEvjqQ=
X-Google-Smtp-Source: ACcGV606jKxlrV8p+l+aAunECIRO5ZFuPhGSmqsZwi/DpaxorKrNKaggjglaObBWq2jzZ+EAehnwZXBwWkvZU63Akc8=
X-Received: by 2002:a2e:8919:: with SMTP id d25-v6mr2224934lji.69.1538595282340;
 Wed, 03 Oct 2018 12:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20181001124351.31615-1-ricardo.ribalda@gmail.com>
 <20181001124351.31615-8-ricardo.ribalda@gmail.com> <20181003190130.4c9e509f@bbrezillon>
In-Reply-To: <20181003190130.4c9e509f@bbrezillon>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Wed, 3 Oct 2018 21:34:25 +0200
Message-ID: <CAPybu_06=Mz+wGLeodM4CjP810Dphm9JKLmX62FVmspy0888ag@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] mtd: maps: gpio-addr-flash: Add support for
 device-tree devices
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris
On Wed, Oct 3, 2018 at 7:01 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
>
> On Mon,  1 Oct 2018 14:43:51 +0200
> Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:
>
> > +static int gpio_flash_probe_gpios(struct platform_device *pdev,
> > +                               struct async_state *state)
> > +{
> > +     struct physmap_flash_data *pdata;
> > +     struct device_node *dn;
> > +     struct resource *gpios = NULL;
> > +     int i;
> > +
> > +     dn = pdev->dev.of_node;
> > +     if (dn) {
> > +             state->gpios = devm_gpiod_get_array(&pdev->dev, NULL,
> > +                                                 GPIOD_OUT_LOW);
>
> Did you consider using gpiod_set_array_value() to update the gpio vals
> instead of having your own update loop (the for loop in the
> gf_set_gpios() func)?

Yes briefly but there are some cons:

- I need to allocate the value_array
- I want to relay on my cached old values, so I still have to loop


-- 
Ricardo Ribalda
