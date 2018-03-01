Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AG47ELs9DkmRIN40F1O7Ipusp0hBTGSxha1VLEKpPTWCC23MN2o3NYEEhtufMyLDRnXTsGXh0/O2
ARC-Seal: i=1; a=rsa-sha256; t=1519913730; cv=none;
        d=google.com; s=arc-20160816;
        b=YSxbDVG3ml/QAbN2Xc7Q8pbD0NYCF1Sd8PSoAcr0nq5kzlT0NFdQjjnMZV/v0gIz4G
         mBaPW5NcrFXafqYCmzsSxUjBxYIGZ6aodsaT7f4tYY6yKZrDQTAIQBr+gkjB0S20yzAy
         WrEQ4zCrySECEEWQ3F9f4nB/jEscSIoUgpbQyRIDsHiJs3pK5c9KWZoXv2fnNOIer+BI
         wf1aoNFGqdhg1yJFyW43jPgM4djZlmn3Geo+PAwT0bZPlTpbdFXbkORBMdoghPHmIuRX
         YwGn7cx39to+cwhBQNZRHYdqa+R1kv1tfSWkshpeyUw2Axps/vN9FgyETm2jNm7vl1Xg
         oJpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=p4EZMgOtO1Z/ZtA8q1dLRQq5ywCgVPcnV7YtliPmPjE=;
        b=XjgN8N3mot8l+WFAtlTeqjXK2T9ZhKhtRiEH2P5h53s3+c/8VJtpSobiiQcONVnR0f
         GwQofFZ51YOPxk/o9XWJnVSd26GkLuAwc+jzt/unslK+pCa8LYVlvMTJnVaxjoGH+8b1
         R8JSxLt6AK+NSJ1JtMi4bsdQ1WNQhbphJhJK43IpnBp+zDYwgqQ09k0/NnUuMhSAipL6
         Vvcy/7FiDzridMW7UXQy2twj965EMICRQ880hlXo6ZuswJHpX6RuMBFh01l3/hGgVOti
         TrW/J5qyt/0DMqja6JlRVR6q5ITOjAvxVc2xBQihOmSvc55hpcdWavlmxvdZPVoiva7a
         xJmg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Cc: ard.biesheuvel@linaro.org, mingo@kernel.org, keescook@chromium.org,
 dmitry.torokhov@gmail.com, Sudeep Holla <sudeep.holla@arm.com>,
 rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Jolly Shah <jollys@xilinx.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: firmware: Add bindings for ZynqMP
 firmware
To: Jolly Shah <jolly.shah@xilinx.com>, gregkh@linuxfoundation.org,
 matt@codeblueprint.co.uk, hkallweit1@gmail.com, michal.simek@xilinx.com,
 robh+dt@kernel.org, mark.rutland@arm.com
References: <1519154467-2896-1-git-send-email-jollys@xilinx.com>
 <1519154467-2896-2-git-send-email-jollys@xilinx.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <778329dd-76a7-0151-26d9-30e87e0c888d@arm.com>
Date: Thu, 1 Mar 2018 14:15:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519154467-2896-2-git-send-email-jollys@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592948931841332945?=
X-GMAIL-MSGID: =?utf-8?q?1593745060373393923?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 20/02/18 19:21, Jolly Shah wrote:
> Add documentation to describe Xilinx ZynqMP firmware driver
> bindings. Firmware driver provides an interface to firmware
> APIs. Interface APIs can be used by any driver to communicate
> to PMUFW (Platform Management Unit).
> 
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> ---
>  .../firmware/xilinx/xlnx,zynqmp-firmware.txt       | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> 
> diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> new file mode 100644
> index 0000000..99434ba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> @@ -0,0 +1,24 @@
> +Xilinx Zynq MPSoC Firmware Device Tree Bindings
> +
> +The zynqmp-firmware node describes the interface to platform firmware.
> +ZynqMP has an interface to communicate with secure firmware. Firmware
> +driver provides an interface to firmware APIs. Interface APIs can be
> +used by any driver to communicate to PMUFW(Platform Management Unit).
> +These requests include clock management, pin control, device control,
> +power management service, FPGA service and other platform management
> +services.
> +
> +Required properties:
> + - compatible:	Must contain:  "xlnx,zynqmp-firmware"
> + - method:	The method of calling the PM-API firmware layer.
> +		Permitted values are:
> +		  - "smc" : SMC #0, following the SMCCC
> +		  - "hvc" : HVC #0, following the SMCCC
> +
> +Examples:
> +	firmware {
> +		zynqmp_firmware: zynqmp-firmware {
> +			compatible = "xlnx,zynqmp-firmware";
> +			method = "smc";
> +		};
> +	};
> 

Do you foresee using SMC/HVC for this firmware even on future platforms?
If not, I suggest to keep the protocol part separate from the transport
i.e. smc/hvc via ATF. It could be replaced with mailbox or some h/w
mechanism in future ?

-- 
Regards,
Sudeep
