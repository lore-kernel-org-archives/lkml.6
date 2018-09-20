Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF071C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FFC52154C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDwS4pER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FFC52154C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbeIUE2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 00:28:16 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35298 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbeIUE2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 00:28:16 -0400
Received: by mail-lf1-f67.google.com with SMTP id x20-v6so9814302lfg.2;
        Thu, 20 Sep 2018 15:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6oyuf8xff154pzJKk83nIp1tzIZ7DE6n4kvor30qYcc=;
        b=BDwS4pERPIr93LjbOspNCRoKaIRHJG17eQn7u0YE7H9i88yd0DPMr4XEkorWWk6ePE
         53jp2i4aGZG5F9wbaICZRGa7hY2F9z+p4IAyRP5JlJ5TD9Oj+mVzU2grGxREArisb19K
         ICcXMtpSQJ5uR/lBLDrWz3ZHOsxnK2AI04eG2oQaQw7s/HfUc8AcExAFERabQT6z+dli
         ahv2/mCGSw3KRcztT2i2zCO0LWyi7OnnHWNpX7dSyZtX4IQ24LuNCN7bX98tDrrpxpML
         RwsacMFjgC2OT2KPGaK5+7vH5EW4EH5Ntq+uqgYI/l55sKse5iTJ420gLGbPYEFqlqhB
         Z0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6oyuf8xff154pzJKk83nIp1tzIZ7DE6n4kvor30qYcc=;
        b=erSF/xOgM6Qa67Neks9IvCAhMR4Lq6mJuVTSSnXWxqWQamaoOQOKehs1DHWiRQckl1
         fpu+xwenMdKA8t6GBir5Humb59TcD8Z2SxfTRRf/SsfQFnIX+oktRJuEe5UQ7qbdGXZG
         mQlvLbbR2vULf41Iy3DbrOLvoPj4bTnfZVFGjrcLeMfvdiKARJWSielGRNQJsFsdpzQg
         lBRnYh0Hg6W5+I7CbrhRCpR/X9chXMwmX4YNaTN+/AsgpWiXCV4z9gVasapO45HMpNt/
         lFiLHDnNh8kgRKiexRjI4D4VJwbdAtZ/SHbm3SVGLAMnjj3X3grO8jsWNiF8JO785BOB
         y2KA==
X-Gm-Message-State: APzg51D0zeSZ2Qnlkq/BDOBJxfQ64jEoRRR1iJbmt+jfhzfntwT0RcH1
        1BLRpi8cttjSTITI3JZTurenP3QRrr+M4A==
X-Google-Smtp-Source: ANB0VdbNs9HHcRiXeXSmcTwZF4iH9JR4kk8w2my/zod6zzL/toEFSOunv131dZz2Nz6bW8GPQZT78Q==
X-Received: by 2002:a19:518a:: with SMTP id g10-v6mr11266158lfl.63.1537483348123;
        Thu, 20 Sep 2018 15:42:28 -0700 (PDT)
Received: from z50.localnet (apn-37-248-215-56.dynamic.gprs.plus.pl. [37.248.215.56])
        by smtp.gmail.com with ESMTPSA id j9-v6sm4616259ljh.40.2018.09.20.15.42.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 15:42:27 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] ARM: OMAP1: ams-delta: Clean up GPIO setup for MODEM
Date:   Fri, 21 Sep 2018 00:43:49 +0200
Message-ID: <4137539.DlEMru2qd5@z50>
In-Reply-To: <20180920212326.GS5662@atomide.com>
References: <20180820181333.2527-1-jmkrzyszt@gmail.com> <2690911.AdkODg5D9b@z50> <20180920212326.GS5662@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Thursday, September 20, 2018 11:23:26 PM CEST Tony Lindgren wrote:
> * Janusz Krzysztofik <jmkrzyszt@gmail.com> [180910 21:52]:
> > On Monday, September 10, 2018 1:44:16 AM CEST Janusz Krzysztofik wrote:
> > > 
> > > Convert modem related GPIO setup from integer space to GPIO descriptors.
> > > Also, restore original initialization order of the MODEM device and its
> > > related GPIO pins.
> > > 
> > > Cleanup of MODEM relaated regulator setup is postponed while waiting for
> > > upcoming conversion of fixed regulator API to GPIO descriptors.
> > > 
> > > 
> > > Janusz Krzysztofik (3):
> > >       ARM: OMAP1: ams-delta: assign MODEM IRQ from GPIO descriptor
> > >       ARM: OMAP1: ams-delta: initialize latch2 pins to safe values
> > >       ARM: OMAP1: ams-delta: register MODEM device earlier
> > > 
> > > 
> > > Changelog:
> > > v2:
> > > - rebased on v4.19-rc1
> > 
> > Hi Tony,
> > 
> > I forgot to mention: please apply on top of "[PATCH v3 0/3] ARM: OMAP1: ams-
> > delta: Complete driver gpiod migration" series. Sorry.
> 
> Hmm but then in that thread you said that it won't apply.. So I'm applying
> this series into omap-for-v4.20/omap1 branch. I just modified the second
> patch in this series for the unchanged header location.

OK, thank you.
Janusz

> I suggest you send the mtd patch separately to mtd maintainers, the fb patch
> separately to fb maintainers and then let's do the header move after all
> those are merged as a clean-up. That avoids some dependencies between these
> branches.
> 
> Regards,
> 
> Tony
> 




