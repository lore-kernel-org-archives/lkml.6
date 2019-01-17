Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0DAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBFCD20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c7alGanV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfAQXPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:15:46 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:35773 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbfAQXPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 18:15:33 -0500
Received: by mail-vk1-f195.google.com with SMTP id b18so2683679vke.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 15:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EqPIalk5FEIB9N2AtutitpHWyD2bU8BRzB3i7sKiMpI=;
        b=c7alGanVZi73lXvd6QuOy9oRrLKqi/b0Ja5XPtKkNt8R077ydgVcdVib7VJjL/N0kB
         4jT3+NSaxV3Z4/CS5WBPDpd1QWLZF+Tdvzh6KyRzYvicnMPMvc6i7Ie8LzPDH7L27Qhc
         uaSY9x1SPdr7FZWdl55WW+1PlcOnmO5u113mY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EqPIalk5FEIB9N2AtutitpHWyD2bU8BRzB3i7sKiMpI=;
        b=E/ZI/T6cjvvxH5YuWjI0qRE8A0j//DIkuB1fqu8fYJWpdYCMQWqZV2aNvDTZuSQm+3
         B343y869ilyhd1FzdJRz76xfInLomDFOrg0EyRnxpRRURQu1rHGXt8Ocq/uniuG3fQhC
         EcZvlV75TTLc8En2bG56IsGuVErUwHA8ioS/l7u/QSAFaf+RTi/FTD2vm34T3dEJUUi8
         AayOvoCdg98+IBw7tYBqgTklRkZ10KhZUleZ+I+xjsx8aXNZu6fkFb3BLDwd0BbrjWiw
         lz9YaTtdskX/NhfltBJaYi/G8yWKV1gb6aV5n2FvdXjuuUN26mQnJ2yAujOcc9+JtV7l
         O68w==
X-Gm-Message-State: AJcUukcxLcOs+PvICyELHQPXxmQa5MmoYKb59lv24c5eA4lAfv5ebM8G
        xJaoqRIVHnZyvAup3iAif1+3dM/VZ8E=
X-Google-Smtp-Source: ALg8bN70buqQhVXlMPmnJtNYB5ur6tmVWTLyy5suHpMSp8u4HGvbJk7iW2JyoKJdbxO6PjYUi/95Yg==
X-Received: by 2002:a1f:95d1:: with SMTP id x200mr6361788vkd.78.1547766931770;
        Thu, 17 Jan 2019 15:15:31 -0800 (PST)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id r8sm4493525uan.0.2019.01.17.15.15.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 15:15:30 -0800 (PST)
Received: by mail-vk1-f175.google.com with SMTP id s184so2673950vkd.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 15:15:30 -0800 (PST)
X-Received: by 2002:a1f:bfd6:: with SMTP id p205mr5232905vkf.70.1547766929774;
 Thu, 17 Jan 2019 15:15:29 -0800 (PST)
MIME-Version: 1.0
References: <1547661809-31184-1-git-send-email-jcrouse@codeaurora.org>
In-Reply-To: <1547661809-31184-1-git-send-email-jcrouse@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 17 Jan 2019 15:15:18 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U0_wi8mJNOXjsPdS7Yrmvbvw1+B20t-=KzDG+tnD8HUw@mail.gmail.com>
Message-ID: <CAD=FV=U0_wi8mJNOXjsPdS7Yrmvbvw1+B20t-=KzDG+tnD8HUw@mail.gmail.com>
Subject: Re: [PATCH v8] arm64: dts: sdm845: Add gpu and gmu device nodes
To:     Jordan Crouse <jcrouse@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 16, 2019 at 10:03 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> +               gpu@5000000 {
> +                       compatible = "qcom,adreno-630.2", "qcom,adreno";
> +                       #stream-id-cells = <16>;
> +
> +                       reg = <0x5000000 0x40000>, <0x509e000 0x10>;

This will now need to be adjusted to:

reg = <0 0x05000000 0 0x40000>, <0 0x0509e000 0 0x10>;

This fixes things up to deal with the patch ("arm64: dts: qcom:
sdm845: Increase address and size cells for soc"), AKA:
- https://patchwork.kernel.org/patch/10767511/
- https://lkml.kernel.org/r/20190117042940.25487-2-bjorn.andersson@linaro.org


> +               adreno_smmu: iommu@5040000 {
> +                       compatible = "qcom,sdm845-smmu-v2", "qcom,smmu-v2";
> +                       reg = <0x5040000 0x10000>;

This one to:

reg = <0 0x05040000 0 0x10000>;


> +               gmu: gmu@506a000 {
> +                       compatible="qcom,adreno-gmu-630.2", "qcom,adreno-gmu";
> +
> +                       reg = <0x506a000 0x30000>,
> +                               <0xb280000 0x10000>,
> +                               <0xb480000 0x10000>;

This one to:

reg = <0 0x0506a000 0 0x30000>,
        <0 0x0b280000 0 0x10000>,
        <0 0x0b480000 0 0x10000>;


In the email:

https://lkml.kernel.org/r/20190117192955.16515-1-bjorn.andersson@linaro.org

...Bjorn provided a link to a github tree that should be OK to use as
a basis for sending a new patch.  Specifically
<https://github.com/andersson/kernel/commits/for-andy/arm64-for-5.1>.
That tree not only has the address-cells / size-cells change but also
has gpucc.


-Doug
