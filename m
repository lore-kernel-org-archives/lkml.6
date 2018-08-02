Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C51C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E6A214D5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMF58R3t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E6A214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732274AbeHBM0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 08:26:23 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35567 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbeHBM0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 08:26:23 -0400
Received: by mail-ed1-f65.google.com with SMTP id e6-v6so771631edr.2;
        Thu, 02 Aug 2018 03:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NXN6oXRY6Z9sshk0JA7uw7aJElwuGvPnjrUMHUeJq6Y=;
        b=CMF58R3tKCvr5BFvtMMDwhFmP9n+LCAjROykR8cJ3Mmay8dl1TvHnYtRhk/uohIQho
         2PQeAxLTgyvOVuIXCk6iqJMHlPTwnvb+Ln/lAz+PLCQipTy/RFSEIRtChFm7eoUh4IJK
         4kfIl9MTt1pdteh7uZ1rFIS50Tubve/3urz87bNx6Gjr/WtdDQY5M+Cg6JlyA14qe5ue
         RBGf8OVkWWwELz9yJ7sMcuNLz97AY9NgQxI/a4+OfkJG/IdG7LO2o8NjPYqUInkcywMI
         U8Wfg3Q1wTskuZyvf98j33HzQsqEHGe5RRzzxJHUrwvDViQAb5IkmTcZD61JoKbypBTI
         pq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NXN6oXRY6Z9sshk0JA7uw7aJElwuGvPnjrUMHUeJq6Y=;
        b=Ms4r46/UpVxmxG7v0/lb4QCJKPE0LYynT4EXg3dmT4XvpRNihNVsFxdQmGgo+9VBOR
         M9xV5ZlKQY3XXh9NWTkuaEYnwZgCTcAQbmnakBgS8W66kOC4K85t4u66PXI9YprnCGTw
         ze0PyPJCoQrIEPGX55zsq0jG6wYhkmrw3wGqrpMiO85s4aOL6oozx9Lzg2NrHyNauYWS
         X78n3I2E/gJvtpH1Ez8XBITsxPsRkUpYmFEhRSt7EN+kT4E3vYwga+t+w18AHR6TWMZW
         AMwFi5VGW8iyephnPgYNPygeYqJJmdSpYAunXSAz9drg3WFu8Tywb56Ge2mqN44k8oFJ
         OQKg==
X-Gm-Message-State: AOUpUlFIu7Hq21+PsW7HT8XDTGyoPO98FUKNgYeQNgt66qdtq5boZNJ9
        6A7FNjgtsdi+LqKul2C53M0=
X-Google-Smtp-Source: AAOMgpdeX8LZlIzKMb+YpOcaiFhCqaDU2oyrMa4B7hu1tSz1skMg7WnMgSoe2ioRV9vN5CQB20HAUA==
X-Received: by 2002:a50:fd93:: with SMTP id o19-v6mr2681507edt.73.1533206148973;
        Thu, 02 Aug 2018 03:35:48 -0700 (PDT)
Received: from dimapc.localnet (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id g1-v6sm670471edr.52.2018.08.02.03.35.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 03:35:48 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Stefan Agner <stefan@agner.ch>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linus.walleij@linaro.org,
        pdeschrijver@nvidia.co, marcel.ziswiler@toradex.com
Cc:     keescook@chromium.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: tegra: readd gpio-ranges properties
Date:   Thu, 02 Aug 2018 13:35:46 +0300
Message-ID: <2268060.eSddBDDeqC@dimapc>
In-Reply-To: <2777476.ese58fB1FL@dimapc>
References: <20180726154025.13173-1-stefan@agner.ch> <17f1c1b1c6d3a83dd1df130420057d3b@agner.ch> <2777476.ese58fB1FL@dimapc>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 2 August 2018 02:11:23 MSK Dmitry Osipenko wrote:
> On Thursday, 2 August 2018 01:51:42 MSK Stefan Agner wrote:
> > On 01.08.2018 22:51, Dmitry Osipenko wrote:
> > > On Thursday, 26 July 2018 18:40:25 MSK Stefan Agner wrote:
> > >> The properties have been commented out to prevent a regression a
> > >> while ago. The first regression should be resolved by
> > >> commit 44af7927316e ("spi: Map SPI OF client IRQ at probe time").
> > >> 
> > >> The second regression is probably addressed by
> > >> commit 494fd7b7ad10 ("PM / core: fix deferred probe breaking suspend
> > >> resume
> > >> order") and/or maybe others. Readd the gpio-ranges properties to see
> > >> whether regressions still get reported.
> > >> 
> > >> This reverts commit 4f1d841475e1f6e9e32496dda11215db56f4ea73
> > >> ("ARM: tegra: Comment out gpio-ranges properties").
> > >> 
> > >> Signed-off-by: Stefan Agner <stefan@agner.ch>
> > >> ---
> > > 
> > > Unfortunately the second regression hasn't been addressed yet, this
> > > patch
> > > still breaks wake-up using GPIO key. BTW, better to spell "readd" as
> > > "re-add".
> > 
> > You do have the hardware and could test it?
> 
> Yes, I have.
> 
> > Hm, that is unfortunate. I think this was the patch which should address
> > the issue:
> > https://lkml.org/lkml/2015/9/10/218
> 
> I've tested the patch and it is still actual, i.e. it fixes the wake-up.
> Welcome back to 2015 :-)

Actually, the pinctrl-gpio probe order is easily fixable by reshuffling the 
drivers registration order within the kernel. I'll send patches.



