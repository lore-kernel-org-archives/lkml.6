Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9263BC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5861D2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgxFmj9t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5861D2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbeJ3D6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:58:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43461 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbeJ3D6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:58:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id t10-v6so9914936wrn.10;
        Mon, 29 Oct 2018 12:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2FB+brlDErFcKaAXgeHxcJPKsFF2HZZjbUO9HWm2rW8=;
        b=SgxFmj9tSXovSPYtHmggzlOV2TAkLud2T9hdGrUjOIKsBpgppYwnnLqTEU0sdN4IAE
         kIa2Vsc9arcLQcWtZ6ayweDA0qV0cDKh2lGoEYXNdJRQk9iGoIHmvfx1bQcK15BkzUeD
         8I50miv1tTfTe9bN12gA2FbKh63hI6hVgkUfMqd+jXCn9AfO33nsTjx8NGzlBpNL4uke
         LQY6yiraP1f7x9UEC+n5tVi6QL+eU+0iWS++S2dPxHhxjBNHny34zr+rPjiUDUSWDvR1
         nwu9zaGwCo+w4pQaNW5Ll85rvUGJS5cepwZFOxVqfIEpZJJy5f1ZFP+KmEt9fJhgm5mP
         QaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2FB+brlDErFcKaAXgeHxcJPKsFF2HZZjbUO9HWm2rW8=;
        b=AhUugMiJMA8CJAcuEtwmcjqH6A7Cwa3n/rdnPGGE0/bAKpzrztNE3uh2+XQBq7U24e
         l5ybv9L2daW1od6xyg7fQ4+DCMc7EwYAyuf6fw7PvbO+4SK/pO+IxUwR/WsWOrYwD79C
         E5zpKX7xD16i2bckdpO2wT2rEmt1NQ0L850SWibgX2R02usyqurb27SE0zhq/XcMkTJq
         ruzHwpJYYYF+EgO8zqcb/w2RYvB9rzZ1X+oBZo7lseqdiNyVtWq5so+U4/UYbxVgY5o7
         ovn4M6gnITlLwpqNQqTHxXJKh7txGTofonQSoIy5261shKt+spiIknlrGd/boamJmGni
         s6xQ==
X-Gm-Message-State: AGRZ1gISRCPeIKx7YXbhkcQ58/N5V2MAXzFXlK/Z/oH2tKEkxB54iohY
        PtwaVH/EZqrmYajatGEpBYE=
X-Google-Smtp-Source: AJdET5dkfCC4pzmu6hCTHcxltT55t4+hTeYl7bXqy1Z8bkkqvcX4gwTE0qc5HwHlaaEzTOTI0rny4A==
X-Received: by 2002:adf:f384:: with SMTP id m4-v6mr15368677wro.111.1540840100875;
        Mon, 29 Oct 2018 12:08:20 -0700 (PDT)
Received: from picard ([194.207.103.1])
        by smtp.gmail.com with ESMTPSA id l140-v6sm28577135wmb.24.2018.10.29.12.08.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 12:08:20 -0700 (PDT)
Date:   Mon, 29 Oct 2018 19:08:19 +0000
From:   Dean Wallace <duffydack73@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Johannes Stezenbach <js@sig21.net>,
        Carlo Caione <carlo@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Regression found (Stop-marking-clocks-as-CLK_IS_CRITICAL)
Message-ID: <20181029190819.2ivlx73n6y6sx4vk@picard>
References: <20181025232517.ywnw54qibemosjws@picard>
 <154083512089.98144.9141070901932719147@swboyd.mtv.corp.google.com>
 <CAHp75VfnN5tF1Z9+CDDhKFNG5QfCRcGOZeAkpf-5BfCEx16gvg@mail.gmail.com>
 <CAHp75VctdBE-GM60udJawBCXdmoOqZn4N=kFWz5GLHzjPG2iQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75VctdBE-GM60udJawBCXdmoOqZn4N=kFWz5GLHzjPG2iQQ@mail.gmail.com>
X-Info: Keep It Simple, Stupid.
X-Operating-System: Linux, kernel 4.18.16-arch1-1-ARCH
X-Message-Flag: WARNING!! Outlook sucks
User-Agent: Every email client sucks, this one just sucks less.
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-10-18, Andy Shevchenko wrote:
> On Mon, Oct 29, 2018 at 7:52 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > Cc: Pierre as well.
> >
> > On Mon, Oct 29, 2018 at 7:48 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Quoting Dean Wallace (2018-10-25 16:25:17)
> > > > I have found a regression in 4.18.15 that means I lose sound on my old
> > > > Toshiba Chromebook 2 (Swanky).  My system details are:-
> > > >
> > > > Toshiba Chromebook (Swanky)
> > > > MrChromebox UEFI coreboot
> > > > Arch Linux running latest alsa/pulseaudio
> > > >
> > > > Upgraded kernel from 4.18.14 to 4.18.15 and lost all sound output.  By
> > > > output I mean, the card is still detected, the module loaded, all apps
> > > > showing sound is being playing, but no actual audible sound comes
> > > > through.  Upgraded to 4.18.16 same issue.
> > > >
> > > > Dug around and found Upstream commit 648e921888ad96ea3dc922739e96716ad3225d7f
> > > > clk: x86: Stop marking clocks as CLK_IS_CRITICAL
> > > > "This commit removes the CLK_IS_CRITICAL marking, fixing Cherry Trail
> > > > devices not being able to reach S0i3 greatly decreasing their battery
> > > > drain when suspended."
> > > >
> > > > I reverted it and compiled 4.18.16 and have sound back again.  Could
> > > > this be looked into, with possibility of fix.
> > > >
> > >
> > > Thanks for the bug report. I'm adding some people involved in the commit
> > > you mention is causing audio regressions. The best plan is to probably
> > > revert the commit from the 4.18 linux stable tree. Or there may be
> > > another patch missing that would be useful to make this backported patch
> > > work. Hopefully Hans or Andy knows.
> >
> > Hans has been investigating S0ix issues on Baytrail and Cherrytrail machines.
> > I have a feeling that the problem can be fixed by properly handling
> > clock in ASoC driver(s). Perhaps Hans and Pierre can figure this out
> > better than me.
> 
> Looking to sound/soc/intel/boards/cht_bsw_rt5672.c I see no
> suspend-resume hooks. Perhaps, adding them like in the commit
> ac8bd9e13be2 ("r8169: Disable clk during suspend / resume") would
> help.
> 
> Btw, what the drivers are in use for the machine you have? It's better
> you run alsa-info.sh or alike to collect necessary information along
> with output of `lsmod`, `dmesg`, etc.
> 
> -- 
> With Best Regards,
> Andy Shevchenko

alsa-info.txt [1], cpuinfo [2], dmesg [3], and 'ls /sys/bus/i2c/devices' [4]
[1] https://gist.github.com/duffydack/480be8ddced44515dbf981dc09f593ec#file-alsa-info
[2] https://gist.github.com/duffydack/480be8ddced44515dbf981dc09f593ec#file-cpuinfo-log
[3] https://gist.github.com/duffydack/480be8ddced44515dbf981dc09f593ec#file-dmesg-log
[4] https://gist.github.com/duffydack/480be8ddced44515dbf981dc09f593ec#file-sys-bus-i2c-devices-log

Regards
-- 
Dean
