Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D749C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29ED3217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VAMKn/y8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbeLRABq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 19:01:46 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37501 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbeLRABq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 19:01:46 -0500
Received: by mail-vs1-f65.google.com with SMTP id n13so976413vsk.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 16:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tU5zb32D1NlDI1ewRK0QXbFSN4oQONEvOQ6pAXCHjIg=;
        b=VAMKn/y8S6cAIfDkt+ISmgGCAZ8o+7gRk7nBqOwhuppd/WiSI1RJzkhxV2OX4yKXCI
         fW3k69YfvISpPaeL8rDlXmW1vIrBjM6jp33GapC3ti+7Zc+1qcUAcjEZh35VEWkVp0mL
         tjqqxjD7OAv9lbGDPohmcr+DOYy200lnLJXVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tU5zb32D1NlDI1ewRK0QXbFSN4oQONEvOQ6pAXCHjIg=;
        b=CI7NA5pD00lkt11Q3gPdtIcmBKkxVpSWAgTpBVE0+hbkvDtqX4HhT5ejfyhllhYWut
         K4vmPLuhW+4pxZWGj0bzMtKRvORe3BdS5oHLguEvnMnB1VTVRwt35B9YKY9g/bZznIna
         +gaLFjokDRxftLsTaE9CMiGw1NT73dBz6uxByINWbEk3RRFSVJ/ODME5y2HscUyJ4I9Z
         aVzx5z3dzo7/JR2pgBIR23qG7DpPi2rvBof2IpvmcQrKR3eim58mD7uKnU1PWLfz+6y4
         VScAtxUDFmcbr5GBDJcXlJhaHmEjKa4w6jSL5mKr+pzyLTqpZAy7oFAIYGpuErMvLRkM
         VYCQ==
X-Gm-Message-State: AA+aEWYrtIq/3VdxO0QWy0UY07BX6+X4Eb+a7w3G5ZbmyWtJZAt5PAZt
        7Q5OUENXc/dfddUg6LH86D3LPaQJlNo=
X-Google-Smtp-Source: AFSGD/VplyHbHOCRx4IzkdlwnJ8rSAtctFFKjQTSuZF3T0Ra7FtWBbAj1A+yHj9xvGdApZm2XjhwEw==
X-Received: by 2002:a67:8a81:: with SMTP id m123mr7478580vsd.206.1545091304742;
        Mon, 17 Dec 2018 16:01:44 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id n200sm4534594vke.44.2018.12.17.16.01.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 16:01:44 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id z24so5092049ual.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 16:01:43 -0800 (PST)
X-Received: by 2002:a9f:2b44:: with SMTP id q4mr6719130uaj.126.1545091303183;
 Mon, 17 Dec 2018 16:01:43 -0800 (PST)
MIME-Version: 1.0
References: <20181217100724.4593-1-sibis@codeaurora.org> <20181217100724.4593-4-sibis@codeaurora.org>
In-Reply-To: <20181217100724.4593-4-sibis@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 17 Dec 2018 16:01:31 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UVm=p4Vo7g5-9z0mEN2xD1JXHK-_1tj8WLvxzr04M0RQ@mail.gmail.com>
Message-ID: <CAD=FV=UVm=p4Vo7g5-9z0mEN2xD1JXHK-_1tj8WLvxzr04M0RQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] dt-bindings: remoteproc: qcom: Add power-domain
 bindings for Q6V5
To:     sibis@codeaurora.org, Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
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

On Mon, Dec 17, 2018 at 2:08 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Add power-domain bindings for Q6V5 MSS on MSM8996 and SDM845 SoCs.
>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>
> v2:
>   * Add load_state power-domain
>   * List cx and mx power-domains for MSM8996
>
>  .../devicetree/bindings/remoteproc/qcom,q6v5.txt | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> index 98894e6ad456..50695cd86397 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> @@ -80,6 +80,22 @@ on the Qualcomm Hexagon core.
>                     reference to the pll-supply regulator to be held on behalf
>                     of the booting of the Hexagon core on MSM8996 SoCs
>
> +- power-domains:
> +       Usage: required
> +       Value type: <phandle>
> +       Definition: reference to the list of 2 power-domains for the modem
> +                   sub-system on MSM8996 SoCs

This is truly required for msm8996 SoCs?  The code I'm looking at
doesn't try to get these power domains for 8996 so presumably you're
breaking backward compatibility with old device tree files by making
this required now.  I don't personally know how widespread msm8996
usage is w/ upstream, so I'd let Bjorn comment on whether he thinks
this is OK.

As with the other patches in this series, I personally prefer less
prose and more lists / tables of exactly what is required for which
compatible string.


> +                   reference to the list of 4 power-domains for the modem
> +                   sub-system on SDM845 SoCs
> +
> +- power-domain-names:
> +       Usage: required
> +       Value type: <stringlist>
> +       Definition: must be "cx", "mx" for the modem sub-system on MSM8996
> +                   SoCs
> +                   must be "cx", "mx", "mss", "load_state" for the modem
> +                   sub-system on SDM845 SoCs

I haven't see a patch for using "load_state".  Can you point at it?  I
guess this was "aop" in your last version?


-Doug
