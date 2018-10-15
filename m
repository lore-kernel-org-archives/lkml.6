Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721EBC71133
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6512089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gxIj2DdH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6512089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeJPAyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:54:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44987 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbeJPAyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:54:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id 63-v6so22192619wra.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 10:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dh+I41dhmOIbT1OIEBdjr5aoOYlS8O6tWmG6ePE8p7k=;
        b=gxIj2DdH85G1Z6agbRWN6ImiFkRDodnIcAG+pWkRESplybBADvSodDg3qMB1RtYbpV
         tl+om52DA0gJluwBf3ONn3Ar0LhmPN7kvFbKp6NNw+ofhHkavLZyx03P4O14dy+Gkf+E
         Ci83VkExtQMaF3263E1G9iUrWA4Zsc3y/1MeNHBlO03LXpL+V20bEMVPoZVmBv2RKWW1
         f0bhDBTsLfAR8+VSD886PcUXj7MAqlqLzNgKoxfvGvKlnZF2d4DKqYqkWzHMdNZxEXRV
         XzbjplGAHPQ5Dab68J8cFtFVOMHWgYYpRsf1xxkfhUbLheDZDCJqoyC42z2kbum8OtO/
         aZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dh+I41dhmOIbT1OIEBdjr5aoOYlS8O6tWmG6ePE8p7k=;
        b=FTh6noR8bxPn0Krht8S7EiCAppS5oPn323ZjcfbS6dLktrOJncPp3FXM0eqOUaTpQs
         rbODDyQaXGdu141GZ9SYKqD9A8QGMpsQGGl5ezQnfrX0mkXecdr9FCS9JMYiXBIH8tn5
         pq/QyC7whSWyQUX6rXIk0YX/xwBuNvIvBkBBEZHh8Kb3yarvJ1w1PdSpMQP+bkm4kBA5
         CbhnZyLU1sa5BeK6A6rcT+P1FFlhvFAqgdrdGEbf502oQVr7LeJ5TEwOx2EF8PSB0Tec
         JUpr2ygm2a3Rjro/9ftGc7CgeEKtv4XoIbzZuQIOlNI2BMV1B6XXz6exIgNUlIOHqYKQ
         e6nw==
X-Gm-Message-State: ABuFfojRv6lX718MeqO7Hk4zMR7tHY/UfiNQXhAYxXgExgQvVlgmBhF/
        D0UhebOn9BV8T8+6vykNZjutAW/UpuI=
X-Google-Smtp-Source: ACcGV63WvDro8j9wJ3io4RG63DgnxBzgyEjabpAC9sTZQLmPMCLqqP3AGn90jook31wF7pp8Q0+YBw==
X-Received: by 2002:adf:e752:: with SMTP id c18-v6mr16689379wrn.143.1539623281428;
        Mon, 15 Oct 2018 10:08:01 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b14-v6sm10499846wrp.42.2018.10.15.10.08.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 10:08:00 -0700 (PDT)
Message-ID: <ed6a889eeec4e2809f0840c9e8188b5e4b24fa76.camel@baylibre.com>
Subject: Re: [PATCH] clk: meson-gxbb: set fclk_div3 as CLK_IS_CRITICAL
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 15 Oct 2018 19:07:59 +0200
In-Reply-To: <20181013160810.88481.14237@resonance>
References: <1539425086-10997-1-git-send-email-christianshewitt@gmail.com>
         <20181013160810.88481.14237@resonance>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-10-13 at 18:08 +0200, Michael Turquette wrote:
> Quoting Christian Hewitt (2018-10-13 12:04:46)
> > On the Khadas VIM2 (GXM) and LePotato (GXL) board there are problems
> > with reboot; e.g. a ~60 second delay between issuing reboot and the
> > board power cycling (and in some OS configurations reboot will fail
> > and require manual power cycling).
> > 
> > Similar to 'commit c987ac6f1f088663b6dad39281071aeb31d450a8 ("clk:
> > meson-gxbb: set fclk_div2 as CLK_IS_CRITICAL")' the SCPI Cortex-M4
> > Co-Processor seems to depend on FCLK_DIV3 being operational.
> > 
> > Bisect gives 'commit 05f814402d6174369b3b29832cbb5eb5ed287059 ("clk:
> > meson: add fdiv clock gates") between 4.16 and 4.16-rc1 as the first
> > bad commit. This added support for the missing clock gates before the
> > fixed PLL fixed dividers (FCLK_DIVx) and the clock framework which
> > disabled all the unused fixed dividers, thus it disabled a critical
> > clock path for the SCPI Co-Processor.
> > 
> > This change simply sets the FCLK_DIV3 gate as critical to ensure
> > nothing can disable it.
> 
> I'm a bit skeptical of this. If FCLK_DIV3 is gated at run-time, there is
> no side effect other than long and/or failed reboot?
> 
> Seems like someone should be managing this clock, and simply leaving it
> on all the time isn't necessarily the right approach. Any chance that
> you can dig into this behavior to better understand it?
> 
> It's easy to solve issues by leaving clocks on all the time, but this
> becomes a problem later on when trying to tune a device for power.

Hi Mike,

I totally agree with you and, in perfect a world, I would prefer not to use this
CLK_IS_CRITICAL at all. It looks like a cheap fix for:

"this is required, I don't for what but it is, so please leave it on"

The problem is this issue is a regression. We added a few gates to better model
the clock tree a while ago. Before, those those clock were left enabled by the
bootloader.

Now that linux turn them off, we are learning a few things about what the FWs
are doing behind our backs.

Among the 5 clocks which got a new gates, only 2 needs to back the old way using
CLK_IS_CRITICAL, so this is still an improvement.

> 
> Also, if this commit really is the right fix, it should include a
> comment for FCLK_DIV3 stating why the CLK_IS_CRITICAL flag was set,
> which may be helpful later on to know if it is safe to remove it. Same
> is true for FCLK_DIV2 in c987ac6f1f088663b6dad39281071aeb31d450a8.

+1 There should be FIXME notice in the driver explaining why we put that flag in
the first place, so we can remove it as soon as a driver properly handle this
clock.

Christian, is Ok if I amend your patch, or do you prefer to post a v2 ?
Mike, with explained, is this change OK with you ?

> 
> Regards,
> Mike
> 
> > 
> > Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> > ---
> >  drivers/clk/meson/gxbb.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> > index 86d3ae5..4c8925d 100644
> > --- a/drivers/clk/meson/gxbb.c
> > +++ b/drivers/clk/meson/gxbb.c
> > @@ -509,6 +509,7 @@ static struct clk_fixed_factor gxbb_fclk_div3_div = {
> >                 .ops = &clk_fixed_factor_ops,
> >                 .parent_names = (const char *[]){ "fixed_pll" },
> >                 .num_parents = 1,
> > +               .flags = CLK_IS_CRITICAL,
> >         },
> >  };
> >  
> > -- 
> > 2.7.4


