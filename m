Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D5EC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F9920835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MZNPrxCx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F9920835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbeJCNoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 09:44:08 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34333 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbeJCNoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 09:44:07 -0400
Received: by mail-io1-f67.google.com with SMTP id k19-v6so4183324iom.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 23:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kjd071kaXG+9T4Ak4vdc9WPfUZj0908319uN3P+WKCI=;
        b=MZNPrxCxTbz0+/6S8rRypmX9DYTn7PeqfgVCJzQjNh6Tb5bqlh1okrVWU2H94Fagax
         qu77DBkuetBH1H1V0+oEDoRmTSllVjEETJfomY+r7EL05CgMyU5c/arD8I4taevr5h6S
         pSKuBs3GsLWp0KqLzlWu8QhKvpGNEUVELDSm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kjd071kaXG+9T4Ak4vdc9WPfUZj0908319uN3P+WKCI=;
        b=iOuOgbJqM4Eg18z01MjXLSzP1Zyzu3cE4zsL0+u90PC4X09Zc85rmR78fgdCfm+iWi
         4Dz9QROiC6HA6n2+jo/PMHLCMhMjlbasDf0rmcr7zE3leCDnx2uVwaJ/8WSQjvOXNreA
         kA5zR6lLqj2IIvYv8VdQYKoYuPz0k9s/HsA4INrP3NjqA1YxVFlgZNzZZ3hFXKWb/+xp
         57Cb3xG2kF6nECmqVg5je9mOD1x6he8OrZsA55iKf5ROQyf3YHf2eTmsmWUFPE1k8BRy
         6meIxuAqn2y5Po5oFbeCMU+uDpuAx25QYTVHxXKIiMif8xtVBHtEYDUNjcRA1p40DGDW
         cL/w==
X-Gm-Message-State: ABuFfoj8MNSSO2ruuy+Q/Du2mg8rqlUguWrRPi9q0lDR+4nneRYKqwsU
        wrSvJI8Ym+fis0Q+uj32r3WVICZoU2oM8gf4abqQZQ==
X-Google-Smtp-Source: ACcGV61NmmaMMm7GYkKMMyTKA8ito3N4uB+CzhSTzJdjw8n4EP5l+Lg76A6R9yq4zkLupStvKxmenrXNtpK6V0rp/ug=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr37094ioa.277.1538549825328;
 Tue, 02 Oct 2018 23:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <20181002041437.2493192-1-taoren@fb.com> <CACRpkdY4VaH2Yoob2gWwAk11P1NTDdza262zKGs=gju0NH9skQ@mail.gmail.com>
 <3a294c92-bcc6-b42e-b3af-72bc5f607fd9@fb.com>
In-Reply-To: <3a294c92-bcc6-b42e-b3af-72bc5f607fd9@fb.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Oct 2018 08:56:53 +0200
Message-ID: <CACRpkdZXum+bQg1FO+EHhKWpxtPYXfeRhoAKkFXeMQh1Jng3Ww@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/fttmr010: fix invalid interrupt
 register access
To:     taoren@fb.com
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Yu Lei <mine260309@gmail.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-aspeed@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 12:08 AM Tao Ren <taoren@fb.com> wrote:

>     1) adding "is_aspeed" flag. "count_down" is kept because potentially faraday-fttmr could also be configured as count_down timer (although I don't see any reason to do so).
>     2) renaming "count_down" to "is_aspeed". By doing this, we set restriction that faraday-fttmr will always be upward.
> What's your thought? Do you want me to include all the changes in this diff?

My thought is go for (2) and do all changes in one patch :)

Yours,
Linus Walleij
