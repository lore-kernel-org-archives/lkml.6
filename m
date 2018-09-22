Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37458ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 11:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73F9204EC
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 11:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0mq4jWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C73F9204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbeIVRNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 13:13:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39403 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbeIVRNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 13:13:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id j8-v6so7089084pff.6;
        Sat, 22 Sep 2018 04:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Azpn2OsVjv0aMJta5wuopC0QuKEomnB7pS3somaDH94=;
        b=T0mq4jWwP8cbcvhnpNd+fQ/6ASyGFzxoKqFfsFaUoQ1UVzaisypMlmB5Lm9ddkZPmr
         kMIDQeTAaZEb4LTVQkZF/f3p62K5xRL4h4zxagSVLFAxb7KKzyRq/BbkiqTyueImBDaR
         ezK84BWDbfRJP3NzqnI8N6ukqWSGPvDecAEfSAxCS02/AFczJ84fZxpvWPmK5uAw88PZ
         6B2E8Qn+c1wGGgvB8cGBVn2P010VMXCQtet3XNzKvdqOCUXNwGBLGfPvQl3fvnkkY26T
         O5W6RiQv+4ASnxRIVmvOtXpKb223uqedstxksxNMP4oRTozxSgExiNmjbZwHH0op9v2u
         TXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Azpn2OsVjv0aMJta5wuopC0QuKEomnB7pS3somaDH94=;
        b=QDgrF2phRTqHC3UUh3bTwCkA6jV6CGNtYHIrOliLxwPbNwT3vBNIxVBWZ30Zz6F0Kj
         P0lf3wV5rqoq4s2U43GiIZr/3qoGpJEfJPOJNzkRuo8NXKqp17+CY9M1l/dPRKPXIg2g
         wyd2UYzgIH08c94sUDE51coCEhiP3R59fj7+w0/yPbDisLgw1tWgic0K4cxdG7Q8immg
         RMTpfrfCcRz+WOwQZ9r6vP8Oq99Z4z3VoDbmS3GM3Lms4tzSbQs3t1HZhnXHcpYgljON
         MyqpmgK60vi13i7Io83rFB2OkbEop4hmT/BwLRlfskNixi1UjZZDhACfOlw62PYAo1SU
         BFiQ==
X-Gm-Message-State: ABuFfogvD5ij8M/GrTwzI3K/ba//DIlLzNeNy20oo+Magx99Lb6lUwX4
        GiPx0yWWNuYf4z4g00x+jQc=
X-Google-Smtp-Source: ACcGV61WLH9Azdo/peTUNiuKM2J/2TZ4a1LT0JeR0Ft5mT9qiJf0XfatredRzxtRUo67+zVbwxLZlA==
X-Received: by 2002:a63:501c:: with SMTP id e28-v6mr1914546pgb.341.1537615221152;
        Sat, 22 Sep 2018 04:20:21 -0700 (PDT)
Received: from Eros (104.176.229.35.bc.googleusercontent.com. [35.229.176.104])
        by smtp.gmail.com with ESMTPSA id e73-v6sm58911879pfb.153.2018.09.22.04.20.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Sep 2018 04:20:20 -0700 (PDT)
Date:   Sat, 22 Sep 2018 19:19:59 +0800
From:   Song Qiang <songqiang1304521@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     kbuild test robot <lkp@intel.com>,
        Eugen Hristev <eugen.hristev@microchip.com>, kbuild-all@01.org,
        ludovic.desroches@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, nicolas.ferre@microchip.com,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 2/2] iio: adc: at91: fix wrong channel number in
 triggered buffer mode
Message-ID: <20180922111959.GA27711@Eros>
References: <1537447238-18674-2-git-send-email-eugen.hristev@microchip.com>
 <201809211544.zop1vk8B%fengguang.wu@intel.com>
 <20180922113616.2d849fb0@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180922113616.2d849fb0@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 11:36:16AM +0100, Jonathan Cameron wrote:
> On Fri, 21 Sep 2018 15:26:03 +0800
> kbuild test robot <lkp@intel.com> wrote:
> 
> > Hi Eugen,
> This one is leaving me stumped...
> 
> Anyone care to point out what I'm missing that is wrong here?
> 
> Also Eugen, please don't cc stable on a patch directly.  It is fine to send
> a backport request once a patch has hit mainline, but before that it's just
> adding noise to a list as they won't take it directly anyway.
> 
> Jonathan
> 

Hi Jonathan,

I run some test code here and found out that C compilers don't allow
us to assign a 'const int *' to 'int *', while assign a 'const int' to
'int' is fine.
In this case this driver was tring to assign a 'struct iio_chan_spec
const *' to a 'struct iio_chan_spec *', mostly because of this issue.

I googled this issue and someone on stack overflow said it's because
this kind of action will break the check mechanism of 'const'.

yours,
Song Qiang

> > 
> > I love your patch! Perhaps something to improve:
> > 
> > [auto build test WARNING on iio/togreg]
> > [also build test WARNING on v4.19-rc4 next-20180919]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Eugen-Hristev/iio-adc-at91-fix-acking-DRDY-irq-on-simple-conversions/20180920-215908
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> > config: arm-allmodconfig (attached as .config)
> > compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=7.2.0 make.cross ARCH=arm 
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >    drivers/iio/adc/at91_adc.c: In function 'at91_adc_trigger_handler':
> > >> drivers/iio/adc/at91_adc.c:257:8: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]  
> >       chan = idev->channels + i;
> >            ^
> > 
> > vim +/const +257 drivers/iio/adc/at91_adc.c
> > 
> >    245	
> >    246	static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
> >    247	{
> >    248		struct iio_poll_func *pf = p;
> >    249		struct iio_dev *idev = pf->indio_dev;
> >    250		struct at91_adc_state *st = iio_priv(idev);
> >    251		struct iio_chan_spec *chan;
> >    252		int i, j = 0;
> >    253	
> >    254		for (i = 0; i < idev->masklength; i++) {
> >    255			if (!test_bit(i, idev->active_scan_mask))
> >    256				continue;
> >  > 257			chan = idev->channels + i;  
> >    258			st->buffer[j] = at91_adc_readl(st, AT91_ADC_CHAN(st, chan->channel));
> >    259			j++;
> >    260		}
> >    261	
> >    262		iio_push_to_buffers_with_timestamp(idev, st->buffer, pf->timestamp);
> >    263	
> >    264		iio_trigger_notify_done(idev->trig);
> >    265	
> >    266		/* Needed to ACK the DRDY interruption */
> >    267		at91_adc_readl(st, AT91_ADC_LCDR);
> >    268	
> >    269		enable_irq(st->irq);
> >    270	
> >    271		return IRQ_HANDLED;
> >    272	}
> >    273	
> > 
> > ---
> > 0-DAY kernel test infrastructure                Open Source Technology Center
> > https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
