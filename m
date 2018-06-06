Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDz/E/Qv"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AB044601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932453AbeFFJXu (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:23:50 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:34313 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932356AbeFFJXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:23:49 -0400
X-Google-Smtp-Source: ADUXVKKDoOebIzYFqqKQpcTwtk7XRFinp6CMa8VwegF437HfiFmGTOCrgpAWBgZ3STrgRtaP9QwHOyaBkFI5hawmKuA=
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1806061114290.1584@nanos.tec.linutronix.de>
References: <CAFgQCTudugoNc26P22V+G_awzj2srKHhWBJubFoa7-K=cDtQyw@mail.gmail.com>
 <alpine.DEB.2.21.1806061114290.1584@nanos.tec.linutronix.de>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Wed, 6 Jun 2018 17:23:48 +0800
Message-ID: <CAFgQCTsqbv2nwAwcvv6hW9mbaWRE251jroMSLM5891VYsr=bMw@mail.gmail.com>
Subject: Re: question about the limited interrupt vector resource on a single cpu
To: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 5:15 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Wed, 6 Jun 2018, Pingfan Liu wrote:
>
>> For x86, there is around 200 vectors left for external device on a
>> single logic cpu.
>>
>> Is there any case that we exhaust them in real world, and is it worth to fix?
>
> Exhaustion is unlikely, but how would you fix it? The vector space per CPU
> is limited by hardware not software.
>
Playing some trick on iommu, we can use it to identify the irq requester.

Regards,
Pingfan
