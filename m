Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751963AbeCPEdz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 00:33:55 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38284 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbeCPEdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 00:33:52 -0400
X-Google-Smtp-Source: AG47ELvOcm5ndJJ0y+kp/GkE8QYUAoV/9gko9m8dbRZ2jh+Aoc4G6iH1Cdi6wO3I1kfyYbpSQcZc7A==
Date: Fri, 16 Mar 2018 10:03:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: sboyd@kernel.org, andy.gross@linaro.org, ulf.hansson@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] dt-bindings: opp: Introduce qcom-opp bindings
Message-ID: <20180316043349.GP15832@vireshk-i7>
References: <20180316040824.21472-1-rnayak@codeaurora.org>
 <20180316040824.21472-4-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316040824.21472-4-rnayak@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-03-18, 09:38, Rajendra Nayak wrote:
> On Qualcomm platforms, an OPP node needs to describe an
> additional level/corner value that is then communicated to
> a remote microprocessor by the CPU, which then takes some
> actions (like adjusting voltage values across various rails)
> based on the value passed.
> 
> Describe these bindings in the qcom-opp bindings document.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/opp/qcom-opp.txt | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/opp/qcom-opp.txt
> 
> diff --git a/Documentation/devicetree/bindings/opp/qcom-opp.txt b/Documentation/devicetree/bindings/opp/qcom-opp.txt
> new file mode 100644
> index 000000000000..56fe87751881
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/opp/qcom-opp.txt
> @@ -0,0 +1,25 @@
> +Qualcomm OPP bindings to descibe OPP nodes with corner/level values
> +
> +OPP tables for devices on qualcomm platforms require an additional
> +platform specific corner/level value to be specified.
> +This value is passed on to the RPM (Resource Power Manager) by
> +the CPU, which then takes the necessary actions to set a voltage
> +rail to a appropriate voltage based on the value passed.
> +
> +The bindings are based on top of the operating-points-v2 bindings
> +described in Documentation/devicetree/bindings/opp/opp.txt
> +Additional properties are described below.
> +
> +* OPP Table Node
> +
> +Required properties:
> +- compatible: Allow OPPs to express their compatibility. It should be:
> +  "operating-points-v2-qcom"
> +
> +* OPP Node
> +
> +Required properties:
> +- qcom,level: On Qualcomm platforms an OPP node can describe a positive value
> +representing a corner/level thats comminicated with a remote microprocessor
> +(Usually called the RPM) which then translates it into a certain voltage on
> +a voltage rail.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
