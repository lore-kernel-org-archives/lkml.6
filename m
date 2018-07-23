Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF3DECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E985C20779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="D51Pk2Gn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="D51Pk2Gn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E985C20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387843AbeGWHSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 03:18:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59186 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeGWHSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 03:18:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 666F76074D; Mon, 23 Jul 2018 06:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532326758;
        bh=rx/onU5JsWjsuqRmMJ07EMfIA9+Mp1g7NPdcOFFtuhU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=D51Pk2GnNIQQUevG2Hh/WMgBrHB+WNUWQS0ESDymYtrT1vOmNrjxDscPXtBz6xWE2
         mNJs/GNQFxcJrqT3WWaGcEh1FnjpTclH6hAvO3MKCjjTSXMkVSi+g+zj4d02+YM4/0
         vGmnF5EafrUyizN21mot93YjNBwlyq6njscInte4=
Received: from mail-qk0-f177.google.com (mail-qk0-f177.google.com [209.85.220.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DDCB260481;
        Mon, 23 Jul 2018 06:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532326758;
        bh=rx/onU5JsWjsuqRmMJ07EMfIA9+Mp1g7NPdcOFFtuhU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=D51Pk2GnNIQQUevG2Hh/WMgBrHB+WNUWQS0ESDymYtrT1vOmNrjxDscPXtBz6xWE2
         mNJs/GNQFxcJrqT3WWaGcEh1FnjpTclH6hAvO3MKCjjTSXMkVSi+g+zj4d02+YM4/0
         vGmnF5EafrUyizN21mot93YjNBwlyq6njscInte4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DDCB260481
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qk0-f177.google.com with SMTP id 27-v6so9527511qkv.0;
        Sun, 22 Jul 2018 23:19:17 -0700 (PDT)
X-Gm-Message-State: AOUpUlHUVlslIeor61hj1ww0+Kg6jP9Cq3dXnDB1m7ISyYdr+ee8uOKz
        b7XgaUoTCfFNd3q4g53niNI+fryY5NVVCr0l2Tg=
X-Google-Smtp-Source: AAOMgpcce3jWc0t4D7j6NZ74g2EC8LH6bUq0ru1M9vGNVu+507bu/lO2k4DI98KUQ9xTCBBg9Yq+vbB24VkXQrsecus=
X-Received: by 2002:a37:6446:: with SMTP id y67-v6mr10089373qkb.309.1532326757129;
 Sun, 22 Jul 2018 23:19:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:f25:0:0:0:0:0 with HTTP; Sun, 22 Jul 2018 23:19:16 -0700 (PDT)
In-Reply-To: <20180703072034.20213-1-niklas.cassel@linaro.org>
References: <20180703072034.20213-1-niklas.cassel@linaro.org>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Mon, 23 Jul 2018 11:49:16 +0530
X-Gmail-Original-Message-ID: <CAFp+6iHKp43aA6it=V4RgCs2nMRnmMuNcoTasmch+EWTZWA6Fw@mail.gmail.com>
Message-ID: <CAFp+6iHKp43aA6it=V4RgCs2nMRnmMuNcoTasmch+EWTZWA6Fw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] soc: qcom: Allow COMPILE_TEST of qcom SoC Kconfigs
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Niklas,


On Tue, Jul 3, 2018 at 12:50 PM, Niklas Cassel <niklas.cassel@linaro.org> wrote:
> Since commit cab673583d96 ("soc: Unconditionally include qcom Makefile"),
> we unconditionally include the soc/qcom/Makefile.
>
> This opens up the possibility to compile test the code even when
> building for other architectures.
>
> This patch series prepares and enables all but two Kconfigs to be
> compile tested even when building for other architectures.

For the entire series.
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>

Best regards
Vivek

>
>
> Changes since v2:
> -The qdsp6 fixes are now solved in another way, and those patches are
>  already applied in the ASoC-next tree.
> -Dropped rpmsg fix, as it has been applied in the remoteproc-next tree.
> -Added a new patch to add sizes.h for the new driver llcc-slice.
> -Added COMPILE_TEST to each Kconfig instead of the menu entry,
>  in order to allow more complex expressions.
>  E.g. RPMh has depends on x && y && z || COMPILE_TEST.
>  This way, if COMPILE_TEST is set,  it will be able to ignore multiple
>  dependencies. This is not be possible if we refactor out
>  ARCH_QCOM || COMPILE_TEST to the top menu entry.
>
> Niklas Cassel (6):
>   soc: qcom: smem: Add missing include of sizes.h
>   soc: qcom: llcc-slice: Add missing include of sizes.h
>   soc: qcom: smp2p: Add select IRQ_DOMAIN
>   soc: qcom: smsm: Add select IRQ_DOMAIN
>   soc: qcom: Remove bogus depends on OF from QCOM_SMD_RPM
>   soc: qcom: Allow COMPILE_TEST of qcom SoC Kconfigs
>
>  drivers/soc/qcom/Kconfig      | 19 +++++++++++--------
>  drivers/soc/qcom/llcc-slice.c |  1 +
>  drivers/soc/qcom/smem.c       |  1 +
>  3 files changed, 13 insertions(+), 8 deletions(-)
>
> --
> 2.17.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
