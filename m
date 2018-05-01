Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751924AbeEAXpb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 19:45:31 -0400
Received: from mail-ua0-f182.google.com ([209.85.217.182]:41823 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751704AbeEAXp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 19:45:27 -0400
X-Google-Smtp-Source: AB8JxZqVMq9ZGAyoc1PBMng1dWgUccN9QD1kY4Nwvsdg+i51x5Wm+jElUZN4Du/bLyWi7C2bLLR1TnoLUvwEcidYxas=
MIME-Version: 1.0
In-Reply-To: <20180419221635.17849-3-ilina@codeaurora.org>
References: <20180419221635.17849-1-ilina@codeaurora.org> <20180419221635.17849-3-ilina@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 1 May 2018 16:45:25 -0700
X-Google-Sender-Auth: sVaAEc1ajiSpLM8USdNkzZJv6vc
Message-ID: <CAD=FV=WfC5x12kFd7Uw8DTR=OFx4HFJhJrd-sDZ5EJgkWL3tQw@mail.gmail.com>
Subject: Re: [PATCH v6 02/10] dt-bindings: introduce RPMH RSC bindings for
 Qualcomm SoCs
To: Lina Iyer <ilina@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 19, 2018 at 3:16 PM, Lina Iyer <ilina@codeaurora.org> wrote:
> +TCS-OFFSET: 0xD00
> +
> +       apps_rsc: rsc@179e000 {

This label is wrong in two ways:

1. I believe it's supposed to be the first reg listed, so 179c0000

2. There's only 3 0's at the end.

Thus, it should be:

apps_rsc: rsc@179c0000

> +               label = "apps_rsc";
> +               compatible = "qcom,rpmh-rsc";
> +               reg = <0x179c0000 0x10000>, <0x179d0000 0x10000>,
> +                     <0x179e0000 0x10000>, <0xd00 0>;
> +               reg-names = "drv-0", "drv-1", "drv-2", "tcs-offset";
> +               interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> +               qcom,drv-id = <2>;
> +               qcom,tcs-config = <SLEEP_TCS   3>,
> +                                 <WAKE_TCS    3>,
> +                                 <ACTIVE_TCS  2>,
> +                                 <CONTROL_TCS 1>;
> +       };
