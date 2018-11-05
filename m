Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A80C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0532085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0532085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387832AbeKFGma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:42:30 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35992 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387441AbeKFGma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:42:30 -0500
Received: by mail-oi1-f194.google.com with SMTP id r127-v6so8861800oie.3;
        Mon, 05 Nov 2018 13:20:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3mXCJxRWdCuXyVmgdb1L7D5AqIJedJzKl/a+bfFI6Iw=;
        b=lkt9mvIUqJUCpLQsN/nBf8tvSXtJkPO0n/LTR5ezyorZBmzVd5eJBOmSdoHc2Cy2Jz
         cC/xrZQWnfxiwOhbHjIx7HTvIa6FtpSKmtsbYmdmJgFlVPMSgeblkRL55L/306FLGk31
         BwyefMKrHsDuJA7yENH7hn0SVtcdul3pY7W6Y5FoCi99YO4mi/AZnAhFZ7hJdqekZf5N
         k4lW7htDGlM0QCymn1LyJIKeUqq2Ws7RTEkYEai4Qr3FuzFEpxMVGrLgJwVKOMmquIKJ
         SwgF4AD2i5jNHZbcxfYDao1xwRBMwhzyMUNsWtTjxlbdtc6spKEk4+lt+9uYO9kAZO27
         c4xQ==
X-Gm-Message-State: AGRZ1gJR9cLRDXA6f1EmQDkSHyOFYQg9GLvdcrwXnXnQlz2El4Wtxi2C
        gbRlyJOC7O4jjvlogyVHdg==
X-Google-Smtp-Source: AJdET5dGMRr6KPzmSx2ZTg/q5/7tu+6MzRHQxjBe2Xs62siCszf+kVU0IEYTeX/30zlQOAR/TIBDFA==
X-Received: by 2002:aca:120e:: with SMTP id 14-v6mr13189477ois.246.1541452851754;
        Mon, 05 Nov 2018 13:20:51 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q16sm12633975otl.43.2018.11.05.13.20.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 13:20:51 -0800 (PST)
Date:   Mon, 5 Nov 2018 15:20:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     thesven73@gmail.com
Cc:     svendev@arcx.com, linus.walleij@linaro.org, lee.jones@linaro.org,
        mark.rutland@arm.com, afaerber@suse.de, treding@nvidia.com,
        david@lechnology.com, noralf@tronnes.org, johan@kernel.org,
        monstr@monstr.eu, michal.vokac@ysoft.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, maxime.ripard@bootlin.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH anybus v3 1/6] misc: support the Arcx anybus bridge
Message-ID: <20181105212049.GA320@bogus>
References: <20181104155501.14767-1-TheSven73@googlemail.com>
 <20181104155501.14767-2-TheSven73@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181104155501.14767-2-TheSven73@googlemail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2018 at 10:54:56AM -0500, thesven73@gmail.com wrote:
> From: Sven Van Asbroeck <svendev@arcx.com>
> 
> Add a driver for the Arcx anybus bridge.
> 
> This chip embeds up to two Anybus-S application connectors
> (slots), and connects to the SoC via a parallel memory bus.
> There is also a CAN power readout, unrelated to the Anybus,
> modelled as a regulator.

bridge vs. host are confusing me as those are often the same thing. But 
here bridge is just some auxilliary controls for the bus and the host is 
the actual bus with devices? I'm not sure why you split this into 2 DT 
nodes? How many devices are connected to the host processor (i.MX) bus?

Rob
