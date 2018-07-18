Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FD5ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ADB02075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OAA4qLua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ADB02075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbeGROTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:19:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42971 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731143AbeGROTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:19:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id e7-v6so4736349wrs.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 06:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gb+pLow3sAMG/+PfNYvDstkm1RNF523qewEMo+QvMyI=;
        b=OAA4qLuauuwzXyT3HuVnACeznC/iKPoCMLBIOlyqxamZEni5eFecUykkXuG7qguR93
         bY2hbTq2/veCD1YdIoB4aiSymjlktyDwDHsdff3bvpjpehbGPNKe9+x3ppR7rz7beWsz
         yWIbEVlv6q84MP7MQBF2CGHufojNhNAuSLzdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gb+pLow3sAMG/+PfNYvDstkm1RNF523qewEMo+QvMyI=;
        b=djY9WGNVSHfeCG5WDm9MNBwekmpYc2yAyXzeTogLGKvzqr0bqV09q7pGpTyaKZ8iiy
         CYpc+i6bwabCznZTSoEJ40fMGT9DiLO06vUgcIFHDaond1ju3HiwbRrqLdYlb9McCj2D
         X/LWxFX/jcAIF1IA/+FDv21nL/3jSKQ+FpizZuwf/FMFdSC2q4jRlzMe7tnK8WQWnYLM
         7jWsFAxh77OW/Guop9DdlxnZb8Q1BA4thtxxVtgluJQHi/dGfIi+MR1fWF2HKWxCA8ZG
         AiREMyz9RoocyETPHQNRi98iQXmxiUFqP+O8ADN2cdYmRKruAedFnzqj5cYpwOZ2JGV/
         IaPQ==
X-Gm-Message-State: AOUpUlES4/FCpiP8Hygof8xh9/KaJz0LobsbBgfNTtmbUtfkw1C4+IT5
        deRLT3mMxANGGi5sA/yHKuDCaQ==
X-Google-Smtp-Source: AAOMgpdJCtaTJp5RAzoRJVbAsZ5fFnjeDc3OLHlEVlFHp6Y9c08DxHWCJgL7sE3CmrX/5yNvM2lvbA==
X-Received: by 2002:adf:afd3:: with SMTP id y19-v6mr4907002wrd.176.1531921267146;
        Wed, 18 Jul 2018 06:41:07 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id b123-v6sm4482197wma.24.2018.07.18.06.41.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 06:41:06 -0700 (PDT)
Date:   Wed, 18 Jul 2018 14:41:03 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
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
Message-ID: <20180718134103.bgwpgk7l6joxtjoa@holly.lan>
References: <20180716210241.9457-1-daniel.thompson@linaro.org>
 <20180718080913.GB4641@dell>
 <1531902119.16896.13.camel@toradex.com>
 <20180718095335.GD4641@dell>
 <20180718101227.shqf54wpt4kdrsj2@holly.lan>
 <1531918626.16896.22.camel@toradex.com>
 <20180718130853.GE4641@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718130853.GE4641@dell>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 02:08:53PM +0100, Lee Jones wrote:
> > > > > No, then we are back to the initial issue of num_steps
> > > > > potentially not
> > > > > being initialised. We really want both of_property_read_u32() to
> > > > > succeed AND num_steps to actually be set.
> > > > 
> > > > I also think num_steps should be pre-initialised.
> > 
> > Yes, I guess it definitely does not hurt.
> > 
> > > > Then it will only be set if of_property_read_u32() succeeds.
> > 
> > Yes, but we still need to check for both, the function not failing and
> > num_steps to actually be non zero.
> 
> Why?  You don't do anything differently if it fails.

Only if you initialize num_steps...

We should either initialize to zero and not worry about the return
code[1] or we check the return code and not worry about
initialization[2]. I don't think both are worthwhile.

Whilst initialization can fix this specific instance we generally avoid
overusing it since it messes up static analysis and, in this instance,
distance from declaration to use is >25 lines, hence current patchset.


Daniel.


[1] https://lkml.org/lkml/2018/7/16/399
[2] https://lkml.org/lkml/2018/7/16/1042

Or...

We check the return code and leave number

num_steps is uninitialized and stack allocated so it only has a valid
value if of_property_read_u32() succeeds.

We can (and I originally did) fix the bug by initializing num_steps to 0
but its quite some distance between declaration and use so I accepted
Marcel's counter proposal to check the return code instead.


Daniel.
