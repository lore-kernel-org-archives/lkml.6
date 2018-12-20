Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB494C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651BD218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QuYZKWrL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388720AbeLTUDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:03:36 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42994 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732280AbeLTUDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:03:36 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so1353688plp.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 12:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:user-agent:to:references:cc
         :from:in-reply-to:message-id:subject:date;
        bh=YpPiLta5HL4FYcYFm9sqCPNW0dwFYuPcTUdZm68XrOQ=;
        b=QuYZKWrLEm/T0W0gpuYHSLpiD69A1DpXX6YQRYmuPc+JTh0shr3D93lxZ8B3fhLz5Z
         mGp8n3s7zfDsgrUQJi8VnoepG1q8D+SB0fDooPUZ9swJGNgJK3qHjFqiFC79j7n4F80j
         Zk4P3O7j406y5Wt96xGCbDiXLKyHaVzVZV6/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :user-agent:to:references:cc:from:in-reply-to:message-id:subject
         :date;
        bh=YpPiLta5HL4FYcYFm9sqCPNW0dwFYuPcTUdZm68XrOQ=;
        b=hMtyui2q0XiHqkHu9UMkY1rLyHlka1Y3i7aN4lelhYg6CX50YYALZZwnN/A6r0AC+W
         lrhkjTkQW/tXhf6WwITHLLAV5XyIJvXCvaaTQA1yJVzgCUX1XVrRWetQ1r5XcV95ibDV
         WLS/uGtyk9D86ia7eALD1UWAayECWDdANC+JbK150y1VtIyecUzPhxeWHmhtdxNcNhbx
         CCNNR3F+iPuEBS41VFjooqdwXcL3tcaW2xKBbFCR+LZX4dbEnGDWXvHWeEbc1gpehOrg
         M61gWLAUlIKwACl1Cv56VHsUvmbrWjnv4IdNOz43F+2BE9z7RG2SRXx2BVEp68mmCji+
         amfw==
X-Gm-Message-State: AA+aEWbxbvFoLw1AwMjevKWsayTSu89+/xn+FMho7TmJtxNORF/EwEW+
        hRv7hxlPYxBJKG0Ev5YvPtbuZQ==
X-Google-Smtp-Source: AFSGD/VP3f1EVTdzaHe7/zyVp5SNMNDWMGaS7RROII5jpBVCkmOPLizp+fGT2uAQKbflQmPfCeqCJw==
X-Received: by 2002:a17:902:161:: with SMTP id 88mr26050560plb.306.1545336214854;
        Thu, 20 Dec 2018 12:03:34 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id k14sm34561339pgs.52.2018.12.20.12.03.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 12:03:34 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
User-Agent: alot/0.8
To:     Lina Iyer <ilina@codeaurora.org>, evgreen@chromium.org,
        marc.zyngier@arm.com
References: <20181219221105.3004-1-ilina@codeaurora.org> <20181219221105.3004-6-ilina@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, Lina Iyer <ilina@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181219221105.3004-6-ilina@codeaurora.org>
Message-ID: <154533621302.79149.15228907259643696166@swboyd.mtv.corp.google.com>
Subject: Re: [PATCH 5/7] drivers: pinctrl: msm: setup GPIO irqchip hierarchy
Date:   Thu, 20 Dec 2018 12:03:33 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2018-12-19 14:11:03)
> To allow GPIOs to wakeup the system from suspend or deep idle, the
> wakeup capable GPIOs are setup in hierarchy with interrupts from the
> wakeup-parent irqchip.
>=20
> In older SoC's, the TLMM will handover detection to the parent irqchip
> and in newer SoC's, the parent irqchip may also be active as well as the
> TLMM and therefore the GPIOs need to be masked at TLMM to avoid
> duplicate interrupts. To enable both these configurations to exist,
> allow the parent irqchip to dictate the TLMM irqchip's behavior when
> masking/unmasking the interrupt.
>=20
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>

I don't think I gave a signed-off-by, so you need to ask to forge my
sign off here. Please change it to be:

 Signed-off-by: Stephen Boyd <swboyd@chromium.org>

and I'm not sure how much I wrote vs. you wrote anymore so perhaps also
add a

 Co-developed-by: Stephen Boyd <swboyd@chromium.org>

And finally, please just email my chromium.org email for this series
because I apparently messed up the address once and now it's all going
to the wrong inbox. Thanks!

> Signed-off-by: Lina Iyer <ilina@codeaurora.org>

Can you Cc Linus Walleij and Bjorn Andersson on the whole patch series
next time? Would be good to have their review on major pinctrl driver
changes.

> @@ -967,11 +994,86 @@ static bool msm_gpio_needs_valid_mask(struct msm_pi=
nctrl *pctrl)
>         return device_property_read_u16_array(pctrl->dev, "gpios", NULL, =
0) > 0;
>  }
> =20
> +static int msm_gpio_domain_translate(struct irq_domain *d,
> +                                    struct irq_fwspec *fwspec,
> +                                    unsigned long *hwirq, unsigned int *=
type)
> +{
> +       if (is_of_node(fwspec->fwnode)) {
> +               if (fwspec->param_count < 2)
> +                       return -EINVAL;
> +               *hwirq =3D fwspec->param[0];
> +               *type =3D fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
> +               return 0;
> +       }
> +
> +       return -EINVAL;
> +}

Maybe this can be a generic function in gpiolib?

> +
> +static int msm_gpio_domain_alloc(struct irq_domain *domain, unsigned int=
 virq,
> +                                unsigned int nr_irqs, void *arg)
> +{
> +       int ret;
> +       irq_hw_number_t hwirq;
> +       struct gpio_chip *gc =3D domain->host_data;
> +       struct msm_pinctrl *pctrl =3D gpiochip_get_data(gc);
> +       struct irq_fwspec *fwspec =3D arg;
> +       struct qcom_irq_fwspec parent =3D { };
> +       unsigned int type;
> +
> +       ret =3D msm_gpio_domain_translate(domain, fwspec, &hwirq, &type);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
> +                                           &pctrl->irq_chip, gc);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (!domain->parent)
> +               return 0;
> +
> +       parent.fwspec.fwnode      =3D domain->parent->fwnode;
> +       parent.fwspec.param_count =3D 2;
> +       parent.fwspec.param[0]    =3D hwirq;
> +       parent.fwspec.param[1]    =3D type;
> +
> +       ret =3D irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &pare=
nt);
> +       if (ret)
> +               return ret;
> +
> +       if (parent.mask)
> +               set_bit(hwirq, pctrl->wakeup_masked_irqs);
> +
> +       return 0;
> +}
> +
> +/*
> + * TODO: Get rid of this and push it into gpiochip_to_irq()

Hmm.. yeah we need to do this still. I think we can have a generic two
cell function similar to irq_domain_xlate_twocell() that does the fwspec
creation and uses some of the things that we pass to
gpiochip_irqchip_add(), like the default level type. This existing
function is not good to have, so there's work to do to get rid of this.

I was also thinking that maybe we can make the alloc function above take
a struct gpio_irq_fwspec structure that tells the alloc function what
gpiochip the irq is for. That would mean that we need to change the
gpio_to_irq() function below to be generic and stuff the chip inside the
fwspec wrapper structure:

	struct gpio_irq_fwspec {
		struct irq_fwspec fwspec;
		struct gpio_chip *chip;
		unsigned int offset;
	};

but I seem to recall that was not working for some reason.

> + */
> +static int msm_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct irq_fwspec fwspec;
> +
> +       fwspec.fwnode =3D of_node_to_fwnode(chip->of_node);
> +       fwspec.param[0] =3D offset;
> +       fwspec.param[1] =3D IRQ_TYPE_LEVEL_HIGH;
> +       fwspec.param_count =3D 2;
> +
> +       return irq_create_fwspec_mapping(&fwspec);
> +}
> +
> +static const struct irq_domain_ops msm_gpio_domain_ops =3D {
> +       .translate =3D msm_gpio_domain_translate,
> +       .alloc     =3D msm_gpio_domain_alloc,
> +       .free      =3D irq_domain_free_irqs_top,
> +};
> +
