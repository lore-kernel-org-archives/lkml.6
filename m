Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A4DC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4432064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYo54SDu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4432064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbeKBACO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:02:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45737 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbeKBACO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:02:14 -0400
Received: by mail-wr1-f65.google.com with SMTP id n5-v6so20341439wrw.12;
        Thu, 01 Nov 2018 07:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1yYQgweBmd+LLPRmIKCZ/aDnJBAyOlWQmxelwoswz7A=;
        b=LYo54SDujVHmrcxTQ6HJvmbfHmIHxfMYaJtqVzOWbpV3o55IjFUKY3gg3hQFpe5Zz4
         joGTM0kp9pmjIu6MoA5emHCSwyZbR0SXowwxVFlX7HQABpfxX8GN063x727+KQAw6BW9
         UFuj6JsmTOR/d+6PoEkFN3ATcST4tWhDDhGuhcyheT3PAx6qvo9dXoTibjQ9TTeEL5nL
         TCCM7msbO2nC5ZNX2v8qZXwPrR2m525D/Ho1hORD3iLlQxO7D11prPoESipmENNUovFg
         1/BoRHyDAyXelUIrNGPHflq/v/npEYCxIacLW+UP/4NwPTQTwUzlppASDOxQlpEIWhGW
         yh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1yYQgweBmd+LLPRmIKCZ/aDnJBAyOlWQmxelwoswz7A=;
        b=NgX7scbyB4lZUT8luCAFqFKhfXn9csK4KXsQzb+eBPA4GbtXPY9tj8smJEpV38P5e3
         PaJLUfPwlq8wXVWkJ1wh0yaXLpt26OkmmQxjBs1enyPRVj5dku5UpOg9q2FtU11EBVDw
         hv/pROxYT97/XQjeJ/sZzZvVY2DJYmrlZZDv6107EUSik0SdqloJy6fri1mLoGifSv2s
         /Dls5AE3bqEPsr1w1wkJ8S+c+JgCV5T0ZhJwL5m5foyLRlp25NazME6SyjqHroPkjkjl
         8rcl/S98L9p50PqfOjC8AhyYxejNSJOR/TA15PXM2At6XTfFj0eVtkUA4pR1v/p8XxK2
         L+bQ==
X-Gm-Message-State: AGRZ1gKqxUnQiCNDzbjj9cN6lpqVuPeyby18et5WIoP8Pc1wnvVnP+B+
        p5gpul/KB8QPG6brXc/U0pjqNxvIi2PTAg==
X-Google-Smtp-Source: AJdET5cUrEJq5yH5uYo+Lo4hT/P7N9klYJOAzRLsThdn3yaWhEp+WBSWvi2TO0Pkx8qVeBq7l9bZ1g==
X-Received: by 2002:adf:83a4:: with SMTP id 33-v6mr6712666wre.13.1541084333425;
        Thu, 01 Nov 2018 07:58:53 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id 134-v6sm23006407wmp.6.2018.11.01.07.58.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 07:58:52 -0700 (PDT)
Date:   Thu, 1 Nov 2018 07:58:50 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] pinctrl: lpc18xx: Use define directive for
 PIN_CONFIG_GPIO_PIN_INT
Message-ID: <20181101145850.GA13794@flashbox>
References: <20181101005257.8778-1-natechancellor@gmail.com>
 <0af2686f-3d9a-3ca6-e5c2-2955ffbd8bd5@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0af2686f-3d9a-3ca6-e5c2-2955ffbd8bd5@mentor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 10:52:14AM +0200, Vladimir Zapolskiy wrote:
> Hi Nathan,
> 
> thank you for your patch.
> 
> On 11/01/2018 02:52 AM, Nathan Chancellor wrote:
> > Clang warns when one enumerated type is implicitly converted to another:
> > 
> > drivers/pinctrl/pinctrl-lpc18xx.c:643:29: warning: implicit conversion
> > from enumeration type 'enum lpc18xx_pin_config_param' to different
> > enumeration type 'enum pin_config_param' [-Wenum-conversion]
> >         {"nxp,gpio-pin-interrupt", PIN_CONFIG_GPIO_PIN_INT, 0},
> >         ~                          ^~~~~~~~~~~~~~~~~~~~~~~
> > drivers/pinctrl/pinctrl-lpc18xx.c:648:12: warning: implicit conversion
> > from enumeration type 'enum lpc18xx_pin_config_param' to different
> > enumeration type 'enum pin_config_param' [-Wenum-conversion]
> >         PCONFDUMP(PIN_CONFIG_GPIO_PIN_INT, "gpio pin int", NULL, true),
> >         ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ./include/linux/pinctrl/pinconf-generic.h:163:11: note: expanded from
> > macro 'PCONFDUMP'
> >         .param = a, .display = b, .format = c, .has_arg = d     \
> >                  ^
> > 2 warnings generated.
> > 
> > It is expected that pinctrl drivers can extend pin_config_param because
> > of the gap between PIN_CONFIG_END and PIN_CONFIG_MAX so this conversion
> > isn't an issue. Most drivers that take advantage of this define the
> > PIN_CONFIG variables as constants, rather than enumerated values. Do the
> > same thing here so that Clang no longer warns.
> > 
> > Link: https://github.com/ClangBuiltLinux/linux/issues/140
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/pinctrl/pinctrl-lpc18xx.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pinctrl/pinctrl-lpc18xx.c b/drivers/pinctrl/pinctrl-lpc18xx.c
> > index a14bc5e5fc24..4bee606088e1 100644
> > --- a/drivers/pinctrl/pinctrl-lpc18xx.c
> > +++ b/drivers/pinctrl/pinctrl-lpc18xx.c
> > @@ -631,13 +631,10 @@ static const struct pinctrl_pin_desc lpc18xx_pins[] = {
> >  };
> >  
> >  /**
> > - * enum lpc18xx_pin_config_param - possible pin configuration parameters
> >   * @PIN_CONFIG_GPIO_PIN_INT: route gpio to the gpio pin interrupt
> >   * 	controller.
> >   */
> > -enum lpc18xx_pin_config_param {
> > -	PIN_CONFIG_GPIO_PIN_INT = PIN_CONFIG_END + 1,
> > -};
> > +#define PIN_CONFIG_GPIO_PIN_INT		(PIN_CONFIG_END + 1)
> >  
> >  static const struct pinconf_generic_params lpc18xx_params[] = {
> >  	{"nxp,gpio-pin-interrupt", PIN_CONFIG_GPIO_PIN_INT, 0},
> > 
> 
> The change, if it is applied, starts to produce a W=1 warning:
> 
> 	drivers/pinctrl/pinctrl-lpc18xx.c:634: warning: Cannot understand  * @PIN_CONFIG_GPIO_PIN_INT: route gpio to the gpio pin interrupt on line 634 - I thought it was a doc line
> 
> Could you please take a look how to satisfy process_name() check from scripts/kernel-doc?
> 
> My proposals are:
> 1) change the first line of the comment block from '/**' to '/*',
> 2) remove '@' prefix symbol and place pinconf description on one line.
> 
> --
> Best wishes,
> Vladimir

Hi Vladimir,

Thank you for the review! I will go ahead and send a v2 with that fixed.

Nathan
