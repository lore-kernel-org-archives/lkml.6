Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE61AECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863922054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IALz8g4p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 863922054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbeKAI6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:58:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42915 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbeKAI6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:58:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id y15-v6so18337363wru.9;
        Wed, 31 Oct 2018 16:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=obf+xfPawAwPDxALjQiPU940b/h/axNfdX7vvyvTZJc=;
        b=IALz8g4pqGfnusbGNE6IfplC9aREqlg5R2drvXjQo43ODmgZuwiX6VIAXqVpzEnR7Z
         GNlb0rwkXBuE1rgG+RqOwsjojJrK9YH/BVQ+2RxG3s+5I2sMkAkxyELVwTcpxn6iZzlS
         B6M8ijIa71vGeequbATDDIev0R6xQ1fxNNPy6+BEGd39+90lI38TeccbdiozSdIPXpF+
         3C9/s4b4R4/aTTIJ1cRrJHDVCiZtlsGIbrHFEDddXHQwiEkq7nWoJpyh/50GLb/fF4+v
         PEjhE2UGuAif2k1p1x5dUOcEJ1jHMt6L/ms3wdZAlyOMAE1L+GLw7bTr8JYtBNDXqRen
         vQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=obf+xfPawAwPDxALjQiPU940b/h/axNfdX7vvyvTZJc=;
        b=XzWkmBdes6/jnPg5ADMGqseTq8ClpJgh3h2X5FuyCh9JnYnhaRV6PBr5d9xny//1X4
         k5b0dLVqCnF7EhAm1H8iRcE6HM5Xxv7JpMs6uryzX6RRgSp0hLuTyLS9JLjG2Pym5jW2
         Un+eP+QbOQ50mJfyY7AN10zjFaa9ynlPb7XSXiP6oCqBnfhNAdqcxIx3v/SUPlQGaA+0
         cBPEfuKaTwIJhMhnm9VuSBCjspfMN7HckytBUWVc4IppHoDoinT9kXEcsJ3tCHmEJhE9
         c6tteqYlj/03Y4kMCBRFXl5dwzs0y2TxBZvsgKyUQEi0u4Vjt+Ui0JwqOepSvLHwYr1U
         TlIg==
X-Gm-Message-State: AGRZ1gLwr7igAbf9lNNetBv9UyvX9S+FH//Kt2EFGRyg4JDNt6U1jjvs
        izL3aXCFXjSa7+Ur7waHaSE=
X-Google-Smtp-Source: AJdET5diEI0gmbPCxbYeN9s3T/uecOO79+aDeDRsIAiN5YEmq8Sdo2RrAvga0aeijuv/u2f1XT0gTQ==
X-Received: by 2002:a5d:4a89:: with SMTP id o9-v6mr4935809wrq.132.1541030268747;
        Wed, 31 Oct 2018 16:57:48 -0700 (PDT)
Received: from picard ([194.207.103.1])
        by smtp.gmail.com with ESMTPSA id x186-v6sm14638839wmx.24.2018.10.31.16.57.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 16:57:46 -0700 (PDT)
Date:   Wed, 31 Oct 2018 23:57:45 +0000
From:   Dean Wallace <duffydack73@gmail.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Johannes Stezenbach <js@sig21.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mogens Jensen <mogens-jensen@protonmail.com>
Subject: Re: Regression found (Stop-marking-clocks-as-CLK_IS_CRITICAL)
Message-ID: <20181031235745.ntksedfker4syqbx@picard>
References: <ffc4bcc9-62c3-8940-85d6-d0fd01f3a1b8@linux.intel.com>
 <c8fb730a-c160-41b4-dad0-8ed8594e5687@redhat.com>
 <20181030143836.feo7zcxiestylxoo@picard>
 <2d429c87-24c5-4075-683e-b0d12c3eb1c2@linux.intel.com>
 <d00df762-e4fc-06c5-701e-d5100bfd0e35@redhat.com>
 <e48696f0-aa3e-e20e-d038-9d8dda9cbfce@redhat.com>
 <20181030161534.wk5cf7nxbwhp2far@picard>
 <307c2074-d268-a87a-6040-1240a2091a4d@redhat.com>
 <20181031200709.xrmu6wsdel7dtcjq@picard>
 <da025116-580d-e442-d96f-875282306f1b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <da025116-580d-e442-d96f-875282306f1b@linux.intel.com>
X-Info: Keep It Simple, Stupid.
X-Operating-System: Linux, kernel 4.19.0-arch1-1-ARCH-dirty
X-Message-Flag: WARNING!! Outlook sucks
User-Agent: Every email client sucks, this one just sucks less.
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-10-18, Pierre-Louis Bossart wrote:
> 
> > Just thought it worth mentioning, this new patch that fixes sound
> > again, seems to have ressurected an old issue with PLL unlock.  I'm
> > seeing journal entries after fresh boot ......
> > 
> > ```
> > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > picard systemd[462]: Started Sound Service.
> > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > picard kernel: max98090_pll_work: 141 callbacks suppressed
> > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > ```
> > 
> > sound is ok, but sometimes plugging in headphones spams journal with
> > those PLL messages, and sound turns into "daleks", and I have to
> > remove/insert headphones few times or stop/start audio to fix it.
> > It's a very old issue, maybe you'd know more about it.
> 
> I noticed this error on my Orco device used for tests many moons ago, but I
> could never find out what led to this error case, it wasn't deterministic
> and didn't impact the audio quality. All I could do is rate_limit it... If
> we have an A vs. B situation it'd be really helpful to diagnose further.
> 
> Is there really a causality between the changes from Hans and this PLL
> unlock error? Are you 100% sure this was not present in the previous install
> you used (4.18.14 as mentioned earlier in the thread)?
> 
> Thanks
> 
> -Pierre
> 
Hi Pierre.  I'm not overly bothered by it, I lived with it for a long
time when it was worse pre cht_bsw days.  It's very hit and miss, like
I have just done a few reboots and nothing is coming up in journal and
switching to headphones works fine.  Was quite a frequent issue back
before it was switched to chtmax, but after that, for me anyway, it
was all but nonexistant, apart from a very rare occassion once maybe
twice.  It's always been slightly unstable I guess, but seeing those
messages in journal, something I look at frequently, and not seeing
them for a long time, hmmm.  I'll do some more tests with older kernel
see how it compares and report back.  Then again, I could just ignore
it :)
Regards

-Dean
