Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754643AbeDPJNE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:13:04 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41916 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754556AbeDPJNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:13:02 -0400
X-Google-Smtp-Source: AIpwx48LcevA0mz0FRRMrFDM3J2QL+YMFYJCvYfiEhB11HnxdC8I5M/FGy+fSDVuI2+lLgMFCPkGVw==
Date: Mon, 16 Apr 2018 10:12:57 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Simon Horman <horms@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH RESEND] backlight: pwm_bl: don't use GPIOF_* with
 gpiod_get_direction
Message-ID: <20180416091257.swbt7i6zjfbwysg2@dell>
References: <20180410123241.25745-1-wsa+renesas@sang-engineering.com>
 <20180411073215.fzvh4ejj2kd7wam3@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180411073215.fzvh4ejj2kd7wam3@verge.net.au>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Apr 2018, Simon Horman wrote:

> On Tue, Apr 10, 2018 at 02:32:40PM +0200, Wolfram Sang wrote:
> > The documentation was wrong, gpiod_get_direction() returns 0/1 instead
> > of the GPIOF_* flags. The docs were fixed with commit 94fc73094abe47
> > ("gpio: correct docs about return value of gpiod_get_direction"). Now,
> > fix this user (until a better, system-wide solution is in place).
> > 
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

Thanks for the Reviewed-by Simon.  I have applied it to the original mail.

Do you know why you mail wasn't sent attached to the original thread?
For some reason I received this mail on it's own i.e. not in reply
to the original.

> > ---
> > 
> > Changes since V1:
> > 	* rebased to top-of-linus-tree
> > 	* added tag from Daniel, thanks!
> > 
> > Through which tree does this need to go?
> > 
> >  drivers/video/backlight/pwm_bl.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> > index 1c2289ddd555..0fa7d2bd0e48 100644
> > --- a/drivers/video/backlight/pwm_bl.c
> > +++ b/drivers/video/backlight/pwm_bl.c
> > @@ -301,14 +301,14 @@ static int pwm_backlight_probe(struct platform_device *pdev)
> >  
> >  	/*
> >  	 * If the GPIO is not known to be already configured as output, that
> > -	 * is, if gpiod_get_direction returns either GPIOF_DIR_IN or -EINVAL,
> > -	 * change the direction to output and set the GPIO as active.
> > +	 * is, if gpiod_get_direction returns either 1 or -EINVAL, change the
> > +	 * direction to output and set the GPIO as active.
> >  	 * Do not force the GPIO to active when it was already output as it
> >  	 * could cause backlight flickering or we would enable the backlight too
> >  	 * early. Leave the decision of the initial backlight state for later.
> >  	 */
> >  	if (pb->enable_gpio &&
> > -	    gpiod_get_direction(pb->enable_gpio) != GPIOF_DIR_OUT)
> > +	    gpiod_get_direction(pb->enable_gpio) != 0)
> >  		gpiod_direction_output(pb->enable_gpio, 1);
> >  
> >  	pb->power_supply = devm_regulator_get(&pdev->dev, "power");

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
