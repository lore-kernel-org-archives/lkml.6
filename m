Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9DAC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE646222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GWnjly4m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387862AbfBMJiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:38:09 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42287 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728873AbfBMJiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:38:09 -0500
Received: by mail-lj1-f195.google.com with SMTP id l7-v6so1391990ljg.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 01:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=diTfoAa5QUfTzyCKudm3waVERUH6mf8lPhS8olEIfwA=;
        b=GWnjly4m3L0IPD8SDnUMVRj095jutzkbt+WpZ4AyR75rL3aN1aeilvTWTZknhajSTO
         +exUHWeBQE4QHYcCwzlJQbUnHfYteFTcOLvIVyVUmqNv2mbJZ8CO5B+Aeoj9Tr/cycRm
         JKqxvK+fRwkn5FWypypefqhiNarWhMvklhU03TI4sgoUxW0X3sTP9EQ3LVkLq7TJvNXy
         2KawqSEBABa3QDDw7unRB/p2zuFivYfS7qTCwUraKb+06dzISxdpgUDOQ6RobeEgjT6h
         6+BEs/vTUVi6l4ZUrWyxMhIV2wlFpEiN9BT6zGvQkY8kKKoSM3XBqPzK2t63eChCL1EE
         vmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=diTfoAa5QUfTzyCKudm3waVERUH6mf8lPhS8olEIfwA=;
        b=Ur1uzMYlN/Fc4HAjy/LNLD0zm5HCfjmUsH2fk8PfFBNONWXIWcy9PPhZH9FY9MNByG
         LXILXM4oVG0fmqszVw692+7/88D1N1kSfYMOFH24Zw6z3CJO/qF5Y3CPE21XReIFU8E7
         2KR+tekrsmjtLIAaAzj58QC6/E4vE5PbOHefVhGNUFQBIgjyC7M2SDCZnib7oKkHHPhw
         8PZid4OP4xCG64yG/pIHsaw7N3z3J99F5j2FHCn++a/hHL8SOufHEN3LsR6li6f7BjcE
         0ZlS2OVkrD3whEjLcy3u765cVDDxU18SMKnbDlX62rlfSr7SnH52zV7DpejVDaW6Pxa1
         L46A==
X-Gm-Message-State: AHQUAuaJ6WAB4JHFwPzNebRo+X3p5lLaSfWCMd74hlZhkG7VKTMxsWOu
        O8lWKc5oD0MKs5SlY9fF8H+EsWtHFfyYHIXsqMexTg==
X-Google-Smtp-Source: AHgI3IZ+FvuvTd0D4WtEj7MZhxu41YRPzxL1ogMPwCR5y2mnUKndGUmf0teqhdLj+kLcleGt0/NDay4QAwlsHrjnXhs=
X-Received: by 2002:a2e:6a18:: with SMTP id f24mr582828ljc.97.1550050687163;
 Wed, 13 Feb 2019 01:38:07 -0800 (PST)
MIME-Version: 1.0
References: <20190208104046.21817-1-thomas.petazzoni@bootlin.com>
In-Reply-To: <20190208104046.21817-1-thomas.petazzoni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Feb 2019 10:37:55 +0100
Message-ID: <CACRpkdaSbcHAV=3NHYRujC7xEvVcbLJpV+k5sHdvFsRpYFsCbg@mail.gmail.com>
Subject: Re: [PATCH] gpio: zynq: properly support runtime PM for GPIO used as interrupts
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 11:40 AM Thomas Petazzoni
<thomas.petazzoni@bootlin.com> wrote:

> The Zynq GPIO driver currently implements runtime PM by:
>
>  - Enabling runtime PM support in ->probe() and letting the runtime PM
>    reference counter drop to zero at the end of ->probe().
>
>  - Increasing the runtime PM reference counter in ->request() and
>    decreasing it in ->free().
>
> However, the latter is not sufficient: when a GPIO is used as an
> interrupt, ->request() and ->free() are not called. Due to this, the
> runtime PM counter remains to zero when the only GPIOs in use are used
> as interrupts, causing them to simply not work.
>
> To address this problem, this commit implement the
> ->irq_request_resources() and ->irq_release_resources() hooks,
> ensuring that the runtime PM counter is properly
> incremented/decremented. Since we override the default hooks, we keep
> the existing behavior by making sure they call gpiochip_reqres_irq() /
> gpiochip_relres_irq() respectively.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Patch applied with Shubhrajyoti's review tag.

Yours,
Linus Walleij
