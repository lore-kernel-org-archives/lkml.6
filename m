Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E317ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D3820647
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:40:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D3820647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387807AbeGTQ2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 12:28:50 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:54282 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731892AbeGTQ2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 12:28:49 -0400
Received: by mail-it0-f68.google.com with SMTP id s7-v6so15229696itb.4;
        Fri, 20 Jul 2018 08:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=K+rZ+/GJJVbWHN2J07qJuEJedXc/x/tmVZY4ahtZqZQ=;
        b=RDaA08CQI6y5Uq+VPcc4pTHOu+/9Nj5UCJ4B+/i5XxihBPkwSmTm9w8QZTHHioqkZZ
         7GI3OAbe52d2nZ7c3YtT4wP6CPtk+5agKevZ2MSki8A92iO589bSbspVPkI9qSPg8iOb
         Bg7D+/NfyELrQIyQEXpFUpOQirdm8oASxCVnNLFKusy6nQAABXiaGt2qpUbu6RS1W5I8
         xtU8vwA+kyqGmNF6CAtfHiGO6RTpSQchRHU/vQlxndQxm4ZVyr4lZAlcMU+rP3Diwf3y
         IuFXMj1+nRsY+MnTA11vTcRwFAPGL/BtUwKiqaloHaaQ6qZfo62Q+1hJUwlKfIKudi/j
         Dg2A==
X-Gm-Message-State: AOUpUlH6zS75JE8yJm+TGxVheP5czCU/RaqnlAwt4sHhGJKZuWrkwnpe
        PvKwHAK2va0MPWFiPFdPBa45Cf0=
X-Google-Smtp-Source: AAOMgpc2mf0cPjpFmhtad2xb0kGTJF6+RC7engBguUBbbj0d6erLBZnSW9M3IyxQRFRYpfqjWvaxvw==
X-Received: by 2002:a24:2b86:: with SMTP id h128-v6mr2327131ita.14.1532101198301;
        Fri, 20 Jul 2018 08:39:58 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id h14-v6sm641637ioj.21.2018.07.20.08.39.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 08:39:57 -0700 (PDT)
Date:   Fri, 20 Jul 2018 09:39:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Rutland <mark.rutland@arm.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: jz4740: Add support for the JZ4725B, JZ4760, JZ4770
Message-ID: <20180720153956.GA18135@rob-hp-laptop>
References: <20180713151424.13000-1-paul@crapouillou.net>
 <20180714131920.GU16084@piout.net>
 <1531574734.2831.0@smtp.crapouillou.net>
 <20180714133250.GW16084@piout.net>
 <1531576208.2831.1@smtp.crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531576208.2831.1@smtp.crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 03:50:08PM +0200, Paul Cercueil wrote:
> 
> 
> Le sam. 14 juil. 2018 à 15:32, Alexandre Belloni
> <alexandre.belloni@bootlin.com> a écrit :
> > On 14/07/2018 15:25:33+0200, Paul Cercueil wrote:
> > >  Hi Alexandre,
> > > 
> > >  Le sam. 14 juil. 2018 à 15:19, Alexandre Belloni
> > >  <alexandre.belloni@bootlin.com> a écrit :
> > >  > Hello,
> > >  >
> > >  > On 13/07/2018 17:14:24+0200, Paul Cercueil wrote:
> > >  > >  The RTC in the JZ4725B works just like the one in the JZ4740.
> > >  > >
> > >  > >  The RTC in the JZ4760 and JZ4770 work just like the one in the
> > >  > > JZ4780.
> > >  > >
> > >  > >  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > >  > >  ---
> > >  > >   Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
> > > |  3
> > >  > > +++
> > >  > >   drivers/rtc/rtc-jz4740.c
> > > | 11
> > >  > > ++++++++++-
> > >  > >   2 files changed, 13 insertions(+), 1 deletion(-)
> > >  > >
> > >  > >  diff --git
> > >  > > a/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
> > >  > > b/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
> > >  > >  index 41c7ae18fd7b..a9e821de84f2 100644
> > >  > >  ---
> > > a/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
> > >  > >  +++
> > > b/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
> > >  > >  @@ -4,6 +4,9 @@ Required properties:
> > >  > >
> > >  > >   - compatible: One of:
> > >  > >     - "ingenic,jz4740-rtc" - for use with the JZ4740 SoC
> > >  > >  +  - "ingenic,jz4725b-rtc" - for use with the JZ4725B SoC
> > >  > >  +  - "ingenic,jz4760-rtc" - for use with the JZ4760 SoC
> > >  > >  +  - "ingenic,jz4770-rtc" - for use with the JZ4770 SoC
> > >  > >     - "ingenic,jz4780-rtc" - for use with the JZ4780 SoC
> > >  > >   - reg: Address range of rtc register set
> > >  > >   - interrupts: IRQ number for the alarm interrupt
> > >  > >  diff --git a/drivers/rtc/rtc-jz4740.c
> > > b/drivers/rtc/rtc-jz4740.c
> > >  > >  index d0a891777f44..1c867e3a0ea5 100644
> > >  > >  --- a/drivers/rtc/rtc-jz4740.c
> > >  > >  +++ b/drivers/rtc/rtc-jz4740.c
> > >  > >  @@ -54,6 +54,9 @@
> > >  > >
> > >  > >   enum jz4740_rtc_type {
> > >  > >   	ID_JZ4740,
> > >  > >  +	ID_JZ4725B,
> > >  > >  +	ID_JZ4760,
> > >  > >  +	ID_JZ4770,
> > >  >
> > >  > I wouldn't introduce those ids unless there are handling
> > > differences at
> > >  > some point.
> > > 
> > >  Well there are handling differences, see below.
> > > 
> > >  > >   	ID_JZ4780,
> > >  > >   };
> > >  > >
> > >  > >  @@ -114,7 +117,7 @@ static inline int
> > > jz4740_rtc_reg_write(struct
> > >  > > jz4740_rtc *rtc, size_t reg,
> > >  > >   {
> > >  > >   	int ret = 0;
> > >  > >
> > >  > >  -	if (rtc->type >= ID_JZ4780)
> > >  > >  +	if (rtc->type >= ID_JZ4760)
> > >  >
> > >  > This would avoid that change (and the test would preferably be
> > >  > (rtc->type == ID_JZ4780))
> > > 
> > >  That branch should be taken if the SoC is JZ4760, JZ4770 or JZ4780.
> > >  It should not be taken if the SoC is JZ4740 or JZ4725B.
> > 
> > Sure but you can achieve that with only 2 ids...
> > 
> > > 
> > >  > >   		ret = jz4780_rtc_enable_write(rtc);
> > >  > >   	if (ret == 0)
> > >  > >   		ret = jz4740_rtc_wait_write_ready(rtc);
> > >  > >  @@ -300,6 +303,9 @@ static void jz4740_rtc_power_off(void)
> > >  > >
> > >  > >   static const struct of_device_id jz4740_rtc_of_match[] = {
> > >  > >   	{ .compatible = "ingenic,jz4740-rtc", .data = (void
> > > *)ID_JZ4740 },
> > >  > >  +	{ .compatible = "ingenic,jz4725b-rtc", .data = (void
> > > *)ID_JZ4725B
> > >  > > },
> > >  > >  +	{ .compatible = "ingenic,jz4760-rtc", .data = (void
> > > *)ID_JZ4760 },
> > >  > >  +	{ .compatible = "ingenic,jz4770-rtc", .data = (void
> > > *)ID_JZ4770 },
> > 
> > By doing the correct mapping here e.g:
> > 
> > { .compatible = "ingenic,jz4725b-rtc", .data = (void *)ID_JZ4740 },
> 
> Not very pretty and future-proof if you ask me...

Looks to me like this can be handled entirely in DT without driver 
changes like the other patches. Correct usage of compatible strings is 
what gives you future-proofing. And no driver change is better than 
needless changing.

It may look a bit wierd if 4780 is the fallback for 4770, but if the 
4780 is older, then that actually makes sense.

Rob
