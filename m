Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030806AbeEYWdr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 18:33:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40520 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030408AbeEYWdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 18:33:45 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4E35260392
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH v2 2/6] dt-bindings: opp: Introduce qcom-opp bindings
To: Rajendra Nayak <rnayak@codeaurora.org>, viresh.kumar@linaro.org,
        sboyd@kernel.org, andy.gross@linaro.org, ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180525100121.28214-1-rnayak@codeaurora.org>
 <20180525100121.28214-3-rnayak@codeaurora.org>
From: David Collins <collinsd@codeaurora.org>
Message-ID: <67054dca-33a8-7e7c-6218-dc5abf84f6d8@codeaurora.org>
Date: Fri, 25 May 2018 15:33:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20180525100121.28214-3-rnayak@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rajendra,

On 05/25/2018 03:01 AM, Rajendra Nayak wrote:
> On Qualcomm platforms, an OPP node needs to describe an

s/Qualcomm/Qualcomm Technologies, Inc./


> additional level/corner value that is then communicated to
> a remote microprocessor by the CPU, which then takes some
> actions (like adjusting voltage values across various rails)
> based on the value passed.
> 
> Describe these bindings in the qcom-opp bindings document.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/opp/qcom-opp.txt      | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/opp/qcom-opp.txt
> 
> diff --git a/Documentation/devicetree/bindings/opp/qcom-opp.txt b/Documentation/devicetree/bindings/opp/qcom-opp.txt
> new file mode 100644
> index 000000000000..db4d970c7ec7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/opp/qcom-opp.txt
> @@ -0,0 +1,25 @@
> +Qualcomm OPP bindings to descibe OPP nodes with corner/level values

s/Qualcomm/Qualcomm Technologies, Inc./ ?

s/descibe/describe/


> +
> +OPP tables for devices on Qualcomm platforms require an additional

s/Qualcomm/Qualcomm Technologies, Inc./


> +platform specific corner/level value to be specified.
> +This value is passed on to the RPM (Resource Power Manager) by

Do you want to mention RPMh here as well?


> +the CPU, which then takes the necessary actions to set a voltage
> +rail to an appropriate voltage based on the value passed.
> +
> +The bindings are based on top of the operating-points-v2 bindings
> +described in Documentation/devicetree/bindings/opp/opp.txt
> +Additional properties are described below.
> +
> +* OPP Table Node
> +
> +Required properties:
> +- compatible: Allow OPPs to express their compatibility. It should be:
> +  "operating-points-v2-qcom-level"
> +
> +* OPP Node
> +
> +Required properties:
> +- qcom,level: On Qualcomm platforms an OPP node can describe a positive value

s/Qualcomm/Qualcomm Technologies, Inc./


> +representing a corner/level that's communicated with a remote microprocessor
> +(usually called the RPM) which then translates it into a certain voltage on
> +a voltage rail.

Should these lines be indented 2 spaces as is the case for the compatible
property above?

Could you add an example for both RPM and RPMh in this binding file?

Thanks,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
