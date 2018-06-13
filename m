Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C6668C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D9A208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arh60sRR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D9A208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935798AbeFMUvw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 16:51:52 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:40687 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935761AbeFMUvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 16:51:49 -0400
Received: by mail-pg0-f67.google.com with SMTP id l2-v6so1834208pgc.7;
        Wed, 13 Jun 2018 13:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8CYv9KMoie8jU3ijgM3hXVF1Csgj6p1tBskcVLgQ6Fw=;
        b=arh60sRRJnOiEFko6UvzTMCXFNV2OeLy3B/8zwuowGTJw1TH03tppVKmkBblsWYe69
         +RPIjcb5o9aIhkJuv+DrhkplCZ/CzA+BNDwEk1XCJ+A1i/Gxp599aCQtoi+XQPsO18tN
         N+LgQvA5Zt49MmTs1iKno4tvygEFA5IRcl7EYwamshYeE9r/04MqZeVsHyxDraIUL3FD
         4SYnV82TwD+ifbQraBksRPvjb5OUiJyGLvyHU8g7f2YHIgc/5tmUBXbJytHD0HB1fSn0
         yurwZHTtY79BTe2Avv4OZPFfy0VjAxpQq56KyT57WtUBmMku/QOvGyegXP4b0S0jmVBs
         JoWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8CYv9KMoie8jU3ijgM3hXVF1Csgj6p1tBskcVLgQ6Fw=;
        b=KpV68rqCPeBtVcKrON8+GXiyXtSyIQxI8DM5sIKBfNHgubdRRxJygmOg3SqZRWJNcy
         l9/aOCmiGCcuYfNU48I6Z7BRI/r1vC9U7G7ROsfiafcwe8OD88Tg8hc9uZjw/sB45yxb
         LpQ/cASnkpVF+Az6QC0Aa0FH0kDL11gzRShMvXcDs3d3NPHbqh6DJ5B3Djh+62xsDlVb
         IV3kd0qnaNeL6nHz7rR24XEl7Q5XCnnE8p1t4S1VWCLa64gxgfatPcsgG0SEdmVUtdZ7
         z+c3rm4tgr5BMHfYQsFHoSFvPGxyBVvSjhLU0q3QHYUuPssY+r+K4gSph0e0zavYujn5
         n/eA==
X-Gm-Message-State: APt69E3WEzrlSzxuMB/8KGFlS19/ax+XsOhKYz5i2q8jcq50WevZ4sql
        tVh00Rz03IIa+YWPSU83Vak=
X-Google-Smtp-Source: ADUXVKKSHyJ6+w5J9jKxwiRxv8xtA3vM+Dn1xP5P+6JFNKwdzsmYJt4v8o9XTq+tUjrTp6LMh3NhpA==
X-Received: by 2002:a63:6185:: with SMTP id v127-v6mr5203936pgb.301.1528923108422;
        Wed, 13 Jun 2018 13:51:48 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id s134-v6sm4741030pgc.30.2018.06.13.13.51.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 13:51:47 -0700 (PDT)
Date:   Wed, 13 Jun 2018 13:51:44 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] Input: ams_delta_serio: Replace power GPIO with
 regulator
Message-ID: <20180613205144.GB62746@dtor-ws>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
 <20180609140224.32606-4-jmkrzyszt@gmail.com>
 <20180612221724.GB38773@dtor-ws>
 <2655614.ErW8VuCT6r@z50>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2655614.ErW8VuCT6r@z50>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 03:01:05AM +0200, Janusz Krzysztofik wrote:
> On Wednesday, June 13, 2018 12:17:24 AM CEST Dmitry Torokhov wrote:
> > On Sat, Jun 09, 2018 at 04:02:18PM +0200, Janusz Krzysztofik wrote:
> > > ...
> > > +	priv->vcc = devm_regulator_get(&pdev->dev, "vcc");
> > > +	if (IS_ERR(priv->vcc)) {
> > > +		err = PTR_ERR(priv->vcc);
> > > +		dev_err(&pdev->dev, "regulator request failed (%d)\n", err);
> > > +		/* Fail softly if the regulator is not available yet */
> > > +		if (err == -ENODEV)
> > > +			err = -EPROBE_DEFER;
> > 
> > Hmm, if regulator is not ready yet, devm_regulator_get() should be
> > returning -EPROBE_DEFER already, we should not have to convert -ENODEV
> > to -EPROBE_DEFER...
> 
> Regulator is not ready because its initialization at subsys_initcall is 
> deferred by not ready GPIO pin, that in turn is caused by gpio-mmio driver, 
> unlike many other GPIO drivers, registered as late as at device_initcall.
> 
> I agree devm_regulator_get() could return -EPROBE_DEFER in this case, but I 
> can see it does that only when of_get_regulator() indicates the regulator 
> should exist. In non-dt case there is apparently no way to justify if it 
> should unless its consumer supply table was already in place. For that,  
> registration of that table would have to be independent of successful 
> registration of the regulator itself while it's not. Maybe it should, but 
> that's a separate topic for a separate discussion, I think.
> 
> > Is it because we have_full_constraints() returns false? You might need
> > to add call to regulator_has_full_constraints() to your board file.
> 
> If have_full_constraints() returned true before the regulator or its consumer 
> supply table is ready, devm_regulator_get() would happily return a dummy 
> regulator and our keyboard would never get its power.
> 
> I'm afraid we have to live with that return code conversion as long as the 
> only user of this driver is not migrated to dt.

OK, fair enough. Can you please add a comment to that effect?

Thanks.

-- 
Dmitry
