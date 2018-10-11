Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECE0C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF142077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:09:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF142077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbeJKSfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 14:35:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35812 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbeJKSfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 14:35:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA7017A9;
        Thu, 11 Oct 2018 04:08:58 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 821D93F5B3;
        Thu, 11 Oct 2018 04:08:55 -0700 (PDT)
Date:   Thu, 11 Oct 2018 12:08:49 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net,
        ulf.hansson@linaro.org, khilman@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH RFC v1 5/8] dt-bindings: introduce cpu power domain
 bindings for Qualcomm SoCs
Message-ID: <20181011110849.GA32752@e107155-lin>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-6-git-send-email-rplsssn@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539206455-29342-6-git-send-email-rplsssn@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 02:50:52AM +0530, Raju P.L.S.S.S.N wrote:
> Add device binding documentation for Qualcomm Technology Inc's cpu
> domain driver. The driver is used for managing system sleep activities
> that are required when application processor is going to deepest low
> power mode.
>

So either we are not using PSCI or the binding is not so clear on
how this co-exist with PSCI power domains. Could you provide details ?

> Cc: devicetree@vger.kernel.org
> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
> ---
>  .../bindings/soc/qcom/cpu_power_domain.txt         | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/cpu_power_domain.txt
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/cpu_power_domain.txt b/Documentation/devicetree/bindings/soc/qcom/cpu_power_domain.txt
> new file mode 100644
> index 0000000..1c8fe69
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/cpu_power_domain.txt
> @@ -0,0 +1,39 @@
> +Qualcomm Technologies cpu power domain
> +-----------------------------------------
> +
> +CPU power domain handles the tasks that need to be performed during
> +application processor deeper low power mode entry for QCOM SoCs which
> +have hardened IP blocks combinedly called as RPMH (Resource Power Manager
> +Hardened) for shared resource management. Flushing the buffered requests
> +to TCS (Triggered Command Set) in RSC (Resource State Coordinator) and
> +programming the wakeup timer in PDC (Power Domain Controller) for timer
> +based wakeup are handled as part of domain power down.
> +

And which is this not hidden as part of PSCI CPU_SUSPEND ?

> +The bindings for cpu power domain is specified in the RSC section in
> +devicetree.
> +
> +Properties:
> +- compatible:
> +	Usage: required
> +	Value type: <string>
> +	Definition: must be "qcom,cpu-pm-domain".
> +

NACK until details on how this can co-exist with PSCI is provided.

--
Regards,
Sudeep
