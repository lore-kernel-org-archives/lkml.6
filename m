Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C69C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420A420883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HsA3Hzv0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 420A420883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbeKITGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:06:02 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40711 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbeKITGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:06:01 -0500
Received: by mail-lj1-f195.google.com with SMTP id t22-v6so990493lji.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 01:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0wfzwFQuWaVVgLusFavfN2oErvoM0tz9avy3ruAHAJg=;
        b=HsA3Hzv09yF2bCa8eoHh1puG23iD/JCiLs2CxoX+vCcw9EDvTK4LbYSf1EPi/682WW
         Lhbj+/QgvBSwP/6IJoQBUvKjWWOBoDYroj5yHwYl+amKsvN+yOd3yAt7TFELgMi2gtC5
         zPk/SjqDRfRHJYsRkHgkvnAX+m5OdYWgzP1+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0wfzwFQuWaVVgLusFavfN2oErvoM0tz9avy3ruAHAJg=;
        b=ts/w2538VMxRfH+uKGtaa5MPioQgaypyp8zg/KOt+2iMBN/5gRMh1Cksp57HWBxJxz
         wjyGoNPSULMqusGMxFiMwmtZigTv2czIIjO+0CBLoDnwXirF7cUl00JbF1sOKhm5UkWD
         aPodGFP5EXTWmwgxOCsm0/I++XmfmlmxzHzOrx64cmJo+eNnTPVRb78c7lA3iQWo/3FC
         xmkceujCKraMW4+wuPU3fx1NfSvsloclss49US0MsqlNMFAtO4Q8P8c0+nIWgzTQnz0N
         3T2VmtfDCJU0n84JnjaFRAyyBfnp9bZA6fi01mmIalG2Igo39XjzzRcdF5xeTzINrKfA
         YtWA==
X-Gm-Message-State: AGRZ1gIaXGhBe8cGZykyjymCycAOOAAM8o6CnM3TMvsYIRg5scrmDrtT
        Cwu2A1ouGItrPF4hJQK0U6jjh4mFxZhVvNmFYfyhyA==
X-Google-Smtp-Source: AJdET5eaG+M0giI1/Zl7DKr0TPPuzX7UZ/ov+t8GJTZfVgcPpJmcVZN6f8xMDjlieEdGKAE+E3lQ45FOlTUOQbWsGZE=
X-Received: by 2002:a2e:874e:: with SMTP id q14-v6mr4522273ljj.120.1541755578042;
 Fri, 09 Nov 2018 01:26:18 -0800 (PST)
MIME-Version: 1.0
References: <20181101005724.9622-1-natechancellor@gmail.com> <20181107085639.32366-1-natechancellor@gmail.com>
In-Reply-To: <20181107085639.32366-1-natechancellor@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Nov 2018 10:26:06 +0100
Message-ID: <CACRpkdZ1424qqPbYrP+vE6WTA81nHb=5Pi7vxD7cgJ9vOonj9Q@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: zynq: Use define directive for PIN_CONFIG_IO_STANDARD
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 9:57 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:

> Clang warns when one enumerated type is implicitly converted to another:
>
> drivers/pinctrl/pinctrl-zynq.c:985:18: warning: implicit conversion from
> enumeration type 'enum zynq_pin_config_param' to different enumeration
> type 'enum pin_config_param' [-Wenum-conversion]
>         {"io-standard", PIN_CONFIG_IOSTANDARD, zynq_iostd_lvcmos18},
>         ~               ^~~~~~~~~~~~~~~~~~~~~
> drivers/pinctrl/pinctrl-zynq.c:990:16: warning: implicit conversion from
> enumeration type 'enum zynq_pin_config_param' to different enumeration
> type 'enum pin_config_param' [-Wenum-conversion]
>         = { PCONFDUMP(PIN_CONFIG_IOSTANDARD, "IO-standard", NULL, true),
>             ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/pinctrl/pinconf-generic.h:163:11: note: expanded from
> macro 'PCONFDUMP'
>         .param = a, .display = b, .format = c, .has_arg = d     \
>                  ^
> 2 warnings generated.
>
> It is expected that pinctrl drivers can extend pin_config_param because
> of the gap between PIN_CONFIG_END and PIN_CONFIG_MAX so this conversion
> isn't an issue. Most drivers that take advantage of this define the
> PIN_CONFIG variables as constants, rather than enumerated values. Do the
> same thing here so that Clang no longer warns.
>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> v1 -> v2:

This v2 version applied with Michal's ACK.

Yours,
Linus Walleij
