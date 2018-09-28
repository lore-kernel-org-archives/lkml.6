Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CC7C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7634720685
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OBf70Tg8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7634720685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbeI2A5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 20:57:38 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55606 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbeI2A5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 20:57:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id 206-v6so3150856wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 11:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=O1kJobRstvUdWYNrD0QIQOpF6x4YWZwXdBLk+Sl6zBw=;
        b=OBf70Tg8DvPhi2PTskSG6tI1yHXVGOo1IE+k7n2phutFahRIkYjkjw0NySi4kO/DDu
         HSWs8v+XAU0P+r+EL4BVVpttMWwJpCTTcTrsyrEA8WTYmgqo2/SNbtO+fJ5txwSq+Ybl
         X8cmRrh87bgxc98fIOsBd0ey31jXY4/6tgrgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=O1kJobRstvUdWYNrD0QIQOpF6x4YWZwXdBLk+Sl6zBw=;
        b=TM1v7YMhy82l3UnJ8guZzIXeHe6SmgYQ0mTreDMNqJCm5BEY1bWrTw7M40tJCZbopR
         Wuz/dLHdera9ffVy6dqWZayp97XQMaadfgqlWUN3v96dUiyUEi3mRctCGwcWUDG0ePXC
         LvTTA1O2JnSvQ3v7ScHr7V5JmU9nzuPIm6z3Yn4wR+UPLc8Ym3hZ2jVX9TxK7ynd/aNA
         7SWyijwR4pqiIREYK0XJvAnQ15RlRvFs5cNlpDdDR1lv13XeJ8AVqGpQ9QjO9JbYXA5n
         Xg8xMxoIHDTNg0fDUnztT3xHOSlcFwz8ATP7qhK+RaHMrq2ZW2UOcpBdSf67WqgeXgt7
         9Cbw==
X-Gm-Message-State: ABuFfoinoc/Sf8HPL2ijcjFxDZBH2e3VsblEmrA2P+esRXhhup4zr5i4
        cSCWAHQ5zHaPbPZeWUdrhsrpMLQsTg+dE0mObEM57w==
X-Google-Smtp-Source: ACcGV63csfyXFps+kklAcRoAfOVUOCgLJbcvaHWBJ27hAr5+Xx6c2yif0TmJ6/0rilT0b9mtaxU+bg9HOGgaXA7QXWs=
X-Received: by 2002:a1c:603:: with SMTP id 3-v6mr2573125wmg.64.1538159555256;
 Fri, 28 Sep 2018 11:32:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:b485:0:0:0:0:0 with HTTP; Fri, 28 Sep 2018 11:32:34
 -0700 (PDT)
In-Reply-To: <3AD91E696667BF4BA728303C178E8A63532ACAE6@am04wembxb.internal.synopsys.com>
References: <1526690943-8211-1-git-send-email-john.stultz@linaro.org>
 <410670D7E743164D87FA6160E7907A5601313531E1@am04wembxa.internal.synopsys.com>
 <CALAqxLVZXs97sryfPaGY5Gq50-FZROgaBADNXXadcyiNhP3EPQ@mail.gmail.com>
 <410670D7E743164D87FA6160E7907A560131356C4E@am04wembxa.internal.synopsys.com>
 <CALAqxLU3sWrgPjFqZ2vK0m8wVThtE1hDsbNq9zRC7ritzyNHmQ@mail.gmail.com>
 <3AD91E696667BF4BA728303C178E8A63532AAF6D@am04wembxb.internal.synopsys.com>
 <CALAqxLXKOG8fxtrDaRLDGhJUfD1-4qc5QU60+ZmB3+9LsW69Lg@mail.gmail.com>
 <3AD91E696667BF4BA728303C178E8A63532AB36A@am04wembxb.internal.synopsys.com>
 <CALAqxLXy0YXNLwFQEUZxSsjFKC9boVcGkt+50XwmVfwKCcqsEw@mail.gmail.com>
 <3AD91E696667BF4BA728303C178E8A63532AB5E5@am04wembxb.internal.synopsys.com>
 <CALAqxLW=jT+oUASGKxcFghfHZEU7LtFJBiBBkmMM1oarKjSBKw@mail.gmail.com> <3AD91E696667BF4BA728303C178E8A63532ACAE6@am04wembxb.internal.synopsys.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 28 Sep 2018 11:32:34 -0700
Message-ID: <CALAqxLU01RGdmGfdNHUfXu1TCbwGDV6R0PtY_Ef5DvLyLCxb5A@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc2: Fix HiKey regression caused by power_down feature
To:     Artur Petrosyan <arthur.petrosyan@synopsys.com>
Cc:     Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        lkml <linux-kernel@vger.kernel.org>,
        John Youn <John.Youn@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 5:33 AM, Artur Petrosyan
<arthur.petrosyan@synopsys.com> wrote:
> We would like to buy the HiKey board to perform testes.
> We found this HiKey LeMaker to have USB 2.0 ports
> https://www.ebay.com/itm/HiKey-LeMaker-version-2GB-Kirin-620-SoC-8-core-ARM-Cortex-A53-CPU-ARM-Mali-450/263958047308?hash=item3d75202a4c:g:aGsAAOSwOkxbqqot
> on ebay.
>
> Could you please confirm that it is the right board to test the issues
> you mention.

Yep. That's the one.

thanks
-john
