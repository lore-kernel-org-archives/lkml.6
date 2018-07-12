Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2787EC476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE7952086E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="VrdmQFKH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kb9u84ou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7952086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732500AbeGLR3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:29:02 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:43536 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732343AbeGLR3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:29:02 -0400
Received: by mail-ua0-f195.google.com with SMTP id x24-v6so18897309ual.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 10:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=6Umkd06nmktfMlUkTbZHjnWkj2jKM2eg4jojzzG5DLc=;
        b=VrdmQFKHWLVaEB2GbyMEWXqb18RDFz9v4FqJsQHVaf74OF6oHrjgiNn+O4CMy/cQyl
         n/DV4wxrbJ/HxrCoCHgVvBmwj1FrAai9U2u5gB/SVJNTGEzpVrx2WRiP1Kb67joOiC3S
         8NZSuX3HF93izRwYmMdhI6H2MYpLeQy7Qr0chQhyBrdmKB+zO54pQwbw3iwV9pI8HRGH
         bXrS5dFfSlv1M3JUXBMnx8ividQ13aOSTpAMW/gKgy4UCZkM963GVkxd4gVhqhRidahE
         26EkWmJhpVXxXkb/Yzbyy3ujYKGSK+62m50KMf5Dj0PTPKYJkS/rCzoWSfQ4ol9fYK9c
         CaOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=6Umkd06nmktfMlUkTbZHjnWkj2jKM2eg4jojzzG5DLc=;
        b=kb9u84ouB/qIXR4zO45IQD+SY/XpByCaE4RMTAB8gu2MzLR+mAnHe8/Gk330Sx/fHM
         j4oTrRyh5IB961A+BkXzzsO4a+WCo2J0KPER0RZ4vajBUUahDvuloGWvBgdBPjYJuMHo
         mBWd5SbTbKjlsqYb9FAbt0L8HPU4jVoHqCx/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=6Umkd06nmktfMlUkTbZHjnWkj2jKM2eg4jojzzG5DLc=;
        b=Z6T6u0N0SOaZLMOJt/YN+CfelWOZiJ0/VsXuoUGXxqbMP1+6AKJnxlrE41wChfl23W
         P2Ab/AoHtndYisfpwVJU7d7d4Hr9SRJ3cM65MN9v1Q0mMOIK4SOXqEMc0ZUImywp1yl6
         ZF3jIOBODxT8R+B0K42P+pyq6g/fvPG2jzwtUEKcuPAix4UPNFRpsipIB75mg3hvO1C9
         3Owy8F6pbh65u2kuKwergE09TsSyk1eQxeO1ejENGG00O0rGCuYSHZK+f84wRl6pwbwn
         rB/RL3XMjWa+6osqM+4Pk/5gENdwyCcoHtMPormCXvmOFKhvmmhIOg/duKAwoc46WzRa
         KG9Q==
X-Gm-Message-State: AOUpUlFPyinb4OXRO3TkafW3TXGbVdamMJqcYWFuSc6ttlNiM8AHP1LX
        jS5si2Sqgsge/p+++0NrV3NwQsdOFxYpDOEYAgqAlw==
X-Google-Smtp-Source: AAOMgpehecfhG5n90onp3XmXgf/uWEfLIUsnO6SjLggGYYGSeX2lWShCe9BNcPJlOOZHVWyz/CIwZOI6EyKfx1hSJ2U=
X-Received: by 2002:ab0:4364:: with SMTP id k91-v6mr2065496uak.46.1531415912518;
 Thu, 12 Jul 2018 10:18:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 10:18:30
 -0700 (PDT)
In-Reply-To: <0dfdbfa82edced85ea5be02e1d74d73d232c7a08.1531384019.git.amit.kucheria@linaro.org>
References: <cover.1531384019.git.amit.kucheria@linaro.org> <0dfdbfa82edced85ea5be02e1d74d73d232c7a08.1531384019.git.amit.kucheria@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 12 Jul 2018 10:18:30 -0700
X-Google-Sender-Auth: kGaw0iUJ9S5GyTYgd9IgK1L9ER0
Message-ID: <CAD=FV=UHQ2SDC9WbS2=D_ka3OxnxPPrQt6tLx5Yy6Lf_bnVqrg@mail.gmail.com>
Subject: Re: [PATCH v7 7/7] arm64: dts: sdm845: Add tsens nodes
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        smohanad@codeaurora.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 12, 2018 at 1:39 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> SDM845 has two tsens blocks, one with 13 sensors and the other with 8
> sensors. It uses version 2 of the TSENS IP, so use the fallback property to
> allow more common code.
>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
