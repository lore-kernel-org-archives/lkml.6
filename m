Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E732C6786F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 565982082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rQ1CluB0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 565982082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbeKBUWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 16:22:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45551 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeKBUWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 16:22:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id n5-v6so1565484wrw.12;
        Fri, 02 Nov 2018 04:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=H5gjf2b363bjsYcwOfjSvwIxzvDH6Obt1DJWqED7bk0=;
        b=rQ1CluB0pG0uqrL2cf7RHvE/syLbry5eaecF+EbgvlqO48uwLstB5R61zHHDKFiYAK
         G0+yYQuHCZDMSy/VruKyoQRqxf23cg3BukoRy3SGWTJJf+ElJV1/wxeP8p/yEAYN+pln
         5m8I/XUQ+utK5NmH50wxI+sLs7DypSyM3KtWz0gOg3u/ex1ww2Z5GNvxoQ95jSpaa6Ze
         rU+HnhR7HDQlc1iROvLfsnUwGJvB/zJGdFCWSGmwe3VEteA+uLEMe1ojZj6Kq/LZlmyS
         0eJwSdsjspqdTNC+wW/g7VuExgZc0c6idnj8vF8xaFPAXrRl4leSoidIl2VgwMcHL4Ls
         ugBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=H5gjf2b363bjsYcwOfjSvwIxzvDH6Obt1DJWqED7bk0=;
        b=tc834sgsCkuGj+q6jOcgYgr3XCONXMxQ47Q/y9CSZBccTfGRns0plpeGTzy18gKHcC
         xkYQr6KZ0+gpSFgriEksPSXmhu6RhG7GahViVVqZt6nqIaacffGz1Pomx1nkP+TGDRON
         AJisjv2R+ePHtUcngZnCxVYte4RdKtcAFayWH4Kid0a+oIlgiqrcF49H/XQfyk/a9DrD
         lpXbOKyqAq5aGeb70pVc12Grv8Re+CAO1yQ9B/eSGgkrkVevD91lSrmsD9wl8PD4V6KT
         zRy91RV29iwP95fRgE1pylNZGTurxO8bTXOUepJlky4t8CqBZAXFOa+K9qbv3uT5ioUV
         y9JQ==
X-Gm-Message-State: AGRZ1gKMI6L4EFPreiPnT8pBU5R6pP5mhEIjvbJ3flsv7qhUdayiSbWz
        /m+v7H8BinRlIO7LGDFRgEA=
X-Google-Smtp-Source: AJdET5eUdhXwXG2UHowq81I+D4/jywrBBWB1g3ZLDuffmFl8dhpTyBkkslq9lWPBicAvq0vGko3P0Q==
X-Received: by 2002:a5d:4b8b:: with SMTP id b11-v6mr8302099wrt.72.1541157361845;
        Fri, 02 Nov 2018 04:16:01 -0700 (PDT)
Received: from picard ([194.207.103.1])
        by smtp.gmail.com with ESMTPSA id o4-v6sm24968645wrj.45.2018.11.02.04.15.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 04:16:00 -0700 (PDT)
Date:   Fri, 2 Nov 2018 11:15:58 +0000
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
Message-ID: <20181102111558.lw67jfyhfneqzhl4@picard>
References: <20181030161534.wk5cf7nxbwhp2far@picard>
 <307c2074-d268-a87a-6040-1240a2091a4d@redhat.com>
 <20181031200709.xrmu6wsdel7dtcjq@picard>
 <da025116-580d-e442-d96f-875282306f1b@linux.intel.com>
 <20181101103705.ay36te4qr5pxtgop@picard>
 <37e44480-44d3-9355-6119-ae46bb38678a@redhat.com>
 <20181101142859.oxtuhbwtt44h2u3r@picard>
 <67a7d54b-49cc-aa4e-fe47-bb6277f02bc8@redhat.com>
 <20181101155036.vkdrc7ajmkyd73o5@picard>
 <685e6291-7064-af8d-1211-72796d880f5b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <685e6291-7064-af8d-1211-72796d880f5b@redhat.com>
X-Info: Keep It Simple, Stupid.
X-Operating-System: Linux, kernel 4.19.0-arch1-1-ARCH-dirty
X-Message-Flag: WARNING!! Outlook sucks
User-Agent: Every email client sucks, this one just sucks less.
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-11-18, Hans de Goede wrote:
> Hi,
> 
> On 01-11-18 16:50, Dean Wallace wrote:
> > On 01-11-18, Hans de Goede wrote:
> > > Hi,
> > > 
> > > On 01-11-18 15:28, Dean Wallace wrote:
> > > > On 01-11-18, Hans de Goede wrote:
> > > > > Hi,
> > > > > 
> > > > > On 01-11-18 11:37, Dean Wallace wrote:
> > > > > > On 31-10-18, Pierre-Louis Bossart wrote:
> > > > > > > 
> > > > > > > > Just thought it worth mentioning, this new patch that fixes sound
> > > > > > > > again, seems to have ressurected an old issue with PLL unlock.  I'm
> > > > > > > > seeing journal entries after fresh boot ......
> > > > > > > > 
> > > > > > > > ```
> > > > > > > > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > > > > > > > picard systemd[462]: Started Sound Service.
> > > > > > > > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > > > > > > > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > > > > > > > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > > > > > > > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > > > > > > > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > > > > > > > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > > > > > > > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > > > > > > > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > > > > > > > picard kernel: max98090_pll_work: 141 callbacks suppressed
> > > > > > > > picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> > > > > > > > ```
> > > > > > > > 
> > > > > > > > sound is ok, but sometimes plugging in headphones spams journal with
> > > > > > > > those PLL messages, and sound turns into "daleks", and I have to
> > > > > > > > remove/insert headphones few times or stop/start audio to fix it.
> > > > > > > > It's a very old issue, maybe you'd know more about it.
> > > > > > > 
> > > > > > > I noticed this error on my Orco device used for tests many moons ago, but I
> > > > > > > could never find out what led to this error case, it wasn't deterministic
> > > > > > > and didn't impact the audio quality. All I could do is rate_limit it... If
> > > > > > > we have an A vs. B situation it'd be really helpful to diagnose further.
> > > > > > > 
> > > > > > > Is there really a causality between the changes from Hans and this PLL
> > > > > > > unlock error? Are you 100% sure this was not present in the previous install
> > > > > > > you used (4.18.14 as mentioned earlier in the thread)?
> > > > > > > 
> > > > > > > Thanks
> > > > > > > 
> > > > > > > -Pierre
> > > > > > > 
> > > > > > Well, numerous boots, kernels, headphone inserting - no PLL or
> > > > > > 'Daleks'.  My laptop must have been haunted that day (halloween).
> > > > > > I'll put it to bed.
> > > > > 
> > > > > So you can no longer reproduce. Bummer. Note this might be caused by
> > > > > the temperature of the laptop when you were running the tests...
> > > > > 
> > > > > Anyways if you hit this again and you can reproduce it, please
> > > > > give adding a msleep(10) after code mucking with the clk a try.
> > > > > 
> > > > > Regards,
> > > > > 
> > > > > Hans
> > > > > 
> > > > Right then, I can make it unlock and 'daleks' by going into
> > > > pavucontrol and switching the Profile back and forth from Stereo
> > > > Output to Stereo Output+Analog Mono Input, which is actually something
> > > > I've done to make it correct itself as well.  I don't use the mic or
> > > > anything so I've had it set to Stereo Ouput only which I 'think' has
> > > > somehow made it more stable for me.  With all my playing around, one
> > > > of the things I did was clean out my .config/pulse folder which meant
> > > > by default the 'Profile' in pavucontrol was set to Output+Input, which
> > > > seems to help trigger the PLL issue when inserting headphones.
> > > > 
> > > > So what would you like me to do, as I can trigger it on demand it
> > > > seems.
> > > 
> > > Please give the attached patch a try (on top of my patch for the clk quirk)
> > > and let us know if that fixes these errors.
> > > 
> > > Regards,
> > > 
> > > Hans
> > > 
> > Sorry, it's not being consistent with me  Now, fresh boot again, no errors
> > in journal, no errors while plugging/unplugging earphones.  I think it's
> > definitely more stable with the profile in pavucontrol set to Output
> > only (no + Input), but I can still trigger it by switching it, and it
> > never corrects itself until I switch a few more times.
> 
> Ok, so there are 2 issues here as I see it:
> 
> 1) It does not always reproduce
> 2) It does still reproduce sometimes with the patch, so the patch does not
> fix it.
> 
> So I think we just have to live with this for now.
> 
> Regards,
> 
> Hans
>
Yeah, I've never known it act any different so I'm used to it.  I do
know a few people in the past who have just bought a usb sound device
because they want to use a mic as well, and that just didn't work
quite right for them, even if sound output worked they had issues as
soon as they tried using mic.  I forget which, 4.1 or 4.4, 1 guy
mentioned still using it just because output/input worked flawlessly.
¯\_(ツ)_/¯

-Dean
