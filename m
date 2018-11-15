Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8CEC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3602087A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTgzcmyA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F3602087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbeKOPpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 10:45:02 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32795 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbeKOPpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 10:45:01 -0500
Received: by mail-pf1-f193.google.com with SMTP id v68-v6so9131939pfk.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 21:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vci6yHtscyCB8IsZ8fX1au55mpo0QlRWMX5IB0rSF0M=;
        b=XTgzcmyAJA6/PonF+kEaiFnYF1Eo58FkuJeSV5Srx3cQG+/Im8rVtUeJ2LEguoVP2P
         3w9bRIr8hRfu/9GdypvOsjY7BbDHtzBX/apHj4DY88hgs2zQi7ZcYbne48XZ4/wrxYZA
         lVcMIgBOQ0Scn9Bq0Qk96rcQLbq5WeKjk0lh9+XO8REGGoWq1G6MSVmgv3rRYH5DylFp
         V2je0QVU2AsICnclsnHc2PC3QQzPE90OltrH+K8T1mqTjYvEj46f2eqHB/7LrUe1cZMD
         F/aD4vqKPruXPwX3VVfI7m+3toGVmiN1VAA6wiJqQ+EQjZeu+hVuNnVxbDbhHY6a1XLm
         nbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vci6yHtscyCB8IsZ8fX1au55mpo0QlRWMX5IB0rSF0M=;
        b=U7sImbW8sasOWy3Xs0r6Mu475HEeVO1fyHewsaFqx8BgmOuMGE4iJnV56b2p6jNoLH
         n8yeTLCDj1SY5BoPFKiyZ87OOwEMLCW9F4hqOjKDaoOIGYvANeyYxghi2dPpEFtOxCVK
         JNjWpNb3gLUK+uR+474p5wHaRuqCSEzFNtJE4+LweQfNKUCJdGH9wbkXbj0C7LJ2hPQ0
         uLBSV6qzDo4FK2ah+UnzlS0m6vJUMRQwbWr/Tv97PRISt/3AeQ0+WZKEfE+NbhsXeikZ
         rkQ4lw73ESOCWQW16ftAuQl92TGYk1XCJ/EYKPkLeyxI6FOtICQpi0qKRE1sSoQewZDx
         UlAA==
X-Gm-Message-State: AGRZ1gK5eNufeYoNOxppX7OT0qNsNolGxFvPjY36RtD64+IJN3fxjY3W
        TB46xPW/mnRolt1pJnFw1c98NjQIe/Q=
X-Google-Smtp-Source: AJdET5dI9D2j+aIRBI0ahf9SUcL3Sb3RG/8UTfXvwlk/NM6tKiTxCTlRMb4vJZTNYBBOG/u0fuDStA==
X-Received: by 2002:a65:6645:: with SMTP id z5mr4582167pgv.351.1542260318164;
        Wed, 14 Nov 2018 21:38:38 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u7-v6sm16134178pfu.34.2018.11.14.21.38.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 21:38:37 -0800 (PST)
Date:   Wed, 14 Nov 2018 21:38:36 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: Default SERIAL_OF_PLATFORM to SERIAL_8250
Message-ID: <20181115053836.GA7606@roeck-us.net>
References: <20181115011125.GA32556@roeck-us.net>
 <29E7A6C0-7829-4650-93C6-7220FECAA6EF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29E7A6C0-7829-4650-93C6-7220FECAA6EF@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 07:56:47PM -0800, Florian Fainelli wrote:
> 
> 
> On November 14, 2018 5:11:25 PM PST, Guenter Roeck <linux@roeck-us.net> wrote:
> >On Thu, Nov 01, 2018 at 11:26:06AM -0700, Florian Fainelli wrote:
> >> It is way too easy to miss enabling SERIAL_OF_PLATFORM which would
> >> result in the inability for the kernel to have a valid console
> >device,
> >> which can be seen with:
> >> 
> >> Warning: unable to open an initial console.
> >> 
> >> and then:
> >> 
> >> Run /init as init process
> >> Kernel panic - not syncing: Attempted to kill init!
> >exitcode=0x00000100
> >> 
> >> Since SERIAL_OF_PLATFORM already depends on SERIAL_8250 && OF there
> >> really is no drawback to defaulting this config to the value of
> >> SERIAL_8250.
> >> 
> >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> >This patch results in situations where CONFIG_SERIAL_OF_PLATFORM is now
> >defined where it was not previously. Example mpc85xx_defconfig. This in
> >turn results in boot failures for those configurations, with an error
> >message of
> >
> >of_serial: probe of e0004500.serial failed with error -22
> >
> >which wasn't seen before.
> 
> Do you know which Device Tree is being used here? The most obvious thing that could be done is to add a !PPC condition but this might be missing other platforms doing their own 8250 registration yet being OF aware (sparc?).
> 
> >
> >Not sure if replacing a potential problem with a real one is really an
> >improvement.`
> 
> That comment is not particularly helpful though I have an appreciation for when a change breaks things in unexpected ways and how frustrating that can be.

Actally, never mind. I dropped the test cases. Sorry for the noise.

Guenter
