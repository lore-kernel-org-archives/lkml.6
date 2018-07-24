Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F43C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33FB2064D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MW1oU3ai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D33FB2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388675AbeGXPzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:55:12 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38629 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388516AbeGXPzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:55:11 -0400
Received: by mail-lf1-f68.google.com with SMTP id a4-v6so3171631lff.5;
        Tue, 24 Jul 2018 07:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C8zCjwoGHvsgBj+oazPYpkMyFbWwDMvYorGDAXNghWE=;
        b=MW1oU3aitLaUbUTAHBUQw+idEcHpWytbFCt36VfUOzhZ9ZQ6maiLmOK6QdpywFMJj8
         TJOUlhuP2F5K+jSGbN7OSknSUw/f6YRNjCZ3LYG2VMNTeLyqD/Tay7rCDbtWCsyriSFp
         9Qx+rf2j/wy6ckPOIyq2I9dzMS2d+BSpV2lsgpWFy8BHqfvR7QZmGwebY0Gb8DX9FzPp
         Bb/t/M2xjgFNTYZDXBUoKHWUoSatQ3BfWmg0LduMi9Zk1pYgSHISFCBJ4klKIrQUON2Z
         L8dQwsu3CxEx/xyj2lI/EWtOcWI+eeV1rBsLlT+z9fEVJMcalhg7PdgWCv0b3o1qPiDn
         t0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C8zCjwoGHvsgBj+oazPYpkMyFbWwDMvYorGDAXNghWE=;
        b=GvyytfjNS1dZVO0WQZ7xEJJPa6N6RO81u38DDEuFEtLWvBXhlppv3yBnIwvnm2J8+g
         D517FvIZ0BNvyAk2nsyrlOgViYOfOIhIsWo2ELr45343TQXOW+eTu0r7SqM9BT8ZXR8o
         iNeREnE9BazLJXREL/FVqEFm0yXjdYrfFm3vO9FNDWJ9zVC+LLek5vgeQwpqttYKUTYl
         mcOxQYeQRIQElAPS/O7x6OOGRUTRQfF19T2Chg/vO+RfDtH9IfO3gQqpSA4lC1wq3ME/
         fDdRPpIMequuVu+sjbQhcFLiXpDm2RFbEO46moKradQrItyl2mkkTfhBBKuXeutEx7gt
         RnZw==
X-Gm-Message-State: AOUpUlG/Vg5pXQtDLSPzsyQRFRP0jwbzs7uU6s/2IcVpgkX7LOwGP1nD
        DqR3Oed5t3+1Bzrr8MsLU5Y=
X-Google-Smtp-Source: AAOMgpf5Vlu+U6LqKlE6RxlBc2TINcqEFdpwIRaLNTtREA81PuRC90nHeiTlvupQ+TkqUUCAmIeKGw==
X-Received: by 2002:a19:d819:: with SMTP id p25-v6mr9935008lfg.36.1532443699874;
        Tue, 24 Jul 2018 07:48:19 -0700 (PDT)
Received: from dimapc.localnet (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id g23-v6sm1838489lfl.42.2018.07.24.07.48.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 07:48:19 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "mperttunen@nvidia.com" <mperttunen@nvidia.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 00/15] ARM: dts: tegra: apalis-tk1: major revamp
Date:   Tue, 24 Jul 2018 17:48:18 +0300
Message-ID: <4715215.NZcU7pUVUy@dimapc>
In-Reply-To: <1532443499.6124.31.camel@toradex.com>
References: <20180724104309.21741-1-marcel@ziswiler.com> <2076484.gx54F3eiOq@dimapc> <1532443499.6124.31.camel@toradex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 24 July 2018 17:45:01 MSK Marcel Ziswiler wrote:
> On Tue, 2018-07-24 at 17:31 +0300, Dmitry Osipenko wrote:
> 
> > On Tuesday, 24 July 2018 17:16:33 MSK Marcel Ziswiler wrote:
> > 
> > > On Tue, 2018-07-24 at 15:44 +0300, Dmitry Osipenko wrote:
> > > 
> > > 
> > > > On Tuesday, 24 July 2018 15:24:34 MSK Marcel Ziswiler wrote:
> > > > 
> > > > 
> > > > > Sorry, I meant to write "minor revamp" in the subject line here
> > > > > as
> > > > > Apalis TK1 was already in quite good a shape but this are still
> > > > > some
> > > > > worthy improvements (;-p).
> > > > > 
> > > > > On Tue, 2018-07-24 at 12:42 +0200, Marcel Ziswiler wrote:
> > > > > 
> > > > 
> > > > 
> > > > 
> > > > Marcel,
> > > > 
> > > > All your emails that are sent from "toradex.com" are treated as
> > > > spam
> > > > by Gmail 
> > > > because "This message has a from address in toradex.com but has
> > > > failed 
> > > > toradex.com's required tests for authentication.", is there
> > > > anything
> > > > you could 
> > > > do to fix that?
> > > 
> > > 
> > > 
> > > Hi Dmitry
> > > 
> > > Hm, unfortunately, Toradex was an M$ only shop when I joined more
> > > then
> > > 7 years ago and so far I was unable to convince our IT to switch to
> > > some grown up email system. Therefore, I am stuck with Exchange,
> > > Office
> > > 365 or whatever M$ nowadays seem to call it. Anyway, I really
> > > thought
> > > sending from Android or Evolution via their resp. Exchange
> > > connectors
> > > would properly do SPF, DKIM and even DMARC. I just confirmed this
> > > when
> > > sending something to my gmail address and doing "Show original".
> > > 
> > > Since Linus himself pointed out any of my patches ending up in his
> > > spam
> > > folder I do send them via my private email which while not having
> > > any
> > > advanced security configured should still be valid. Moving it to a
> > > fully secure configuration including DNSSEC and stuff is still
> > > pending
> > > on my side.
> > > 
> > > Can you please tell me which exact email it is that you got this
> > > reported on so I may further investigate what is going on?
> > 
> > 
> > This email from you looks okay. Unfortunately all of your previous
> > emails from 
> > "toradex.com" were getting into the spam folder.
> 
> 
> You sure they were from "toradex.com"? The patches should have been
> coming from "ziswiler.com" resp. "perfora.net".

The patches from "ziswiler.com" are fine, only your emails specifically from 
"toradex.com" had an issue. Looks like you've resolved it now.




