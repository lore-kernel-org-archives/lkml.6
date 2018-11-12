Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32648C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F015422419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qLP+7DXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F015422419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbeKMCDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:03:41 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40390 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbeKMCDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:03:40 -0500
Received: by mail-pl1-f193.google.com with SMTP id q19-v6so4555081pll.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 08:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pS0vjIpTzOA5EZLYCF/q3ECOenpoLoSToWqBfz9nuG0=;
        b=qLP+7DXGU4d8q9CRBunnySoaT1vK3LYgZP1SNMGy9wAiaOEOQ656DFhEP+FDhlce40
         8HsTgOHGMrsrbszbuv201dqu2oidzJbHYzhcrd48ZdOswkG4Ppa1O2M9+K+9TaPnBuWl
         fFAvvhFoemsWgqWRq54N7QvbaRtM/VDjsxJvrvS4Rb6e+uEc9/9y5YDP6hPctRXee5/s
         iFNrQJ0TghVnsyGyjg+laHoknrGEam1MTSlGzxl2QJaHTMeESU/iOnNZGt1adyslk27A
         ZB/VEKIdI1D2s1FWRGQw3jn/+lW4Y6F1eK8J5qvJMlYsU6IvmKBg2Lx8DWjuYiEqz37i
         gEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pS0vjIpTzOA5EZLYCF/q3ECOenpoLoSToWqBfz9nuG0=;
        b=KEbveSKeb4SZyM6GRlEdNj0miciqMwxOw28HJHX6tgdmtvJ+D0JdGTXIWoDt2XL/L0
         ld/jajmsQn+uUrTKVJDNHuY2C6qO93H5Ad9F/rR2JMQYK0V7Qw6JCYIk5WlAHBVgaWfV
         kkYfS5pr6RsmaQGQxE3PxS3SuHVA401bG/7pFFziFB2LM1BQZ43vsFHUNWp8Moel/M2Q
         JBAzusTIqt3ipuPy6u6HkGcT67HeSzw0b4dSK//2I31eNu12Ghi2YCIdOnJpe9/Lf1vb
         V9Km0iMUHccHIRGH+kqbTqjcF0/2PUwVwKkIwc2eib0eqkiLg5UacXTYM7DPuQ+2E/6r
         niGg==
X-Gm-Message-State: AGRZ1gL1rF8kMtlNjkppV78tGh8WxnwmOgjTlo9OoHwkEctZnUWkG683
        0pFylLvAL5hlWapYdIJsOio=
X-Google-Smtp-Source: AJdET5eLxh7VGqs05BMZ2aslhIe64fB7JB1wSV++3CZMJ2udSe1GTiSB8398E6ji76PhYk8oW6FUAA==
X-Received: by 2002:a17:902:8e8a:: with SMTP id bg10-v6mr1511432plb.214.1542038986889;
        Mon, 12 Nov 2018 08:09:46 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id s9sm7706299pgl.88.2018.11.12.08.09.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 08:09:46 -0800 (PST)
Date:   Mon, 12 Nov 2018 21:39:40 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: arche-apb-ctrl.c: Switch to the gpio
 descriptor interface
Message-ID: <20181112160938.GA5367@nishad>
References: <20181111054405.GA32548@nishad>
 <20181111193651.GA18278@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181111193651.GA18278@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 11:36:51AM -0800, Greg Kroah-Hartman wrote:
> On Sun, Nov 11, 2018 at 11:14:14AM +0530, Nishad Kamdar wrote:
> > Use the gpiod interface instead of the deprecated old non-descriptor
> > interface.
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> >  drivers/staging/greybus/arche-apb-ctrl.c | 158 ++++++++++-------------
> >  1 file changed, 65 insertions(+), 93 deletions(-)
> 
> This patch does not apply to my tree at all :(
> 
> Please rebase and resend, thanks.
> 
> greg k-h

Sorry about that. I'll check and resend.

Thanks for the review.

Regards,
Nishad
