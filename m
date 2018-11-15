Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D5DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F81B21582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqxS16D3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F81B21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388512AbeKPDeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:34:21 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37009 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387839AbeKPDeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 22:34:20 -0500
Received: by mail-pf1-f196.google.com with SMTP id u3-v6so7332326pfm.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 09:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6KAH6hpxqNo/XCTd6VP0DGaycQ+9mc1Oro5HXxV0M7I=;
        b=FqxS16D3p5logDoEcYTOt5kJwRyL2GuOZnhpeObeT4E9Y/37mcClPtubNEGOSgpMPn
         USDl4zHMKTCMNBLZyIjoegNHX++E23/mIo5fHsVEcpIAD8SWfIG95twXQvGA7hX8qSQT
         D32/vuCvBhxEnLx+DaxS3RNi1/3se7fT0YzuoQbjhs9L2aafKmVW/ZeVMLCbuZaZb4wA
         qZeILjl160FGrc8+ntezT6eMY35sePHIYtFNdfcrNbX/giSvfLh5vMxgR/e6pdT5Lk/R
         xbG5wfGtj7W5W079exUh1w8OPQyBTwQxlr2pIhbt2+j80DzSXmygQ61YoposN9gKFp1P
         tisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6KAH6hpxqNo/XCTd6VP0DGaycQ+9mc1Oro5HXxV0M7I=;
        b=IIC43vZsO5/Ad4tZ67v/gUmhJ9AF3D0CB9RRhdssFeBx9jx2dubWvCUSqpKc5gMMfk
         Tmvzy8zCK9N8M/1MnF6pemuoWCtJyGGvCUMqCU3DdLxRKG86IJzEQ+JWLSuMzBUUQuLf
         Z6sWcTPEQYxNhJdxwlupxRo9R7HYhm86YUHRYYpwvoKrygzn61A4TEql4I6D9Vmwh5Tr
         Rw/kwg+1X2VRoJJJFpbtoucK0wkMZtghvhDKPj/UhWmJogLH1knaZhNMZ7u327oFzxni
         9+/izboPSiENopYXKuN94oTECsJ5O/+1+tIP3lZkds+dEb+v6JhtHtMW7ryforb+Ka2L
         kUvQ==
X-Gm-Message-State: AGRZ1gLg9nGmxKIFlty9mfkWS5fWorbtBv5MO2Q2c1reLCbouHwjGR8a
        fdKEZZETR5+uuUIbPW5sWf4=
X-Google-Smtp-Source: AJdET5dhh3gwN49k69MITdqyJKi7/5Vb9efXeQloYNtmoEtCcROUvPh4Zvsld7Q9Pr/eDNQpDFxTcA==
X-Received: by 2002:a62:65c3:: with SMTP id z186-v6mr7492306pfb.206.1542302737908;
        Thu, 15 Nov 2018 09:25:37 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 11-v6sm38418814pfr.55.2018.11.15.09.25.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 09:25:36 -0800 (PST)
Date:   Thu, 15 Nov 2018 09:25:35 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: Default SERIAL_OF_PLATFORM to SERIAL_8250
Message-ID: <20181115172535.GA26922@roeck-us.net>
References: <20181115011125.GA32556@roeck-us.net>
 <29E7A6C0-7829-4650-93C6-7220FECAA6EF@gmail.com>
 <20181115053836.GA7606@roeck-us.net>
 <27ed27d3-220e-963f-7d2c-64df10421580@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27ed27d3-220e-963f-7d2c-64df10421580@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 09:19:14AM -0800, Florian Fainelli wrote:
> 
> 
> On 11/14/2018 9:38 PM, Guenter Roeck wrote:
> > On Wed, Nov 14, 2018 at 07:56:47PM -0800, Florian Fainelli wrote:
> >>
> >>
> >> On November 14, 2018 5:11:25 PM PST, Guenter Roeck <linux@roeck-us.net> wrote:
> >>> On Thu, Nov 01, 2018 at 11:26:06AM -0700, Florian Fainelli wrote:
> >>>> It is way too easy to miss enabling SERIAL_OF_PLATFORM which would
> >>>> result in the inability for the kernel to have a valid console
> >>> device,
> >>>> which can be seen with:
> >>>>
> >>>> Warning: unable to open an initial console.
> >>>>
> >>>> and then:
> >>>>
> >>>> Run /init as init process
> >>>> Kernel panic - not syncing: Attempted to kill init!
> >>> exitcode=0x00000100
> >>>>
> >>>> Since SERIAL_OF_PLATFORM already depends on SERIAL_8250 && OF there
> >>>> really is no drawback to defaulting this config to the value of
> >>>> SERIAL_8250.
> >>>>
> >>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>>
> >>> This patch results in situations where CONFIG_SERIAL_OF_PLATFORM is now
> >>> defined where it was not previously. Example mpc85xx_defconfig. This in
> >>> turn results in boot failures for those configurations, with an error
> >>> message of
> >>>
> >>> of_serial: probe of e0004500.serial failed with error -22
> >>>
> >>> which wasn't seen before.
> >>
> >> Do you know which Device Tree is being used here? The most obvious thing that could be done is to add a !PPC condition but this might be missing other platforms doing their own 8250 registration yet being OF aware (sparc?).
> >>
> >>>
> >>> Not sure if replacing a potential problem with a real one is really an
> >>> improvement.`
> >>
> >> That comment is not particularly helpful though I have an appreciation for when a change breaks things in unexpected ways and how frustrating that can be.
> > 
> > Actally, never mind. I dropped the test cases. Sorry for the noise.
> 
> Why? The tests are useful, if I gave you an impression that I was just
> going to walk away from this issue and not look at it, then that is not
> happening. What I was objecting to is your qualification of the issue,
> this is unfortunately not a potential/latent problem, it happens more
> often than not.
> 

I ended up adding a flag to my builders which remove the offending
configuration for affected platforms/configurations, so this is no longer
an issue for my build tests.

Guenter
