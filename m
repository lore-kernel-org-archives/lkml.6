Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 21623C5CFF1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BDA2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uFroVNfr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4BDA2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935031AbeFMBAr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 21:00:47 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37522 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934873AbeFMBAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 21:00:45 -0400
Received: by mail-lf0-f66.google.com with SMTP id g21-v6so1242454lfb.4;
        Tue, 12 Jun 2018 18:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ICkPN39nbeJA1vp7TzeaI+ZbTu5evffdYOSeaxXnoFA=;
        b=uFroVNfrJQtv1/5+IfEbFJapoIhcUljO0eCcoi8qAzdvzeCyB3Dh3PsnulPdY7isiy
         3wdLNdznvA/WjRs4h5ArWGydSzZca7l8ydqo5gMX3zMQCLHypIG1xb1gNnslQQ1NCY0w
         JQE/FIJ3/1nNFOy+8bPYWryCmMiXt2b5a2gs17OG7nZAGOfPcrA/IA5ipQH0d0HJMeEJ
         UG3O0DGi6qkdauai+rJTCyRgiVmIN5y2UayFclAanag4NZaPCPuV0I9sjJ4887xJ0gII
         xPxDVlfMM/66oHX0uiRlMWRjMngneGrOzjD3LxCf+HS6Q73Ut4lOV6xiezGUJn9avJUy
         H8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ICkPN39nbeJA1vp7TzeaI+ZbTu5evffdYOSeaxXnoFA=;
        b=cgzCjRIoIsx57P2HkL1h9b4mvP9a8n91RSeyBQ+yuyjMvTG9J/0PssBqBjOIaflJ6r
         ykqNOeu9TBsjfJRCKTX4R7FNB623agEIVaIcGCXcku+9dRaKn623fkWTHMq+ZjvUTDyL
         ZUa8WrN7OAftIAATdSgLiuoaGP/0cXPS9EEzP5nXCLEC5Tu4m3640JwulnYQfptdJjLQ
         Crl1HosoMNjt+xIOPabxTz8P7ANIshjqsA6hXVzTxY2qpKvJWpVFdSMsoesx3DaarBkV
         IcSBOKD8SsFrCdT5f4ETvBY36nXcqLqOb1oEL781K4l6oBy9dsZ1I8XdUUkK4EwVcE6l
         uDHQ==
X-Gm-Message-State: APt69E0Vo4LVLmQOWpCXeT1/11SrcU5gGLyso7Ftpwrpz+iqBtK4L2wb
        8MANuMPG1thFhHfHtfsrn6k=
X-Google-Smtp-Source: ADUXVKIW0uCiKs4OO7HSKCMU5/KB2h8mlKDG9qbGayzgzXVMV0LWhycvCHsKkgq7EluBHkdnTrV+ug==
X-Received: by 2002:a2e:529c:: with SMTP id n28-v6mr1685979lje.62.1528851643038;
        Tue, 12 Jun 2018 18:00:43 -0700 (PDT)
Received: from z50.localnet (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id a19-v6sm277673lff.84.2018.06.12.18.00.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 18:00:42 -0700 (PDT)
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
Subject: Re: [PATCH 04/10] Input: ams_delta_serio: Replace power GPIO with regulator
Date:   Wed, 13 Jun 2018 03:01:05 +0200
Message-ID: <2655614.ErW8VuCT6r@z50>
In-Reply-To: <20180612221724.GB38773@dtor-ws>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com> <20180609140224.32606-4-jmkrzyszt@gmail.com> <20180612221724.GB38773@dtor-ws>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, June 13, 2018 12:17:24 AM CEST Dmitry Torokhov wrote:
> On Sat, Jun 09, 2018 at 04:02:18PM +0200, Janusz Krzysztofik wrote:
> > ...
> > +	priv->vcc = devm_regulator_get(&pdev->dev, "vcc");
> > +	if (IS_ERR(priv->vcc)) {
> > +		err = PTR_ERR(priv->vcc);
> > +		dev_err(&pdev->dev, "regulator request failed (%d)\n", err);
> > +		/* Fail softly if the regulator is not available yet */
> > +		if (err == -ENODEV)
> > +			err = -EPROBE_DEFER;
> 
> Hmm, if regulator is not ready yet, devm_regulator_get() should be
> returning -EPROBE_DEFER already, we should not have to convert -ENODEV
> to -EPROBE_DEFER...

Regulator is not ready because its initialization at subsys_initcall is 
deferred by not ready GPIO pin, that in turn is caused by gpio-mmio driver, 
unlike many other GPIO drivers, registered as late as at device_initcall.

I agree devm_regulator_get() could return -EPROBE_DEFER in this case, but I 
can see it does that only when of_get_regulator() indicates the regulator 
should exist. In non-dt case there is apparently no way to justify if it 
should unless its consumer supply table was already in place. For that,  
registration of that table would have to be independent of successful 
registration of the regulator itself while it's not. Maybe it should, but 
that's a separate topic for a separate discussion, I think.

> Is it because we have_full_constraints() returns false? You might need
> to add call to regulator_has_full_constraints() to your board file.

If have_full_constraints() returned true before the regulator or its consumer 
supply table is ready, devm_regulator_get() would happily return a dummy 
regulator and our keyboard would never get its power.

I'm afraid we have to live with that return code conversion as long as the 
only user of this driver is not migrated to dt.

Thanks,
Janusz



