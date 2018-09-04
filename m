Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6B8C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8518820843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aB6TeOSk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8518820843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbeIDNax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 09:30:53 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40052 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbeIDNax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 09:30:53 -0400
Received: by mail-lf1-f67.google.com with SMTP id x26-v6so2322879lfi.7;
        Tue, 04 Sep 2018 02:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-transfer-encoding:content-disposition
         :message-id;
        bh=Xo/9ODQ1eP0jXKBoNDINSBpq5qNIp8iTqqMDjfd6kAk=;
        b=aB6TeOSkoV7c/l3oDWK/mF56N/m8Hc4A7kS7Mw5gZ7lwhYiN+OnixA7iOzfZcpkUay
         uxa9r0DNs+hCZE61m2+ACR33QHyPuM8YpEYHXaBPqEdR5cs8Kmwxcfx2x6/OLsQUQLB3
         /P32glb0PDSKoY1kl2hbT1BftKXI9KsMIu5canJA8rbMOjXEpCDHnuGpuxlUsXqoXsrT
         OXXFWQJuNLYoiGsQ6OLXZLNKclEElaBHPeDZLxODxCHohfemaj7QkO/0EPP5m0t2owRN
         /46MnAm0zeiZt7x8U1b0xkkuClHs5VIV26Lt/DPea7qt6C61akE0g3G+KrM/IFn4S5kD
         HxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-transfer-encoding
         :content-disposition:message-id;
        bh=Xo/9ODQ1eP0jXKBoNDINSBpq5qNIp8iTqqMDjfd6kAk=;
        b=qC/3NyylPlH934L428R4aFKEX8NXk/YMwOwPWHHFgrad12C80ns9Kur2BlYbt+N5Xx
         3KwL9HP5ZsI1T9hLYiEciWMJHlPxXf0AQOiBBByfaKgRbf7HNzyQjLXdHs/aCw03ATsA
         WQv22aKtyxF0oheuH/Omaq5cPFKk6FhZzUVto1P8xQGw6u8HLyK0+VQVd7odCqpkz7ER
         pjndvE86H8N0Srmw+wnMK2vaZ9EQnSHqYdld6XrlI9b7Zo9pejHwd0NWSLrF5xFK/UzZ
         NsUJgqzCAKnSq2pcTVEjtNgucoM78nP6ZIz53LnjHz33dGb52pSmhUVMo/NIdv7ChL/H
         mbXw==
X-Gm-Message-State: APzg51Btp8JpXf5OSc/D1F1lWZTCDPWiUJrp1dPp8PbCsPHUCqf7C82l
        dLIyjaYO66YW6/hoLDbmZfc=
X-Google-Smtp-Source: ANB0VdYSs9YrQGVyAaS4QTwVSffs6FcijFRxHY+blJvgFENdJD1LxQo2wc9pv29KON7l8GyZSCTXuQ==
X-Received: by 2002:a19:518a:: with SMTP id g10-v6mr20941333lfl.136.1536051999551;
        Tue, 04 Sep 2018 02:06:39 -0700 (PDT)
Received: from dimatab (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id h90-v6sm4183193lji.66.2018.09.04.02.06.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 02:06:38 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Subject: Re: [PATCH v2 2/2] clk: tegra20: Enable lock-status polling for PLLs
Date:   Tue, 4 Sep 2018 12:06:36 +0300
User-Agent: KMail/1.9.10 (enterprise35 0.20100827.1168748)
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180830184210.5369-1-digetx@gmail.com> <909e2a52-4116-9ee7-db23-8ea1dfffade0@gmail.com> <20180903080111.GR1636@tbergstrom-lnx.Nvidia.com>
In-Reply-To: <20180903080111.GR1636@tbergstrom-lnx.Nvidia.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201809041206.37080.digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 September 2018 11:01:11 Peter De Schrijver wrote:
> On Fri, Aug 31, 2018 at 12:45:17PM +0300, Dmitry Osipenko wrote:
> > On 8/31/18 12:29 PM, Peter De Schrijver wrote:
> > > On Thu, Aug 30, 2018 at 09:42:10PM +0300, Dmitry Osipenko wrote:
> > >> Currently all PLL's on Tegra20 use a hardcoded delay despite of having
> > >> a lock-status bit. The lock-status polling was disabled ~7 years ago
> > >> because PLLE was failing to lock and was a suspicion that other PLLs
> > >> might be faulty too. Other PLLs are okay, hence enable the lock-status
> > >> polling for them. This reduces delay of any operation that require PLL
> > >> to lock.
> > >>
> > >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > >> ---
> > >>
> > >> Changelog:
> > >>
> > >> v2:	Don't enable polling for PLLE as it known to not being able to
> > >> lock.
> > >
> > > This isn't correct. The lock bit of PLLE can declare lock too early,
> > > but the PLL itself does lock.
> >
> > Indeed, it locks but can't be polled for the lock-status as it doesn't
> > have the lock-status bit.
> >
> > Do you want me to adjust the commit description or it is fine as is?
>
> I think it's better to adjust it.

Okay. I expect to get a review from you for the other clock (and related) 
patches too and will send the new version once all the current patches will 
be reviewed. Please take a look at them once you'll have some free time, 
thanks.

> > It is also a bit odd that PLLE has "lock_delay = 0", is it correct?
>
> That seems odd yes..

:)
