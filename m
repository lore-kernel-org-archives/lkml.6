Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755446AbeE3FX0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 01:23:26 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:35204 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751912AbeE3FXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 01:23:23 -0400
X-Google-Smtp-Source: ADUXVKJ6fDr4frU9/Qm6tWuFy7Ck7pZL82EDmWlacIiaRh4bkrcQzbavq+wiN4qCVAj/Owcsy8CAEucSDs2gSEqEF/0=
MIME-Version: 1.0
In-Reply-To: <6d03576cf90f06afb1194301cb41fc31704def1d.1527040878.git.collinsd@codeaurora.org>
References: <cover.1527040878.git.collinsd@codeaurora.org> <6d03576cf90f06afb1194301cb41fc31704def1d.1527040878.git.collinsd@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 29 May 2018 22:23:20 -0700
X-Google-Sender-Auth: tjlk6J9oVaS-0rPjCp00X2mv27Q
Message-ID: <CAD=FV=VH0bTxPOmRr+jUyV0cGNQHLcwQTV9L-t0bxZOqD8FnHA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] regulator: dt-bindings: add QCOM RPMh regulator bindings
To: David Collins <collinsd@codeaurora.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 22, 2018 at 7:43 PM, David Collins <collinsd@codeaurora.org> wrote:
> +========
> +Examples
> +========
> +
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +
> +&apps_rsc {
> +       pm8998-rpmh-regulators {
> +               compatible = "qcom,pm8998-rpmh-regulators";
> +               qcom,pmic-id = "a";
> +
> +               vdd-l7-l12-l14-l15-supply = <&pm8998_s5>;
> +
> +               smps2 {
> +                       regulator-min-microvolt = <1100000>;
> +                       regulator-max-microvolt = <1100000>;
> +               };
> +
> +               pm8998_s5: smps5 {
> +                       regulator-min-microvolt = <1904000>;
> +                       regulator-max-microvolt = <2040000>;
> +               };
> +
> +               ldo7 {
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <1800000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +                       regulator-allowed-modes =
> +                               <RPMH_REGULATOR_MODE_LPM
> +                                RPMH_REGULATOR_MODE_HPM>;
> +                       regulator-allow-set-load;
> +                       qcom,regulator-drms-modes =
> +                               <RPMH_REGULATOR_MODE_LPM
> +                                RPMH_REGULATOR_MODE_HPM>;
> +                       qcom,drms-mode-max-microamps = <10000 1000000>;

Things look pretty good to me now.  I'm still hesitant about the whole
need to list the modes twice (once using the unordered
"regulator-allowed-modes" and once to match up against the ordered
"qcom,drms-mode-max-microamps").  I'm also still of the opinion that
the whole "drms-mode-max-microamps" ought to be a standard property
(not a qcom specific one) and handled in the regulator core.

However, for both of these things I leave it to the discretion of Mark
to choose what he wants.  Thus assuming Mark is OK with these two
things, feel free to add my Reviewed-by.

-Doug
