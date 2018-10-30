Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02C0C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6967920657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpZa2rLV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6967920657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeJaBJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:09:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55565 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbeJaBJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:09:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id s10-v6so12359203wmc.5;
        Tue, 30 Oct 2018 09:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+nw3wWqfVi125r2Ty0SrKAS4AMq86yi6J+OvF4otjbg=;
        b=RpZa2rLVcpWgpxOs9ZKzfv9YYXJ5UvaY+xre8invEJxeK5w9tLrruNmIF8wjnNAQsX
         /mzaB4WuMQtj21keC9CNlHk2UK+nvSH9TXgq/vuGWs2Sg5pl/P3Ri2aNUoBXDVc2ezGi
         Mp2IyDrZBwV/ozOnDymFrZDcnGtPu2hvRC4AyN/y60fyKEHM7AUV0qT70F8QhU6B5R5v
         WzW9+qQcwXRVDqMryzQ31SUj+ReWhZRE7NWfIpd5oVWNVQLLFFKSt/2TEvW8JnsTz5Kb
         YXaNXSVq0Pv/0AN+D7FV19wxXjbIikAC+gKgT6czDjoc6re8OZZzXmfmODktd+Z2V+EZ
         /JLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+nw3wWqfVi125r2Ty0SrKAS4AMq86yi6J+OvF4otjbg=;
        b=KWd27m1upZ66UanS0SHhks2fzQYmz7aXhQ0W//rZWEVKaz9MzzJUyQpVv1qlzHBUHN
         WfM9iTld+vUcm5bGDnKxmP/r9qG7+iWf7rQoJc6Y3j5tmRtCXrz8tH+PAF+d77eaG1V/
         tE2PqTY7qLw0hqNmlj11g6GvDA0bcp0BZPwsqAgTUsaJ6UMhciy81Wcwvl51XcTbz4+F
         KbPrWM8jpDzC5TKYtz36kGFR29QfSvxhSHfK6F9GSo7cQBsz6l11NFws+leqBU+PlJ1X
         GEsojvO/lHHqheeR2STAe1EccRPgSsSCuv0Cy7hnDdyUuWdQVIyQknCJIeod8tIw+3ng
         UmLg==
X-Gm-Message-State: AGRZ1gLmIltsrfHRVvJKb28OYVsqtfxcoH1zTOvswGfOEZs/+obvaUYn
        ZFQ7YbNntTAc0QDxI7HDXMc=
X-Google-Smtp-Source: AJdET5ftJMQBoHdA8/MK5Vt4XBuAIDSdeSEQz6alEf64WTzNagN7dfrb3X6y5ux4YjXwk7PA5BjrTQ==
X-Received: by 2002:a1c:6c0f:: with SMTP id h15-v6mr2199643wmc.123.1540916136424;
        Tue, 30 Oct 2018 09:15:36 -0700 (PDT)
Received: from picard ([194.207.103.1])
        by smtp.gmail.com with ESMTPSA id e7-v6sm25153360wra.37.2018.10.30.09.15.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 09:15:35 -0700 (PDT)
Date:   Tue, 30 Oct 2018 16:15:34 +0000
From:   Dean Wallace <duffydack73@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Johannes Stezenbach <js@sig21.net>,
        Carlo Caione <carlo@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mogens Jensen <mogens-jensen@protonmail.com>
Subject: Re: Regression found (Stop-marking-clocks-as-CLK_IS_CRITICAL)
Message-ID: <20181030161534.wk5cf7nxbwhp2far@picard>
References: <154083512089.98144.9141070901932719147@swboyd.mtv.corp.google.com>
 <CAHp75VfnN5tF1Z9+CDDhKFNG5QfCRcGOZeAkpf-5BfCEx16gvg@mail.gmail.com>
 <CAHp75VctdBE-GM60udJawBCXdmoOqZn4N=kFWz5GLHzjPG2iQQ@mail.gmail.com>
 <20181029190819.2ivlx73n6y6sx4vk@picard>
 <ffc4bcc9-62c3-8940-85d6-d0fd01f3a1b8@linux.intel.com>
 <c8fb730a-c160-41b4-dad0-8ed8594e5687@redhat.com>
 <20181030143836.feo7zcxiestylxoo@picard>
 <2d429c87-24c5-4075-683e-b0d12c3eb1c2@linux.intel.com>
 <d00df762-e4fc-06c5-701e-d5100bfd0e35@redhat.com>
 <e48696f0-aa3e-e20e-d038-9d8dda9cbfce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e48696f0-aa3e-e20e-d038-9d8dda9cbfce@redhat.com>
X-Info: Keep It Simple, Stupid.
X-Operating-System: Linux, kernel 4.19.0-arch1-1-max98090
X-Message-Flag: WARNING!! Outlook sucks
User-Agent: Every email client sucks, this one just sucks less.
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-10-18, Hans de Goede wrote:
> Hi,
> 
> On 30-10-18 16:46, Hans de Goede wrote:
> > Hi,
> > 
> > On 30-10-18 16:04, Pierre-Louis Bossart wrote:
> > > In addition I am not aware of any baytrail device using plt_clk_0,
> > > so moving a common machine driver such a cht_bsw_max98090_ti to use
> > > plt_clk0 only would break other devices (e.g. Rambi/Orco). Asking
> > > for both clocks to be on might work though,
> > 
> > Ok, so we need to have a DMI based quirk for the Swanky and maybe also
> > the clapper to use plt_clk_0 there. Asking for 2 clks if we only need
> > one does not seem like a good plan.
> 
> Dean, Mogens,
> 
> To write a proper patch for this I'm going to need DMI strings
> from your devices.
> 
> Can you please run (as normal user):
> 
> grep . /sys/class/dmi/id/* 2> /dev/null
> 
> And reply with the output of this command?
Here's mine, for a coreboot uefi based swanky.

https://ptpb.pw/~swanky-dmi-log

--
Dean
