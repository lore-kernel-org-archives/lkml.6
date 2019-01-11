Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9561C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35EC20874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WMLcjg+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731583AbfAKJye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:54:34 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39200 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730166AbfAKJye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:54:34 -0500
Received: by mail-lj1-f196.google.com with SMTP id t9-v6so12397274ljh.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 01:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lDK1FAgxhgi3jXoNAQKdEfAbhO19e8mPHK/hUEQFr7I=;
        b=WMLcjg+XD2sK/PkoIlRemJuRAMSvYdo+TPNeYthUtIN3L3VTbGLv/4nyi3pJgRXPim
         JCH6y179utuToP1Y9VDNa4Puv2WJRNu3Zp5U8is9gH3JL/Fxh2DDXIj4hol6dsO58VMz
         twEZgWSZwE6cD/ndgYA+UxT4XsV9YjZucb95g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lDK1FAgxhgi3jXoNAQKdEfAbhO19e8mPHK/hUEQFr7I=;
        b=aaD5I8S/6dqG7Ju1FXdGO7vPI0zBMWFntZEyJlVCoDBOoaxk+2A+swkT0agHJ8hEfz
         wagjVu+RFnjQYOBUjPtI+lvVonpfdIfYeAmNbMEqhbWUNBQB+6xZfgSXt68DCAcsavKn
         +11kwtjEZSZ7Gcr4SBlr/8t48iQ+FhJY4MNptVE48ENfPHg2KKqxMgYdKtDdycbryU0t
         jDcI/dYqn088Lz10KGdcd84Ic0lYXZ3IVhXAfvPYeyCQIWsQvhYlXR8R/QvFEEWTAEh8
         HlX5I0x0vvZqdf3+7LkPZVrOTYsTajxwZzofDX9vtAsXjD9a0i8XouCFKWPkrDF8XoG8
         KZ8Q==
X-Gm-Message-State: AJcUukfaIDTmM/k3cgLotoEnEb6TVuOKI4xstYWGRXOGvHyhLVRVsyMw
        LPWAJIynPVlVouFfS/bb69GrtcLHQVGrHTSIe2GD6A==
X-Google-Smtp-Source: ALg8bN7nRDxyuo1cVbZfGLGHtnNshIBA79qFEezoOXTXDQHk2/Om7qYQ8hbQyi4L7SJW3JvQ42LB9FVV2eGmCJv6Aqw=
X-Received: by 2002:a2e:9e16:: with SMTP id e22-v6mr8099680ljk.4.1547200471478;
 Fri, 11 Jan 2019 01:54:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1502103715.git.michal.simek@xilinx.com> <72d3cd83bed792a23ab60cf9b6d51b618f5aa084.1502103715.git.michal.simek@xilinx.com>
 <CACRpkdZE-Edr7fWZY5VQM1_65iw7MYGP-iDa2ExZsPxpM0rurQ@mail.gmail.com>
 <6da5fd79-fbc8-b613-954f-dcbe2ef8d6c5@xilinx.com> <20190107164210.3ecf37e8@windsurf>
In-Reply-To: <20190107164210.3ecf37e8@windsurf>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Jan 2019 10:54:20 +0100
Message-ID: <CACRpkdafBpC14TxBNVN2AemkBz-yKkXkKfNpdgkYKQX3qFemag@mail.gmail.com>
Subject: Re: [PATCH 2/8] gpio: zynq: Wakeup gpio controller when it is used as
 IRQ controller
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Nava kishore Manne <navam@xilinx.com>,
        Josh Cartwright <josh.cartwright@ni.com>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
        Borsodi Petr <Petr.Borsodi@i.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Rob Herring <robherring2@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 4:42 PM Thomas Petazzoni
<thomas.petazzoni@bootlin.com> wrote:

> This patch almost solves the problem. It doesn't work as-is, because it
> assumes that runtime PM is used by all GPIO controllers, which is not
> the case. When runtime PM is not enabled, pm_runtime_get_sync() fails
> with -EACCES, and the whole gpiochip_irq_reqres() function aborts.
(...)
> However, I must say that from a design perspective, I am not a big fan
> of this solution. Indeed for the normal GPIO ->request() and ->free()
> hooks, it is currently the GPIO driver itself that is responsible for
> runtime PM get/put, so it would be weird to have the runtime PM get/put
> for the IRQ request/free be done by the GPIO core.
>
> I believe that either the GPIO core should be in charge of the entire
> runtime PM interaction, or it should entirely be the responsibility of
> each GPIO controller driver. Having a mixed solution seems very
> confusing.

My stance is that the driver is responsible of enabling and managing
runtime PM for its hardware block(s).

Runtime PM in the core should only be added if the core needs to
be aware about it, such as is the case when e.g. a block device
needs to drain its write buffer before going to runtime sleep.

I fail so see why the GPIO core need to be aware about this.

Yours,
Linus Walleij
