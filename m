Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751510AbeDESDE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 14:03:04 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38658 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751285AbeDESDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 14:03:02 -0400
X-Google-Smtp-Source: AIpwx49P9UynHE9zgASCtrF+kKsfgTubAgOT1l01wQKIm4DeEYTKZgfRhF/zCpKesW3/+yT+P0ua9A==
Date: Thu, 5 Apr 2018 11:02:58 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Lina Iyer <ilina@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org,
        devicetree@vger.kernel.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>
Subject: Re: [PATCH v6 2/2] dt-bindings: introduce Command DB for QCOM SoCs
Message-ID: <20180405180258.GJ18510@minitux>
References: <20180405160459.16693-1-ilina@codeaurora.org>
 <20180405160459.16693-3-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405160459.16693-3-ilina@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 05 Apr 09:04 PDT 2018, Lina Iyer wrote:

> From: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> 
> Command DB provides information on shared resources like clocks,
> regulators etc., probed at boot by the remote subsytem and made
> available in shared memory.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
> 
> Changes in v6:
> 	- Move to bindings/reserved-memory
> 	- Remove indirection address and use only the actual reserved
> 	  memory
> 
> Changes in v4:
> 	- Fix unwanted capitalization
> 	- Add reg property
> ---
>  .../bindings/reserved-memory/qcom,cmd-db.txt       | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.txt
> 
> diff --git a/Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.txt b/Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.txt
> new file mode 100644
> index 000000000000..d808ada474c1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.txt
> @@ -0,0 +1,37 @@
> +Command DB
> +---------
> +
> +Command DB is a database that provides a mapping between resource key and the
> +resource address for a system resource managed by a remote processor. The data
> +is stored in a shared memory region and is loaded by the remote processor.
> +
> +Some of the Qualcomm Technologies Inc SoC's have hardware accelerators for
> +controlling shared resources. Depending on the board configuration the shared
> +resource properties may change. These properties are dynamically probed by the
> +remote processor and made available in the shared memory.
> +
> +The bindings for Command DB is specified in the reserved-memory section in
> +devicetree. The devicetree representation of the command DB driver should be:
> +
> +Properties:
> +- compatible:
> +	Usage: required
> +	Value type: <string>
> +	Definition: Should be "qcom,cmd-db"
> +
> +- reg:
> +	Usage: required
> +	Value type: <prop encoded array>
> +	Definition: The register address that points to the location of the
> +		    Command DB in memory. Additionally, specify the address
> +		    and size of the actual lacation in memory.

The reg doesn't reference the indirection registers anymore, please
update this.

Apart from this, you have my:

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
