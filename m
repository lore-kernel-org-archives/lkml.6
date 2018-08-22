Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FFDC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 07:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7D12147A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 07:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHToCtYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD7D12147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbeHVLBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 07:01:00 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37145 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeHVLBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 07:01:00 -0400
Received: by mail-lf1-f66.google.com with SMTP id j8-v6so707784lfb.4;
        Wed, 22 Aug 2018 00:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a9VCxUC2by57cuvYI6iL2Kjjlr/iuJhElG1A2aAAsTs=;
        b=gHToCtYHk+elba6KDcmqy5DqPt3w7m+Ln2+STpBo9QPgOJjbf7E5wQ9IPAdcpfLHgW
         tJkYFYBOIiVwbg5ljAAl1/qvXH6F7NNTSV3yCfoa5+nViC8m+u6eXYA3cDp3NbTKxIuQ
         HiqPoP/gPQ7BxMMxV11aqOJWGsn93S8wQPtvf+nmKvf/mhw4zVdidiWrIyFvRHkcx/zT
         tWjWqdcpYsfVD/x6f1VAabOMzE3rOtK0evSU2JSnwHUKslwvZLyekzifoY179FB94JKv
         labYte5JYl1Um2y3cXRd8Gn+T47RgmaZ2jyiBRFHqLoW1ODatX57LgrQXGazSGk5sJrn
         +Jnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=a9VCxUC2by57cuvYI6iL2Kjjlr/iuJhElG1A2aAAsTs=;
        b=EpLQ0pj1zA6cNwtmpSYRZkskwQYmg9yG2aVeQ4cgrLBwDoG1g06mYinOQx+FdoP5lW
         9ZBweRkEdO464XX1eQEjgHoRVUmaIEfYWiT5nMumjdBRhxHaJ5iaGHoYmc5k8t/7fqP/
         N3XUUARxE/Lh3hYGLu7aA23Hz8Mav1o5mP8ot+/pNxqIBNefoVr6TX6RtJGQ8IgOMWyC
         PNxBAwcnslie6RUOub4EIhiCGs57dMDPTpy0tVah8Ih+UApQeYjLZVm7y8/xapWLACay
         2W30PJq10+IIBPeFfzA7ZQgAxPSlBzZhx4y80yOiehw6mBeXlJjDfL9j4RvCeAy75FYU
         0D0g==
X-Gm-Message-State: AOUpUlFN/cpn+JpjyX+66wl+VD5ByO1V3y0WxlsdEsypLJcHvQNh50b5
        N8FnLBuCemITDJGnyQefElsxiawd
X-Google-Smtp-Source: AA+uWPxJ5iumQBH1VoCiQJEX/94SvPfJsGIfffTV0ksIiBXm6tpunGH0MzyJGzNg+1PAW+fwxZZPpg==
X-Received: by 2002:ac2:50c7:: with SMTP id h7-v6mr8630362lfm.47.1534923438502;
        Wed, 22 Aug 2018 00:37:18 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id h11-v6sm156497ljf.27.2018.08.22.00.37.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 00:37:17 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fsNhf-0007qo-97; Wed, 22 Aug 2018 09:37:19 +0200
Date:   Wed, 22 Aug 2018 09:37:19 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Keerthy <j-keerthy@ti.com>
Cc:     tony@atomide.com, d-gerlach@ti.com, linux-kernel@vger.kernel.org,
        t-kristo@ti.com, ssantosh@kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] soc: ti: pm33xx: Enable DS0 for the platforms on which
 it is functional
Message-ID: <20180822073719.GL14967@localhost>
References: <1534915951-8783-1-git-send-email-j-keerthy@ti.com>
 <20180822073409.GK14967@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822073409.GK14967@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 09:34:09AM +0200, Johan Hovold wrote:
> On Wed, Aug 22, 2018 at 11:02:31AM +0530, Keerthy wrote:
> > Enable DS0 for only those platforms on which it is functional
> > 
> > Signed-off-by: Keerthy <j-keerthy@ti.com>
> > ---
> >  arch/arm/mach-omap2/pm33xx-core.c    | 5 +++++
> >  drivers/soc/ti/pm33xx.c              | 9 +++++++++
> >  include/linux/platform_data/pm33xx.h | 2 ++
> >  3 files changed, 16 insertions(+)
> > 
> > diff --git a/arch/arm/mach-omap2/pm33xx-core.c b/arch/arm/mach-omap2/pm33xx-core.c
> > index f4971e4..f0f6e8e 100644
> > --- a/arch/arm/mach-omap2/pm33xx-core.c
> > +++ b/arch/arm/mach-omap2/pm33xx-core.c
> > @@ -135,6 +135,11 @@ static int am43xx_suspend(unsigned int state, int (*fn)(unsigned long),
> >  {
> >  	int ret = 0;
> >  
> > +	if (!(args & WFI_FLAG_DEEP_SLEEP0)) {
> > +		pr_err("DS0 mode not supported\n");
> > +		return -ENOTSUPP;
> > +	}
> > +
> >  	amx3_pre_suspend_common();
> >  	scu_power_mode(scu_base, SCU_PM_POWEROFF);
> >  	ret = cpu_suspend(args, fn);
> > diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
> > index d0dab32..53238d7 100644
> > --- a/drivers/soc/ti/pm33xx.c
> > +++ b/drivers/soc/ti/pm33xx.c
> > @@ -324,6 +324,15 @@ static int am33xx_pm_probe(struct platform_device *pdev)
> >  	suspend_wfi_flags |= WFI_FLAG_SAVE_EMIF;
> >  	suspend_wfi_flags |= WFI_FLAG_WAKE_M3;
> >  
> > +	/*
> > +	 * Deep Sleep0 mode is currently functional only on am437x-gp-evm,
> > +	 * am33xx-evm and boneblack family. Hence set the DS0 flag
> > +	 */
> > +	if (of_machine_is_compatible("ti,am437x-gp-evm") ||
> > +	    of_machine_is_compatible("ti,am335x-bone-black") ||
> > +	    of_machine_is_compatible("ti,am335x-evm"))
> > +		suspend_wfi_flags |= WFI_FLAG_DEEP_SLEEP0;
> 
> What about other (out-of-tree) machines which supports DS0 and which
> this change would break?
> 
> I think this needs to be a blacklist if anything.
> 
> Please also expand in the commit message why you think this is needed.
> 
> Last, what tree is this against? There's no am43xx_suspend() in
> linux-next (and you add compatibles above for am33xx too).

Sorry, there is indeed an am43xx_suspend(), but you are adding
compatibles for am33xx which use am33xx_suspend().

Johan
