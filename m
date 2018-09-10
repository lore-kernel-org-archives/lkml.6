Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05152C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54662087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A54662087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbeIJVwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:52:30 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36803 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbeIJVw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:52:29 -0400
Received: by mail-ed1-f68.google.com with SMTP id f4-v6so17072723edq.3;
        Mon, 10 Sep 2018 09:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B/c4yY5yML7+QhxA/6VTMuArnLdEas4APK+tCOdD6Co=;
        b=nLFN2D6HGriLIkqdeaVo3B31gOXPjEM9zBHxaXzH5vOQklgaaMqSvuXMUNbeBXjUJI
         xC7cz4sSaMHedVxe6ACWcVdwKDbDKq58dtsebA7LtKIL6QbwzTtQ+OovWAdreYpUZ27a
         ZHwKlFZ40Yx40FME6Q8CdJ0N9+q1TmjeC+FlPNxJdNYAubagIrFrwPvlqRRqgRb54Lvp
         z6TBrU4C2LJDsRFCwrOAnv+udfw7WQfbJNxTEl9gV3WLVCvqBEnLYcBmpYYJw6XFfj7P
         BoH2OLwTdmwKIEflwoXlK68EC0fZhyv1JM8Cs7OX7iR3GBMFxrcx/x8eS//fM9vMesC/
         9Nrw==
X-Gm-Message-State: APzg51ADaMSbqQzgDi87QWW71O+I5Ad06rsfURMlRsMZflarJvUf2swm
        XHy54sjCTqD0r6fHJ1jKVse9nuDg
X-Google-Smtp-Source: ANB0VdZUdt5xJxYLxw1gJqav6JxMmQuiYzH6ZvhluJrFIk4/rUKs2+M+toRlundnr1b/XssR9Rk6OQ==
X-Received: by 2002:a50:9a02:: with SMTP id o2-v6mr23991996edb.236.1536598648706;
        Mon, 10 Sep 2018 09:57:28 -0700 (PDT)
Received: from kozik-lap (xdsl-188-155-58-14.adslplus.ch. [188.155.58.14])
        by smtp.googlemail.com with ESMTPSA id d23-v6sm3324897eds.47.2018.09.10.09.57.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 09:57:27 -0700 (PDT)
Date:   Mon, 10 Sep 2018 18:57:26 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Cedric Roux <sed@free.fr>
Cc:     kgene@kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] ARM: s3c24xx: Correct SD card write protect
 detection on Mini2440
Message-ID: <20180910165726.5vl24ng2dywexzsf@kozik-lap>
References: <20180907215446.15160-1-sed@free.fr>
 <20180907215446.15160-2-sed@free.fr>
 <CAJKOXPeYO3VR5LABP3zKYnKckqUBahKPt7MCjzuo3j6oe+d87w@mail.gmail.com>
 <ba9d81bf-f000-f6ae-30b1-3e922985f655@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ba9d81bf-f000-f6ae-30b1-3e922985f655@free.fr>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 06:55:09PM +0200, Cedric Roux wrote:
> On 09/10/2018 12:23 PM, Krzysztof Kozlowski wrote:
> >>  static struct s3c24xx_mci_pdata mini2440_mmc_cfg __initdata = {
> >> -       .gpio_detect   = S3C2410_GPG(8),
> >> -       .gpio_wprotect = S3C2410_GPH(8),
> >> -       .set_power     = NULL,
> >> -       .ocr_avail     = MMC_VDD_32_33|MMC_VDD_33_34,
> >> +       .gpio_detect     = S3C2410_GPG(8),
> >> +       .gpio_wprotect   = S3C2410_GPH(8),
> >> +       .wprotect_invert = 1,
> >> +       .set_power       = NULL,
> >> +       .ocr_avail       = MMC_VDD_32_33|MMC_VDD_33_34,
> > 
> > This looks unexpected... after patch 1 there should be only one change
> > - one new line added. What happened here?
> 
> This is to align all the '='.
> 
> These were spaces before the '=' so I also used spaces.
> Should I put TABs instead? I looked in the coding style
> and didn't find anything about this specific thing
> (maybe I read too fast though).
> 
> And if this ends up unaligned because 'wprotect_invert'
> requires a second TAB for the others, should I do a separate
> commit?

Ah, I understand. It's okay, thanks!


Best regards,
Krzysztof

