Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D170C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF0321473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DsqqKKpw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731132AbfA3MuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 07:50:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34309 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfA3MuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 07:50:11 -0500
Received: by mail-wr1-f66.google.com with SMTP id f7so26018712wrp.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 04:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CLa5JjFpyyfV+TUYzZT4J1fIb+syO/uBxi2+fYGp6HI=;
        b=DsqqKKpwvtKOarGMQyGVugys2g9ZnrVYJBb375EiGHm2FTwYv8koWIFd9YD/Q/rL5p
         YZPGl8CcSysKoe3WdbrZcgGEi1EN0OdZyvvtZyb61nFgP9wUi9tO3bSOn/tqXJHRG8FU
         X4+0mvGKHrYJl5L14iynCZmCe09vIw/nLWh0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CLa5JjFpyyfV+TUYzZT4J1fIb+syO/uBxi2+fYGp6HI=;
        b=Wqyi5wrm4JMz0hrdysNxeTRXFl6IvzMVp+KUYfm8s05WHF2vkMI2UcEXsOXELcWS5m
         QuBpzTaGkclTT32UC+WKbFlcOAxToDhKZ8ABGQNqR2ak9HmqHRfZzqzrUkzuqb9M4q83
         NK3JdEDJNPALoC1wFvQ1yY6QmFUeLfqejruepU3gTokBdeRQmVp21IQGsz3F9yhHRFTR
         UhJwqO50mSSMSA13S1MxLCw+XihCO9MMzP7D+X+8AUxGWkwDETji/XMlBNgZ9bxvdaPM
         3JCwphdJJViXQrHyfUVv3iKDdD6BCzqvmlrrajmjCjfyFWiKsDONP+XcJF4/jXUfTwNo
         XybA==
X-Gm-Message-State: AJcUukci9P+8rjVEVW8t1P7wNIXYOrZxMkJiEQ60mdn2+Vk6Yy+eI2R5
        1FvN5UN4nDtdStV3fO7ctYsHcA==
X-Google-Smtp-Source: ALg8bN5T1Hy3+ZyNezR4q0xnUrJZWJJm361lBi49JtQZL2JAUkJHSf0eiIcIMhKmFmQjFD+lip9wHg==
X-Received: by 2002:adf:c042:: with SMTP id c2mr31105985wrf.158.1548852609225;
        Wed, 30 Jan 2019 04:50:09 -0800 (PST)
Received: from dell ([2.27.35.198])
        by smtp.gmail.com with ESMTPSA id 125sm2649363wmm.26.2019.01.30.04.50.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 04:50:08 -0800 (PST)
Date:   Wed, 30 Jan 2019 12:50:07 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     linux-kernel@vger.kernel.org,
        Emeric Dupont <emeric.dupont@zii.aero>
Subject: Re: [PATCH v3] mfd: tqmx86: IO controller with i2c, wachdog and gpio
Message-ID: <20190130125007.GA4701@dell>
References: <1547250965-17668-1-git-send-email-andrew@lunn.ch>
 <20190129113532.GB24070@dell>
 <20190129205652.GF13334@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190129205652.GF13334@lunn.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019, Andrew Lunn wrote:

> On Tue, Jan 29, 2019 at 11:35:32AM +0000, Lee Jones wrote:
> > On Sat, 12 Jan 2019, Andrew Lunn wrote:
> > 
> > > The QMX86 is a PLD present on some TQ-Systems ComExpress modules. It
> > > provides 1 or 2 I2C bus masters, 8 GPIOs and a watchdog timer. Add an
> > > MFD which will instantiate the individual drivers.
> > > 
> > > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > > ---
> > > v2:
> > > 
> > > Drop setting i2c bus speed, which removes the build dependencies on
> > > the i2c ocores patches. This can be added back later.
> > > 
> > > v3
> > > --
> > 
> > You're going to have to resend this.
> > 
> > Mailers tend to use '--\n' to signify the start of the mail signature
> > (see mine as an example), so when someone (myself included) attempts
> > to reply to the mail, it is likely that their mailer will chop
> > everything from there down.
> 
> Hi Lee
> 
> I posted a new version.
> 
> Your email indicates you are using Mutt:
> 
> >User-Agent: Mutt/1.9.4 (2018-02-28)
> 
> Which is also what i use. I've never had issues with signatures like
> this. I also cannot find any documentation as to how you configure
> mutt remove signatures. How are you doing it?

I think it's automatic.  I certainly didn't set that up.

I see my signature was not included in your reply.  Did you manually
remove it?  Try replying to your own mail.  I should automatically
cut.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
