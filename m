Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A12C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 02:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71DAA20855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 02:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V5Jl5jW+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfARCvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 21:51:02 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41406 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfARCvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 21:51:01 -0500
Received: by mail-vs1-f66.google.com with SMTP id t17so7563762vsc.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 18:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h7wFAMQ1TwFUAHZNZ7eC0jGMmupcHkRoHMn4VkWMquI=;
        b=V5Jl5jW+Gn19LSA4e5cxDNdyBXJntk9BSv/YhOE8tTFcj8A8nL9jryIUuDWp6R+P8D
         E98lb3qtniehQZeH3MJ66UGoWaP+S4laOQYIFTQCrd0qobDOVhGEjHNdxXLXRDsXQzkn
         YQs2zbEl3XM3jFRIj86cNP5vLy+p+27w6cNJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h7wFAMQ1TwFUAHZNZ7eC0jGMmupcHkRoHMn4VkWMquI=;
        b=tkV9591jI6XZ2P3YoMfLBlOOntfSmcxb7Fbg0zp92mnwydeW/pEgYUR0BmbXhXBdeC
         u/pubaaIHzL/nXuVtmlMejwQZN23iK7U/ual9iolcdJVyUbzPuaBsyuF92/F9n2OmSBq
         Wcs6ewg9lztyGNEQVuF+owODDZXD230RI4e4sOl7/pt051o7c/oZBfsW4jerYzFBY1/g
         V6nsVHHf4QpHqiCpw2XccI68zez69753CSo/nSYQvGo5fJg3bN5bnybQ8WBAPUJaqGwH
         T63m73s+KyNkgI4jKElHE38Cr6H0KRTQVb3O4OZfJ0X8rCSGwy5I1sWpD/ah1ReZaXRt
         xrXg==
X-Gm-Message-State: AJcUukcgIE1wAa2Gi1Bw6c7j6VlLtYsaceEXl0S4h+617n17+DaYlRoI
        Cc+Xlpz5b6PkZr/wcfykAzufxPAyVkQ=
X-Google-Smtp-Source: ALg8bN7LqzrmxXr5eqw2+jjTsVDbOQ+rxMuw8IRRNLrwaJDBhWbPo5weFnCU6lQIpyhuqCqdMO4Rfg==
X-Received: by 2002:a67:4909:: with SMTP id w9mr6965398vsa.189.1547779860349;
        Thu, 17 Jan 2019 18:51:00 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id 188sm23682570vkr.25.2019.01.17.18.50.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 18:50:59 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id n10so7548802vso.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 18:50:58 -0800 (PST)
X-Received: by 2002:a67:da93:: with SMTP id w19mr7025064vsj.144.1547779858569;
 Thu, 17 Jan 2019 18:50:58 -0800 (PST)
MIME-Version: 1.0
References: <20190114184255.258318-1-mka@chromium.org>
In-Reply-To: <20190114184255.258318-1-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 17 Jan 2019 18:50:46 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xac6FCx=scgm5BCBsHFgtvqBpHT1ziKzrOWR2y7+J-_A@mail.gmail.com>
Message-ID: <CAD=FV=Xac6FCx=scgm5BCBsHFgtvqBpHT1ziKzrOWR2y7+J-_A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: sdm845: Add CPU topology
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 14, 2019 at 10:43 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> The 8 CPU cores of the SDM845 are organized in two clusters of 4 big
> ("gold") and 4 little ("silver") cores. Add a cpu-map node to the DT
> that describes this topology.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 38 ++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)

Looks right to me and matches bindings examples.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
