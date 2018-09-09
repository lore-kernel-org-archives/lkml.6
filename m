Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CF8C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 17:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB3452075B
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 17:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yoo8NGjY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB3452075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeIIVuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 17:50:18 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43551 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbeIIVuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 17:50:18 -0400
Received: by mail-qk1-f195.google.com with SMTP id 130-v6so12876888qkd.10
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 10:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xDKe0NhkEWT0/ZfyFzq8rK6vRYm4qxZAQIL9Iz/qWis=;
        b=Yoo8NGjYPN44IsAmj2uWhJUgP87DFY+gqMuO8KEMBZdjfSBcOqjDtrmrknVRhC5wg8
         r71qxxZPI+lzMRNyNZK9YrjmRC5lTIi3tGuByUWu4+iM287VC0dmQwkv4oH+aItlIDjX
         hXfkgKfDQdn5oEDdUFU6T6211mQBYajjl0xGTipX1Izjp4l21kpP90280Mq7dhIAPkfh
         mqm2AlWQLdLs4Mdf0N8rXNFvsOYBCqYuMnZmoVQJxaX5t6Lph94hU3RrDRoq5mtjkzVw
         jXR3H50wg3WdfpIYd/NSqRGJ5YgIV4HLyopzjxhNgrz4X45kIMsQsUlhZob1a1J4b1Ef
         vBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xDKe0NhkEWT0/ZfyFzq8rK6vRYm4qxZAQIL9Iz/qWis=;
        b=Q8cWMckOilByu2iEY5kqOCcP7QsPifrfI1FcqoEXelMrEDQUhFgvnhGCOoX2dQk1ps
         azfU3ERm8u0Djkaw/jxJo4F01a2DGtnyFnSDJ5hrOfGuqb6Ym02GBBN1CLFOb0kLi4us
         fbyLALcURZ+3Q/m3Hl1lfkVOzCratIvZJYxLHkbd7lN7UTG4WI4kwcb/YCudN+BxfnM+
         ldVkmW3ZkhJniMlptALMfAfzgVUwVr5brSNtYXzzwVy0PYMKycfXCIDeCk5pStW4z6hb
         Mqu1Xf0xtO2eiBEQTkMy2dFsBR3vLFfL34TOi41aKfWQ7cGjq1bZNL2GsIKWPR0f3w9R
         U4Ow==
X-Gm-Message-State: APzg51DGl5L3LQGa9IHBkXC+vRIS8alDyclwJtavkpk8ZSW5KiIrjzWt
        TGt0Tdg1RNBKaHnQpUn+3xxF08bBqpghqW/LGgs=
X-Google-Smtp-Source: ANB0VdbfnZxq/gI0TzPn9acqeL3x01e1MEKDSk0fgrZ2Oiet9L5Fs9KAntaGMPUhdHwNq7jDsroZulBv9fb0Ls7/Ee0=
X-Received: by 2002:a37:1383:: with SMTP id 3-v6mr12185127qkt.129.1536512401900;
 Sun, 09 Sep 2018 10:00:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:7494:0:0:0:0:0 with HTTP; Sun, 9 Sep 2018 09:59:41 -0700 (PDT)
In-Reply-To: <20180909164530.GB3873@zn.tnic>
References: <20180908190553.GA4573@gmail.com> <20180909093611.GA4614@zn.tnic>
 <CANiq72=RbankDmDSmD+jtvAFArGG-orMSayooGCAEa73_aOAuw@mail.gmail.com>
 <20180909160601.GA3873@zn.tnic> <CANiq72mXK8EGt7x4EVgU6H0ve9c-wGWuV06=TUfLbzB89_qYeQ@mail.gmail.com>
 <20180909164530.GB3873@zn.tnic>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 9 Sep 2018 18:59:41 +0200
Message-ID: <CANiq72m2H2Y5MqOq62i2wVCZswWJmG4Bv8ODDFjjy4ec9+WaMA@mail.gmail.com>
Subject: Re: [PATCH] kernel/sched/core.c: Avoid unused variable on non-SMP configs
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 9, 2018 at 6:45 PM, Borislav Petkov <bp@alien8.de> wrote:
> On Sun, Sep 09, 2018 at 06:36:01PM +0200, Miguel Ojeda wrote:
>> No, you get a different warning depending on whether you have enabled
>> CONFIG_PARAVIRT_TIME_ACCOUNTING or CONFIG_IRQ_TIME_ACCOUNTING.
>
> Ok.
>
> Still, adding __maybe_unused to both (or writing it before the name,
> whatever works!) and dropping the ifdeffery is still better for
> readability's sake than having more ifdeffery, IMO.

Agreed, it is quite confusing already. I tried to keep the style of
the code, but Ingo/Peter might prefer the cleanup. Let's see...

Cheers,
Miguel
