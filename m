Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC589C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CAE220833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aP0M+B+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CAE220833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbeIJLxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 07:53:15 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34453 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeIJLxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 07:53:14 -0400
Received: by mail-io1-f66.google.com with SMTP id c22-v6so6161345iob.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 00:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t0kkfXVXCcgxTeA0arM3/Tx97BB+JTB3nLajx1qDzck=;
        b=aP0M+B+w7aS0CaXtTZUB50UXsMUOgEGJsE2yckd/dr4BfEnUf1SPOTBp78A1P8CsDn
         dTgj0B87NVgtq0dYo+Aj5+Hzf6UPJrKIHQ5LE7vOppdECytPNGkqtHjcwAXAusB2f/xF
         XxXoEO7JEn+eaFViuJv+8fXXuWj+f7wMCIgAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t0kkfXVXCcgxTeA0arM3/Tx97BB+JTB3nLajx1qDzck=;
        b=GgK5vVzHOvvvlzlUhTkjCl3I1YJFpc7NBnX5dO3FiwqMGQlezNZzYklosC/iettCuk
         O7Fjj4zSiwI9m5dGI3RGBV+JHkmJlcssPwZk0Q0J6T9rQpNP3JmezJfmuD0VqTZ46mIE
         Rlb6R1w+ZuCtgPCRBSRra405D3ugAu81AEiwquJqXTyfl+5IC43SB47+b+KNskYVAXuV
         ct51k2zTX3rt6moi2xNDYBKcehZXlzAmb3Q1gbO9Im0nE/Xs/bK697hXlbCocJBGvr4t
         rcsnOsyD10eM8xltKdgbPMECA5IqpIxhMIuURm+cj2aRqbIIsEN0pg6MjoRzR8ftMTwU
         Tx/A==
X-Gm-Message-State: APzg51CR/GXUxI2wZMGaeLB94eoVi2OKhijBRzjgFX2GzpooW8A+Uh2c
        icqpvhPmuu8G4OOwXOYu0xPVyz346+baH5JfMnTI78dOQYo=
X-Google-Smtp-Source: ANB0VdaJSXlHA8zJT76X7Bee5295TVJ3Xe20Qt8+H2c5LcYB3p6gESNokmEw38yzCx7CxNAxycluOc69/JIrGRUXKIg=
X-Received: by 2002:a6b:fe0d:: with SMTP id x13-v6mr14892443ioh.294.1536562841798;
 Mon, 10 Sep 2018 00:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180908190553.GA4573@gmail.com> <20180909093611.GA4614@zn.tnic>
 <CANiq72=RbankDmDSmD+jtvAFArGG-orMSayooGCAEa73_aOAuw@mail.gmail.com>
 <20180909160601.GA3873@zn.tnic> <CANiq72mXK8EGt7x4EVgU6H0ve9c-wGWuV06=TUfLbzB89_qYeQ@mail.gmail.com>
 <20180909164530.GB3873@zn.tnic> <CANiq72m2H2Y5MqOq62i2wVCZswWJmG4Bv8ODDFjjy4ec9+WaMA@mail.gmail.com>
In-Reply-To: <CANiq72m2H2Y5MqOq62i2wVCZswWJmG4Bv8ODDFjjy4ec9+WaMA@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 10 Sep 2018 09:00:30 +0200
Message-ID: <CAKfTPtCJhPS0tuVhsLgB0Z-=5Vr5KvfU9tJ7E0MEdFJBVxt=5w@mail.gmail.com>
Subject: Re: [PATCH] kernel/sched/core.c: Avoid unused variable on non-SMP configs
To:     miguel.ojeda.sandonis@gmail.com
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Sep 2018 at 19:00, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sun, Sep 9, 2018 at 6:45 PM, Borislav Petkov <bp@alien8.de> wrote:
> > On Sun, Sep 09, 2018 at 06:36:01PM +0200, Miguel Ojeda wrote:
> >> No, you get a different warning depending on whether you have enabled
> >> CONFIG_PARAVIRT_TIME_ACCOUNTING or CONFIG_IRQ_TIME_ACCOUNTING.
> >
> > Ok.
> >
> > Still, adding __maybe_unused to both (or writing it before the name,
> > whatever works!) and dropping the ifdeffery is still better for
> > readability's sake than having more ifdeffery, IMO.
>
> Agreed, it is quite confusing already. I tried to keep the style of
> the code, but Ingo/Peter might prefer the cleanup. Let's see...

FYI, another patch has already been sent for this warning
https://lkml.org/lkml/2018/8/10/22


>
> Cheers,
> Miguel
