Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7319C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640FE20882
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VJd2oRfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640FE20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731973AbeG2XJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 19:09:49 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35369 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728824AbeG2XJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 19:09:49 -0400
Received: by mail-it0-f68.google.com with SMTP id q20-v6so14274524ith.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 14:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MzIlMg4SU8Cpsy8k36jlTE1lyYh9N+3HBHuAR1ei+ig=;
        b=VJd2oRfSh9VpwLvBu4YARoV0+MIAZaYtUit1U/Js0m9fbp4QL+hnzpcbZngNF8ewU3
         DL3V6gnJEDxFbwEiPnHclRpM58lB5fhxrZTASHgtFFSh1QZ4gJzKi44eXxNeI4kM5W3d
         +3nPuLUzCUZT2UYnoGl9FfFJUrb9Gq2xV4Psc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MzIlMg4SU8Cpsy8k36jlTE1lyYh9N+3HBHuAR1ei+ig=;
        b=fuexwlUOuttjSZ2i3oI6LDVhMkSUY8++NQeqbCFWcpwkmEC2p5fw5n4HaGD+X0xGdf
         yfuCigQ1lrpORK+UxpH/IOm6AqzR0VWwl4zQnrydBqOVBv9CtlX5FhlWRnuuX9EZY2H4
         tR1BRg/cmQCq7CIiOrbQndnCTsHWNty+EHJUNUS2eOO+R0lLHY7xKf9ndrcXho93ThVS
         Q3z7OH3vSqtKEdEo2Fd0LHwTu/6/kwp2O/oWhUYLyX5Wfn2Z/oQWZZ3cWMBObDUAvElz
         VhAlT90Tv1A4diQoXZ1PSFJIcNru4FEeru9IZ3vokkR5fIErbzV7pXVQpJJIYD6izoR0
         A/NQ==
X-Gm-Message-State: AOUpUlEr4IK1xqSUJt1lB3T+eNMVop2sgWC3irFZAt4ycpMjTZ6Nq8ID
        0psJj/ZzjjrR/Aq59MZ5/j6xadJTaJbCq1p4ZA30+Q==
X-Google-Smtp-Source: AAOMgpc4d/5zaRrqLhYw14P9kRbqKUU2lalSXl2cTwwjtXmliBFgEDOz+ogvJv0sndkOl2zekB/YO6iNBLNt3IH2xfQ=
X-Received: by 2002:a24:2c49:: with SMTP id i70-v6mr12625819iti.135.1532900272637;
 Sun, 29 Jul 2018 14:37:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180726154025.13173-1-stefan@agner.ch>
In-Reply-To: <20180726154025.13173-1-stefan@agner.ch>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 29 Jul 2018 23:37:40 +0200
Message-ID: <CACRpkda2SouLeKO8UrRxwQOwKtwsiUctE0cu3YKKj8C2SViSbw@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: tegra: define GPIO compatible node per SoC
To:     Stefan Agner <stefan@agner.ch>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.co>,
        Dmitry Osipenko <digetx@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-tegra@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 5:40 PM Stefan Agner <stefan@agner.ch> wrote:

> Tegra 2 uses a different GPIO controller which uses "tegra20-gpio" as
> compatible string.
>
> Make the compatible string the GPIO node is using a SoC specific
> property. This prevents the kernel from registering the GPIO range
> twice in case the GPIO range is specified in the device tree.
>
> Fixes: 9462510ce31e ("pinctrl: tegra: Only set the gpio range if needed")
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Patch applied.

Yours,
Linus Walleij
