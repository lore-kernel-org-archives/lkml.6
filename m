Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D93EC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43FD22151D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYPjF3y/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43FD22151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732458AbeHOAIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 20:08:15 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36584 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730881AbeHOAIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 20:08:15 -0400
Received: by mail-ed1-f65.google.com with SMTP id k15-v6so10862338edr.3;
        Tue, 14 Aug 2018 14:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ze8rrhvH6SYKPMQZJ2QD7+bnoaUSqElBcjJcHuotmh4=;
        b=ZYPjF3y/z2iPfXVR4MbJ0hXX0wQVr7dQ0/oVPH13m6fPc2ceufQrNvzUXKU3axB7Sd
         XBUjaINTuQnwyAhZHAmNrtaHDyC2O4v3iqXHuckBBiVefVEHQ4ZK4ADTg4YORmSzjnOd
         OI+Itvqva5H4k1JM2/g789OWqvlB8wVMf4eO0hPfMx1+/XkjtKuxBbGfr72W9QxRuRkJ
         p7VY2Nj9kxVSbN4Jce17wenKODvNHyKTsWJLgRPCRxvULBFTs1OWybvHdzc29FBR2Amm
         B315tqyOqCkAwPct4jUzVsNaLGe79XRFEW9KYaPDS6WR4BFXOwwV7ZsYlixGsMeKBoJk
         6kbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ze8rrhvH6SYKPMQZJ2QD7+bnoaUSqElBcjJcHuotmh4=;
        b=lbC/dXXReZMv5/Vf46/z/vT863Z4xXbxe5BGtVfm82Ze59aG2DvKlzCI+ndyTKdxEa
         o1pzQZIC2MvwcRqKikRY42j8cbrW1wua2XzQcyCQovXtD3KsTJCFa0fbq/r8+TAHTruw
         lu2DuYROih2YfFGnpxXjpW7pI32R7Se3wm0iQAAGvdlfUIqIrEBOspTJuFwcQ+zaAZI8
         ECZFkL54cSm+bfVttajrdxVHVRgxfpf39FMfoGTXPryvzEShEX3y6RhF2hOW0GVih3Vv
         G1mGr2t4In6vW1L5dJzsZPz/TD2OJmsgdfQf9X2AJSWT8A76D5xRpO7AfsLDvcG6ImAu
         Op9Q==
X-Gm-Message-State: AOUpUlGCbSTER+K16AC1YKVpT60fG/WIOOijCSsWwCTQo+JxWX3Dw1vL
        XYnioU8CdeFhl5N6OTliCLkACNHY
X-Google-Smtp-Source: AA+uWPwf8I9sPK2+7xAm5l1rB2nzecrkQuT6c32P7T9JZWWSFe0THqR/iVNyF40YF0JloMez0xg13A==
X-Received: by 2002:a50:c01d:: with SMTP id r29-v6mr28938678edb.202.1534281551062;
        Tue, 14 Aug 2018 14:19:11 -0700 (PDT)
Received: from dimapc.localnet (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id v56-v6sm21413587edm.97.2018.08.14.14.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 14:19:10 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH v2 1/5] ARM: trusted_foundations: Implement L2 cache initialization callback
Date:   Wed, 15 Aug 2018 00:19:08 +0300
Message-ID: <1581737.LbIJYaB7YW@dimapc>
In-Reply-To: <20180619110027.16935-2-digetx@gmail.com>
References: <20180619110027.16935-1-digetx@gmail.com> <20180619110027.16935-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 19 June 2018 14:00:23 MSK Dmitry Osipenko wrote:
> Implement L2 cache initialization firmware callback that should be invoked
> early in boot to enable cache HW.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/firmware/trusted_foundations.c | 27 +++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)

Russell, could you please take a look at the arm/firmware/ patches and ACK 
them if they are good to you?


