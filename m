Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751773AbeDGNFo (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 09:05:44 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39677 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751501AbeDGNFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 09:05:41 -0400
X-Google-Smtp-Source: AIpwx482JE3vcvhMrK55+MuZY3aVPXYWNkGtG6rEeyK9IkJRM5GVd+pSgMA9SeEG7GBdnovR9qHs6g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Rajendra Nayak <rnayak@codeaurora.org>, andy.gross@linaro.org,
        ulf.hansson@linaro.org, viresh.kumar@linaro.org
From: Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180316040824.21472-4-rnayak@codeaurora.org>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>
References: <20180316040824.21472-1-rnayak@codeaurora.org>
 <20180316040824.21472-4-rnayak@codeaurora.org>
Message-ID: <152310634007.180276.1696228496997606733@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 3/7] dt-bindings: opp: Introduce qcom-opp bindings
Date: Sat, 07 Apr 2018 06:05:40 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w37D5nCj020238

Quoting Rajendra Nayak (2018-03-15 21:08:20)
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
> diff --git a/Documentation/devicetree/bindings/opp/qcom-opp.txt b/Documentation/devicetree/bindings/opp/qcom-opp.txt
> new file mode 100644
> index 000000000000..56fe87751881
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/opp/qcom-opp.txt
> @@ -0,0 +1,25 @@
> +Qualcomm OPP bindings to descibe OPP nodes with corner/level values
> +
> +OPP tables for devices on qualcomm platforms require an additional

Capitalize qualcomm?

> +platform specific corner/level value to be specified.
> +This value is passed on to the RPM (Resource Power Manager) by
> +the CPU, which then takes the necessary actions to set a voltage
> +rail to a appropriate voltage based on the value passed.

to an

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

Can this be operating-points-v2-level or -qcom-level? Just worried that
qcom is too generic.

> +
> +* OPP Node
> +
> +Required properties:
> +- qcom,level: On Qualcomm platforms an OPP node can describe a positive value
> +representing a corner/level thats comminicated with a remote microprocessor

s/thats/that's/

> +(Usually called the RPM) which then translates it into a certain voltage on

lowercase Usually

> +a voltage rail.
