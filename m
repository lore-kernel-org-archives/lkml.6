Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD57AC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 523B620866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="W9+kr9Pi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 523B620866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbeILDzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 23:55:11 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45203 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbeILDzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 23:55:10 -0400
Received: by mail-qk1-f193.google.com with SMTP id z125-v6so17880008qkb.12;
        Tue, 11 Sep 2018 15:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yecEx44M8PDKMBTNei5rTsr98sIveDfTubDW32UfeNA=;
        b=W9+kr9PiBTLMZIsIgqC+gYpeByqEE5FyJlxptKbWASdvfptxJFesDpaVOdPjbHzMkq
         3MIra+4URbx9Z/Qd0udQebHm3wCadOJZcsFAf83Q/ZZP91ygXmaxmroeKzUIVeeJM4kl
         ZnEBVKDxw0WtWqqZMtei3e3G2vrJrZuoNBpvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yecEx44M8PDKMBTNei5rTsr98sIveDfTubDW32UfeNA=;
        b=gAho0huzWnv1UsaDcBQi29R6oH/VXzhFEjqMo+Q4SXYCxoCOUPatlZ14ibA9DJqWhZ
         XXN2LO4yK1J8qDT/Zvo1jIvMeu8sC4twS0m1uamf2ltparDZbobdHnkvlziy+7b7sQkp
         Dy/ji0pu+tRRNQNnZbI5F9qg/MDAS/DYF20L4102KkH7oHk2ZhzpieHrqKNND+frHRXC
         MV88tiCiDAomSSqtjE+zajVuEINmttBp4HiAkXLPGrESTwu4iZhgZ0UYrb5EYjYzvdGY
         w4k2GZNAPL9HYdqtev3ruo7FI0pruU00KF1MjyoeRB1Qp8ovFXJ7/4hHYTqhj9LQY8sE
         IfWQ==
X-Gm-Message-State: APzg51DZgeCu50JOKS5uyNXKOpCZtceXgbzd98+6Cx12wE3RonWb2hER
        R2iRFjqXdExXKp2XDG8gU9hB8Jp4Cgwp/ubKmcE=
X-Google-Smtp-Source: ANB0VdZV//eMibxhpLRInlz48XxZzBxIQTwzsaeCnOrbY24mPEHbyZYY5jzaTe5GoP83MKrKOlR3Q7+YTxZ7/6auB1U=
X-Received: by 2002:a37:bd02:: with SMTP id n2-v6mr21038412qkf.336.1536706421114;
 Tue, 11 Sep 2018 15:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180823225731.19063-1-jae.hyun.yoo@linux.intel.com>
 <20180911183734.GA21976@roeck-us.net> <1f34fe8c-69ef-5f2d-25dc-d5f6037cc558@linux.intel.com>
 <20180911204107.GA26017@roeck-us.net> <e5135af4-9105-214f-5de2-65cc03804222@linux.intel.com>
In-Reply-To: <e5135af4-9105-214f-5de2-65cc03804222@linux.intel.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 12 Sep 2018 08:23:29 +0930
Message-ID: <CACPK8Xdv3aP_zOHAL0WMgwvkpBHAUesU7OdhW==jgvXjRmt-Zw@mail.gmail.com>
Subject: Re: [PATCH i2c-next v6] i2c: aspeed: Handle master/slave combined irq
 events properly
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-aspeed@lists.ozlabs.org,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jarkko.nikula@linux.intel.com,
        James Feist <james.feist@linux.intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018 at 07:48, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>
> On 9/11/2018 1:41 PM, Guenter Roeck wrote:
> > On Tue, Sep 11, 2018 at 01:30:41PM -0700, Jae Hyun Yoo wrote:

> >> I checked this patch again but it doesn't have any change that could
> >> affect to the probing flow. I'll debug the issue on qemu 3.0 environment
> >> and will share if I find something.
> >>
> > The problem may be that qemu and the new code disagree how interrupts
> > should be generated and handled, and the new code does not handle the
> > interrupts it receives from the simulated hardware. This will result
> > in i2c device probe failure, which in turn can cause all kinds of
> > problems.
> >
>
> Yes, that makes sense. Looks like it should be reverted until the issue
> is fixed. Will submit a patch to revert it.

Let's not rush. The qemu model was written in order to allow us to
test the kernel code, and was validated by the kernel driver we have.
We've had situations in the past (with the i2c driver in fact) where a
change in the driver required an update of the model to be more
accurate.

I suggest we wait until Cedric has a chance to look at the issue
before reverting the patch.

Cheers,

Joel
