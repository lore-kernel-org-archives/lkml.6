Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAE9C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81624205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXvXaaT3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81624205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbeKAXcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:32:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41103 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbeKAXcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:32:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id x12-v6so20279981wrw.8;
        Thu, 01 Nov 2018 07:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HyhLaazR2P04yWxB+5xP47WyoiBrADPA9X3iHNC4ZBw=;
        b=SXvXaaT3CdywFFptMxThDoxbbikMpW6fZ8rWYU7wSsLuhquYhTyGCi6jPs1MRdwZz/
         4ADvb7E50/zycqGJIBlLiva38OXDS5Uw4qc5HMNsavn+eyK0XGQFIL+6WNYCxY2CvKRb
         0KonLosQ6WDob0i7m16xC7f1YlREPDeY0dd3mXlT8mb+OAyJhrezotxDtONIg549CTlo
         EgWfO/LtrXpo4xruoi8faUyzikW6gQyym5fA9SU7lROCZ/gG2MihHVitMJ8uR0q4MD5+
         xT1cuUPpNQnJdaoCtRgk2VPpWX+xl7+2kqQjszjea+KnAsUviWAleouQ74JxhKUl2Htz
         sZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HyhLaazR2P04yWxB+5xP47WyoiBrADPA9X3iHNC4ZBw=;
        b=K9MvVWuzR7PYIPBMvk8cuciwC+s4REtv0h3EY8XEv0vueK3jaIzxdo+YuVuSs85ltg
         puSz/b4bkhLjTo9pHHlhVmiJsHD+IHdgUW3WS8UlovT5fe2JJ/3FNUgrYAJRldb0MyF2
         84tzhxpfLh5v2B0Z4qNWldwwjb91RP2eManLessRVWGxdyvdUg1Kot7eikNReaBiDJbF
         rwFxoa5dTXW+G+StfGIFq/oMTZ/xZY25sx4Amicnl/4h6rmSRzXOvPFnf22zJtPe17It
         t2mjN808i/YcwYrrkrj0MlqzuOE4kpnhGrpfkazRVUSe5tV45i+xj8FF76ETugSDyTK9
         iDQg==
X-Gm-Message-State: AGRZ1gKW+i2U7vWpzvUr0kKM1coPYYDsolwvoWnGT4rSCQQhLG24X7cP
        lkREKz4xs0BLrZJ8D/3hV08=
X-Google-Smtp-Source: AJdET5eQY2AjBtYXDzBkb8Dod7CKNp4TaUkn6P+RlIEf69WxYkWCOhRStkBxHtFULRYfU73A6/W56A==
X-Received: by 2002:a5d:4a89:: with SMTP id o9-v6mr7223669wrq.132.1541082542254;
        Thu, 01 Nov 2018 07:29:02 -0700 (PDT)
Received: from picard ([194.207.103.1])
        by smtp.gmail.com with ESMTPSA id i7-v6sm36545509wmd.41.2018.11.01.07.28.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 07:29:00 -0700 (PDT)
Date:   Thu, 1 Nov 2018 14:28:59 +0000
From:   Dean Wallace <duffydack73@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
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
Message-ID: <20181101142859.oxtuhbwtt44h2u3r@picard>
References: <20181030143836.feo7zcxiestylxoo@picard>
 <2d429c87-24c5-4075-683e-b0d12c3eb1c2@linux.intel.com>
 <d00df762-e4fc-06c5-701e-d5100bfd0e35@redhat.com>
 <e48696f0-aa3e-e20e-d038-9d8dda9cbfce@redhat.com>
 <20181030161534.wk5cf7nxbwhp2far@picard>
 <307c2074-d268-a87a-6040-1240a2091a4d@redhat.com>
 <20181031200709.xrmu6wsdel7dtcjq@picard>
 <da025116-580d-e442-d96f-875282306f1b@linux.intel.com>
 <20181101103705.ay36te4qr5pxtgop@picard>
 <37e44480-44d3-9355-6119-ae46bb38678a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <37e44480-44d3-9355-6119-ae46bb38678a@redhat.com>
X-Info: Keep It Simple, Stupid.
X-Operating-System: Linux, kernel 4.18.14-arch1-1-ARCH
X-Message-Flag: WARNING!! Outlook sucks
User-Agent: Every email client sucks, this one just sucks less.
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-11-18, Hans de Goede wrote:
> Hi,
> 
> On 01-11-18 11:37, Dean Wallace wrote:
> > On 31-10-18, Pierre-Louis Bossart wrote:
> > > 
> > > > Just thought it worth mentioning, this new patch that fixes sound
> > > > again, seems to have ressurected an old issue with PLL unlock.  I'm
> > > > seeing journal entries after fresh boot ......
> > > > 
> > > > ```
> > > > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > > > picard systemd[462]: Started Sound Service.
> > > > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > > > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > > > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > > > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > > > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > > > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > > > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > > > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > > > picard kernel: max98090_pll_work: 141 callbacks suppressed
> > > > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > > > ```
> > > > 
> > > > sound is ok, but sometimes plugging in headphones spams journal with
> > > > those PLL messages, and sound turns into "daleks", and I have to
> > > > remove/insert headphones few times or stop/start audio to fix it.
> > > > It's a very old issue, maybe you'd know more about it.
> > > 
> > > I noticed this error on my Orco device used for tests many moons ago, but I
> > > could never find out what led to this error case, it wasn't deterministic
> > > and didn't impact the audio quality. All I could do is rate_limit it... If
> > > we have an A vs. B situation it'd be really helpful to diagnose further.
> > > 
> > > Is there really a causality between the changes from Hans and this PLL
> > > unlock error? Are you 100% sure this was not present in the previous install
> > > you used (4.18.14 as mentioned earlier in the thread)?
> > > 
> > > Thanks
> > > 
> > > -Pierre
> > > 
> > Well, numerous boots, kernels, headphone inserting - no PLL or
> > 'Daleks'.  My laptop must have been haunted that day (halloween).
> > I'll put it to bed.
> 
> So you can no longer reproduce. Bummer. Note this might be caused by
> the temperature of the laptop when you were running the tests...
> 
> Anyways if you hit this again and you can reproduce it, please
> give adding a msleep(10) after code mucking with the clk a try.
> 
> Regards,
> 
> Hans
> 
Right then, I can make it unlock and 'daleks' by going into
pavucontrol and switching the Profile back and forth from Stereo
Output to Stereo Output+Analog Mono Input, which is actually something
I've done to make it correct itself as well.  I don't use the mic or
anything so I've had it set to Stereo Ouput only which I 'think' has
somehow made it more stable for me.  With all my playing around, one
of the things I did was clean out my .config/pulse folder which meant
by default the 'Profile' in pavucontrol was set to Output+Input, which
seems to help trigger the PLL issue when inserting headphones.

So what would you like me to do, as I can trigger it on demand it
seems.
-- 
Dean
