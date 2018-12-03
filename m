Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2393EC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2BC2081C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2BC2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbeLCXvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:51:48 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46956 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeLCXvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:51:48 -0500
Received: by mail-oi1-f195.google.com with SMTP id x202so12618866oif.13;
        Mon, 03 Dec 2018 15:51:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7kz3YLuocRsmihqXQI9LLFbs+KxuNq5m0QiZgl78RUM=;
        b=RYp4jxmPIJvvcohBxHjlSxtMtPJMrta+HaiGPOnKxsOVk/g+PiKiXHe88njto3jYK8
         9IwHbGm/k+Ddi3br2jKQqGoHgmtlamaF7BF5XiBnAlkzoKn5SJfw0sSngZ6TvpE27U29
         BR7Jibe1ZZCXyTzvmPMEoT97q9SZnjA3fJSgJ9vn1/D9oNZDBB9irRO3ulTyK4nzyXlT
         rxIydtepv3EC1u6yYdLeB3ammFWehbMs4DGAdW+TJ5SyjqrMTPSVZLq9cWbn004Xlb0g
         genBKlT7TgVJC1lzUR/PRjhMgqj7Jk7h4UOctxXN5uN0XLWdhXYPEFcaS+bt01yWs9AX
         MH2Q==
X-Gm-Message-State: AA+aEWYOxy4i3yPO6k9+1I187M2wGjgV+8cbCK4CcGydOBg8oyG1zfla
        AOv2RTG19IuhPgTJPpxWvw==
X-Google-Smtp-Source: AFSGD/Udb6j0Bb0lIP25xDOUEbDCsdgIIlkCi7QeLgHF4wEGpdR6Y8QUwikhleCMAziqOt1/yd8RDw==
X-Received: by 2002:aca:cc8b:: with SMTP id c133mr10714955oig.256.1543881107075;
        Mon, 03 Dec 2018 15:51:47 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o189sm5946642oif.23.2018.12.03.15.51.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 15:51:46 -0800 (PST)
Date:   Mon, 3 Dec 2018 17:51:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: soc: qcom: Add AOSS QMP binding
Message-ID: <20181203235145.GA30118@bogus>
References: <20181112080557.22698-1-bjorn.andersson@linaro.org>
 <20181112080557.22698-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112080557.22698-2-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 12:05:55AM -0800, Bjorn Andersson wrote:
> Add binding for the QMP based side-channel communication mechanism to
> the AOSS, which is used to control resources not exposed through the
> RPMh interface.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  .../bindings/soc/qcom/qcom,aoss-qmp.txt       | 63 +++++++++++++++++++
>  include/dt-bindings/power/qcom-aoss-qmp.h     | 15 +++++
>  2 files changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
>  create mode 100644 include/dt-bindings/power/qcom-aoss-qmp.h
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
> new file mode 100644
> index 000000000000..e3c8cb4372f2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
> @@ -0,0 +1,63 @@
> +Qualcomm Always-On Subsystem side channel binding
> +
> +This binding describes the hardware component responsible for side channel
> +requests to the always-on subsystem (AOSS), used for certain power management
> +requests that is not handled by the standard RPMh interface. Each client in the
> +SoC has it's own block of message RAM and IRQ for communication with the AOSS.
> +The protocol used to communicate in the message RAM is known as QMP.
> +
> +- compatible:
> +	Usage: required
> +	Value type: <string>
> +	Definition: must be "qcom,sdm845-aoss-qmp"
> +
> +- reg:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: the base address and size of the message RAM for this
> +		    client's communication with the AOSS
> +
> +- interrupts:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: should specify the AOSS message IRQ for this client
> +
> +- mboxes:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: reference to the mailbox representing the outgoing doorbell
> +		    in APCS for this client, as described in mailbox/mailbox.txt
> +
> += AOSS Power-domains
> +The AOSS side channel exposes control over a set of resources, used to control
> +a set of debug related clocks and to affect the low power state of resources
> +related to the secondary subsystems. These resources are described as a set of
> +power-domains in a subnode of hte AOSS side channel node.

Why does this need to be a sub-node? Are there other sub-nodes needed?

> +
> +- compatible:
> +	Usage: required
> +	Value type: <string>
> +	Definition: must be "qcom,sdm845-aoss-qmp-pd"
> +
> +- #power-domain-cells:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: must be 1
