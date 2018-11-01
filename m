Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA37C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27482081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOC++B2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A27482081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbeKATjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 15:39:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36621 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728451AbeKATjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 15:39:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id y16so19579503wrw.3;
        Thu, 01 Nov 2018 03:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k/T9l/sM3HsH2ATw1TRKagfWe7sL2tiFUKym7tVA7EA=;
        b=LOC++B2oG6cTHeeIo0sOACbWWYfeHFWJcZoMf6mQjdcpRlwNVaYCjYvgO8zTCpuHVY
         V7uB5zHWPoUbvyiVV90Mn+TJzahGSgkvtDl95YCxZeY99AM2mv1DcZM8U0fJcsyFBiYr
         fCOcn1ZPAPjNQ1gpvyRYfT5pU4rYynjt4hwCT/nGM48b/IqUaqAt9wVsG24l8srT3Pmx
         jnnR6thno5JUXW+KJAWMvUYPVukq4uWzwDErBPkr6PqVTsC8fQSlJAranRyhAp54jT7e
         tldOIAY3d1HtVOq4AdWbIsPFD+XKfcPiPIsxIjpUEefM0rl99UckHEBcY2z7IbAKSCCq
         LJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k/T9l/sM3HsH2ATw1TRKagfWe7sL2tiFUKym7tVA7EA=;
        b=kUoWT8DnfybhwDChvu869Na4EKduncoPYyh2guEEfr4FHevTRNlU7A9Ye8J1piYcZ1
         EZTB1pcAUL/dn2crnyQ5QWiXB1qR56bobOu/hjQpZsnbN0pFPJUya8SIxmY5aywYDaqb
         9xT7BrTS8n0LwoxmZ9Zyrw1saKNF8/7MCKBEh9KsO+Wzg3A68NvLEMulIh11RtvsafW5
         lWs9tBIDMULr8VvFSgpwq7QWvl+Gk+6oMdvtC9C3K3LYorDL8jKhCuHH9fgaeB1zvJ2n
         yJusLiy06+Osm8YRPYVSs0vQQPYBeuUargt7FEf7iVuqEFxx9HUAMobXS48Nga6eKDNv
         ZX2Q==
X-Gm-Message-State: AGRZ1gJPQvc7rhZJN9HNoiO4aLfNHBgdmm748lMvarhCQz07Bn/2oWeH
        Odcd/rPLtF3kKpcpwsoStrvc23QcRNTZsA==
X-Google-Smtp-Source: AJdET5eEHanD1gDj9+i74zQOCWFtB4CYIBWcDqihiiUhYsd7G7RYyF0w7WSVrGW5xM8vvSKVN5rrpw==
X-Received: by 2002:adf:fa04:: with SMTP id m4-v6mr6137943wrr.155.1541068628210;
        Thu, 01 Nov 2018 03:37:08 -0700 (PDT)
Received: from picard ([194.207.103.1])
        by smtp.gmail.com with ESMTPSA id w17-v6sm3242468wmc.39.2018.11.01.03.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 03:37:06 -0700 (PDT)
Date:   Thu, 1 Nov 2018 10:37:05 +0000
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
Message-ID: <20181101103705.ay36te4qr5pxtgop@picard>
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
X-Operating-System: Linux, kernel 4.18.14-arch1-1-ARCH
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
Well, numerous boots, kernels, headphone inserting - no PLL or
'Daleks'.  My laptop must have been haunted that day (halloween).
I'll put it to bed.

-- 
Dean
