Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D14ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C89FE2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="kMdVlv7B";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QaamRUA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C89FE2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbeGQUdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:33:03 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:33366 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729805AbeGQUdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:33:03 -0400
Received: by mail-ua0-f196.google.com with SMTP id i4-v6so1476067uak.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 12:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=zJ8fyGDAJlLXOUY+UUh2YIaX8YpUkamjhLeh0EoU6C4=;
        b=kMdVlv7BZO9y2DW3scMQ7ktN2MZGlJbKPKDuq1lcEiMs+5+bC5hT++Xddqk90/vNmH
         W+SWmtkQBTu0CdteZabNj6FrcIfNh8QB3WJE0bZuGpsOQzOLhB2Vvunk7KGAS46PKrKm
         J1iXi+fMJyngccxZkLHKoBIfE9z3ZcOl+8I0BM0iQOizbKMjKRdpUdMGn+0GDbLQUF7J
         qFuBNDLTaNoWKRQhIm30zAi8UuYMRTi0suAFepUu2ytioWam3+VhLmPC8BXzqy0HKJG8
         HfXqltwcFYuetTmSkwwy7PuRoVeAs6yC00vO1hM96RKXrpBX/HqWsbj/LVK+QMw7hHOh
         Vudg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=zJ8fyGDAJlLXOUY+UUh2YIaX8YpUkamjhLeh0EoU6C4=;
        b=QaamRUA4qOhQHUuqFLvWXeTJvV9qAoDoV/tBa4WUFQLhpobkiC8kje1JZTM37HK3e7
         oU0C3p1bvVa9Y9op1EuEpuMnJKQxy7rVT/8bvG3WqYFGVVXuXARtY6fCCYbuuu5vDcZ3
         FniIwFiw8U7EO/y01w4Oj94GCp4zARFX0pyOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=zJ8fyGDAJlLXOUY+UUh2YIaX8YpUkamjhLeh0EoU6C4=;
        b=Od+3kQNKcZRMKGvga8soXalqS+C1V7ih5oT4/JWW+rdao/xO0G5roLtewmLQKT0m76
         zOynB0pN0kpdxICCc8LPGYKdEohRILOQW6wv0T+VW+2oTH0RzHw+WBgfgLeKg6Y88aXt
         ZdQe1CEE046A9Ttf2TACElck3kXBq81gNf5l8/hE0BbBgrwrjS2xV9vpnCzkSAR+HhxV
         c6onXSLRrHIxd0/mz7wstq8QF7R/Zwzb6h4sV2KF/xkSd4o5b5DnyCAYrqarStn1yl7l
         rSeWM/gjypt2kbBH/vC8ta++ZklpEX55IBcB7QoUpPKu1cytpQXZOgq7OojduRNRCgAH
         lnig==
X-Gm-Message-State: AOUpUlHllMIr8QqMKADkA79kbF892Mxkgyp0Qg2pl5feeHR0cUMD/f9G
        d//HhmoZdUlUwrf2DdLzQCSbk134hYuyxag82Q57kg==
X-Google-Smtp-Source: AAOMgpcLLAXZ82mPGEl9Q5GyZSudUl7/vjMJI1dztQQedv8VZw8ZYI7brSk+9UgTyrKJ55wNWpHBucBma/zZ0waL/3E=
X-Received: by 2002:ab0:11dd:: with SMTP id q29-v6mr1998672uac.191.1531857530774;
 Tue, 17 Jul 2018 12:58:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 12:58:50 -0700 (PDT)
In-Reply-To: <CAD=FV=X7fveskggyu_Fd44zCWdGMqU9sF-tHHcrF5mOpUD_+Dw@mail.gmail.com>
References: <20180615220131.65402-1-dmitry.torokhov@gmail.com>
 <20180615220131.65402-2-dmitry.torokhov@gmail.com> <CAD=FV=X7fveskggyu_Fd44zCWdGMqU9sF-tHHcrF5mOpUD_+Dw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 17 Jul 2018 12:58:50 -0700
X-Google-Sender-Auth: auDnz_GkWnoOyWX4C8fE7pkFGYk
Message-ID: <CAD=FV=W3uhhv1sqfYkErXk3rpNiN_u91=os9rG=NHJqMvrKWgg@mail.gmail.com>
Subject: Re: [PATCH 2/3] usb: dwc2: host: do not delay retries after
 successful transfer
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 15, 2018 at 4:49 PM, Doug Anderson <dianders@chromium.org> wrote:
> Hi,
>
> On Fri, Jun 15, 2018 at 3:01 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> When handling split transactions we should not be delaying retrying
>> SSPLIT/CSPLIT after we successfully communicate with the device, so
>> let's reset dtd->num_naks counter when handling XFERCOMPL.
>>
>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> ---
>>  drivers/usb/dwc2/hcd_intr.c | 1 +
>>  1 file changed, 1 insertion(+)
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Though this looked good, I just tested this myself and found that it
corrupts memory.  Please do not merge it.

Specifically slub_debug complains of a use after free and sure enough
I can see that in one case we call dwc2_xfercomp_isoc_split_in() and
it can call dwc2_release_channel() and that can free the qtd.  Setting
the qtd->num_naks to 0 at the end of the function is a use after free.

I've just tested the same USB peripheral that Dmitry was testing with.
I found two things:

* This patch is important for making that peripheral work

* When I move the "qtd->num_naks" to the beginning it's all good.

Dmitry is OOTO at the moment, so I'll re-post this patch with that change.



-Doug
