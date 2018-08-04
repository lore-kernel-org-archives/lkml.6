Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41505C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC222217BD
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtNH1bM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC222217BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbeHDQCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 12:02:48 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39046 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbeHDQCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 12:02:47 -0400
Received: by mail-ed1-f65.google.com with SMTP id h4-v6so3118103edi.6;
        Sat, 04 Aug 2018 07:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PsTNT+sIh9KcjwB+Cm8P3Z1IQB7Tu9+O9j0/sPlkYdo=;
        b=AtNH1bM+6Q1H86HOPs8c/92eJyuPvvreLIbz7140BvS+FmtiMW7sDOSL+Q4q4YViQw
         oKz8qUfaTBqgLNS2ipMKfAqPQ1WUrAUgYprqVEYWQx2kdT6HKPw/43HmdbPUGASqcNxq
         bfcb+y5RyqWXk3SpmE6s3msNzREbNA4wkhBIts0k1knHVZyI6wj+GFevsiASVnI6wpR9
         BKWH250PByIgdvSPQDPlSyvz+GuS4LFUFRkB5oMwiDWJ409S8kiJRLGw6IVzQxd3c46x
         KqhVmAzTxJjsZk8BhTZImrl3oarr03TmtqQndeXWlm1IiwzgZQY+wSJ+OLTDrPjyBLI+
         O8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PsTNT+sIh9KcjwB+Cm8P3Z1IQB7Tu9+O9j0/sPlkYdo=;
        b=AyyFhEF8EnTORckFhGZHR7VIO9QSomcJ0hnSDff3WIQuzpx6WZ3Lwql1HjXioteKc4
         9GN6y/ffAegSeQ3G7JL6jfIRa8EYQKCPOUAJfzc08VueIkW/yTvKwCHVjhUy97aQtA3y
         /V4yGAilO7FTAmvdsGR2BxONaCagvCuEOWkdwckbR6y26835hg7AnOoZq5bQvNau+NhF
         APhjbKAetlWI74yOFqGPDydjHVCd2Q7gTGMf8mAXSCPSHTWwsaRpU+sNynA0XQhxqejW
         6nVfnrVciF+SgRGjyIqYeTcJUZVN/5XKVfuVuNb8PPxrmATrTeJwerngOefw68BqCc4J
         cbyw==
X-Gm-Message-State: AOUpUlFDOgEld7boaoYzQTsXzZ46YnZyvTCB+5UWgaojTwIaqN1q0UM4
        gssa5mxi3mSbX5dio45O8jI=
X-Google-Smtp-Source: AAOMgpfBWy0fdNt6HArGvlqi05kYDgUiKIK6fnM9Hnl5FljKM2CTLh0oHg30PfposoKHZKjsNV+IFg==
X-Received: by 2002:aa7:c6c2:: with SMTP id b2-v6mr10822948eds.302.1533391318025;
        Sat, 04 Aug 2018 07:01:58 -0700 (PDT)
Received: from dimapc.localnet ([109.252.90.13])
        by smtp.gmail.com with ESMTPSA id i15-v6sm5855997ede.66.2018.08.04.07.01.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 07:01:57 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Stefan Agner <stefan@agner.ch>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        linux-tegra@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] pinctrl: tegra: Move drivers registration to arch_init level
Date:   Sat, 04 Aug 2018 17:01:48 +0300
Message-ID: <2738202.Xfnp0pFbCN@dimapc>
In-Reply-To: <CACRpkda+t=0aJMSKre+U-GHN2d47pV3b_g13PcinXScP_UX5Ng@mail.gmail.com>
References: <20180802111144.12512-1-digetx@gmail.com> <20a52a0461e32e776e526171c250551a@agner.ch> <CACRpkda+t=0aJMSKre+U-GHN2d47pV3b_g13PcinXScP_UX5Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 3 August 2018 20:24:56 MSK Linus Walleij wrote:
> On Thu, Aug 2, 2018 at 1:31 PM Stefan Agner <stefan@agner.ch> wrote:
> > A while back at least using those init lists were not well received even
> > for GPIO/pinctrl drivers:
> > 
> > https://lore.kernel.org/lkml/CACRpkdYk0zW12qNXgOstTLmdVDYacu0Un+8quTN+J_az
> > Oic7AA@mail.gmail.com/T/#mf0596982324a6489b5537b0531ac5aed60a316ba
> You shouldn't listen too much to that guy he's not trustworthy.
> 
> > I still think we should make an exception for GPIO/pinctrl and use
> > earlier initcalls. Platform GPIO/pinctrl drivers provide basic
> > infrastructure often used by many other drivers, we want to have them
> > loaded early. It avoids unnecessary EPROBE_DEFER and hence probably even
> > boots faster.
> 
> When we have the pin control and GPIO at different initlevels it makes me
> uneasy because I feel we have implicit init dependencies that seem more
> than a little fragile.

Yes, it is not very good.

> My recent thinking has involved the component method used in DRM drivers
> such as drivers/gpu/drm/vc4/vc4_drv.c where a few different component
> subdrivers are linked together at bind time (not probe time!) into a master
> component.
> Rob was no big fan of this but the DRM people like it and I was thinking to
> make a try at it.
> 
> This way we could at least probe and bind the pin control and GPIO drivers
> at the *same* initlevel and express the dependencies between them
> somewhat.

Sounds interesting, maybe you could help to convert Tegra drivers to a such 
method and others will follow afterwards.

> > This should definitely go in, at least as a stop gap solution.
> 
> Agreed. (And patch applied.)

The best solution will be to fix the deferred probing, it's awkward that it 
could break suspend-resume order. Hopefully somebody with a good knowledge of 
driver/base will manage to fix it eventually.



