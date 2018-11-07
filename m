Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D421C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 08:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FEA2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 08:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rRTompHP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0FEA2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbeKGSYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 13:24:32 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37138 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbeKGSYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 13:24:31 -0500
Received: by mail-wm1-f67.google.com with SMTP id p2-v6so14874488wmc.2;
        Wed, 07 Nov 2018 00:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZhIDeR1uQeuaXJX9jsPmuv4vShXcHELuy1glYh09DqY=;
        b=rRTompHPXxJljnV0IYuzaXXyMuOuBgLu9nzF2BqMBUqA124M7kNYJTRPY7ItEH/V//
         Yitj6q8rIUzfqVljLdg358Xtw48p+vVEWbYl9rcLlL1113/U7Ehy3EhQzQJu0IVI6rvb
         ZAnCp7P3UiaBkqcmDnl7IHB2AOuhGuQ976Zop2SgYeEpfE8nP8SyZwgYUy5yHkLjYJ4Y
         VkK6Cx5PTY22vmNLLrx46cgZT3Au/FaOGIxnuJFb67rVyskAWm2fAJ5pZHBBE7wzblRA
         hXoGQGSXGxAMp6P/FV4AWm5FXopJj0iFHSVtlk3QRlVD221M0Of2dgNkX6FzhicJrwy8
         jN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZhIDeR1uQeuaXJX9jsPmuv4vShXcHELuy1glYh09DqY=;
        b=T1y/HbZLGTlD30l+DBOEyLckUXh39yA3nDJ0Ng0MRnX588GKe0ywpkDqzkyLlWeHon
         nLQYCV3EjAuNjBIaUFuZEknYDgBycp1Ut3lig1E70JDQBBnNn/Cseg7AId2NH6liTH6K
         dPCWZVNEvXPz7EPWhAxtipN71MI29ROw5ZlcozrArHDw8tteu/7ZDE5zeXR5Li7Gv0/W
         XCzsLbc5SSuqVE4O7kdUhBny9MiVxWyQWeUJoEIqGJysbaWQMAXZEskbIqLuuVENvpYz
         4i554m2lY5LGUGEgiG1UgFkrz4I+soLMotyrdq4HZJQbr2RdoRJEVVBuaJMAc1eJUEE2
         epFw==
X-Gm-Message-State: AGRZ1gI5t1Zyfp9nmmIDtfUnEyzRNWXKF0AW1l2ix5I7K6MtC3h/6n8n
        YrxNbqHk5InformxgXYz+gELzhPgtz8=
X-Google-Smtp-Source: AJdET5cl+wT4KefSkBoRkYrxesypAy4ff0ImpBvVaHtfsKA6ri0Iho5m5BXXCXDARHivJsuYHoExNQ==
X-Received: by 2002:a1c:6c09:: with SMTP id h9-v6mr1161307wmc.131.1541580905945;
        Wed, 07 Nov 2018 00:55:05 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id z17-v6sm18850931wrm.65.2018.11.07.00.55.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 00:55:05 -0800 (PST)
Date:   Wed, 7 Nov 2018 01:55:03 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] pinctrl: zynq: Use define directive for
 PIN_CONFIG_IO_STANDARD
Message-ID: <20181107085503.GA31517@flashbox>
References: <20181101005724.9622-1-natechancellor@gmail.com>
 <68ae935a-aec3-915c-bfe6-d69bfb93d702@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68ae935a-aec3-915c-bfe6-d69bfb93d702@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 09:46:12AM +0100, Michal Simek wrote:
> On 01. 11. 18 1:57, Nathan Chancellor wrote:
> > Clang warns when one enumerated type is implicitly converted to another:
> > 
> > drivers/pinctrl/pinctrl-zynq.c:985:18: warning: implicit conversion from
> > enumeration type 'enum zynq_pin_config_param' to different enumeration
> > type 'enum pin_config_param' [-Wenum-conversion]
> >         {"io-standard", PIN_CONFIG_IOSTANDARD, zynq_iostd_lvcmos18},
> >         ~               ^~~~~~~~~~~~~~~~~~~~~
> > drivers/pinctrl/pinctrl-zynq.c:990:16: warning: implicit conversion from
> > enumeration type 'enum zynq_pin_config_param' to different enumeration
> > type 'enum pin_config_param' [-Wenum-conversion]
> >         = { PCONFDUMP(PIN_CONFIG_IOSTANDARD, "IO-standard", NULL, true),
> >             ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ./include/linux/pinctrl/pinconf-generic.h:163:11: note: expanded from
> > macro 'PCONFDUMP'
> >         .param = a, .display = b, .format = c, .has_arg = d     \
> >                  ^
> > 2 warnings generated.
> 
> This is interesting. I have never tried to use llvm for building the
> kernel. Do you have any description how this can be done?
> 

Depending on what version of Clang you have access to, it is usually just as
simple as running 'make ARCH=arm CC=clang CROSS_COMPILE=arm-linux-gnueabi-'.

Clang 7.0+ is recommended but 6.0 might work too.

> 
> > 
> > It is expected that pinctrl drivers can extend pin_config_param because
> > of the gap between PIN_CONFIG_END and PIN_CONFIG_MAX so this conversion
> > isn't an issue. Most drivers that take advantage of this define the
> > PIN_CONFIG variables as constants, rather than enumerated values. Do the
> > same thing here so that Clang no longer warns.
> > 
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/pinctrl/pinctrl-zynq.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pinctrl/pinctrl-zynq.c b/drivers/pinctrl/pinctrl-zynq.c
> > index a0daf27042bd..57046c221756 100644
> > --- a/drivers/pinctrl/pinctrl-zynq.c
> > +++ b/drivers/pinctrl/pinctrl-zynq.c
> > @@ -972,14 +972,11 @@ enum zynq_io_standards {
> >  };
> >  
> >  /**
> > - * enum zynq_pin_config_param - possible pin configuration parameters
> 
> This is wrong. kernel-doc is reporting issue with it.
> 
> drivers/pinctrl/pinctrl-zynq.c:975: warning: Cannot understand  *
> @PIN_CONFIG_IOSTANDARD: if the pin can select an IO standard, the
> argument to
>  on line 975 - I thought it was a doc line
> 1 warnings
> 

Ah yes, I forgot to send a v2 of this patch when someone pointed out
this problem in a different patch. I'll send that now, thanks for the
review!

> 
> >   * @PIN_CONFIG_IOSTANDARD: if the pin can select an IO standard, the argument to
> >   *	this parameter (on a custom format) tells the driver which alternative
> >   *	IO standard to use.
> >   */
> > -enum zynq_pin_config_param {
> > -	PIN_CONFIG_IOSTANDARD = PIN_CONFIG_END + 1,
> > -};
> > +#define PIN_CONFIG_IOSTANDARD		(PIN_CONFIG_END + 1)
> >  
> >  static const struct pinconf_generic_params zynq_dt_params[] = {
> >  	{"io-standard", PIN_CONFIG_IOSTANDARD, zynq_iostd_lvcmos18},
> > 
> 
> This change is fine.
> 
> Thanks,
> Michal
