Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9802C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 719562145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LnP2TPxd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbeLQXsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 18:48:17 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34556 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbeLQXsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 18:48:17 -0500
Received: by mail-ot1-f68.google.com with SMTP id t5so13999771otk.1;
        Mon, 17 Dec 2018 15:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rt7CdRQssFR6XPEPPXiILF4IcZMbBsZnZ/kJsmQYXDs=;
        b=LnP2TPxdt7Tual/++38WGq5Y7xCiAY8oRDzCDoH7fo+aw5XbfLmfqSligXTECc9WER
         i6SUD0p0eoxdrcGvniU6JzjCwdS+cPa4A4EY1M8oENIfTAOOhgEpjbNyO6Z5zpcizagp
         W55Ovf1E3Jy6iomn23NZabRyEc93k2EDZDveeLSukEWjv7xB6PnKcSEtBcSVYZdCLfgU
         NP2yzh8mpHrPMLn9C+5jJ9Wb+LgEKXi6grW6Y/3DSZJHGRb84io1D0bFPZTEcZ/U7O9k
         421QmfExwvYLKZz0mYJ0AAZm+DIT87yc/PrWTiYVCNuKamRS9gX5b3McaunpnniNKfDR
         6cFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rt7CdRQssFR6XPEPPXiILF4IcZMbBsZnZ/kJsmQYXDs=;
        b=F8AAgWdY46aMFLxw7y1XzYIfTs0HMryZtxwbHl8t+AuigGe8/M+H0wjMs3PAPxDpMZ
         elxTHg3tYTKb4/glXz2PpAMIZ4u9okS6/cCiqDTOLMtrJsKSPZv1/eGateGqEu6+YK0O
         5jsTo9jvBpHaHpdDG/zHosYuzdjLq/dApIw4M0T0wTVc+/Rf7nolJ6JHkq6P9CUoEuzX
         3JjJs1pI+qu7eO75pAn6YCTqJRPRNIGntxJ/FZI27sfhTxFYVtqXhNCmAtNsJHKx/Aay
         AmR+oHONL1iODPSDrGf1hlAIl82WDLw96wGFre1R9t7DpBdgfhUQ2+qG5swc+69L0Nsd
         kYwg==
X-Gm-Message-State: AA+aEWaWIruBGKEYoVL5CubpC13nLBWcx0NQPIiSsVlaPPqxXBD3HqC3
        dMVsX6BUdyMv2CbEoZ1oD3cGJ25lA3sVjB1THLY=
X-Google-Smtp-Source: AFSGD/WgOUrjzw3r7cF0wdB9sAFysppeNnwH1UIZjLX5ZG2xx0bUQIN6nohG5gztj/9cysAu5C7Ipj2FwmLigttYsSo=
X-Received: by 2002:a9d:7749:: with SMTP id t9mr11457998otl.342.1545090496291;
 Mon, 17 Dec 2018 15:48:16 -0800 (PST)
MIME-Version: 1.0
References: <20181202220847.24364-1-martin.blumenstingl@googlemail.com>
 <20181202220847.24364-3-martin.blumenstingl@googlemail.com>
 <85aa8e12-0bca-6432-e1a8-0faceff1dd5e@codethink.co.uk> <CAFBinCBDUxTc+ofCYm-zEeiFdU90U6DQOkX4B659q=MvRK64fg@mail.gmail.com>
In-Reply-To: <CAFBinCBDUxTc+ofCYm-zEeiFdU90U6DQOkX4B659q=MvRK64fg@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 18 Dec 2018 00:48:05 +0100
Message-ID: <CAFBinCAY7+-zA5-hY6oXmFz2i8aj9wFJsb-HBbKt_Swn9BtMMg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] rtc: support for the Amlogic Meson RTC
To:     ben.dooks@codethink.co.uk
Cc:     linux-amlogic@lists.infradead.org, linux-rtc@vger.kernel.org,
        alexandre.belloni@bootlin.com, a.zummo@towertech.it,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ccaione@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

On Wed, Dec 5, 2018 at 11:15 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
[...]
> > > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > > [resurrected Ben's patches after 2 years]
> > > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> >
> > Just checking if the change of author is deliberate?
> > not sure how to do >1 author on patches like this.
> I changed the author on purpose after seeing how much I changed
> (compared to your v4). this is also why I added you to the CC list
> however, I left in your copyright (just like you kept Carlo's
> copyright note) and MODULE_AUTHOR
please let me know:
1. whether you want to be the author of the patch or if you're fine
with my name in there
2. if you are fine with both of us being listed as Signed-off-by or if
you want me to switch to Co-authored-by
3. about any other concerns you have

I would like to update this patch next weekend so it can be reviewed
(and merged once all is fine) for v4.22


Kind Regards
Martin
