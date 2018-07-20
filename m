Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66D8ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52FF3206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="dlBppNUF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JFYe819z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52FF3206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbeGTVZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:25:02 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:42903 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727766AbeGTVZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:25:01 -0400
Received: by mail-vk0-f68.google.com with SMTP id t4-v6so6653233vke.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 13:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=qDuU28NoXOhA9CNP5N2LOSbBxJY4X+lR3pTMC2WKcXI=;
        b=dlBppNUFGoYqvaCW+2fk1cGhl2DmU3de1sRdoDhogr7YDiwBGHSH7B7p8+5CZjS5nw
         5aYF3b25L3laRbE3L93F/6XuFYC8/Ht4F0QJ3X0MNaXb6CADOKcP6192r/bsm1+OYDMy
         4vBVHLcRpdc4Ox49aSMtjxLaaQepw4zJ/p3fWOTfhrCpl0I7CkzgT/5bls3w5MLrVnFu
         wF2uHf1AgTxaxOzE564C43nBKsN7J15BtxcMZKcISmlhQm2aKRKpCFtDFh0B6El+C9WB
         0df0t8yAvcoRPydaRO9YdybSVhlQhK80EEI60foonY/NF9eMFmilymMUIw2OO4IMsGSC
         oUfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=qDuU28NoXOhA9CNP5N2LOSbBxJY4X+lR3pTMC2WKcXI=;
        b=JFYe819z3EdJ9In7jQlWoEG6Zoex4TFUt/NcY+OcW3YrI/owTCd0WtV71cXix2T1oY
         vdUbylwoeEAy5B+rUwoWtIbpl5Q5zTKa5yk48vr5KDmXC4XUp8CAGEgyxEmsQ4CdhGke
         l1WFGW2zN2Vj1euAZlsynGPSFnWqpno9c3yBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=qDuU28NoXOhA9CNP5N2LOSbBxJY4X+lR3pTMC2WKcXI=;
        b=qN2gr3VZrue8jkcp9uFzZiguk/awgwzW01EyXFxHQd6o4eGb0Yqev8USOv+5pAXeOV
         WdMQ5oUdHOLCEPG68tlLuIorXw/A2tI4vEsUEZxnEwoYJgnpGFXp+vbs4+0Ile9Akzvx
         C8ePA3vJuXOxH0bzfgl8ZChwNsy/jPUVDewEJDeVBuoNmb9v3O2vSoa4UINAS6cNUjj6
         SNplOfck0OsnxX2QquLUTUXxPhsMQ3IWb/+nKxvVn6I+tLwAYoMDMczWp4XvBLcFSfXR
         OjnPczgyYrxbplCM2A87v0aBuFZbk7DFyBJJs7YbLxS6TgWiakrN4cGMmgMrR1gXaExu
         Pevw==
X-Gm-Message-State: AOUpUlFD7WiJeHDjOw7E1LhoQRV7RB5dqdS1PJ6Drp56AxzeoK0KWGms
        19e7pOEa0mA11q27a6sdH8okCye0KNb7AaS28EMfqA==
X-Google-Smtp-Source: AAOMgpfYbccQ6oORBHmj7EHArAQX+SMIuNq73u6ymR5HPd3AKLEu2tUtSEEcfM1b52feYWBG3N2GU61u106WMEAWLLU=
X-Received: by 2002:a1f:ebc7:: with SMTP id j190-v6mr2171310vkh.114.1532118906616;
 Fri, 20 Jul 2018 13:35:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:610e:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 13:35:04
 -0700 (PDT)
In-Reply-To: <1532087461-3474-3-git-send-email-dkota@codeaurora.org>
References: <1532087461-3474-1-git-send-email-dkota@codeaurora.org> <1532087461-3474-3-git-send-email-dkota@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 20 Jul 2018 13:35:04 -0700
X-Google-Sender-Auth: U2r1nRRJka4VPEKuIZK03VkeqEo
Message-ID: <CAD=FV=W+UOeK0p_QAg=bSZxxBXq_2whGKC9H6kgYNS1dy0qLvA@mail.gmail.com>
Subject: Re: [PATCH V2] dt-bindings: soc: qcom: Add device tree binding for
 GENI SE
To:     Dilip Kota <dkota@codeaurora.org>
Cc:     timur@codeaurora.org, Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 20, 2018 at 4:51 AM, Dilip Kota <dkota@codeaurora.org> wrote:
> From: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
>
> Add device tree binding support for the QCOM GENI SE driver.
>
> Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
> Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Andy Gross <andy.gross@linaro.org>
> ---
>  .../devicetree/bindings/soc/qcom/qcom,geni-se.txt  | 119 +++++++++++++++++++++
>  1 file changed, 119 insertions(+)

Just a note to mention that this patch landed two months ago and can
already be found in mainline Linux.  See commit e9b02415565b
("dt-bindings: soc: qcom: Add device tree binding for GENI SE").

...I think Mark Brown made comments on v1 of the SPI driver that he
was surprised about how the bindings landed, but that doesn't mean you
should re-post a patch that is already in mainline--just point to the
patch that landed by git hash.  If something about the bindings needs
to change then post a patch that changes them.

-Doug
