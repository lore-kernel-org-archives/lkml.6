Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADAFC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D8E21855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nERpfa9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfAWVAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 16:00:50 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43313 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfAWVAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 16:00:49 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so1759161plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 13:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:references
         :user-agent:cc:from:in-reply-to:message-id:to:date;
        bh=gqEucwrdi6Chws+59xYXQjnc2B6XgHyUHFcCbJE+l9Q=;
        b=nERpfa9eR4yguPuijdCxYM262CJLkb4tvWDUIqRdTsOmXJ8bx7rP61e9h+Ui1Sx1eV
         fpLJSgv7HIyLK42rPjc0+yZZ8lfd4q885/OB2UbjfvF4d+Vx3zcrpSTTl1aAsA8KekgE
         U6nHfERh+hFdUhhmrAJ3lXjuEqVRXTuHT0QiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :references:user-agent:cc:from:in-reply-to:message-id:to:date;
        bh=gqEucwrdi6Chws+59xYXQjnc2B6XgHyUHFcCbJE+l9Q=;
        b=AcJK+7af5Olr6B+ZEufvwd7zIuDh8Zh8BFrtywAUBjYXV5hDYbW69STQxXvgKAQ4Wm
         OnG5AUF8o8Q3gOLY3W2X+qb7DrAAwgbMJQh0O7mYW2q9AivpdBFWfWI1Ln2tbMo4LsEq
         g8NAF1HhNFe2lN37zTDR39f1n4QV3iClqACGPLHJ1WYf5I11N9xrwx7+gRmXMVEJd/kz
         WP3b8pa62plciKVhvXl+O1O4PnidTnhTHSpgnc1wS1OAY4mQnxoLOvgBj/xFfaAor6/O
         Vqy6VCuD/stbmqtFs+0kAeThGer7Od6mLEvvdBw84Bt/72Qj7xx6aWDIhutUosVa03rb
         sAqw==
X-Gm-Message-State: AJcUukdI0ocRPOXN+bsQVwk7HaKdcgXPFFV+IK8PPscxw8FIUv9wJhfj
        cA/DJPJ2RurHZG8uybic04rWFg==
X-Google-Smtp-Source: ALg8bN5rH7wfvWWDcHlfXhPdqz/ln3h21Qsrr5j1VG4Kku0u0z+r2E2j5WG5NOymWaz4Blb5KjduWQ==
X-Received: by 2002:a17:902:7791:: with SMTP id o17mr3805571pll.60.1548277248885;
        Wed, 23 Jan 2019 13:00:48 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id o66sm34290574pgo.75.2019.01.23.13.00.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 13:00:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 5/7] drivers: pinctrl: msm: setup GPIO irqchip hierarchy
References: <20181219221105.3004-1-ilina@codeaurora.org> <20181219221105.3004-6-ilina@codeaurora.org> <154533621302.79149.15228907259643696166@swboyd.mtv.corp.google.com> <20190116231328.GA20369@codeaurora.org>
User-Agent: alot/0.8
Cc:     evgreen@chromium.org, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20190116231328.GA20369@codeaurora.org>
Message-ID: <154827724678.136743.1337362671388538883@swboyd.mtv.corp.google.com>
To:     Lina Iyer <ilina@codeaurora.org>
Date:   Wed, 23 Jan 2019 13:00:46 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2019-01-16 15:13:28)
> On Thu, Dec 20 2018 at 13:03 -0700, Stephen Boyd wrote:
> >Quoting Lina Iyer (2018-12-19 14:11:03)
> >> +
> >> +static int msm_gpio_domain_alloc(struct irq_domain *domain, unsigned =
int virq,
> >> +                                unsigned int nr_irqs, void *arg)
> >> +{
> >> +       int ret;
> >> +       irq_hw_number_t hwirq;
> >> +       struct gpio_chip *gc =3D domain->host_data;
> >> +       struct msm_pinctrl *pctrl =3D gpiochip_get_data(gc);
> >> +       struct irq_fwspec *fwspec =3D arg;
> >> +       struct qcom_irq_fwspec parent =3D { };
> >> +       unsigned int type;
> >> +
> >> +       ret =3D msm_gpio_domain_translate(domain, fwspec, &hwirq, &typ=
e);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       ret =3D irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
> >> +                                           &pctrl->irq_chip, gc);
> >> +       if (ret < 0)
> >> +               return ret;
> >> +
> >> +       if (!domain->parent)
> >> +               return 0;
> >> +
> >> +       parent.fwspec.fwnode      =3D domain->parent->fwnode;
> >> +       parent.fwspec.param_count =3D 2;
> >> +       parent.fwspec.param[0]    =3D hwirq;
> >> +       parent.fwspec.param[1]    =3D type;
> >> +
> >> +       ret =3D irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &p=
arent);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       if (parent.mask)
> >> +               set_bit(hwirq, pctrl->wakeup_masked_irqs);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +/*
> >> + * TODO: Get rid of this and push it into gpiochip_to_irq()
> >
> >Hmm.. yeah we need to do this still. I think we can have a generic two
> >cell function similar to irq_domain_xlate_twocell() that does the fwspec
> >creation and uses some of the things that we pass to
> >gpiochip_irqchip_add(), like the default level type. This existing
> >function is not good to have, so there's work to do to get rid of this.
> >
>=20
> >I was also thinking that maybe we can make the alloc function above take
> >a struct gpio_irq_fwspec structure that tells the alloc function what
> >gpiochip the irq is for. That would mean that we need to change the
> >gpio_to_irq() function below to be generic and stuff the chip inside the
> >fwspec wrapper structure:
> >
> >       struct gpio_irq_fwspec {
> >               struct irq_fwspec fwspec;
> >               struct gpio_chip *chip;
> >               unsigned int offset;
> >       };
> >
> >but I seem to recall that was not working for some reason.
> >
> I was thinking about this. If I understand you correctly, we want to
> generalize the .translate and .alloc functions. We could move the
> .translate to generic however, the alloc would still need to be specific
> for the parent.mask. But we can do this without the gpio_irq_fwspec. I
> presume you suggest this structure so we could pass the hwirq and type
> to the .alloc function. but we have that in the fwspec. What am I
> missing?

I'm trying to flatten the irq number space into a single integer while
letting it cross multiple gpio chips. Similar to how gpiolib flattens
the gpio number space across multiple gpio chips. The goal being to make
gpiochip_to_irq() do this all for us without having to implement it in
each gpio driver, but maybe that isn't needed or wise if the goal is to
move drivers away from taking a gpio number and converting it into an
irq with gpio_to_irq() to begin with.

FWIW, the SPMI PMIC gpio chip conversion patches didn't fix this problem
and Brian just called irq_create_fwspec_mapping() from the to_irq()
hook. So maybe this can be cleaned up later.

