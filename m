Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E7BC46464
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17A92086C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="n/ggGP2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A17A92086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbeKGHtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:49:40 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36864 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbeKGHtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:49:40 -0500
Received: by mail-lf1-f67.google.com with SMTP id p17so10066519lfh.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 14:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9zZvvPwsGBroj85YG3ziNGW9xNZkOTOpbiaqB60/LG8=;
        b=n/ggGP2BJd1lXWFU0191zC0w/Cg6DNSsF/cDJXRQ8HenyHNtajv6X2hqfG4y35S7XU
         MAB3uL+uRWBbiiCccKWm5x5gguZOYxVI6SrpDQJzhB6Y+49oCtNpoTWGga3FdLYvFhDL
         cz3y5UBQXsEk7NFsn/SYB0al69LBRo1ZD1CZRbqY0XMzvhRZUn6gOUqB+7hxf9an9f/e
         d4dlNNXW09A85WbC8pvOJifpRoaWjCVozP6JKhyCc5Ceoza9ZfV72K3t1DKuzUHqwcsl
         US/gTceVppSmEAW3y/B0lJsrC7enYDGwtcYhGPn1xb3zntsuaZvtCcTEFCYGssqw295Z
         6KUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9zZvvPwsGBroj85YG3ziNGW9xNZkOTOpbiaqB60/LG8=;
        b=MSdRXlzV7dhEeTvdS0gFH0rvtfa6/BPBQ8uGRC/mCu0hcbMEZ3t7T8cG4/8eu7GhZG
         ZlxSwsM4Ywt/9YIkFgrMQtIkVgi8KyMN8xQ/ys5AAnYhJDhdbX1nxDWxtal+ZTL0C4s1
         f8/4S5KYqalOeIlus+00huexWrYna2qdYlhpnuRu0SVk5waVcFkiYuqtKOvGpe3KomZZ
         7j//BDnnAUUi4cwJh/rir1xsWU98ESdhBWqajt/wdqRStHS9wPv0YSx0IS3uIJVnFOum
         Xd0b9jGGp34asUaUJQZPQkI1+99l0PUPh/GQgqxsrMRWAi3XJH5/IvKFnhaTBwqm9i+5
         Yjow==
X-Gm-Message-State: AGRZ1gIRr0XlErgutd88ECONpro/1w2Qu8IqjoxMgIQTRrepiHIUgBDZ
        W23McS+45eYuoYqLFxHhIEiMOOHIP0hFviVJBfpyhg==
X-Google-Smtp-Source: AJdET5d91v6juPzlnj1ui0xgvN15F06CW+3BWfT904Gf4NE8XfOz7qbEfoOzy9TWi9jkHLU+jc3qG9vMlFdLHKOPPaY=
X-Received: by 2002:a19:4c02:: with SMTP id z2-v6mr15718648lfa.48.1541542932548;
 Tue, 06 Nov 2018 14:22:12 -0800 (PST)
MIME-Version: 1.0
References: <CAOesGMgVPsK9YsV2nGoBptWwtHYv=3yMytLx2_tF_ujS5c5p3Q@mail.gmail.com>
In-Reply-To: <CAOesGMgVPsK9YsV2nGoBptWwtHYv=3yMytLx2_tF_ujS5c5p3Q@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Tue, 6 Nov 2018 14:22:00 -0800
Message-ID: <CAOesGMiKMfvLQaqmruMs_sGcJ6i9z=GCApmMBn+CkO+8z0-=7g@mail.gmail.com>
Subject: Re: [TECH TOPIC] SoC maintainer group
To:     ksummit <ksummit-discuss@lists.linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>, rmk@armlinux.org.uk,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kevin Hilman <khilman@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 2:16 PM Olof Johansson <olof@lixom.net> wrote:
> Mike Brown (gpio/regmap + more)

_Obviously_ Mark Brown, not Mike. D'oh.


-Olof
