Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FB8C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 07:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E326E2145D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 07:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHovr18/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfBEH1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 02:27:40 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:47002 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfBEH1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 02:27:39 -0500
Received: by mail-pl1-f193.google.com with SMTP id o6so1106333pls.13;
        Mon, 04 Feb 2019 23:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=09vU9GczybNRgaHkJ/2vVUQ8J1PSrP2qVLxcnTEEuo0=;
        b=oHovr18/95D1IA5FlJZNvqItiquzMvMJiZ/1BV++qlB2WCJ3xE2WNAeTlC3jGyDPiR
         06GiYbQZsq1W2Lp4I1j4j7Wa43h7QfENeZByo7VMazeeWKDoamyu9kwazXlMAnT7gFju
         bcfJbTMIaaS4TMg5+T8FWMGLHDlEsCty/LK2iZAoxwoJikyxQZGsfFcIdQkzZalV8Ahk
         RtZgxiUU6miYRPkkbeBU/7BKIyH7HKvu5gI1DN/78jYPKgHEXIh7afqbUX5P9W7bw6Qq
         /8hFAtLU6AuOAp5t/Fj6mqmoHHoRu6lqUpDH7qspDcVjrDoQ0WZLW5fjMjVVm/ws/hkk
         mPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=09vU9GczybNRgaHkJ/2vVUQ8J1PSrP2qVLxcnTEEuo0=;
        b=ffeHrvM0SjQFq9AblhqWRoAr84jR4yNOHiXr+9czY3B3V7FM5ErqCuAkj/RX3nAVXV
         A4/7dQRoZ/taNhkjf93kfrnyln6sLPUoej9T6CEHmE/lcwZM2O7eXtT7Ely/gtIpw/WV
         jhUyUpRj4+7G79jGeWf3peijvVy6s+g0LHLRW8LTJA0XknXgSAJ6HsWRe7sfqTcATkPd
         88Xnt76aw6f6+sLCigXUu21EPaQ91dOJ3dkP2e1aqkuZI6rYLtHNjwWeAxlJFmPnJeNg
         hc29mvFFgBa0dbUP/3yJ/fjYCoH7MwCMjy07wdceSXbjVJJZkB+jM9ku7BRSQdqberf+
         jhPg==
X-Gm-Message-State: AHQUAuaGBtyZzeZ7/BamdXSrMPTPjBehFSvudAdeHR2dAGXTyO7t9/ML
        WJhlhs3Ac27AQwAJcVxHxOU=
X-Google-Smtp-Source: AHgI3Ia8JQYMsYrsrQIyl/+579hQcs2vw8EdRFjrrGPF/pNKdbyPxF91yv6VK3S039pMUS7/YxuZoQ==
X-Received: by 2002:a17:902:887:: with SMTP id 7mr3658010pll.164.1549351658446;
        Mon, 04 Feb 2019 23:27:38 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id c4sm2277115pgq.85.2019.02.04.23.27.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 23:27:37 -0800 (PST)
Date:   Mon, 4 Feb 2019 23:27:35 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Richard Leitner <richard.leitner@skidata.com>
Cc:     Joe Perches <joe@perches.com>, mark.rutland@arm.com,
        robh+dt@kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2 8/8] Input: sx8654 - convert #defined flags to
 BIT(x)
Message-ID: <20190205072735.GA24918@dtor-ws>
References: <20181218083606.25795-1-richard.leitner@skidata.com>
 <20181218084002.19454-1-richard.leitner@skidata.com>
 <20190129002518.GH34692@dtor-ws>
 <533e48bd35d360cec8d749f3b70425c1eb5e6e9d.camel@perches.com>
 <50c0a3a5-7039-abc0-9b9e-4314504bcb6f@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50c0a3a5-7039-abc0-9b9e-4314504bcb6f@skidata.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 12:23:01PM +0100, Richard Leitner wrote:
> Hi Joe,
> 
> On 29/01/2019 06:40, Joe Perches wrote:
> > On Mon, 2019-01-28 at 16:25 -0800, Dmitry Torokhov wrote:
> > > On Tue, Dec 18, 2018 at 09:40:02AM +0100, Richard Leitner wrote:
> > > > Some of the #defined register values are one-bit flags. Convert them to
> > > > use the BIT(x) macro instead of 1 byte hexadecimal values. This improves
> > > > readability and clarifies the intent.
> > > > 
> > > > Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> > > 
> > > Applied, thank you.
> > 
> > Not so sure this should be applied.
> > 
> > > > diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchscreen/sx8654.c
> > []
> > > > @@ -46,7 +47,7 @@
> > []
> > > >   /* bits for I2C_REG_IRQSRC */
> > > > -#define IRQ_PENTOUCH_TOUCHCONVDONE	0x08
> > > > -#define IRQ_PENRELEASE			0x04
> > > > +#define IRQ_PENTOUCH_TOUCHCONVDONE	BIT(7)
> > > > +#define IRQ_PENRELEASE			BIT(6)
> > 
> > Shouldn't this be BIT(3) and BIT(2)
> > or did you mean to change the values too?
> > 
> > If so, this change should be noted in the commit message.
> > 
> 
> That's true, those values should stay the same. Thanks for the catch!

Thanks Joe!

> 
> @Dimitry: Should I send an updated version or do you fix it yourself?
> 

I updated the values and pushed out the new version.

Thanks.

-- 
Dmitry
