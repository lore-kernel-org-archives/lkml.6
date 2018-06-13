Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D13F1C5CFF1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783BD20891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwdO47/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 783BD20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935054AbeFMBKM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 21:10:12 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46428 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754425AbeFMBKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 21:10:10 -0400
Received: by mail-lf0-f67.google.com with SMTP id j13-v6so1225682lfb.13;
        Tue, 12 Jun 2018 18:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OMKVDkcDMBadt57O6X3RGTeaAPv3YFu6AM+q/mfdVro=;
        b=nwdO47/8B8JN0pbdi+sYIaf4AVhQ/t3ay0g6NFk6+bKcXjBgPUhEIzrGAR1QYXNwuG
         ajUfXNqcVoatryF3l+dBS2Gy7oeOMjkNRa5vMiiqWwtcW5zkHNEjkgT+XNGdUZec+OWi
         ZNk4sSw4yREhieZknDvQfb/sGBDTXspS83iiaqOOb7dlVXrVfIC840eysvwRNWeevMkS
         aZjot8M4zoiymTL5rKRBInKRl5P5V9KZsk+pE+o0iVLgOyZYo5SyTSrdHjDFuF9gv6Qm
         QULZCWqV4VV34pC5J0RtHgxltQa1Vxwt7eg8QmYuw6u7PemFAUMDcc4uOEbe9lWBlhie
         ncqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OMKVDkcDMBadt57O6X3RGTeaAPv3YFu6AM+q/mfdVro=;
        b=fkpksGg+VhVPf5KZOavdPCg54C7hqmm77hWAmIdCTzPQGcE9g252kf9NQiDYcifqD5
         TXmQ4OTAGR5M/8cKOnrW/oRCoEdsk079QQ/Bdlkvf5/BH/DfZxG8Mc6Dwgx3ydJTJq+Q
         QsTYJ1p5wqhv8MJQmll1+JERNcKIor3UYkrQuRauitbEEA0LpMh0dm9CgseQGQw6mQnl
         3ecSir7FzfR2hYcxgEmObdw34HH7G1ayqDj2060+3ExgKqga5K5DiCdVDOzQEaWNMaWG
         wI0oTMejrMQTIMHR00OJftbd9TcXlAzEYVDVW/RHRqN9F4r9n0obaV8upItUUGwNVj3V
         wQ1Q==
X-Gm-Message-State: APt69E1IhTJdoIYwzY2meaebxbG8q5dyw71f6cmFC7CXLVaeFuf4hNPn
        NnRsS5nDOfGq+fhPzDsZ/Y4=
X-Google-Smtp-Source: ADUXVKIFCXjmgBp6hcJI6rHLolgNipEgRsmbAlTFZ244GMbNfaHbQ5ZGzJshLgaNWTwfJAdTuCIpHg==
X-Received: by 2002:a2e:28b:: with SMTP id y11-v6mr1591615lje.27.1528852208418;
        Tue, 12 Jun 2018 18:10:08 -0700 (PDT)
Received: from z50.localnet (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id g5-v6sm290907lje.21.2018.06.12.18.10.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 18:10:07 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [PATCH 09/10] Input: ams_delta_serio: use IRQ resource
Date:   Wed, 13 Jun 2018 03:10:31 +0200
Message-ID: <1688832.aCTLqTvW5e@z50>
In-Reply-To: <20180612222104.GC38773@dtor-ws>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com> <20180609140224.32606-9-jmkrzyszt@gmail.com> <20180612222104.GC38773@dtor-ws>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, June 13, 2018 12:21:04 AM CEST Dmitry Torokhov wrote:
> On Sat, Jun 09, 2018 at 04:02:23PM +0200, Janusz Krzysztofik wrote:
> > ...
> > @@ -141,14 +141,11 @@ static int ams_delta_serio_init(struct
> > platform_device *pdev)> 
> >  	 * at FIQ level, switch back from edge to simple interrupt handler
> >  	 * to avoid bad interaction.
> >  	 */
> > 
> > -	irq_set_handler(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK),
> > -			handle_simple_irq);
> > +	irq_set_handler(irq, handle_simple_irq);
> 
> Do we still need to do this here, or it can be moved into board file?

You're right, it should be possible to move it. I'll check possible options 
and submit a follow up patch.

Thanks,
Janusz



