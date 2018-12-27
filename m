Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCF8C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD40214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hc6SMTqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbeL0V4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 16:56:41 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34443 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730428AbeL0V4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 16:56:40 -0500
Received: by mail-ot1-f67.google.com with SMTP id t5so17379425otk.1;
        Thu, 27 Dec 2018 13:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qpvNNDNFbl2XbhdSLEQ4I8hppK6pfisIA9kuAu0WWwU=;
        b=hc6SMTqW8avzQ7rmPZQdiGq7T0o5dRNfIz+a/uG4biAb2WML9ZWIruyB9goiv15u8q
         3BQhnP8Hvts53wqfGupIuPPuzxsBQAXllRYp4zlQxxkGLd3ztouHSNA4qkYZwu5P3l23
         C+Xmk2ufdPGsh0oy4wFv+H1HnOPxQIkSneY9NW8x57i9NAjIBl9gJ8KuOU2EIKGqVqWo
         qN+a1WxyCqQ5ANlfdo9ynbm/O22mL28XIO3/UO/RdlTA4OGMeL2ca3bTsi00g6xY23n+
         X1kWiAQv0GtKKzgsHvz+gCbjCWWAi0zcc8VuVwIKY5JNQk4Bo5icXfXbKUlBTPmaxITe
         +6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qpvNNDNFbl2XbhdSLEQ4I8hppK6pfisIA9kuAu0WWwU=;
        b=D+s/K5eZ6SDI5dYSBpSUI7qI3SO4FT39wO1in7tK4/sRO5k+Flk6mcArS8auxKxoHa
         //TA4On0BMZSdOKagc4lXR3+5C5cUFRh/4aqGqj0ThwkBGwbsMddubtQQe3CFW8Has59
         YUuhgQSm4rTB1M40e0bmHn7U0dyXlgsLhsAfjyQAArtFboSrYpZiHnXln23vPbGuViDB
         IeT6Ywiijc1jdQIHgWFfWLNQh8iwkzI/PS7OdqlsSSXKmdz1iJQOGpXxfXqgquPRPwq9
         YsGUQtRedIelJuk5hNtrMYhzePtIJ6uVvRrP7yl1NIgDLxk6pC/8GZ0owiqxXfFqXZJ0
         CgNw==
X-Gm-Message-State: AJcUukcKX3J27znkydQuDzVLWaj7YltCsk+J4uk/7yHkCsSeIYRGO+Q8
        nv2J+UVO93DG7REqgM8nJhAfcvL6r16p81pofK0=
X-Google-Smtp-Source: ALg8bN4JIlq1HeVMU+lVRPIXqHKVDV+Dv+k1Q24nGnE9gM6S4jB8m07E2kNz5c71dIobNSQqIrpuDcnUflGeon0qzzk=
X-Received: by 2002:a9d:715d:: with SMTP id y29mr17710714otj.148.1545947799737;
 Thu, 27 Dec 2018 13:56:39 -0800 (PST)
MIME-Version: 1.0
References: <20181202220847.24364-1-martin.blumenstingl@googlemail.com>
 <20181202220847.24364-3-martin.blumenstingl@googlemail.com>
 <85aa8e12-0bca-6432-e1a8-0faceff1dd5e@codethink.co.uk> <CAFBinCBDUxTc+ofCYm-zEeiFdU90U6DQOkX4B659q=MvRK64fg@mail.gmail.com>
 <CAFBinCAY7+-zA5-hY6oXmFz2i8aj9wFJsb-HBbKt_Swn9BtMMg@mail.gmail.com>
In-Reply-To: <CAFBinCAY7+-zA5-hY6oXmFz2i8aj9wFJsb-HBbKt_Swn9BtMMg@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 27 Dec 2018 22:56:29 +0100
Message-ID: <CAFBinCBh8hy8xmtz6j5mKPKwy3yW5bxTQG8TEFDNN-ocHfqTEw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] rtc: support for the Amlogic Meson RTC
To:     ben.dooks@codethink.co.uk
Cc:     linux-amlogic@lists.infradead.org, linux-rtc@vger.kernel.org,
        alexandre.belloni@bootlin.com, a.zummo@towertech.it,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ccaione@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

On Tue, Dec 18, 2018 at 12:48 AM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Ben,
>
> On Wed, Dec 5, 2018 at 11:15 PM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> [...]
> > > > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > > > [resurrected Ben's patches after 2 years]
> > > > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > >
> > > Just checking if the change of author is deliberate?
> > > not sure how to do >1 author on patches like this.
> > I changed the author on purpose after seeing how much I changed
> > (compared to your v4). this is also why I added you to the CC list
> > however, I left in your copyright (just like you kept Carlo's
> > copyright note) and MODULE_AUTHOR
> please let me know:
> 1. whether you want to be the author of the patch or if you're fine
> with my name in there
> 2. if you are fine with both of us being listed as Signed-off-by or if
> you want me to switch to Co-authored-by
> 3. about any other concerns you have
>
> I would like to update this patch next weekend so it can be reviewed
> (and merged once all is fine) for v4.22
I've been busy last weekend so I didn't manage to update this series
please let me know how you want me to proceed with this


Regards
Martin
