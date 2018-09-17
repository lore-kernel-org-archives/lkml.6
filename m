Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80867ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F7F214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d7J1VK/k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F7F214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbeIRBeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 21:34:18 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:44519 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeIRBeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 21:34:17 -0400
Received: by mail-wr1-f54.google.com with SMTP id v16-v6so18585048wro.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 13:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ylrIF1yg0m5rqQCIIE2zWRerOLOiaoss4Aqw7R40/L0=;
        b=d7J1VK/kdZQw/RKxFz4u+c2BtZnEbM6jQmu98UuENXZ7oMg3hR3rMDbRiu57st/Ig8
         ZJbHUuXEUqd2IOiSyxJY0Ve5tUDT9DGcnrAEEBzC6zUjizLdPleO0ClTR9rpBqyFwC2R
         yuo0Y+9WjGLoamJBY7Fn52pTBCzIUJsogZMxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ylrIF1yg0m5rqQCIIE2zWRerOLOiaoss4Aqw7R40/L0=;
        b=UDvkIhi3W8uJvFh+WGo6KZyZSPtAHmtfADbOHjRby5XcV/UuFckWLRWfQ1+367ruPQ
         f17uc+EaMjYoG071ifxoLsFBAFOElUvG3rE5VhnRuGZqLZscV2OFsQPrIsFMiahs3GBL
         RYplgNLwLwRih9nV7VI4u2ap1x71M1w+Sc8asikrVRlQOlMy/88w4oAN8QoLjk48wmUb
         9jVErltiBA/FVqyE/K7G3fczBEPAoK75mBm/OrbLt/BM+pNVgYzU/DlgHr9+DbcGIqWU
         DZc/EFcFXudIpNOdeKtA4jDaQ2+Z5Cq6wpvUEbOI7jPszOxsWos8vBoUP4DS9LePEuxF
         QKPg==
X-Gm-Message-State: APzg51DMga6Lx0hmKH8jiKLvchVI3xHiJLmDXJwTRqA9zcd20EFGamn8
        dhMZ4B2ebpv21HYONe3zotzo10kS+/19lrEp37PkIA==
X-Google-Smtp-Source: ANB0VdaYhb7xXiHjlykLYFMRBbtKSyql2Io1IMitjQ1JavHuinJYvS2LD63B1zc4YcuPnsnGsdGYw6EZr1z7s2C5EgQ=
X-Received: by 2002:a5d:6103:: with SMTP id v3-v6mr20950872wrt.265.1537214726324;
 Mon, 17 Sep 2018 13:05:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:a986:0:0:0:0:0 with HTTP; Mon, 17 Sep 2018 13:05:25
 -0700 (PDT)
In-Reply-To: <20180917130706.973042587@linutronix.de>
References: <20180917124533.329334911@linutronix.de> <20180917130706.973042587@linutronix.de>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 17 Sep 2018 13:05:25 -0700
Message-ID: <CALAqxLVYXhbb6k4TNx4N4wf9wDCTm0JjhyOg9B3V5QYfUMtU+A@mail.gmail.com>
Subject: Re: [patch V2 01/11] clocksource: Provide clocksource_arch_init()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        devel@linuxdriverproject.org,
        virtualization@lists.linux-foundation.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 5:45 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> Architectures have extra archdata in the clocksource, e.g. for VDSO
> support. There are no sanity checks or general initializations for this
> available. Add support for that.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Sorry, Let me try reply-all this time. :)

Acked-by: John Stultz <john.stultz@linaro.org>

thanks
-john
