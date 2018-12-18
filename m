Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D39FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE86A217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wk6y6ZJ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbeLRABO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 19:01:14 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37486 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbeLRABN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 19:01:13 -0500
Received: by mail-vs1-f65.google.com with SMTP id n13so975676vsk.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 16:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ISLz8DiNoyXUnepiP7Vb7/kiH8sUvVTMQpLRE8vqHk=;
        b=Wk6y6ZJ84Fx/KuDdDijLPbyuTP4DYDFldXVsVPVLmiAqIJvYJhPQ4AXiv3NmDjo8pv
         SB11X64CDpGL2KC+3qtXrUv5xQmjcpFSNkkbEkXbZKVX5fD4qHWqsA15GB5A+DfykKTO
         3ixbzLBWnpmlGJCKEYtqbIMjeKrNst4UhV/x4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ISLz8DiNoyXUnepiP7Vb7/kiH8sUvVTMQpLRE8vqHk=;
        b=NzJFCgnHOqHLwl1nGzfSgUYO59WvlQt5so2QFuQS/ywkYKrjHDZPFGiQzFbsA/thqc
         oU6wiAksm8kGrhlavrcb6/OOQAoz84o6PPikVfCV5w+A9im8oVklNbdU5D9CRJqGc3zg
         97QJ6P7/WXy7x98Cmsd5uH5Y8OkEWKgF7M8RmySf/g301tuYFioA3hj58Sgj3A07R6jh
         bMdMIGrqryMHJUlEC9oM0QbJywa7ffzB+e4d9hRd91PyC5aP2zUJ41GWaYBnouCStt49
         DYO0ROwq1AR9HqVig2BXlUQOd/UzPF0BktLNUDcUya+HKUtPi5XZcOVxdbtrsehM6Lan
         tGqQ==
X-Gm-Message-State: AA+aEWYlIq3pBbs30ZkT1DiUXK1+u/XewpPcEF57lcWBc6Z0OTS1QqD0
        LQNMnz9i4KqOl1j7MCegvQRYlL+3BSM=
X-Google-Smtp-Source: AFSGD/XJi8kaoSQ2WqPvxmalQAPfASHfSVg4ifipfO7xTdZ2wZnKhmMCbW76dGp6oULLjhI9kSMlEQ==
X-Received: by 2002:a67:804e:: with SMTP id b75mr7320147vsd.226.1545091271454;
        Mon, 17 Dec 2018 16:01:11 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id g203sm4694142vsd.19.2018.12.17.16.01.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 16:01:10 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id d19so5068660uaq.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 16:01:10 -0800 (PST)
X-Received: by 2002:ab0:146b:: with SMTP id c40mr6889952uae.9.1545091269772;
 Mon, 17 Dec 2018 16:01:09 -0800 (PST)
MIME-Version: 1.0
References: <20181217100724.4593-1-sibis@codeaurora.org> <20181217100724.4593-3-sibis@codeaurora.org>
In-Reply-To: <20181217100724.4593-3-sibis@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 17 Dec 2018 16:00:58 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XNZ5CzKXHogKEGTHgPVg_nbXxVEJR0e9F9usEY3YKEiQ@mail.gmail.com>
Message-ID: <CAD=FV=XNZ5CzKXHogKEGTHgPVg_nbXxVEJR0e9F9usEY3YKEiQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] dt-bindings: remoteproc: qcom: Fixup regulator dependencies
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

On Mon, Dec 17, 2018 at 2:08 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Fixup regulator supply dependencies for Q6V5 MSS on MSM996 SoCs.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> index 780adc043b37..98894e6ad456 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> @@ -76,7 +76,9 @@ on the Qualcomm Hexagon core.
>         Usage: required
>         Value type: <phandle>
>         Definition: reference to the regulators to be held on behalf of the
> -                   booting of the Hexagon core
> +                   booting of the Hexagon core on MSM8916 SoCs
> +                   reference to the pll-supply regulator to be held on behalf
> +                   of the booting of the Hexagon core on MSM8996 SoCs

The prose gets in the way and doesn't add anything.  I also don't
understand what you're saying for msm8996.  You're saying that
"pll-supply" is required there but none of the others?  That doesn't
seem to be true in the code I have in front of me, but maybe I'm
missing some patch.  For me, I'd write:

For the compatible strings below the following supplies are required:
  "qcom,q6v5-pil"
  "qcom,msm8916-mss-pil",
  "qcom,msm8974-mss-pil"
- cx-supply:
- mss-supply:
- mx-supply:
- pll-supply:
Usage: required
Value type: <phandle>
Definition: reference to the regulators to be held on behalf of the
    booting of the Hexagon core


...and if msm8996 actually needs "pll-supply", you could add in...

For the compatible strings below the following supplies are required:
  "qcom,msm8996-mss-pil"
- pll-supply:
Usage: required
Value type: <phandle>
Definition: reference to the regulators to be held on behalf of the
    booting of the Hexagon core
