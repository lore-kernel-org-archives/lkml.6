Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A52ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9FF2064D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UZqavJ2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A9FF2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731304AbeGRQeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:34:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36260 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731098AbeGRQeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:34:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id h9-v6so5214445wro.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 08:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=csqUbP1KwHBS9PwgM+IAIRMhDTPo7tGbU1S4wTpvUSk=;
        b=UZqavJ2to3CrKSc06I41A7YLt7P5bnmmsVifSJypQllWuIZZciyf+OOg6nfbcim8LU
         hUYvbAxGgIT10+OmfT8uMSaMKel3Y7UNms5STqwySN1OLs/iIX4FCmb2VT40P2i61X0p
         CygW99FApbDwwEtWpHo23Qpoc5JRazpyPfGAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=csqUbP1KwHBS9PwgM+IAIRMhDTPo7tGbU1S4wTpvUSk=;
        b=taElHr3CkyTatoT/OK632Hxk/X8Fxtt8Lp/WgrpDSTULMvhEbBvYmjzMQaFlheoSoJ
         cPcCfx7mp9Nji070hXYxOcBFuse2j66Heu5Lk0hBviDGJRjSUidVmP9plz6xHe6gWmKQ
         xoZ4BIVH44kOa7d05VPRTFvASUKBaHHEToOwTkOxoSQqGEXfnx2BX4RWEC5Ti2kab3+r
         ps1GBh9uKwlT2APuLCK+HP1utxnhpax5YXrRZzQlDzocI9G4/TtNHOO/cYH1ZVCeFlkO
         qq4LOF7zuqabgE7Ji4tWcre3EHMUp9SQr/97tfsWDfq/zVgjK8Oi2NDShzhF8z8ZM9Sf
         lLXA==
X-Gm-Message-State: AOUpUlFzqZkxczEJ9vjFZLh/AKP3OzHssF4wXxp/gJu0qiHsfQc/+ah+
        clxtdzUqlXcFd9bMXZgFj58K6w==
X-Google-Smtp-Source: AAOMgpeSfriL9L62XrLiRaUZpeRkNyfWgHooTHgsR39EqpYS+6vT030CEId1OGixiVYDNv5I7oaF+A==
X-Received: by 2002:adf:a3d6:: with SMTP id m22-v6mr4966134wrb.1.1531929347709;
        Wed, 18 Jul 2018 08:55:47 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id 31-v6sm7278258wra.26.2018.07.18.08.55.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 08:55:46 -0700 (PDT)
Date:   Wed, 18 Jul 2018 16:55:44 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "patches@linaro.org" <patches@linaro.org>
Subject: Re: [PATCH] backlight: pwm_bl: Fix uninitialized variable
Message-ID: <20180718155544.GF4641@dell>
References: <20180716210241.9457-1-daniel.thompson@linaro.org>
 <20180718080913.GB4641@dell>
 <1531902119.16896.13.camel@toradex.com>
 <20180718095335.GD4641@dell>
 <20180718101227.shqf54wpt4kdrsj2@holly.lan>
 <1531918626.16896.22.camel@toradex.com>
 <20180718130853.GE4641@dell>
 <20180718134103.bgwpgk7l6joxtjoa@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180718134103.bgwpgk7l6joxtjoa@holly.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jul 2018, Daniel Thompson wrote:

> On Wed, Jul 18, 2018 at 02:08:53PM +0100, Lee Jones wrote:
> > > > > > No, then we are back to the initial issue of num_steps
> > > > > > potentially not
> > > > > > being initialised. We really want both of_property_read_u32() to
> > > > > > succeed AND num_steps to actually be set.
> > > > > 
> > > > > I also think num_steps should be pre-initialised.
> > > 
> > > Yes, I guess it definitely does not hurt.
> > > 
> > > > > Then it will only be set if of_property_read_u32() succeeds.
> > > 
> > > Yes, but we still need to check for both, the function not failing and
> > > num_steps to actually be non zero.
> > 
> > Why?  You don't do anything differently if it fails.
> 
> Only if you initialize num_steps...
> 
> We should either initialize to zero and not worry about the return
> code[1] or we check the return code and not worry about
> initialization[2]. I don't think both are worthwhile.
> 
> Whilst initialization can fix this specific instance we generally avoid
> overusing it since it messes up static analysis and, in this instance,
> distance from declaration to use is >25 lines, hence current patchset.
> 
> 
> Daniel.
> 
> 
> [1] https://lkml.org/lkml/2018/7/16/399
> [2] https://lkml.org/lkml/2018/7/16/1042
> 
> Or...
> 
> We check the return code and leave number
> 
> num_steps is uninitialized and stack allocated so it only has a valid
> value if of_property_read_u32() succeeds.
> 
> We can (and I originally did) fix the bug by initializing num_steps to 0
> but its quite some distance between declaration and use so I accepted
> Marcel's counter proposal to check the return code instead.

Only checking the return value of of_property_read_u32() is also
suitable.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
