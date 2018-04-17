Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752703AbeDQUHC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 16:07:02 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:41849 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752327AbeDQUG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 16:06:59 -0400
X-Google-Smtp-Source: AIpwx4+nueSh1YdBtaDSAmneBncRbIK6DpjOV7Yu07F0AGJ5/kDRi/twfOCOxWOuD/EdMOOSMbzP38ZPQLH8827EUt4=
MIME-Version: 1.0
In-Reply-To: <39b676d2ba7dac2436196cc5a090c6f151498dc8.1523673467.git.collinsd@codeaurora.org>
References: <cover.1523673467.git.collinsd@codeaurora.org> <39b676d2ba7dac2436196cc5a090c6f151498dc8.1523673467.git.collinsd@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 17 Apr 2018 13:06:57 -0700
X-Google-Sender-Auth: dxbqW3AYA25lNto5cUQo9-HV5ho
Message-ID: <CAD=FV=UxabaHPa-pkGBvQDcmh7e+bqMRX4WdMS8xfhAQSKD9gg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] regulator: dt-bindings: add QCOM RPMh regulator bindings
To: David Collins <collinsd@codeaurora.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>, Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 13, 2018 at 7:50 PM, David Collins <collinsd@codeaurora.org> wrote:
> Introduce bindings for RPMh regulator devices found on some
> Qualcomm Technlogies, Inc. SoCs.  These devices allow a given
> processor within the SoC to make PMIC regulator requests which
> are aggregated within the RPMh hardware block along with requests
> from other processors in the SoC to determine the final PMIC
> regulator hardware state.
>
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> ---
>  .../bindings/regulator/qcom,rpmh-regulator.txt     | 207 +++++++++++++++++++++
>  .../dt-bindings/regulator/qcom,rpmh-regulator.h    |  36 ++++
>  2 files changed, 243 insertions(+)

I noticed that "qcom,rpmh-resource-type" is now gone.  Not needed
anymore?  Oh, I see.  Stephen said to add it when it's needed.  OK,
fine.


> +===============================
> +Second Level Nodes - Regulators
> +===============================
> +
> +- qcom,regulator-initial-voltage

nit: regulator framework tends to include "microvolt" in the name to
make it really obvious in the device tree what the units are.  Can you
do that too?


> +- qcom,drms-mode-threshold-currents

Could use microamp in the name of the property too...


> +                       qcom,allowed-drms-modes =
> +                               <RPMH_REGULATOR_MODE_LPM
> +                                RPMH_REGULATOR_MODE_HPM>;
> +                       qcom,drms-mode-threshold-currents = <10000 1000000>;

optional nit: to make it match downstream drivers, does it make sense
to change this to:

  <9999 999999>

...so if a driver used to request exactly 10000 mA that it will end up
with the same mode (no idea if drivers actually do that).


-Doug
