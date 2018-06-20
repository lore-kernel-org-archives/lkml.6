Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F3BC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B75920872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fxy3kyPX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B75920872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933493AbeFTWIC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 18:08:02 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44867 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933249AbeFTWIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 18:08:00 -0400
Received: by mail-oi0-f65.google.com with SMTP id c128-v6so1031181oig.11;
        Wed, 20 Jun 2018 15:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=J3nY396sRDoWoSZQznVRtR27oPKUZ8YKRf3bH1Q6I08=;
        b=Fxy3kyPXgfLN2yhUSuCbVmUORo4bNuvzWBaujAovYQ1iTQXFQAZilF2+R0WhWLdIDl
         x+JdpmHfKNAMMAObuWyn5HlCe3IZjhyIPtAQCyHiguOI7lJ9kp0lJkpiZEoRfAsoWW0S
         s19IZQ1xb+Pks3MgPTI4akoJzmP4hO7dW1O6pJ8FunddkpZ+PLjq8zgd0pXh4M9BnE56
         Z5BwvJyNtWJxHMtcW5jGe1QCB8tqlbP2W7gBP2YoSIJipTjOJ0BGDSE+U9RfAKQ8GOlF
         7Y0IfDTSsuFArMT0Bc7orL8TXNmdLicsazkXjbbpLYxdImcVJ49pDi1nmPJAgAx1+fSI
         NOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=J3nY396sRDoWoSZQznVRtR27oPKUZ8YKRf3bH1Q6I08=;
        b=es8DG7Z1BEPALyfxeQ5YAku6rsKM+mgyKu81fBzixaeD/phzdT6c4hTJ23CDqtzoZW
         /eaHCn6vHj30fakw/jtBs0Yb/Jr2oO1tnpiaMg3IT72Y/p53jmnDk1ptuxQj/+8LeYq7
         5KCLCB2VE4YIBC5gSTDClZMk+X9ykQ5tMRkVKIWOtD6HBsZ5l5N/n35tJZPGrTgSiAso
         8Qi/MLjf0/f+v5Yd64+kYnNqYI+3cGRFWF0tTOH9FzK2Q2JgZIdfNB8ugcx/9ebKu/Mm
         y2hDGulIdqIL+mn9CQHhm/Xd2k77dsTUnSp/4mEOqjA7VxFdiHlCkqQHWnZ0c10STBHb
         cd4g==
X-Gm-Message-State: APt69E0k0+MzDwZLOZ3sSZi/eoIhU1yvW1b8KG0pCw9olIfP0O9f/R6G
        TM6irBe7YlVuIO0lpWqnQpPAh6VycaCE3mGnNCQ=
X-Google-Smtp-Source: ADUXVKIATKxl5AkT1e47t1hn10dCClcvKrzCR0YvGOc7ZzhA30m1Jr8bACL6huS/DkWUp89bDzjkHvp0dZADGsTMxXU=
X-Received: by 2002:aca:400b:: with SMTP id n11-v6mr13646933oia.44.1529532480083;
 Wed, 20 Jun 2018 15:08:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 15:07:59
 -0700 (PDT)
In-Reply-To: <20180530173414.6121-1-andrew.smirnov@gmail.com>
References: <20180530173414.6121-1-andrew.smirnov@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 20 Jun 2018 19:07:59 -0300
Message-ID: <CAOMZO5AyAegbvUtX42by99mU8yQfi91bmhJfd9iqu1Ak0dEHiw@mail.gmail.com>
Subject: Re: [PATCH] usb: chipidea: Fix ULPI on imx51
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Peter Chen <peter.chen@nxp.com>,
        USB list <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On Wed, May 30, 2018 at 2:34 PM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> Workaround introduced for i.MX53 in be9cae2479f48 ("usb: chipidea:
> imx: Fix ULPI on imx53") seems to be applicable in case of i.MX51 as
> well. Running latest kernel on ZII RDU1 Board (imx51-zii-rdu1.dts)
> exhibits a kernel frozen on PORTSC access and applying the workaround
> resolves the issue.
>
> Cc: Peter Chen <peter.chen@nxp.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

This patches causes a regression on a imx51-babbage running 4.18-rc1:
I get a kernel hang.

If I revert it on top of 4.18-rc1, then it boots fine and USB host is
functional.

I understand this patch fixes a kernel hang for you, so which commit
is responsible for the hang you observe?

It seems this commit fixes a hang for you and causes another hang for me :-)

Any ideas?

Thanks
