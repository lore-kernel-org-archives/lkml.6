Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B145FECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE5920874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVjz2f0m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE5920874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388555AbeGXSKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:10:53 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38780 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388432AbeGXSKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:10:52 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3-v6so3322879pgq.5;
        Tue, 24 Jul 2018 10:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xtaium+WK7Nbnd7Bg090kq36jPUhUXtTSaiOcKpjdPo=;
        b=pVjz2f0m0vC3uFLmFu3OM8naq3ZNGp2BCvo8xxVfQo3je03aefEVMgLkVPM37eHWMS
         AV98lTJQ+xYKGoLFwwf1N74eoFVIi3jDj8No3CRO4jylBr7mxOm+StE93QHz1B7+hOje
         l1hCoMQJDutrDOP8CjcnaCJ1jFT/CD6AAF74i8/AUNlKi7e5yASQPCu9IWKXJKy55Gz4
         dVwd5IzR/fAJmqjaUHxWC78M2YX7FrvPWFWPmamZmVfC6ELIuK1X1fQ6U5mSRthYt0t8
         HOGfGozaBvhD76y5NM0k2Fz26eCy+FsThnUuiuHbHk27Mnca9qnFWxI4qfVCcEqlvKVA
         rgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xtaium+WK7Nbnd7Bg090kq36jPUhUXtTSaiOcKpjdPo=;
        b=s8oenf0ZQir9lAIbGgN4hYpFCoIN29w5kfFTy0lQJCAzclNjAjN6RIy0/4ezg202ja
         Ac9npOQaKXPDdg/ZVs5vg4dYSYcOb55uQ89ARKW7gBCjrqftp49hrhZxPYMcJovxetM5
         NpBDUJuTG0e8T/FnR//nZ4ieyJBTX2PzKZCiUQqRWobs0dtlAUePhlJ7jYKesIhh/3TA
         X8jghW68RJsv1JxO7GolBipl3NSlDoovmam1EfiJWwSE75S7v7hZ3taNtqku4Q2ku3sv
         BdEPcfxwYc3YBHpIDr7AVrEyYVisZZly9tSwTxDH0IWbjwgO6bpJs6NRoBGuSuR0KD/h
         2bOQ==
X-Gm-Message-State: AOUpUlEk/4Qs65YNpgQLyQvMJaAARSy+ZuiOFyfk+7UvSR7okRQGWw42
        Ue5qm63eAPlqgsycKB9+Vq4=
X-Google-Smtp-Source: AAOMgpeNK2XEuklGSrwuISXxl/72NahJQP2lNPce9AYc9tPOwYJuIa1a0t9NnMc7yhXnh+B7zxRWGA==
X-Received: by 2002:a63:4002:: with SMTP id n2-v6mr16821232pga.285.1532451807659;
        Tue, 24 Jul 2018 10:03:27 -0700 (PDT)
Received: from dimapc.localnet (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id j1-v6sm39502195pfk.125.2018.07.24.10.03.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 10:03:26 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "mperttunen@nvidia.com" <mperttunen@nvidia.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 00/15] ARM: dts: tegra: apalis-tk1: major revamp
Date:   Tue, 24 Jul 2018 20:03:18 +0300
Message-ID: <2665137.5yJaStjver@dimapc>
In-Reply-To: <79afd852-af93-dfa1-0d65-11be7507f81f@gmail.com>
References: <20180724104309.21741-1-marcel@ziswiler.com> <4715215.NZcU7pUVUy@dimapc> <79afd852-af93-dfa1-0d65-11be7507f81f@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 24 July 2018 18:47:41 MSK Peter Geis wrote:
> On 07/24/2018 10:48 AM, Dmitry Osipenko wrote:
> > On Tuesday, 24 July 2018 17:45:01 MSK Marcel Ziswiler wrote:
> >> On Tue, 2018-07-24 at 17:31 +0300, Dmitry Osipenko wrote:
> >>> On Tuesday, 24 July 2018 17:16:33 MSK Marcel Ziswiler wrote:
> >>>> On Tue, 2018-07-24 at 15:44 +0300, Dmitry Osipenko wrote:
> >>>>> On Tuesday, 24 July 2018 15:24:34 MSK Marcel Ziswiler wrote:
> >>>>>> Sorry, I meant to write "minor revamp" in the subject line here
> >>>>>> as
> >>>>>> Apalis TK1 was already in quite good a shape but this are still
> >>>>>> some
> >>>>>> worthy improvements (;-p).
> >>>>> 
> >>>>>> On Tue, 2018-07-24 at 12:42 +0200, Marcel Ziswiler wrote:
> >>>>> Marcel,
> >>>>> 
> >>>>> All your emails that are sent from "toradex.com" are treated as
> >>>>> spam
> >>>>> by Gmail
> >>>>> because "This message has a from address in toradex.com but has
> >>>>> failed
> >>>>> toradex.com's required tests for authentication.", is there
> >>>>> anything
> >>>>> you could
> >>>>> do to fix that?
> >>>> 
> >>>> Hi Dmitry
> >>>> 
> >>>> Hm, unfortunately, Toradex was an M$ only shop when I joined more
> >>>> then
> >>>> 7 years ago and so far I was unable to convince our IT to switch to
> >>>> some grown up email system. Therefore, I am stuck with Exchange,
> >>>> Office
> >>>> 365 or whatever M$ nowadays seem to call it. Anyway, I really
> >>>> thought
> >>>> sending from Android or Evolution via their resp. Exchange
> >>>> connectors
> >>>> would properly do SPF, DKIM and even DMARC. I just confirmed this
> >>>> when
> >>>> sending something to my gmail address and doing "Show original".
> >>>> 
> >>>> Since Linus himself pointed out any of my patches ending up in his
> >>>> spam
> >>>> folder I do send them via my private email which while not having
> >>>> any
> >>>> advanced security configured should still be valid. Moving it to a
> >>>> fully secure configuration including DNSSEC and stuff is still
> >>>> pending
> >>>> on my side.
> >>>> 
> >>>> Can you please tell me which exact email it is that you got this
> >>>> reported on so I may further investigate what is going on?
> >>> 
> >>> This email from you looks okay. Unfortunately all of your previous
> >>> emails from
> >>> "toradex.com" were getting into the spam folder.
> >> 
> >> You sure they were from "toradex.com"? The patches should have been
> >> coming from "ziswiler.com" resp. "perfora.net".
> > 
> > The patches from "ziswiler.com" are fine, only your emails specifically
> > from "toradex.com" had an issue. Looks like you've resolved it now.
> 
> Dmitry,
> Gmail normally suspends flagging emails as spam from addresses you
> respond to.
> It may pick up again though, so I would add toradex.com to your allow list.

Yes, probably I could add a custom filter for the domain name. But It is not 
really a problem for me, I just wanted to point Marcel at it.




