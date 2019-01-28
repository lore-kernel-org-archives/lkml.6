Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716CCC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332AF214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RvVb5ioK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfA1OV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:21:29 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40757 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbfA1OV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:21:29 -0500
Received: by mail-lj1-f194.google.com with SMTP id n18-v6so14355746lji.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 06:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xm0NvZVtRVE0ULzJNN4xom1yIoB2C8sOA+Gtqpkm5VM=;
        b=RvVb5ioKwXHjkiaEvVukLPs6nrhFdlO31l2LoW9wWw/iFmicgpoEfean3vPoYLSuEm
         q2E0GLFpMUs9M1SUYrkhuLJwk2hfiJSoI5fq1sViow/I0PX/EI3se0cgG6LGYVWLvdqf
         AAlrWBKrCGnqLtN2+/KxXB+MY/KjzmumAsrwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xm0NvZVtRVE0ULzJNN4xom1yIoB2C8sOA+Gtqpkm5VM=;
        b=Hi5To+sfpiI5DVlHCFE7iW0UEApBRR5MfTlEud/CdLypv2umVPxcVVEBOvGT92J1bV
         qQ6aQoZNDM9/FbZxPmECxBDYcNWe/yAuGeJczYKH8fJudrEH9LzUPXcGoxg58g/+eSrw
         k/mkrpGm99XhVxR4mGMW+f+CCjVDuOOEFnOKFmrp5iR8iBoTZHYsebRizhvvf92Ywzag
         VOIyWGRlc5nJ3Fi5w9VpKc1TF9FdousqYjNAfVKCvkHbRwwgH36IHOZdIkVafFsXS6Uy
         MjrFNg/Sq/GnabdUHX4LemaGEqz4MNNcn9Wd/b739DvOhv/KtAXWBwNluibzaqVcJ1yh
         hrXQ==
X-Gm-Message-State: AJcUukfg/rIqXPvrA6BSrrmgYW+a0D8aBZPJeqpu8znIE/CpyIs4H5NT
        qNwuBUQCEGUuWnKjaMUWl7eqKpeDBoE+Qsl91hNG8Q==
X-Google-Smtp-Source: ALg8bN5GC7axSY0k5JvfjQf5BzFMgDaUjPwq3VOmWdEWAmC7vjoXoFU3KZVrQPZQ8XYkJSC40kdcS0XFUoUoAv8tkMg=
X-Received: by 2002:a2e:131a:: with SMTP id 26-v6mr16812430ljt.107.1548685287365;
 Mon, 28 Jan 2019 06:21:27 -0800 (PST)
MIME-Version: 1.0
References: <20190125153934.3dc818b6@xhacker.debian>
In-Reply-To: <20190125153934.3dc818b6@xhacker.debian>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 28 Jan 2019 15:21:16 +0100
Message-ID: <CACRpkdZ4Ux-y47MumT9wYmJhTt1YmVqVO-cZVV-2U5q6i_-jvw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: berlin: as370: use generic "pwm" as pwm function name
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 8:45 AM Jisheng Zhang
<Jisheng.Zhang@synaptics.com> wrote:

> So that we could use the generic "pwm" for two or more pins, e.g
>
>         pwm0_pmux: pwm0-pmux {
>                 groups = "PWM0", "PWM1";
>                 function = "pwm";
>         };
>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Patch applied.

Yours,
Linus Walleij
