Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956BEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E2620851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OHUDPdBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbfAQUDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 15:03:46 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42304 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728801AbfAQUDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 15:03:44 -0500
Received: by mail-pf1-f194.google.com with SMTP id 64so5334291pfr.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 12:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=qwZJUgpwArcYqTNlUheNWb60xm1WHexmmM4IJW32JdM=;
        b=OHUDPdBsNo9GmlFAqXB0smBY/lIdrq9H0h6k1ABkxT++YpcB1rV2kG4J3f5cv6Aq0i
         SZWHB/9xgsyensRvjc45Y6z48cxvsp6rtHPjoaIY5E4FY+FNv6nnMgefGn4o8y7pkXYN
         WsjXJeAZSfUI/V3pnIErP0OnA4k1NYm75gAhZxTRIWbsTg09V+LuY5yJHN3WyQFhPa/r
         flpKdG+CsOI5nsNJqAt2xocXqIFj5GWryM4YB5G/EbE2LesUcae8MSGhmwdBtPNUNNad
         3n4HhlJ8aB1/+NW50nkzs4FBBdBZrE4ENT6QLBHXI8kuannCdsbZAVnRKTsBlR7T1rgi
         CRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=qwZJUgpwArcYqTNlUheNWb60xm1WHexmmM4IJW32JdM=;
        b=IKExDC8Oi9KjOq3nbcV0orVwrW5GRD7kYQTLokKlPpx3sus41up5Oi5BlGZElaYMdI
         zIslamx1Baqp5noGdcyx5eW+wbyZaBi6HFFvYcSm03wK2u39h9nwD6ctBsxtdARfjccx
         lOaTRlfWFRsDyUPsJHAyAz4rqnz8XqPGmVMC0X55L1zT4aW5Rmyty0B7dWWEvY6yR3LY
         DWMtgXa06mYKtx1UcN+xbHC3ZGKU6QcDGjIX8/cgDO5dqTY5PWF2qfNoyt2QAna9bqm7
         nMZrlZ2zfrDmCsBfaXbf93j3NU7kapRrnTnVQmvL1nVsYQteaWCPwsbjQhfAxmVdLMNv
         Jt6w==
X-Gm-Message-State: AJcUukdEZ/b5FLf3UZrOISqYQz4AilXVNv5G0u75cGZ1WEKwa4wps38J
        9XDre5CVi1jqj8AznvHurCi6kw==
X-Google-Smtp-Source: ALg8bN5FdbamzsRdYz7zzTszh7hifTI9+iTUYb3bEydV+6vx55bv7HRZt5HqRJncx+rqLeHQ89muAQ==
X-Received: by 2002:a63:e5c:: with SMTP id 28mr7517016pgo.369.1547755423975;
        Thu, 17 Jan 2019 12:03:43 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:e076:9fe9:59e2:1e0b])
        by smtp.googlemail.com with ESMTPSA id 85sm3452328pfw.17.2019.01.17.12.03.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 12:03:43 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: Re: [PATCH] arm64: dts: meson: s400: fix emmc maximum rate
In-Reply-To: <20190116175947.6093-1-jbrunet@baylibre.com>
References: <20190116175947.6093-1-jbrunet@baylibre.com>
Date:   Thu, 17 Jan 2019 12:03:41 -0800
Message-ID: <7hr2dbaw6a.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Limiting the HS200 rate on the s400 was just a way to mask that the
> tuning setting were not correct. This seems to have been fixed with
> the recent MMC driver update. We can now use HS200 at full speed.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Queued for v5.1,

Thanks,

Kevin
