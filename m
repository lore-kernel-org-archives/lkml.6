Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C36C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 23:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB76208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 23:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/j6+11c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB76208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732376AbeHBA7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 20:59:37 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:47028 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbeHBA7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 20:59:36 -0400
Received: by mail-ed1-f66.google.com with SMTP id o8-v6so232063edt.13;
        Wed, 01 Aug 2018 16:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GbMdsfrRAvTYntLxhEW2T2jHUz7cg0OAmZMn94ilYrg=;
        b=p/j6+11cqMQJ2GP2NwdR9cMPfoAIEFKHxHZuiHujbEyy+mOu0J1UIUbhxhNFqnox/q
         XtjVmB1fKAFphgqLPG+Nc3Sm4NNUljXsQ3PBEHmqOTym8aW65vHwLhaAHQ7LEDjNbS2h
         BdhjP7A1xmUlThvEpjHjs5oAhakO76semo923d7acFzGPOnUQD42QGP18uhOa21boUCY
         XkLOW6tH6UEMRSZMZs6xGXIYbDXXcf+9xe+VYEQftfRgCjaZ9cISDvIS81s1wza8ltX5
         B+51oTOjeyNzwcx1jZg1sjUPvUSTgQBH7UNYYThxzDAawU0x6sceWs4H5NHzM/NN0jlk
         1Log==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GbMdsfrRAvTYntLxhEW2T2jHUz7cg0OAmZMn94ilYrg=;
        b=AmcojrR77bO+fkB9+DC1D/Rt8T4NtxD18Ps09fPUJCXOfbXmr7g7SVRs5mVYU9agzv
         Fkynaq4D83VpzJOdD5Fo+w1VGZNkLlmYjkPdzVnnG//N9ZHKlCLqIaN4TZK0BJfiylVZ
         rvwh68GTeICuSZrtXzl3sVcqve3wthT5A7py1mERQalslo/v8k4JT+Prj5pp/Vci5yip
         wNY4/kE7VnJvQAcoxvD5f+HtwHYgbZ0LH/LZpfFN/qeH3a3zSKPHpwr0c7/okvAJuICJ
         xdWLDX5ueChkh2AjPTcuNAyzXKT0s5hJSnEjgk1dMgWcJebBuLRnJSnOjHZVuATx7ezi
         bfyg==
X-Gm-Message-State: AOUpUlEwsNekIa2Fhpilp86pB7keWRC08A1fCdX6g80WvMovHjBnpvDB
        C4C6vk4Y76bxyF3TIRgBKFw=
X-Google-Smtp-Source: AAOMgpeXTMjUBiQLLblirVzJvTKtcTXd5BWtIc7/Zf7iHbV22T6EhYFyX4s9dXpZlUus1RHLFjM+iA==
X-Received: by 2002:a50:d65e:: with SMTP id c30-v6mr728011edj.178.1533165085648;
        Wed, 01 Aug 2018 16:11:25 -0700 (PDT)
Received: from dimapc.localnet (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id i15-v6sm183547edq.56.2018.08.01.16.11.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 16:11:25 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Stefan Agner <stefan@agner.ch>, thierry.reding@gmail.com
Cc:     jonathanh@nvidia.com, linus.walleij@linaro.org,
        pdeschrijver@nvidia.co, marcel.ziswiler@toradex.com,
        keescook@chromium.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: tegra: readd gpio-ranges properties
Date:   Thu, 02 Aug 2018 02:11:23 +0300
Message-ID: <2777476.ese58fB1FL@dimapc>
In-Reply-To: <17f1c1b1c6d3a83dd1df130420057d3b@agner.ch>
References: <20180726154025.13173-1-stefan@agner.ch> <2326493.bQHeyqsldt@dimapc> <17f1c1b1c6d3a83dd1df130420057d3b@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 2 August 2018 01:51:42 MSK Stefan Agner wrote:
> On 01.08.2018 22:51, Dmitry Osipenko wrote:
> > On Thursday, 26 July 2018 18:40:25 MSK Stefan Agner wrote:
> >> The properties have been commented out to prevent a regression a
> >> while ago. The first regression should be resolved by
> >> commit 44af7927316e ("spi: Map SPI OF client IRQ at probe time").
> >> 
> >> The second regression is probably addressed by
> >> commit 494fd7b7ad10 ("PM / core: fix deferred probe breaking suspend
> >> resume
> >> order") and/or maybe others. Readd the gpio-ranges properties to see
> >> whether regressions still get reported.
> >> 
> >> This reverts commit 4f1d841475e1f6e9e32496dda11215db56f4ea73
> >> ("ARM: tegra: Comment out gpio-ranges properties").
> >> 
> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
> >> ---
> > 
> > Unfortunately the second regression hasn't been addressed yet, this patch
> > still breaks wake-up using GPIO key. BTW, better to spell "readd" as
> > "re-add".
> You do have the hardware and could test it?

Yes, I have.

> Hm, that is unfortunate. I think this was the patch which should address
> the issue:
> https://lkml.org/lkml/2015/9/10/218

I've tested the patch and it is still actual, i.e. it fixes the wake-up.
Welcome back to 2015 :-)


