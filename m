Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CABC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F734205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VfqdU7e2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F734205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbeKBFiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 01:38:06 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:34625 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeKBFiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 01:38:05 -0400
Received: by mail-ua1-f65.google.com with SMTP id e16so7705652uam.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 13:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A1ccitTiEnIn0NIxNEiZUO7Pg547IWf6T2kcK+zCA7g=;
        b=VfqdU7e2tSu4CFbVigp0aLqLR32bOTcTCJHlhSXC06DiVZRwJ2hanS33beGVXRVwut
         dyMpBhBu6tMNbQuaLAcSI5H6pUiCuoJGNo7nlhvWK6kwiniqYNGJvMTODL+g0TgrMf2l
         PGoKXYLXhJ5GPIodzzXl3WCzNXLLs709P8TNRjaI9bsyzUnA84t0dbQMV2lgUQkrue0I
         mjhNaqGrX/xBw7jsvI8w0VywUVDw2J0YxRwtFGi1Jb61GCCmc49cMdrxxPtqnys4acFn
         hICeQ5Nh0V8OkiteskvbJgSNDuMRyK+VcJ8G/qjwN/IM3R7QNuyXqc4yPZ7iYC6s9kl9
         JRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A1ccitTiEnIn0NIxNEiZUO7Pg547IWf6T2kcK+zCA7g=;
        b=imyQ19FU437mKw8S29rlFAnmALVsHtI92SJe7v+HOZ1kBlvk6oQLY1vFtfUr+cV7Zc
         4To2Fy1qib3msQCTpi0Yfm1ltZN/mEFpJ6oQrizJEe8MSttzEMkmGEWWHaFhNNrwQXll
         JaA8Dppr4AIdz+gKnI8Ci2Ioak/K+RcFwAZx7FswlGoJmU6bB3b1kyKBYydh2Vu3qyUj
         FjIRC2YlR7PomDAahBS57k904gcbIVwrZ7uN7ISq4CG4BOynQaSVFzEyFNvMrIv2TYdn
         ZVE09jK7xiMGQ+8Mv1UYGVI6KblyOLJWMKC2hcCb8U++S/Jmcju7nnpqJGZwswcOFUlM
         lbhQ==
X-Gm-Message-State: AGRZ1gIGOJSaMFp0SLrcX9QGj9P1teUv0uZcamqcr2G0NGMzvwBqlh9M
        TZe+k1V117IvdwcMv/v9IcIb04qh5cqSMYpRiniT6g==
X-Google-Smtp-Source: AJdET5f00YPG05jAd9wuAU84T6GSgRQ/LBCAx3n2DYi67Z60XhmnPFtcNiCm9Th1R+jmDfj/7yWeI3xGFPopow3ySIc=
X-Received: by 2002:ab0:650e:: with SMTP id w14mr3427660uam.83.1541104413025;
 Thu, 01 Nov 2018 13:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <1541073999-11752-1-git-send-email-vbadigan@codeaurora.org> <1541073999-11752-3-git-send-email-vbadigan@codeaurora.org>
In-Reply-To: <1541073999-11752-3-git-send-email-vbadigan@codeaurora.org>
From:   Doug Anderson <dianders@google.com>
Date:   Thu, 1 Nov 2018 13:33:21 -0700
Message-ID: <CAD=FV=U7FGn0Jt_63SJ0zeU9u4vh5J9EFtbLHGtjGOUV7AceKw@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] mmc: sdhci-msm: Re-initialize DLL if MCLK is gated dynamically
To:     vbadigan@codeaurora.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>, riteshh@codeaurora.org,
        stummala@codeaurora.org, sayalil@codeaurora.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 1, 2018 at 5:08 AM Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>  static const struct sdhci_msm_variant_info sdhci_msm_v5_var = {
>         .mci_removed = true,
> +       .restore_dll_config = false,
> +       .var_ops = &v5_var_ops,
> +       .offset = &sdhci_msm_v5_offset,
> +};
> +
> +static const struct sdhci_msm_variant_info sdm845_sdhci_var = {
> +       .mci_removed = true,
> +       .restore_dll_config = true,
>         .var_ops = &v5_var_ops,
>         .offset = &sdhci_msm_v5_offset,
>  };

One last thing: are there actually any "v5" controllers that _don't_
require restoring the DLL?  Since "sdm845" is currently the only v5
controller maybe just set "restore_dll_config = true" for all v5
controllers and when there's a new v5 controller that doesn't need it
then match off the SoC-specific compatible string.  As per my review
of the bindings patch IMO you should include both the "v5" and the
SoC-specific string for SDM845 (and all future SoCs) so you could make
the generic v5 case do this...


-Doug
