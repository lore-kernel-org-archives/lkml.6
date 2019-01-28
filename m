Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7ACC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C26E2148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtLRJh/V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbfA1TW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:22:58 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36757 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbfA1TW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:22:57 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so8460326pfc.3;
        Mon, 28 Jan 2019 11:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4w5GVgfSc7HDd4w82dp/ZXFLWhzvarEeSPreNtWAt24=;
        b=YtLRJh/VTwFwZTLiBH8nhmwp9XiwpPsk/31466R4V8uL7VKH1UaBT7UHcwuVZmF7Pn
         yi2aqKPdjxQr5JB0PEpPjVrCbcdtaSTf2+350JAfH00AvlYlUF7El8XBZ2T9NVRDRBdG
         W0OJ87fZxqp4EB7IVz95BPOFUWc8fp1ecxSc2GrFU6nh2D0bVMvH0hP96F7db5F6HxPL
         ztg5Oa1aak6pmGzWjXR7Zv9LupnlU/55TaYJs8D2Lh6K4IqwFipaes8z6WAtx75UEbpl
         /U5FnoY3YPeCIDx3063c2hTT+awuZivw+RrwzBpCEmyyXQYocAUEV5KmkJ4XnID+AvjE
         r5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4w5GVgfSc7HDd4w82dp/ZXFLWhzvarEeSPreNtWAt24=;
        b=l9PN/R9uUzeRrrS6uAKDxrOZ/aHpMKwEPVVBaN0qo3vd8okfeiqqm0+pE8B6SEfAhw
         gEVYlXggzkYW+RcHa0MLgdKkScuHqhiSBkMKXGnflY1B/EuEOPUkxkEq3AuBzcX4Y2H+
         1VnFHBQmN+Ud/Va9Y0iwTQvdlQPWDPBl7yOiyngVxLND5/L8XYPQBjJVxqPbyDgQDsm8
         pSSzeezwZkaxvKavtiVZ1djI0b6R0IPKrWmeODe0N3pzPkmKK7RSWuSm4kRU6RU+iy/u
         IFHI3K9XA9SpVQ+74iQVZkO8FEdFjWZ1AAe5SXGaJLYJheWGbiMgy7ulanxmT7EXyXcr
         HpZg==
X-Gm-Message-State: AJcUukco/14QzjECjx4FZHpWLAuDnqe7wRxRlXOFRHhZFwEt5OzBA+BF
        KcXnfTpbkbVLmUh1zsAiHLQ=
X-Google-Smtp-Source: ALg8bN4T4eNxnwW4DJ9WSVR5aF0mF+0xhZgpR38hQhbfVpKpzZWvdwCrnljPzsZxRGVtU/ygw1fwQA==
X-Received: by 2002:a63:4e15:: with SMTP id c21mr21004600pgb.50.1548703375956;
        Mon, 28 Jan 2019 11:22:55 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id y6sm49018429pfd.104.2019.01.28.11.22.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 11:22:54 -0800 (PST)
Date:   Mon, 28 Jan 2019 11:22:53 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 12/13] input: max77650: add onkey support
Message-ID: <20190128192253.GD34692@dtor-ws>
References: <20190118134244.22253-1-brgl@bgdev.pl>
 <20190118134244.22253-13-brgl@bgdev.pl>
 <20190119090318.GB187380@dtor-ws>
 <CAMRc=MfOWWK+nfYLt03EFe-ekTnbDr6oCoqd=n3dpMjz1sELMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfOWWK+nfYLt03EFe-ekTnbDr6oCoqd=n3dpMjz1sELMQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 11:52:50AM +0100, Bartosz Golaszewski wrote:
> sob., 19 sty 2019 o 10:03 Dmitry Torokhov <dmitry.torokhov@gmail.com>
> napisał(a):
> >
> > Hi Bartosz,
> >
> > On Fri, Jan 18, 2019 at 02:42:43PM +0100, Bartosz Golaszewski wrote:
> > > +     input_set_capability(onkey->input, EV_KEY, onkey->code);
> > > +
> > > +     rv = devm_request_threaded_irq(dev, irq_f, NULL,
> >
> > Why threaded interrupt with only hard interrupt handler? If parent
> > interrupt is threaded use "any_context_irq" here.
> >
> 
> Hi Dmitry,
> 
> actually it's the other way around. Take a look at the function
> prototype for  devm_request_threaded_irq()[1].
> 
> The third parameter is the hard-irq handler (NULL in my patch), the
> fourth is the thread function. Actually even if I did what you're
> saying - it would never work as this is a nested irq for which the
> hard-irq handler is never called.

Sorry, my eyes must have crossed. Still, from the driver POV the
interrupt does not have to be threaded, this is dictated by the
constraints beyond the driver control. For these cases we have
devm_request_any_context_irq() that takes essentially only "hard" IRQ
handler, but internally either does request_irq() or
request_threaded_irq(), depending on the context (whether the interrupt
is nested or not). Using devm_request_any_context_irq() should not have
any behavioral changes, but documents the logic better.

Thanks.

-- 
Dmitry
