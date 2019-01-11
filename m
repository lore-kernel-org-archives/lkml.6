Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED27C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE1320878
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IxgkcsDm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfAKVNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 16:13:54 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:43323 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfAKVNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 16:13:53 -0500
Received: by mail-vk1-f196.google.com with SMTP id o130so3598365vke.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 13:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UKzd9pPOcEiCygbV6NpA8u3JCLbm1XYHW8Oq121fRWg=;
        b=IxgkcsDmOZC9zDPE9IdGeChpPCnxVkBOW8AWkol4d+ufmWHcalzEOLLEVtzEeFYjyb
         BnwjFREavLjTxXJC1HLEj3S6POIaUNTtinpuoE81pMMYHchL39HgcRaAPoOWgIwU5cyr
         0nIy58qTb0jdghCJkeaCsvLL6G+sPPdKwYS7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UKzd9pPOcEiCygbV6NpA8u3JCLbm1XYHW8Oq121fRWg=;
        b=el2sQXSivL/c4gvJ5tCO1iczvDELYJSbDs705SbvRhFCjwKbPtMcnkWwpyKxASwalS
         yR5zrZwXy+ui+jnq8IPdmBIdjK0mWX7FDiq69QJjWLGSld4V1JkhkstJkDujpu47mwUb
         l+w/21r/r8lhTkWTDqPE0xgdld8+3phS3SUhfBz6x3Wf4IkYJ7lv1pf2PGEphwZyDotV
         u2qcypDLMDPe47yZQn11iy+qQISc8e3WRWb2JZMXYuKsOZ2en9fmcJn6BqAfufmIYPkb
         fIsmqpVMZuWeCf2ftkPOfLrhURb5ezgazPGljMRRfmF5WbJhShbgGHGoBRIzSb3N0GHr
         Qk8w==
X-Gm-Message-State: AJcUukfn6PLdFUz64zyyheYlRr6o/NjcxXdJlolaPGY/TJp5zcWf6QUn
        63UjX3pwu3l/smm80txY+ZD/LkIpcHg=
X-Google-Smtp-Source: ALg8bN6bP2MxnVeUugynW+R9yut1dIab2jHGaOKWAMCOA5Rhy2ea94a+SGEa9+Sf3IkNVLP8FQDvlQ==
X-Received: by 2002:a1f:6bc8:: with SMTP id k69mr4141894vki.84.1547241231838;
        Fri, 11 Jan 2019 13:13:51 -0800 (PST)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id a137sm36997056vsd.24.2019.01.11.13.13.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 13:13:51 -0800 (PST)
Received: by mail-vs1-f52.google.com with SMTP id x64so10081370vsa.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 13:13:51 -0800 (PST)
X-Received: by 2002:a67:dd94:: with SMTP id i20mr7034035vsk.111.1547240813840;
 Fri, 11 Jan 2019 13:06:53 -0800 (PST)
MIME-Version: 1.0
References: <20190109170010.15430-1-sibis@codeaurora.org>
In-Reply-To: <20190109170010.15430-1-sibis@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 11 Jan 2019 13:06:42 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xu3m5=ByHo_38T=H2cm4VqkndVjJ1rUkD2gp-2SWFXdQ@mail.gmail.com>
Message-ID: <CAD=FV=Xu3m5=ByHo_38T=H2cm4VqkndVjJ1rUkD2gp-2SWFXdQ@mail.gmail.com>
Subject: Re: [PATCH v5 8/8] arm64: dts: qcom: sdm845: Add Q6V5 MSS node
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-remoteproc@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        sricharan@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 9, 2019 at 9:00 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> This patch adds Q6V5 MSS remoteproc node for SDM845 SoCs.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> v5:
>   * Use qmp_aop updated dt binding

nit: since this is now a singleton patch in v5 (because patches #1 -
#7 landed), the general policy is to drop the "8/8" in the subject.
AKA I believe the subject of the patch ought to have been:

[PATCH v5] arm64: dts: qcom: sdm845: Add Q6V5 MSS node


> v3:
>   * with shutdown-ack irq redesign make it mandatory,
>     merge multiple patches into a single one
>
> v2:
>   * Fixed style changes
>   * Added missing clocks in the dt-bindings
>   * Split mss remoteproc node into a number of patches
>
> This patch depends on the following bindings:
> https://patchwork.kernel.org/patch/10662089/ - mba/mpss reserved regions
> https://patchwork.kernel.org/patch/10657325/ - pdc reset node
> https://patchwork.kernel.org/patch/10753659/ - rpmhpd dt node
> https://patchwork.kernel.org/patch/10749469/ - AOP QMP dt bindings
> https://patchwork.kernel.org/patch/10751757/ - shutdown-irq binding
>
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 60 ++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 5da9fa1feb8a..e021b15f87fd 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -1366,6 +1366,66 @@
>                         };
>                 };
>
> +               remoteproc@4080000 {

It would be handy if you added a label here, AKA:

mss_pil: remoteproc@4080000 {

It's expected that boards will need to refer to this node so that they
can provide a firmware-name, so you need to give them a label to grab
onto.

...and actually, I wonder if boards will also need to be able to set
status = "okay"?  Right now they don't because you don't have a status
= "disabled" in sdm845.dtsi, but maybe you should?  Are there ever
going to be any boards with sdm845 that don't hook up the modem?


-Doug
