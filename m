Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26F8ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 20:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64CE62081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 20:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbuzsLzU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64CE62081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbeKAFGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 01:06:50 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53443 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeKAFGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 01:06:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id v24-v6so6512591wmh.3;
        Wed, 31 Oct 2018 13:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b0MXq5WSc31v12l+Qo6mb4zyzuRiB3sSENpMEPBRw1I=;
        b=AbuzsLzUWwlbOz0RfX5QBmHuE2xU+ddb9VkrBh2wv02Oogzo6MfBMJTmsPAmCIIwA0
         1BXrldVqn+9okuL1a4fQjkxL0/Anlq6a2K97dor0u/CFAvqNMe/NZ7rOFBsPgULfFVxS
         H72oF/jVRPOM37AGgZ2AU7O7cHtQynHjhZsmbyDi5mAZ0dju2kqitW8b4lJa4iBkobeJ
         KNau6l60NrMEKZ3mafyIyAM6uoAObcd/Ll5fo0HryU5Y5tUtuVsXbQNtJ2xjDvMWGqgH
         oi7AgsZuqkJypycMBAPyLsZZtdmhtooa7y+tJzzjcfGtzumcPsWmMdHcxgfr3bHMBk92
         MqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b0MXq5WSc31v12l+Qo6mb4zyzuRiB3sSENpMEPBRw1I=;
        b=HS3PRAvsWVh3SG5JqcAqCl9HylMdd1wqPaoc0SZMDo/8/d3nLqe2bPcLWnRTQcBonI
         D/Hwhda9/X+O8+mGDOSHVwCHCHKaGw/I6Re7nW3t+NCAPZ81D1KCUV/StXgNVGz07TgA
         Pw24AqG1PrikiCXbsSg9s9auYe+5c+f6CqyXJtTNYT+L2F/PvBoC+R2BtLz/GBcZ7qgZ
         xim8pICZlHV1uNhvDJfe6AS2E81uXGCFFx5jObLKCW11g/kIuAWQM0R/NfqR6sn95ryn
         UFuYLbFto0hC1ivT7ppnfOoQVdoHdlsKjd6/2x8i3cVC58uJkhi7d31Zh2c9M15LIfBm
         fj+g==
X-Gm-Message-State: AGRZ1gK1MP7KV/e1pR0xE5ONMt1Q0lQhW5x9MInW8gqG7F10RPGeCZFM
        SmvecAWawm7N3DTjKY8H3Qk=
X-Google-Smtp-Source: AJdET5c4PLj6fPV7uHa9aoj3epqf0ylCveci73DmiGdZdqumUwRAlq7/nCzX0kPtFTXLgIys5H3a8g==
X-Received: by 2002:a1c:2097:: with SMTP id g145-v6mr3430424wmg.57.1541016433389;
        Wed, 31 Oct 2018 13:07:13 -0700 (PDT)
Received: from picard ([194.207.103.1])
        by smtp.gmail.com with ESMTPSA id r188-v6sm8085848wmg.19.2018.10.31.13.07.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 13:07:11 -0700 (PDT)
Date:   Wed, 31 Oct 2018 20:07:09 +0000
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
Message-ID: <20181031200709.xrmu6wsdel7dtcjq@picard>
References: <CAHp75VctdBE-GM60udJawBCXdmoOqZn4N=kFWz5GLHzjPG2iQQ@mail.gmail.com>
 <20181029190819.2ivlx73n6y6sx4vk@picard>
 <ffc4bcc9-62c3-8940-85d6-d0fd01f3a1b8@linux.intel.com>
 <c8fb730a-c160-41b4-dad0-8ed8594e5687@redhat.com>
 <20181030143836.feo7zcxiestylxoo@picard>
 <2d429c87-24c5-4075-683e-b0d12c3eb1c2@linux.intel.com>
 <d00df762-e4fc-06c5-701e-d5100bfd0e35@redhat.com>
 <e48696f0-aa3e-e20e-d038-9d8dda9cbfce@redhat.com>
 <20181030161534.wk5cf7nxbwhp2far@picard>
 <307c2074-d268-a87a-6040-1240a2091a4d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <307c2074-d268-a87a-6040-1240a2091a4d@redhat.com>
X-Info: Keep It Simple, Stupid.
X-Operating-System: Linux, kernel 4.19.0-arch1-1-ARCH-dirty
X-Message-Flag: WARNING!! Outlook sucks
User-Agent: Every email client sucks, this one just sucks less.
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-10-18, Hans de Goede wrote:
> Hi,
> 
> On 30-10-18 17:15, Dean Wallace wrote:
> > On 30-10-18, Hans de Goede wrote:
> > > Hi,
> > > 
> > > On 30-10-18 16:46, Hans de Goede wrote:
> > > > Hi,
> > > > 
> > > > On 30-10-18 16:04, Pierre-Louis Bossart wrote:
> > > > > In addition I am not aware of any baytrail device using plt_clk_0,
> > > > > so moving a common machine driver such a cht_bsw_max98090_ti to use
> > > > > plt_clk0 only would break other devices (e.g. Rambi/Orco). Asking
> > > > > for both clocks to be on might work though,
> > > > 
> > > > Ok, so we need to have a DMI based quirk for the Swanky and maybe also
> > > > the clapper to use plt_clk_0 there. Asking for 2 clks if we only need
> > > > one does not seem like a good plan.
> > > 
> > > Dean, Mogens,
> > > 
> > > To write a proper patch for this I'm going to need DMI strings
> > > from your devices.
> > > 
> > > Can you please run (as normal user):
> > > 
> > > grep . /sys/class/dmi/id/* 2> /dev/null
> > > 
> > > And reply with the output of this command?
> > Here's mine, for a coreboot uefi based swanky.
> > 
> > https://ptpb.pw/~swanky-dmi-log
> 
> Thanks, can you give the attached patch a try. This does the same
> as the previous one you tested, but then only on the Swanky.
> 
> Note I've added:
> 
> Reported-and-tested-by: Dean Wallace <duffydack73@gmail.com>
> 
> To the commit message, I hope that is ok with you, if not let me
> know and I will drop it.
> 
> Once you can confirm that this version also fixes things I will
> submit this version upstream.
> 
> Regards,
> 
> Hans
> 

Just thought it worth mentioning, this new patch that fixes sound
again, seems to have ressurected an old issue with PLL unlock.  I'm
seeing journal entries after fresh boot ......

```
picard kernel: max98090 i2c-193C9890:00: PLL unlocked
picard systemd[462]: Started Sound Service.
picard kernel: max98090 i2c-193C9890:00: PLL unlocked
picard kernel: max98090 i2c-193C9890:00: PLL unlocked
picard kernel: max98090 i2c-193C9890:00: PLL unlocked
picard kernel: max98090 i2c-193C9890:00: PLL unlocked
picard kernel: max98090 i2c-193C9890:00: PLL unlocked
picard kernel: max98090 i2c-193C9890:00: PLL unlocked
picard kernel: max98090 i2c-193C9890:00: PLL unlocked
picard kernel: max98090 i2c-193C9890:00: PLL unlocked
picard kernel: max98090_pll_work: 141 callbacks suppressed
picard kernel: max98090 i2c-193C9890:00: PLL unlocked
```

sound is ok, but sometimes plugging in headphones spams journal with
those PLL messages, and sound turns into "daleks", and I have to
remove/insert headphones few times or stop/start audio to fix it.
It's a very old issue, maybe you'd know more about it.

regards
-- 
Dean
