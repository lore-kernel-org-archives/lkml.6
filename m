Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A72DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175FE2083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qcw+X3Tv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175FE2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbeIABft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 21:35:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38495 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbeIABft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 21:35:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id w11-v6so12386411wrc.5;
        Fri, 31 Aug 2018 14:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j1nSmX2lqdcK7cjjN0dtzKa3tALV9wgDsaltmPtnYBE=;
        b=qcw+X3Tv8zcr1FVvlX9bpMFSyxhNDvcekKOlaFDFomx9pNAL4sHVrH3zDsuUkLIWIE
         H815ZftDe3UH3c9hCoPTkKjzhoSckbryMek8bHvT1ybDM/NZQpVhGoW4ciyHgDDTo4td
         RUMOsCq6Q83qaHJw+nb8oDAcsnmDOvla9p5nge5oXFm7Ymjnurtw+m1IDl39+Ozes+Ra
         EVpJHxobQJ2UiAJlgm0QJppaRAhAhoVJ4HS3pVIyRFp/K7sfi1TOH3PjaZUHsLdCnuK/
         HI4NoiJjeYgM26HQo53dxOcxGEnaCR5g5efa2sqg0T36hZWcsQgiiVWJun32y9zRn2eL
         btUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j1nSmX2lqdcK7cjjN0dtzKa3tALV9wgDsaltmPtnYBE=;
        b=mUpts03wvR9dFqZkkOq/avr0nYS6E02wvPV9zH93TtUtKkPZ/7gWL1BPxdc17J3lhj
         OyUL7jNGzTonBnStlEVRhCvBoFyXmJKSMBJZDk8tNiWvDVQmdTUOa4Vn8PJl8KyNM7ga
         8QHkAJyTbOIFRyoKvLV58n70DspvxAMLtfK3BxOy7nTye4JoHGVxMHOvGr7Q6P+4GVSy
         3YouLicN3LeXqp7K/rKYI/NCydKmQioNIMD/2aIj2FxW2EcO3VpDAJE7YnqzzQmAtOyg
         zdysj/dWUur2+PBVfWe/OCoowcaSAWHa9R6N0x7Wif5JwxqEDHHgsQvCg9xlRLsg042/
         uNcQ==
X-Gm-Message-State: APzg51ClApXkMABksCQQXbdHGxDuymj14eGEKioVw9RzHBvF+YrJovsp
        BTpH3LvGHTbofZS76GRR1IzKotVVw2DTOGLUQxcFKA==
X-Google-Smtp-Source: ANB0VdbQqTS1L3HRAft2bltmD4qWiEyg0tZcVdx/v5438BDyRaWfkVqzLvNqBaiI+gU+hym0OUoahmqrHb7xWrqEcII=
X-Received: by 2002:adf:ae5a:: with SMTP id u26-v6mr3589818wrd.246.1535750787783;
 Fri, 31 Aug 2018 14:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <1534549659-15883-1-git-send-email-justinpopo6@gmail.com>
In-Reply-To: <1534549659-15883-1-git-send-email-justinpopo6@gmail.com>
From:   Gregory Fong <gregory.0xf0@gmail.com>
Date:   Fri, 31 Aug 2018 14:26:01 -0700
Message-ID: <CADtm3G4yn2n_D8Kd8d9ohv1Fd6YFSyRtgrzLT=1xbcegNLMWCQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: brcmstb: allow 0 width GPIO banks
To:     Justin Chen <justinpopo6@gmail.com>
Cc:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 4:48 PM <justinpopo6@gmail.com> wrote:
>
> From: Justin Chen <justinpopo6@gmail.com>
>
> Sometimes we have empty banks within the GPIO block. This commit allows
> proper handling of 0 width GPIO banks. We handle 0 width GPIO banks by
> incrementing the bank and number of GPIOs, but not initializing them.
> This will mean a call into the non-existent GPIOs will return an error.

This is clearer now; thanks for rewording!

>
> Also remove "GPIO registered" dev print. This information is misleading
> since the incremented banks and gpio_base do not reflect the actual GPIOs
> that get initialized. We leave this information out since it is already
> printed with dev_dbg.
>
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>

Looks like I'm a bit late on the response, but in case you feel like
adding it Linus:

Acked-by: Gregory Fong <gregory.0xf0@gmail.com>
