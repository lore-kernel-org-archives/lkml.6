Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168D1ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87F420693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZtuZRdP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B87F420693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbeGQW3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 18:29:01 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:40575 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729754AbeGQW3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 18:29:01 -0400
Received: by mail-vk0-f65.google.com with SMTP id s23-v6so1422883vks.7;
        Tue, 17 Jul 2018 14:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=U/dnaiGtJuYHtI7VDkkqVBq5rgXXs7fzI/Uh6IC24OU=;
        b=QZtuZRdPs8VFR4+yglZZIFU3/pvLS3IWAm+ZVa7j69l72QtI/DgHr1TfKdWNtZFgeE
         yzBL54Hb3xRMgEUYit0/YRXaXC7f0KmQTXrwk2cSQXTbwmDVEpcRPFi1tAnhJf0pdGSP
         FYbtGj9GTMOjnpLlPM6lUxlHBjQK7pJkpOk3Lxg3At3tzTTqy9FG6/JW4E5O5cPdB7SQ
         8SKnQBeFnSCrlFI4V6FVtEhVac7a+6gzwIKZOFf9ScHvu0SNFkuQVpf+lOMz/TEI8iUL
         87Pbx3qaluNYFh7TaL3C3Fcm9ArefNd+kenYPJBfJ0oW+ZiEe94f0+o7WRjFRuzgtvcS
         kAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=U/dnaiGtJuYHtI7VDkkqVBq5rgXXs7fzI/Uh6IC24OU=;
        b=cZCmb1CUU7G57t42wfJKJBrMGlw79VoB4jXuqgauqpSl/hDlO2pxk10qDgNeARd5eI
         vBcwl3IeuF3zc+bd0jJAv9Xxalw//R+z+litva95kVeeexyaCk45th/TiqpPIu6COWBo
         is/NmfwVhIVohflP+f1uCj5ffBzHioaf+cMyeDa9hicMb9RA6jEu+u7SdHz2VO1YH267
         ZmODyuKGYvncKBOofpc6/aDhn+HVLtZHgzgwpiDcLetMzqSaRrONRnlGgPn0LP+yAarn
         0yMBFXhDohmKLxStctn9VY9ge0lbdFi1+ld1wJUng0idoxQ3EP0PClBmsloBDID/ICAX
         t0yw==
X-Gm-Message-State: AOUpUlHRHD4e1SpXP8wsP10L1/B7e1MEqRxXLVxuv9Yj0gexI1mIZnO1
        dUmvwf98MhGm7HubtkI3iFqrzF1X1GFpXgCZtUk=
X-Google-Smtp-Source: AAOMgpdWowQcVNvtWO/wfPgPZYdBf4FiUWOSGxGiqz0K+Fk8LMUWPVw6dMa4YUwX8H2W+NIX9qhsQSM85t/ccrveIcs=
X-Received: by 2002:a1f:20d4:: with SMTP id g203-v6mr1995788vkg.176.1531864462359;
 Tue, 17 Jul 2018 14:54:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 14:54:21
 -0700 (PDT)
In-Reply-To: <20180717214212.GE3211@piout.net>
References: <20180717142314.32337-1-alexandre.belloni@bootlin.com>
 <20180717142314.32337-2-alexandre.belloni@bootlin.com> <CAHp75Vc4SrMXznc6PSrO2Lfrc3gspu_g1QYjuFDWT9-J=C+bjw@mail.gmail.com>
 <CAHp75VfRS_gSv6x22M1TiTariUftF04sLyd84dQpxudOmT0s7w@mail.gmail.com> <20180717214212.GE3211@piout.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 18 Jul 2018 00:54:21 +0300
Message-ID: <CAHp75VdEkQ=AC8xUBno7qp0E+cXqwq03WOtVB3sX+Z6zthDJSw@mail.gmail.com>
Subject: Re: [PATCH 1/5] spi: dw: fix possible race condition
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 12:42 AM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> On 18/07/2018 00:30:49+0300, Andy Shevchenko wrote:
>> On Wed, Jul 18, 2018 at 12:30 AM, Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>> > On Tue, Jul 17, 2018 at 5:23 PM, Alexandre Belloni
>> > <alexandre.belloni@bootlin.com> wrote:
>>
>> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> >
>> >> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>>
>> Shouldn't it have a Fixes tag?
>>
>
> Well, I'm not sure how far this can be backported. It also seems nobody
> ever hit that while our hardware will hit it at every boot.
>
> I'll try to find out.

No-one enabled CONFIG_DEBUG_SHIRQ?

-- 
With Best Regards,
Andy Shevchenko
