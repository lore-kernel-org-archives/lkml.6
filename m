Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B973AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A5FA20866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Eyc8XkJi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbfAPTNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 14:13:23 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45966 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729879AbfAPTNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 14:13:23 -0500
Received: by mail-vs1-f66.google.com with SMTP id x28so4603312vsh.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1mh2Y9cC4/IGhR5nB9bWO0Y87rjnAmYcq8xifXpLwc4=;
        b=Eyc8XkJiU6XLTHHKYJ2xwShFj7NVWQkTGZnU+VxyPsv/NXZzq4jSYpeIKnWbZkwn+U
         9mpZmlQpUIYWXgyJ0yzWP/kteTBFJAEm7PQPOHdjMtosF8+Or3qg3XNZs8qzS9QU9Qn/
         vTz7D7uPmGak46JjL1AOlh6U8kMNudo5zMM8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1mh2Y9cC4/IGhR5nB9bWO0Y87rjnAmYcq8xifXpLwc4=;
        b=VqPnvWpifjXAahUYNQ/LDz7+/P4757u7t56xSQwN0z+zDSD3IA/sa8y7OqZHCLBlUq
         gW9GfK7aQresQDvtTY2U3veewABrIWz2zrT0eEhqb7SzGjitey2OvnfnEW5uMb3N3xS5
         k29vNeUkUFz5rCjAoqKBvjQYtJ4yjZw7UQmScjpW7O/trN6VXMr/Bu+P1xDwwX0IGg6A
         JShrVfNDvIUGQYQVwfEvpZeoIlme5GP30uCpRxmoGQLB/2YxtQAZvc2DZDxmZjQRnPTq
         rdkJZLAPKVOH1yPxPQmT/JthAbfgBbEtPCVMp29J5T9qN/bBmjdKj56/UadIrjkRXCZA
         VDrw==
X-Gm-Message-State: AJcUukdQMC944dhjUtGW4s5LABRI7UiQjgVoQpSolv30+i4X6QevKWCj
        zbiFERT+e9KcpSqdYKDtVlgjz7lOVVc=
X-Google-Smtp-Source: ALg8bN5y6E0T9ST5q0fHlziLZMrkwqe0FBuw1vnaOfPejoVzGuM69SPurGz6IvxQSNqjGRzQUFENVw==
X-Received: by 2002:a67:358b:: with SMTP id x11mr4844931vsh.145.1547666001789;
        Wed, 16 Jan 2019 11:13:21 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id p8sm52542638vke.27.2019.01.16.11.13.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 11:13:21 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id z11so2563844uaa.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:13:20 -0800 (PST)
X-Received: by 2002:ab0:45d4:: with SMTP id u78mr4215395uau.52.1547666000475;
 Wed, 16 Jan 2019 11:13:20 -0800 (PST)
MIME-Version: 1.0
References: <1547661809-31184-1-git-send-email-jcrouse@codeaurora.org>
In-Reply-To: <1547661809-31184-1-git-send-email-jcrouse@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 16 Jan 2019 11:13:09 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WuVOWYLbNKy=t1+X4a7cjegU+AUyFJmYNHkjYnRzLQBA@mail.gmail.com>
Message-ID: <CAD=FV=WuVOWYLbNKy=t1+X4a7cjegU+AUyFJmYNHkjYnRzLQBA@mail.gmail.com>
Subject: Re: [PATCH v8] arm64: dts: sdm845: Add gpu and gmu device nodes
To:     Jordan Crouse <jcrouse@codeaurora.org>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
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
>
> Add the nodes to describe the Adreno GPU and GMU devices for sdm845.
>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Tested-by: Douglas Anderson <dianders@chromium.org>
> ---
> This has the following dependencies:
>
> [v11,1/9] dt-bindings: opp: Introduce opp-level bindings
> https://patchwork.kernel.org/patch/10755199/
>
> And the following patches already in Rob's msm-next:
> msm-next:d1c9cadea6f7 ("drm/msm/gpu: Remove hardcoded interrupt name")
> msm-next:b08b92546807 ("drm/msm: drop interrupt-names")
> msm-next:24937c540917 ("dt-bindings: drm/msm/a6xx: Document GMU and update GPU bindings")
>
> And finally drm/msm: Fix A6XX support for opp-level
> https://patchwork.freedesktop.org/patch/276756/
>
> Which is not merged because it too depends on Rajendra's stack.

Newer version:

https://lore.kernel.org/patchwork/patch/1032724/

...that one should be able to land earlier since it's simpler.

---

Don't forget that your patch also depends on:

https://lkml.kernel.org/r/20181128185743.75328-2-dianders@chromium.org

...because you won't compile unless gpucc is there.


>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 121 +++++++++++++++++++++++++++++++++++
>  1 file changed, 121 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index f07c4ca..90766fc 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -1618,6 +1618,127 @@
>                         };
>                 };
>
> +
> +               gpu@5000000 {

Heads up to Andy that when this lands it should be re-sorted to be
right before gpucc so that the unit addresses are sorted.  :-)  ...and
while doing that we can make sure there's not an extra blank line.


-Doug
