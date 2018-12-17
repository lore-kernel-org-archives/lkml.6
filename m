Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CDFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C584D21473
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zs3a5vW+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbeLQX72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 18:59:28 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39353 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbeLQX72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 18:59:28 -0500
Received: by mail-vs1-f68.google.com with SMTP id h78so8894130vsi.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 15:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=21DN3RbyMrnuNVTwgUOi1PJqvQNrIzsDFux9XPVlb+4=;
        b=Zs3a5vW+PcCRE4KrpngI33uVlEJqyzoXtRjwKyu9uje7TBqkBxiK4Iumn96s8xx4Py
         oK5LcA/7l85UssfvAXl+Y/YJDUsVDbTC5hUTIMvbZso4PODKz0melHKCIX/2xqtVOYpu
         kLJ4I3XH2XWMBWYDs+PanZzNNJeDQenX0hWdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=21DN3RbyMrnuNVTwgUOi1PJqvQNrIzsDFux9XPVlb+4=;
        b=mMmh+UHkdngD+90ZrzYKGRkmCfzWySJF6N+Cs2qVYb3om3xmauXAcg13LWK8b5nEHM
         cmlZUOP0iofLJP0W7vMxiy2FpK9IfvbIQiVWrNNl+N0mayZHWNwBn5YTW0GCuCIlTUfs
         XIlCcmjuCRYbDrA6yAhsMcD2wnRXoknXJeBmpUf26xZ+NH9wDS9STDvXtehZ9gFXMeDX
         Mj3IvYRPTwNthct/CqCkVGYFlR0JzUPvFB1rxhkczG9Xpg41bPV1STkZaaBVXumpKj09
         Q4WzvSnmKAB6/ecLn+1vTNBagqa2F4t8ZsoyhHsyF1cKk632Td3jhmmq/KI0VG6vzMCN
         uOrw==
X-Gm-Message-State: AA+aEWZiCl+rJeVF2jkrBRiJhcc4beLtJAsuF0vy5KwGURPKwiy7uQ2G
        GIOno27nENtcrPfmMl3qt0dkom9vx3M=
X-Google-Smtp-Source: AFSGD/VDVrFjqijJI6BrpFIyBdXKMf5MDg79yT8svN07v4QLJOHLD5b5ZxYYB/thHaU8rljJt+e+ew==
X-Received: by 2002:a67:d38c:: with SMTP id b12mr7302498vsj.131.1545091166766;
        Mon, 17 Dec 2018 15:59:26 -0800 (PST)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id e67sm6210035vsd.32.2018.12.17.15.59.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 15:59:25 -0800 (PST)
Received: by mail-vk1-f178.google.com with SMTP id b18so3285657vke.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 15:59:25 -0800 (PST)
X-Received: by 2002:a1f:ab17:: with SMTP id u23mr6697176vke.73.1545091165009;
 Mon, 17 Dec 2018 15:59:25 -0800 (PST)
MIME-Version: 1.0
References: <20181217100724.4593-1-sibis@codeaurora.org>
In-Reply-To: <20181217100724.4593-1-sibis@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 17 Dec 2018 15:59:13 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WJPEzXahN3HRdNPTfcPs+OPCiQ_3f1zQh1-poekPgGRg@mail.gmail.com>
Message-ID: <CAD=FV=WJPEzXahN3HRdNPTfcPs+OPCiQ_3f1zQh1-poekPgGRg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: soc: qcom: Add remote-pid binding for
 GLINK SMEM
To:     sibis@codeaurora.org
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
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 17, 2018 at 2:07 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Add missing qcom,remote-pid dt binding required for GLINK SMEM
> which specifies the remote endpoint of the GLINK edge.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt | 5 +++++
>  1 file changed, 5 insertions(+)

Fixes: 2b41d6c8e696 ("dt-bindings: soc: qcom: Extend GLINK to cover SMEM")


> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
> index 0b8cc533ca83..59ae603ba520 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
> @@ -21,6 +21,11 @@ edge.
>         Definition: should specify the IRQ used by the remote processor to
>                     signal this processor about communication related events
>
> +- qcom,remote-pid:
> +       Usage: required for glink-smem
> +       Value type: <u32>
> +       Definition: specifies the identfier of the remote endpoint of this edge

s/identfier/identifier/


Other than the typo this seems right to me.  Feel free to add my
Reviewed-by tag when that's fixed.


-Doug
