Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA2AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1EB20652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxWo0xtr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfAQNQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:16:06 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38071 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfAQNQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 08:16:05 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so10976487wrw.5;
        Thu, 17 Jan 2019 05:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vO0u/ighJu9/Pgld8XWvcp25uFZhyw/lMVsD9ojHRh8=;
        b=kxWo0xtrN4S9G9SG3QB8h/KJn3nNYrHG2n8GN743BJqSe9Kk5yq8MkvUaabJKwGpWt
         kkFZQyCNVyIr2jVYJg5ZfeYb2xSRM9QR/9T4c9JEne7vrcDK/dNrdL8i9Icvw/1UNSi/
         /n2L2EyrpBfr7e9IrNMCzrZ2FwR7bYiXl/8fad+nFarRtF1P8uZIBdWBpY8SAHwLnXMW
         5z0Bc6A8OYjyJFWfsODzvK5k8zpMO6SKuyNwJ3WJ0ta3iLBKM0DDskaC0ln+ROildl+z
         Kioa/gFBOMph4VUQEySfPiDNkhKkilYrxR4x91oIbmgRFJza4lS8yGw6mDL1DoRm/pqm
         f9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vO0u/ighJu9/Pgld8XWvcp25uFZhyw/lMVsD9ojHRh8=;
        b=JhTQhCS7Lap23FdEa2e9/QYuLJfWZR0mdYEnvl9onrEs2n2Vi3l0/2y9an5L46daiF
         bnem8Jx5o/lAgUVxjp3bNLLQDVmWrJP26MahHQLQyFoHC+6p2Jjs4Ul4c119Ab8lh4lm
         HukuYAsuSkRfc2t3b7raO8ILRblKsDqtceDqql+70bLC+hEHW5u8tfaBpdRUWDEHnX2O
         88VGLZYllJ0ckdbA8/97yA74tyH04+y+MAQ7IB9iY8L3PMNQHoDYSv6Zyq7QWNTxQx2y
         iaY170qMo2aj9VFP9KS7ZuuK4qby+xgZAthIr1IAoatuub8G1ZQMBWXsLCOWsHkknZQ0
         a3fA==
X-Gm-Message-State: AJcUukePdZfVdVNFkiyGjV0Z+cKnY2k3p/0tQaXauQaDRE3kpM3yIb8c
        2BVC4033R+DBP3/eqovR+rU=
X-Google-Smtp-Source: ALg8bN5jE5ei3NdujAOhSwy2ncQ0ixXP4RHKHTQReyRtYx+sNO7w3afFtTuqcfpN6cmsA2Pt9ddlcw==
X-Received: by 2002:adf:ea11:: with SMTP id q17mr11550698wrm.328.1547730963253;
        Thu, 17 Jan 2019 05:16:03 -0800 (PST)
Received: from spock ([194.207.103.1])
        by smtp.gmail.com with ESMTPSA id k3sm117499926wrm.7.2019.01.17.05.16.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 05:16:02 -0800 (PST)
Date:   Thu, 17 Jan 2019 13:16:01 +0000
From:   Dean Wallace <duffydack73@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mogens Jensen <mogens-jensen@protonmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Johannes Stezenbach <js@sig21.net>,
        Carlo Caione <carlo@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Regression found (Stop-marking-clocks-as-CLK_IS_CRITICAL)
Message-ID: <20190117131601.qlkdk6tqznyr2s7x@spock>
References: <e48696f0-aa3e-e20e-d038-9d8dda9cbfce@redhat.com>
 <BaxBOBmUCld7THAnRIDXUpKq8uQ2oJ49EaNlq0mZ11gFjA5JjhbfhVouLZGc1q74PrQC6uGfddKklIP059D_DtQwBqK-sn9rd4xEPhW9E6s=@protonmail.com>
 <d53738e1-4ba5-640e-7ef7-1705ab205061@redhat.com>
 <kAuINEBUUnlS5_uJafGtvryMEJVkDO4pb_yLfClwMcTS1h3sB1gYPcXBvg9X3RINfp5Uch7kLXuhTRX_JtouTYxoS6xNr77_b46e-mugl3k=@protonmail.com>
 <b8849ae1-5a38-e7a1-da14-dc7f9d164825@redhat.com>
 <3iO9ehQbZm_haTV0IuZ0qhsVHR0QLUbTgRJT8ZenGuRsnz2_uBvO93f0bHVYnsApibUT16JsJ0dgphLhUBd-u0t-lDBNsbvvlKWTgq8XOlw=@protonmail.com>
 <3e12e051-b874-187d-d4f5-e146f59c659b@redhat.com>
 <U9ny3qDg8fEQ-IaXWgwAmDf_U7yb1NZxpwoOvTorCbG86v8wUae3kWsa5omAv-ngu3VMaSONp6RdzmaI26Cz6uoyf5ddIiXuJQbzGf2MN3w=@protonmail.com>
 <20190117091214.7djttnpo4jjzi4su@spock>
 <c935552f-951f-ab9f-b41c-76c729c6d85c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c935552f-951f-ab9f-b41c-76c729c6d85c@redhat.com>
X-Info: Keep It Simple, Stupid.
X-Operating-System: Linux, kernel 4.20.3-arch1-1-max98090
X-Message-Flag: WARNING!! Outlook sucks
User-Agent: Every email client sucks, this one just sucks less.
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-01-19, Hans de Goede wrote:
> Mogens, Dean, can you please try the SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
> driver, without reverting any patches, with the attached patch on top and
> see if that helps?

Hi Hans.   Just compiled 4.20.3 with your new patch and no other
patches.  First impressions are, this is now as stable as it has ever
been in my experiences with this baytrail drama.  A quick run down on my
tests/findings:-

No PLL messages on boot, good.
Played audio using mpd, all fine.  Plugged in headphones, switches,
stays stable, no messages.
Unplugged/plugged again few times, no issues.
Ran pavucontrol, stayed stable, no messages.
I can still make it lose the lock and turn on the dalek distortion by
switching profiles in pavucontrol (from stereo output to any other, like
putput + input) but that has always been the case afaik for this
machine.  So basically this is now back to working as it was before the
4.18.5 'clk' breakage.

One thing to mention, I don;t normally use UCM files, tho I have in the
past, which is where I assume my asound.state file has come from, which
makes my sound work /shrug.  Well I've just tested using the UCM, and
things are a little less stable regarding plugging/unplugging headset a
few times.  It loses lock, but, what's different now is after maybe 3-4
seconds it corrects itself.  Not sure if it matters, but shows things
are a little more stable with this patch than previously known.

I'll test a little longer and report (if) any problems.  It will be
interesting to see how my buddy who uses headset/mic a lot gets on, as
he needs to use usb audio device because internal sound and mic don't
work properly.

-Dean
