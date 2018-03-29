Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbeC2U4A (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 16:56:00 -0400
Received: from mail-ua0-f182.google.com ([209.85.217.182]:34923 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751194AbeC2Uz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 16:55:57 -0400
X-Google-Smtp-Source: AIpwx4+kVdDnI+VYxZP2anavzqfyxnfObkZwT5EPMEVjv561TtRkgq4pMByr0IYq4P43P2cS+Ie1ByVAyRv+k4eQKiM=
MIME-Version: 1.0
In-Reply-To: <1522321466-21755-2-git-send-email-mgautam@codeaurora.org>
References: <1522321466-21755-1-git-send-email-mgautam@codeaurora.org> <1522321466-21755-2-git-send-email-mgautam@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 29 Mar 2018 13:55:55 -0700
X-Google-Sender-Auth: y-PZU7paaO_mzVpOx_b09zVjzPo
Message-ID: <CAD=FV=UXvf+_rvbFGrHAQ1N0kbrMR_c2=LBVD=AMuL6DAjWO+Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] clk: msm8996-gcc: change halt check for USB/PCIE pipe_clk
To: Manu Gautam <mgautam@codeaurora.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>, linux-arm-msm@vger.kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 29, 2018 at 4:04 AM, Manu Gautam <mgautam@codeaurora.org> wrote:
> The USB and PCIE pipe clocks are sourced from external clocks
> inside the QMP USB/PCIE PHYs. Enabling or disabling of PIPE RCG
> clocks is dependent on PHY initialization sequence hence
> update halt_check to BRANCH_HALT_DELAY for these clocks so
> that clock status bit is not polled when enabling or disabling
> the clocks. It allows to simplify PHY client driver code which
> is both user and source of the pipe_clk and avoid error logging
> related status check on clk_disable/enable.
>
> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> ---
>  drivers/clk/qcom/gcc-msm8996.c | 4 ++++
>  1 file changed, 4 insertions(+)

As per my feedback on <https://patchwork.kernel.org/patch/10314937/>,
I'm not a fan of this.  Hopefully we can adjust the PHY driver so it's
not needed.

-Doug
