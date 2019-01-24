Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B9DC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD306217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfAXKHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 05:07:15 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44453 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfAXKHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 05:07:14 -0500
Received: by mail-ed1-f66.google.com with SMTP id y56so4068318edd.11;
        Thu, 24 Jan 2019 02:07:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qBmEZzVOX/SIzMHv3rv0lFTIcGaNCblyNlW68laj+hI=;
        b=WwLOHj9hYjG3rDEebcOBCfrtCrtva/q+VeCLLQheOdu9Yo2FcDcSs46iDC2sBxPtLr
         fP5gWgx1f0P3M2L/JSMfaCp163jlXSJXPOb5H4jJnCtBQHD57fvWhDP/jr7PlXXrT3Ot
         3b9xGWHkqHgIYu2VkiA7RdUZlQhPbkhj+PjbAPpu9110eMilZQbE2vFZZI/eanWJ4u67
         jrZWOPCmNo9QBywp5FLAWrZeX0CsehtLWafOo4MTe4dtwL6WzEWjCJ9tH/L8rtcK84mg
         l/6XQcKEPpICpEaC+KjipYrKExTvl7AsdqOshfEt2f+Q4BP2E4MmUbtWNAv5UlJpj1Q+
         DgGg==
X-Gm-Message-State: AJcUukeCAVx+WBAe+Y3qliS9gW6TTZjpKOt1UvsN4Ub+7hVQ5Hkfg7sf
        2+PusW6jdw62j7Qc8DYvqn9zpIMr6yI=
X-Google-Smtp-Source: ALg8bN7SrYRCr7XG+CIE2lw/0L/immea7WCyDCTsyOEDkZ/dzqDCuu+a6n0Z6AwweyisugXSqu7dZQ==
X-Received: by 2002:a17:906:4a0c:: with SMTP id w12mr880799eju.240.1548324432388;
        Thu, 24 Jan 2019 02:07:12 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id v14sm10366622edq.74.2019.01.24.02.07.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 02:07:12 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id m1so2457706wml.2;
        Thu, 24 Jan 2019 02:07:11 -0800 (PST)
X-Received: by 2002:a1c:494:: with SMTP id 142mr1938306wme.111.1548324431473;
 Thu, 24 Jan 2019 02:07:11 -0800 (PST)
MIME-Version: 1.0
References: <20190113021719.46457-1-samuel@sholland.org> <20190113021719.46457-3-samuel@sholland.org>
In-Reply-To: <20190113021719.46457-3-samuel@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 24 Jan 2019 18:06:58 +0800
X-Gmail-Original-Message-ID: <CAGb2v65H_ZBMFY_c86acSxX96wFC=0_p_H2x+vzio4-ATayHHQ@mail.gmail.com>
Message-ID: <CAGb2v65H_ZBMFY_c86acSxX96wFC=0_p_H2x+vzio4-ATayHHQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v3 2/2] arm64: dts: allwinner: a64: Enable
 A64 timer workaround
To:     Samuel Holland <samuel@sholland.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2019 at 10:17 AM Samuel Holland <samuel@sholland.org> wrote:
>
> As instability in the architectural timer has been observed on multiple
> devices using this SoC, inluding the Pine64 and the Orange Pi Win,
> enable the workaround in the SoC's device tree.
>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied for 5.1.

ChenYu
