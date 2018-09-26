Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4B7C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C9C20645
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rr3yotkb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C9C20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbeIZPqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:46:45 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33965 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeIZPqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:46:44 -0400
Received: by mail-qt1-f193.google.com with SMTP id x23-v6so16515733qtr.1;
        Wed, 26 Sep 2018 02:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FqNaK7IonQNtqPsrEUFlLKHkQ0U2PjM6oWkbnSTTnno=;
        b=rr3yotkbIWBxDymVTAQdmNF5UrIJUQMqU8GcKmGI81riXdfwKUsWceqhVGMDgCnTEa
         YOkpwqXf3sFrViya1cHKK7P/4EeG1au1z2G60ofpxL2nCPaAHxveWOdE5XtpQ7cfNp9g
         Y27Yy0h5tNVCf+CUsU+JPBfgiGG3heg0VLREAIwZ5IN8eeFkcia1rZMsUIEOxy8y13uU
         DJgS8zxsYdBpu3GqHY4SMLu87uKzMKczpyjRaQlLWT9N95ozEYlHbwWSQrqONceesB08
         m/6GksV8vMDbBjdpAlVRd0pQ5gaz0hsNLQ0THCZgKuRq3AiNxOlNYCDAlouul5QIA02/
         hmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FqNaK7IonQNtqPsrEUFlLKHkQ0U2PjM6oWkbnSTTnno=;
        b=H7Oyn/s2gz3BmOZg1EBcPqRJwjy5ga3g+2o0UCYY8nN2/pCzBtEXycrcCF74lFUVac
         2D46Sl65d447v3KULhBnHHxwghi6mm2ljEaEhjVEgs3ohFxDP+3Tz1LCTKol6iYPDckb
         sGJW3zAuYm0+U4zhf4/yp013OggjCDPjFFC5ylU20uw3EUcA6csyEYxMno8DFa2E855U
         3aMp9HRf0KTutmGdYcTO+MAtbCK1FIuquIv5z743RWbqLK6sKfBw3el6eohjEABFm3y2
         zvxiFTG/0BNBz0TAaaQxfF+zucX8K44GttLBzR4d+efxnI+z/qtSUPptuSl1sSYx+90t
         MxMA==
X-Gm-Message-State: ABuFfojNWCFmpYdx3eBhwuCxQqacgCDiaqolJaB8ksOPTK4/8VehSm0+
        8Nqk/VRGyX/riFyZyZJNfpgicqygOGfYx1JW/uw=
X-Google-Smtp-Source: ACcGV62jUh5zOu4alYdeZ0hmwmjiQEonE6ZZnev4WZvwz9YcLndke7N84E/BU0D53DotveW9zxsU9LIO+uM62xrDl8Y=
X-Received: by 2002:aed:21ac:: with SMTP id l41-v6mr3657824qtc.293.1537954479558;
 Wed, 26 Sep 2018 02:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180924143719.22191-1-hdegoede@redhat.com>
In-Reply-To: <20180924143719.22191-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 26 Sep 2018 12:34:28 +0300
Message-ID: <CAHp75VcXLLPc+aFYYBBr28KXOCM1Yopon_HjvL=jNKJPRa_hJQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: intel_int0002_vgpio: Implement irq_set_wake
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 5:37 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> We were relying on the interrupt being shared with the ACPI SCI and the
> ACPI core calling irq_set_wake. But that does not always happen on
> Bay Trail devices, so we should do it ourselves.
>
> This fixes wake from USB not working on various Bay Trail devices.
>

Pushed to my review and testing queue, thanks!

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/intel_int0002_vgpio.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/platform/x86/intel_int0002_vgpio.c b/drivers/platform/x86/intel_int0002_vgpio.c
> index 987a3b03f225..33c3489f5bc1 100644
> --- a/drivers/platform/x86/intel_int0002_vgpio.c
> +++ b/drivers/platform/x86/intel_int0002_vgpio.c
> @@ -106,6 +106,21 @@ static void int0002_irq_mask(struct irq_data *data)
>         outl(gpe_en_reg, GPE0A_EN_PORT);
>  }
>
> +static int int0002_irq_set_wake(struct irq_data *data, unsigned int on)
> +{
> +       struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
> +       struct platform_device *pdev = to_platform_device(chip->parent);
> +       int irq = platform_get_irq(pdev, 0);
> +
> +       /* Propagate to parent irq */
> +       if (on)
> +               enable_irq_wake(irq);
> +       else
> +               disable_irq_wake(irq);
> +
> +       return 0;
> +}
> +
>  static irqreturn_t int0002_irq(int irq, void *data)
>  {
>         struct gpio_chip *chip = data;
> @@ -128,6 +143,7 @@ static struct irq_chip int0002_irqchip = {
>         .irq_ack                = int0002_irq_ack,
>         .irq_mask               = int0002_irq_mask,
>         .irq_unmask             = int0002_irq_unmask,
> +       .irq_set_wake           = int0002_irq_set_wake,
>  };
>
>  static int int0002_probe(struct platform_device *pdev)
> --
> 2.19.0.rc1
>


-- 
With Best Regards,
Andy Shevchenko
