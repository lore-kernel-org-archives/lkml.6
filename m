Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F03C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 05:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36242064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 05:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YnYFX/Ml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D36242064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeKAO7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 10:59:15 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42656 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbeKAO7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 10:59:15 -0400
Received: by mail-lj1-f194.google.com with SMTP id f3-v6so17012733ljk.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 22:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Wka7EPdZE1wJMFXxDmlVYyo07ONt9qlzyw91Su37joo=;
        b=YnYFX/Mltu6Yp9Ng1mq/3bf2bIdQpmCFYJDhCbULgzvVofTRRFQ4oasykoTU1oeBKh
         wpCMjxcwehN2ktCT1IR6LDjgeoVq5np7a3hZ7hKVvv88TzmNAfWEQ00j74RFDVsXA6bN
         7+wb8/JFYS2EDi65weSuZcxYDQcalOuOFn+fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Wka7EPdZE1wJMFXxDmlVYyo07ONt9qlzyw91Su37joo=;
        b=cLJj/o7654uiwgjtCZa29lsLRyDQR3JnTBeiRR5AgrUZEsWVhsiL4tATjXUog3aNZl
         W831rtBNrXZjLMCgYgy2RB1Jh9/ey/7Fyj7Z1boBpCHfzqesWxqS3NtmmTlg9tWFij6L
         X+GQ6+kPhBKIPGg5PbODxvy+72yVd4UxMSSeawzAlzSzAR8vmHGxXjWDgM/kdbscP7aW
         AuP3jIIHG7d+XVl2iDqrVsUmB/AfrbUz6iEIwXdxUL7EoeSs99SqYnP/X+CU0q/x9XrH
         PozWpy5x+UNe92UyHblgXHMjZD98rmdZg7Qo6f2HEFwrRt5wlbrSjizW6pGCgetbj1OL
         fXDQ==
X-Gm-Message-State: AGRZ1gLC7pjbDb68GEPpeNbnf5Gltv2zKFlhEV1KbRs52qMHl7Zq59dd
        gpL7D0RH/gRsFj5q0bZVOpGCPtorNFeB2ntlzEO2NA==
X-Google-Smtp-Source: AJdET5eJ0FzLtA4bE7qmr2dwgBhvRGWJxP2qrDZWc7OqJPQpiy/+043EqapoK8vntD+IMqMU3sRKS2lLWRyGRnjWWew=
X-Received: by 2002:a2e:2f1b:: with SMTP id v27-v6mr3806496ljv.31.1541051862459;
 Wed, 31 Oct 2018 22:57:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:95d7:0:0:0:0:0 with HTTP; Wed, 31 Oct 2018 22:57:42
 -0700 (PDT)
In-Reply-To: <20181101004410.6893-1-natechancellor@gmail.com>
References: <20181101004410.6893-1-natechancellor@gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 1 Nov 2018 13:57:42 +0800
Message-ID: <CAMz4kuJg9gWtqy4mFsEV12c=kH_-999xeabPEJmb2P_usKRoMQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: sprd: Use define directive for
 sprd_pinconf_params values
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 November 2018 at 08:44, Nathan Chancellor <natechancellor@gmail.com> wrote:
> Clang warns when one enumerated type is implicitly converted to another:
>
> drivers/pinctrl/sprd/pinctrl-sprd.c:845:19: warning: implicit conversion
> from enumeration type 'enum sprd_pinconf_params' to different
> enumeration type 'enum pin_config_param' [-Wenum-conversion]
>         {"sprd,control", SPRD_PIN_CONFIG_CONTROL, 0},
>         ~                ^~~~~~~~~~~~~~~~~~~~~~~
> drivers/pinctrl/sprd/pinctrl-sprd.c:846:22: warning: implicit conversion
> from enumeration type 'enum sprd_pinconf_params' to different
> enumeration type 'enum pin_config_param' [-Wenum-conversion]
>         {"sprd,sleep-mode", SPRD_PIN_CONFIG_SLEEP_MODE, 0},
>         ~                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
>
> It is expected that pinctrl drivers can extend pin_config_param because
> of the gap between PIN_CONFIG_END and PIN_CONFIG_MAX so this conversion
> isn't an issue. Most drivers that take advantage of this define the
> PIN_CONFIG variables as constants, rather than enumerated values. Do the
> same thing here so that Clang no longer warns.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/138
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---

Looks reasonable to me. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>

-- 
Baolin Wang
Best Regards
