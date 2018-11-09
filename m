Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6452C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2B520883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hCBdIZr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A2B520883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbeKITDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:03:07 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40447 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbeKITDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:03:07 -0500
Received: by mail-lj1-f196.google.com with SMTP id t22-v6so983912lji.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 01:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ThCZt9zVWkwqGt7TEPGWG2j1KJOMyCrcKrGwBQNDiY0=;
        b=hCBdIZr9MfvSwAmFlCJwVHu/kBr5QKWCYSFUsHkfT2F5AJL+BBGV7opJBpd5pxw29u
         ZaGIpYN5maWZUHt+ZyWiZEWwcpLGOpG2JUD/UvQaOPTkqi1Bjq1rXp6N7Ja5J27+Hg4u
         fBpzuH28ro6VO2H/Wtis3KrCAQu627k3byuEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ThCZt9zVWkwqGt7TEPGWG2j1KJOMyCrcKrGwBQNDiY0=;
        b=rP1Pnct5Fhd/jiEex/KA5ILoT0T4NJDDiwl50WrE8ddRheWksjwiV7UpFrf63Yi7+r
         njIK9u9kYA5JNcwk6REmU45ma49SwHC4dSICZcvjSyfqMc31vbqQQN1wy7fPE8t3WzMB
         wuV2oPiqzxB5W19c5v3+Zt2eadOoH0sy9UVLRF/mI2G5Kbw0QWQ1ajL9yvw775+eqGKD
         OfZrbtCfAKi6HCQ4K4oRgjJzUOryd+Ps31azd8oyE473JANuL63Vg7HwEYznbmxSSwkR
         ZPfoDuL5GsUwSV2TvpL3JM+7mlC6791gBtvLQQxq0BU93jRTp8bCHn/7OFMnS3SDeQzF
         Imlw==
X-Gm-Message-State: AGRZ1gKwlQFrvCz4UaSvfBehtmm88iCBhHEZ3IPsrselqIf7O74BGyCe
        aam2HPZw0FXURPme/B5n6ISL9VfadUa7Dhxu/TBGCA==
X-Google-Smtp-Source: AJdET5fVh01YpIue6Uiz6lYV9f8diQzcVuIWe6XHEBB5k8Xp2k0fnoB2cVrlY+XgrKMMb6XhA80o66eI9IjlKA8ykog=
X-Received: by 2002:a2e:874e:: with SMTP id q14-v6mr4516938ljj.120.1541755404763;
 Fri, 09 Nov 2018 01:23:24 -0800 (PST)
MIME-Version: 1.0
References: <20181101004653.7552-1-natechancellor@gmail.com>
In-Reply-To: <20181101004653.7552-1-natechancellor@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Nov 2018 10:23:13 +0100
Message-ID: <CACRpkdZBtrwEdGQu_XfaYpFarn5x=HpXVj32uczgfJYTNP8kjw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: bcm2835: Use define directive for BCM2835_PINCONF_PARAM_PULL
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 1:47 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:

> Clang warns when one enumerated type is implicitly converted to another:
>
> drivers/pinctrl/bcm/pinctrl-bcm2835.c:707:40: warning: implicit
> conversion from enumeration type 'enum bcm2835_pinconf_param' to
> different enumeration type 'enum pin_config_param' [-Wenum-conversion]
>         configs[0] = pinconf_to_config_packed(BCM2835_PINCONF_PARAM_PULL, pull);
>                      ~~~~~~~~~~~~~~~~~~~~~~~~ ^~~~~~~~~~~~~~~~~~~~~~~~~~
> 1 warning generated.
>
> It is expected that pinctrl drivers can extend pin_config_param because
> of the gap between PIN_CONFIG_END and PIN_CONFIG_MAX so this conversion
> isn't an issue. Most drivers that take advantage of this define the
> PIN_CONFIG variables as constants, rather than enumerated values. Do the
> same thing here so that Clang no longer warns.
>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Patch applied with Stefan's ACK.

Yours,
Linus Walleij
