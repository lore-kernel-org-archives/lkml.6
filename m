Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463FDC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 23:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0952147D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 23:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z+03PoXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D0952147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbeKUJoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 04:44:08 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46655 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbeKUJoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 04:44:07 -0500
Received: by mail-ua1-f65.google.com with SMTP id v24so1269200uap.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 15:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VCkHosYoxqyFXmkNwSWL1vHtKhVU1uDoVLQnYPsN2jM=;
        b=Z+03PoXNMCMgu4sCelw2GlEPFrNstP1AvM9IZmhUVROfAJfWLF9Jf7eD6g+ZJsU4yX
         f63BmnjQYzkHV6Kdyhn5GVZX+j3ghU4FaNad8RHSHJT/aVgCexMBKe1hndj80uq3q4zd
         XwST45TUSPj+aDHjcMTsxOHCB0Br8NqUAVylM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VCkHosYoxqyFXmkNwSWL1vHtKhVU1uDoVLQnYPsN2jM=;
        b=W1FXxDxi0byAptpzWqachofjPte8R+r4m8jaFq4IsdnRojMT9KXiRMYDJDQGlnyFD6
         uE98m9wnEGcxwNgLwRKnsFiKE7IR7gBjpNIwaMSOFhhqZ30vJu5gR3S6nEFSYlo5uJi1
         6h2dg+/Y3KhAfXEWeRBa2zfl6hCiroLGBV5U5a42k62SVTCwM/R4dZyYgi2Cw7Dd/ujP
         s0YV9T66DBwtLEyMPfRmLCRy9NBX5G+xpSAMRNSTFlGyA2jdCFLFDWaJveONw6TWVmNW
         bRJUKfi8/MYmN98L6nTcR4RVUGVOKYboyn0puNgF8MQtYO0guxDf/V9eNiH6ztZgQ+vr
         ZHBQ==
X-Gm-Message-State: AA+aEWZCtD1DfIv1fymt45hm6SdtHBvuhMgZNbZ/25yJXIJzDkWSb/X3
        9T5Qt63tUdXgHPgMz/UZt0QUlMEwiFg=
X-Google-Smtp-Source: AFSGD/WvyOwGfT3O+kUvyNcqJwfT6BqUnECAmS8hagKKv2dgeg42NWc/UvFxq5ttTbplLfJOygI5vQ==
X-Received: by 2002:ab0:5b1c:: with SMTP id u28mr1885817uae.135.1542755548073;
        Tue, 20 Nov 2018 15:12:28 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id 81sm12980064vkv.13.2018.11.20.15.12.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 15:12:26 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id z3so2147277vsf.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 15:12:26 -0800 (PST)
X-Received: by 2002:a67:6cc1:: with SMTP id h184mr1742981vsc.149.1542755545626;
 Tue, 20 Nov 2018 15:12:25 -0800 (PST)
MIME-Version: 1.0
References: <20181105210921.253707-1-dianders@chromium.org>
In-Reply-To: <20181105210921.253707-1-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 20 Nov 2018 15:12:14 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V7RM2AEM857VJMZmFcBOTSL+Aa03=wiricMV9DZ=NCRg@mail.gmail.com>
Message-ID: <CAD=FV=V7RM2AEM857VJMZmFcBOTSL+Aa03=wiricMV9DZ=NCRg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: qcom: Add SoC-specific string for
 sdhci-msm-v4 nodes
To:     Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy,

On Mon, Nov 5, 2018 at 1:09 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> As per upstream discussion [1], we should have an SoC-specific
> compatible string for Qualcomm's SDHCI nodes.  Let's add it.
>
> [1] https://lkml.kernel.org/r/20181105203657.GA32282@bogus
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  arch/arm/boot/dts/qcom-apq8084.dtsi | 4 ++--
>  arch/arm/boot/dts/qcom-msm8974.dtsi | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)

This patch and the 2nd patch in this series are ready to land.  The
bindings change related to this has been Acked by Rob and can now be
found in Ulf's "next" branch.  See:

https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git/commit/?h=next&id=c1f921e9b691d0110f46c55fdeb8762b85994fba

...everything here should be fully backward compatible so it can be
landed without concern for any dependencies.

-Doug
