Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C04ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EBBF20839
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kd86RPBj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EBBF20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbeGPVW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 17:22:29 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:43509 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbeGPVW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 17:22:29 -0400
Received: by mail-vk0-f66.google.com with SMTP id s17-v6so1341822vke.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 13:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3dvJTKBoOWCJdDC7QGer36lI68OAmu9VeAFz235MZ68=;
        b=kd86RPBjBV31mAg1PGhGm+z+r+hyFc9P0Dhg61Wl4CHMhgQ6TDALrYv2gZAyQfhlAm
         klMiz/awEgixOFwMZK6Zoj6shN6kvjrIN69KQw+Tdfz18w/eI6A/NLf7YFcrrn+Z77tQ
         6QTHI87WiTPgx0QWJiQb/LPu8lCG/I6yb+L09+4naowXXNKNnSk3WGdE9JO/gZ1uP1yM
         QQWPM+PmLYO/bbzXIUjiLGQoXctk01XwdMncrPTt8+0QCVTlg0B9JwGrgSs4TBrPtE3v
         V/Gpb1hrkOFPbNSICl5765LPJqcYmk5EDb2UhKx5e9G8MuUBz217PuhQd+OVxZ0D/S4s
         5+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3dvJTKBoOWCJdDC7QGer36lI68OAmu9VeAFz235MZ68=;
        b=IzZO02fWoBmhSd2+EIdiPZP09BAyYnbpBg+YUPH8V+5HeBugo4XX6gukcGQvVhJ/qF
         +tKUiWbdfkUjBeahVFICOrEXG+ScaivAoEel7/uY8zyiFlxDv1XwdvdelLO8uYuWrYy6
         h7JW3r+gW718GaRHCwayaZaFwjqek5RZYDdd2b0+CRmk3jLl2SkDr2AsLIhUJZM2TDEX
         K+QduVS9ob8Bi2c54/XOfc6INLt/HJgA3SPoFeGZ0v47NAo+69L8A3OSrhw+VGBcaslE
         o+6I+rYcXkTT0IV4VRxzWXoMXcFvUYWUV0hZHTd7tfD9Fsld4zUmsk/DA+IsaBgc08Nm
         H+5g==
X-Gm-Message-State: AOUpUlEd6w4WUr35mRB/rtGw8NEnRC3SZSz44q0QR0S0ikE+BWAOTLAN
        QOqzjhr3vuUQymq3wkTBnwOnLSw6ns7PwWrPAA0=
X-Google-Smtp-Source: AAOMgpdtZ3wvDnIq22LlKPJTuqRgylENM9tP/3VbjaYZI0qw5ezSfMnOVsRXCnK9W3PoszQh/s1LwHQIQwj9OOInM8o=
X-Received: by 2002:a1f:20d4:: with SMTP id g203-v6mr10487360vkg.176.1531774400265;
 Mon, 16 Jul 2018 13:53:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 13:53:19
 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1807161829090.1693@nanos.tec.linutronix.de>
References: <20180302130436.uxv7hjruung6m5x7@linutronix.de> <alpine.DEB.2.21.1807161829090.1693@nanos.tec.linutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 16 Jul 2018 23:53:19 +0300
Message-ID: <CAHp75VfPa0sWRvEs9Gt9u9AP0xzE50qmx6i=fOBN016Geg-BTA@mail.gmail.com>
Subject: Re: [PATCH] x86/ioapic: Do not unmask io_apic when interrupt is in progress
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 7:41 PM, Thomas Gleixner <tglx@linutronix.de> wrote:



> +static inline bool ioapic_prepare_move(struct irq_data *data)

> +static inline void ioapic_finish_move(struct irq_data *data, bool moveit)

> +static inline bool ioapic_move_prepare(struct irq_data *data)

> +static inline void ioapic_move_irq(struct irq_data *data, bool masked)

Verb or noun?


-- 
With Best Regards,
Andy Shevchenko
