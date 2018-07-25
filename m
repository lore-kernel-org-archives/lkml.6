Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96B4C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4990E20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXhIAIKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4990E20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbeGYQgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 12:36:48 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:35260 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728646AbeGYQgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 12:36:48 -0400
Received: by mail-vk0-f68.google.com with SMTP id p12-v6so3992200vkf.2;
        Wed, 25 Jul 2018 08:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2Ozl4dcjmHQ6+f0pm4w1uuLp9zxqi2LiHnwTryC9tp0=;
        b=GXhIAIKVlLh7TpYGJhZSfQIAjwr/Ik3wDG6Fy9pw7nVHodL9DHPJkNUaOcsxoNwsKa
         8VuhHmwTXrzbck4CRUAeuDbos8AwF/55yic6tiy4kHXp8fVLBslJVIOiCgEWflVTDkWH
         WfJqA3dqr+Fgx4WjqiwOuU/WEN3xZow1B0u8QkqWo0KljDwQf/lwkXSMfLlLCsS8OJvy
         KjrSciRdj3jgQnCRysybNnlZ7n8nTR7KxbZ+tnPP0Ag5lWGE9N9ykTNCuPFPmdMhlfya
         oDBQ9J+vqWsvXgYB+F8+QBLj5sQmLjFBBHE8IoH5RQFviFWneRtN30fQABbqNle2rXXP
         5mdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2Ozl4dcjmHQ6+f0pm4w1uuLp9zxqi2LiHnwTryC9tp0=;
        b=IgSRkdni+kB4gzVexUX+mr2j8CgCFoibCCVfe3mty+4z+Oyiz+0UsA1ApsHv1skG61
         bgNy/eou+wvneEmKIvXfHb4jRtZt8UCfVivuJyUJrjA80yEFyyMfSOPOND0fN5Jopyzm
         9QsDJNS0dCG9xvSw3Z2ygN0D0gTX5Byyjt4b7Xg/Hge48Qv5oUWuspOVdpMZAIG3lyCY
         9JjYGMbV9UUvUnBG6EQcuk9qk5WOR1VGNHxJUtyDprNvR5vj6u1bx/Roi5CsZuggnKq8
         t/JQzkc2cvW1J4Vev1+z3vNcb1whJ8H8GGzMH4xStQwK+aE06aEliuCxsDySJ14EiKjp
         Q8nA==
X-Gm-Message-State: AOUpUlF5mGRH6Ri8PkY/fZ7AzFvDCBcgmXcNlnTuUc40Uc2pD2MwUKfU
        xzZrzrYPsslfRmd9R3QjLEyxIcCX7+A1c4ewdqU=
X-Google-Smtp-Source: AAOMgpe4z35H+eiTG8oBfvPmcMRcUpJ6GgC6OsMqp5HfUdCZTbme2N+RyI5l8ZNnIkn0GJjEjmFDE74duoeNQD2P7E8=
X-Received: by 2002:a1f:b503:: with SMTP id e3-v6mr7064953vkf.97.1532532278652;
 Wed, 25 Jul 2018 08:24:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 08:24:37
 -0700 (PDT)
In-Reply-To: <MWHPR02MB2816A41E9C145BC8D89F834AA7540@MWHPR02MB2816.namprd02.prod.outlook.com>
References: <1532519491-19502-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1532519491-19502-5-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <CAHp75VfM8h9CKXO9bfmF74fcLW68Rs+1514Je=o1jOFd52Uf7A@mail.gmail.com> <MWHPR02MB2816A41E9C145BC8D89F834AA7540@MWHPR02MB2816.namprd02.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 25 Jul 2018 18:24:37 +0300
Message-ID: <CAHp75VfBYPF5u9e64VMrDfi7yC2XyAwr5qa7ow1Xat5hFq1etQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] usb: dwc3: implement stream transfer timeout
To:     Anurag Kumar Vulisha <anuragku@xilinx.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 6:14 PM, Anurag Kumar Vulisha
<anuragku@xilinx.com> wrote:

>>> +/*
>>> + * Timeout value in msecs used by stream_timeout_timer when streams
>>> +are enabled  */
>>> +#define STREAM_TIMEOUT         50
>>
>>Perhaps, STREAM_TIMEOUT_MS 50
>>
>>Dunno about this driver, but it's a usual practice to help reader with understanding
>>code on the first glance.
>>
>
> Since I have mentioned "msecs" in comment above describing the STREAM_TIMEOUT,
> thought it would suffice. But if you feel I should change it, I  will fix it in v2

But you didn't put that comment before each occurrence of this
constant in the code, right?
That's what I'm talking about. If reader looks into the code, there is
no need to understand the order of the value for timeout, since units
are part of the name.

Of course, you may ignore this comment.

-- 
With Best Regards,
Andy Shevchenko
