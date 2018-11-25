Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE0EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 23:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A7F2082E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 23:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ossystems-com-br.20150623.gappssmtp.com header.i=@ossystems-com-br.20150623.gappssmtp.com header.b="nIOmaC1U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A7F2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbeKZKDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 05:03:30 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44949 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeKZKD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 05:03:29 -0500
Received: by mail-oi1-f194.google.com with SMTP id m6so2521792oig.11
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 15:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ossystems-com-br.20150623.gappssmtp.com; s=20150623;
        h=from:mime-version:references:in-reply-to:date:message-id:subject:to
         :cc;
        bh=FYBy+rAfS5/DrU1qQA24eg0ZQrivaLwWb0g/alawEhc=;
        b=nIOmaC1UBy3QRydjWJkx26ADHn7AwvlaK1GcWPkeESN06uWV4lJEukp1FmXYjnLVqD
         o7YYGC8GrrGc6PnXFw7J7tCvrjGib8dNJZdEhjbWFOssnFqyMNj0slozRSukaHkRnySL
         len14kvHkQz89AqlGh4L7wOLecTSyc5FpuXnHOMMrAfd2n46dZ9buV+0nVA+FvObjr/i
         hcvAZeQ5RFXJlp1yaOuh9m1o4T2BsRNP7kGk0pFThTETJCefAs56sqwQ0DDI+8e13Q+h
         4bYVdNNYpyRIMZGOYzt+fmaS2P4SaNihp2zhQLfRqCMt9bx3UNtMmbQDfzfhSTuh+1wT
         b8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:references:in-reply-to:date
         :message-id:subject:to:cc;
        bh=FYBy+rAfS5/DrU1qQA24eg0ZQrivaLwWb0g/alawEhc=;
        b=cWRCoXrj7V/6/00OHGoddM39UiZhg4nUOSVzeFPhPEY7ZZSrnwPTK0TxLn2/Z+sWMC
         Xf36AvVD/jYpP2gjk785Kp14VI3I1PHkeQ0mZxtnjXA+82t73V1O944OVSQKbUOrBAZk
         I0FdJCp6Xk5xCdUgi3Oh5Z/68aNmUMBPQTa7+BKJQF/7krBN3Q2BmZS2dTPKDdpV/GYr
         LuF3QdxO017BbIWIfT2mO/tllT0haW4gipafRPpk6+gVtMTNFA/0tkOjF/kGELvgoEq5
         0DX77+ECueiITpAbJWh5UKX1d1UPNqcFV7u/mJZSI06JttjUCDgoAhVGs3G4e43Whwfk
         MCFg==
X-Gm-Message-State: AA+aEWajrk4L61lteaMEyyTm6Q7KUKxvob1Ls6jug9IJv+kFpo5MrwJo
        h9aGWlYPR8lbfVuAaaKdxTNTXPO3mwb45w==
X-Google-Smtp-Source: AFSGD/W/7CAyWHpn+676YvOY6LIgaUzm+mSCZswjqLC1W8UpVgeuAFknzIFOBUZPwTddr6An07k2lQ==
X-Received: by 2002:aca:e84d:: with SMTP id f74mr8668243oih.34.1543187474426;
        Sun, 25 Nov 2018 15:11:14 -0800 (PST)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com. [209.85.167.178])
        by smtp.gmail.com with ESMTPSA id d10sm5185441otl.62.2018.11.25.15.11.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 15:11:12 -0800 (PST)
From:   Otavio Salvador <otavio.salvador@ossystems.com.br>
X-Google-Original-From: Otavio Salvador <otavio@ossystems.com.br>
Received: by mail-oi1-f178.google.com with SMTP id x202so14153307oif.13
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 15:11:12 -0800 (PST)
X-Received: by 2002:aca:5906:: with SMTP id n6-v6mr13203112oib.268.1543187471792;
 Sun, 25 Nov 2018 15:11:11 -0800 (PST)
MIME-Version: 1.0
References: <20181125211907.9895-1-otavio@ossystems.com.br>
 <20181125211907.9895-2-otavio@ossystems.com.br> <CAOesGMjR--5XC1pNMkPHR9BaPfgGfdC8JHAM3oqS3Xte3TQbGA@mail.gmail.com>
In-Reply-To: <CAOesGMjR--5XC1pNMkPHR9BaPfgGfdC8JHAM3oqS3Xte3TQbGA@mail.gmail.com>
Date:   Sun, 25 Nov 2018 21:10:51 -0200
X-Gmail-Original-Message-ID: <CAP9ODKrTZm8FuRWLh+5NZSbpMh_yptotdoEgfrARHypUx8FkMg@mail.gmail.com>
Message-ID: <CAP9ODKrTZm8FuRWLh+5NZSbpMh_yptotdoEgfrARHypUx8FkMg@mail.gmail.com>
Subject: Re: [PATCH 02/13] ARM: multi_v7_defconfig: Add missing systemd options
To:     olof@lixom.net
Cc:     Otavio Salvador <otavio@ossystems.com.br>, stefan.wahren@i2se.com,
        Fabio Berton <fabio.berton@ossystems.com.br>,
        alexandre.torgue@st.com, arnd@arndb.de, eric@anholt.net,
        Tony Lindgren <tony@atomide.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Russell King <linux@armlinux.org.uk>, yannick.fertre@st.com,
        linux-rockchip@lists.infradead.org, horms+renesas@verge.net.au,
        geert+renesas@glider.be, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Olof,

On Sun, Nov 25, 2018 at 8:25 PM Olof Johansson <olof@lixom.net> wrote:
> Thanks for these patches. I don't have a reason to _not_ enable
> systemd features, but would you mind providing a brief description of
> what's not working without this change? Is it completely broken, or is
> it just the random-UID featues that don't work, or something else?.
> Useful for others to know what's expected to break if someone turns
> them off, etc.

Thank you for your kindness reviewing this. I am not an experienced
Linux kernel contributor so I am going to do some mistakes during this
process.

We usually follow the required feature set listed on Gentoo wiki[1] as
it is usually up to date and avoids a lot of headaches for us when
dealing with boot issues with SystemD.

1. https://wiki.gentoo.org/wiki/Systemd#Kernel

Do you think mentioning where it has been taken from is enough?

> Also, I noticed you posted a series of 13 patches, which includes some
> dts files for rv1108, some network driver changes and some of these
> more generic defconfig changes. I would suggest that you split up your
> patches into independent series where possible, especially when they
> end up going to different subsystems. Providing suitable cover letters
> for the series when you post them is also useful to help reviewers by
> summarizing the series, including changes from last time it was
> posted, etc. Please address it to the superset of patch receivers on
> the series.

I can certainly improve it for the next submission. Should I split
them all and tag them v2 to easy it?

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9 9981-7854          Mobile: +1 (347) 903-9750
