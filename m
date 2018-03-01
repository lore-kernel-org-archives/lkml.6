Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AG47ELun/hZDx14csUXyx6JBpgoJyanG9ajKEZ2wFUHXHP6NTOvTowKcb9882qw8rNYHmUtj2jzU
ARC-Seal: i=1; a=rsa-sha256; t=1519915458; cv=none;
        d=google.com; s=arc-20160816;
        b=LF6EKEjVwniO4VYQ2N9V0WMLvNCvC0ROYcZTdGHEMbwhTUSKeo1SM0m5VDUwdDk1DD
         r2Xme4qqcHkG2FJkO/RAezhqa8rZlyW78BbroHdIv2t1D9e9E6v0cD9cBJr4sP18OQzd
         a6mCXxzbkp0lHPjBhcvAcsclVoarmA2WmhUjnBWudpMHl6f3+C3PswXlELtEMZAV8wyr
         5IB728s1JCnnxINmD/C4uL9/XZ+hSKgy1gmPkNGQMGMr+F3KtsrkZBuuAwATlznwb3F1
         HlXHP7Bp9PD5c++MZq1OZ3uvS8JJokqo2KhvXdWO3AAxaMYEcaBfWPQxA1ks1dHc9evY
         PFcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=qSz+0wiwRFscFRQ53jnyQCGxtyHLFUyGx0pZreca9Qs=;
        b=K/XhoVx/AqB4wc70bEUp87PR0qU0AzNOWXugpD8wiIdW4TkVCvipL2ehDOS4Kyf92q
         DhbIIqyZ3iY3ovkiybsfsMRTKo2qSMfUN9J7K8yNQCwdv//jNKGfZhfHTppgY/GgIPQ1
         PLAZapSUReyNETLkHjjrK8neadZvb4s2XiL0EJPSwK3si7jK+/4CP3neCbLO3dAnwOgK
         vmxsImvEJfDZM0MCbhU9U0+AZ6e3ZFgXK1RebiO/if7OpXZaqt/UG46NAeVTSHNE1LdN
         p5bfy5DF1AUxLoq0SpTbwW21yILDRpWQ0v+YAKaNogaqnvU27CG1xFIsmv+HuuzmTHe/
         u15Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Cc: ard.biesheuvel@linaro.org, mingo@kernel.org, gregkh@linuxfoundation.org,
 matt@codeblueprint.co.uk, hkallweit1@gmail.com, keescook@chromium.org,
 dmitry.torokhov@gmail.com, michal.simek@xilinx.com, robh+dt@kernel.org,
 mark.rutland@arm.com, Sudeep Holla <sudeep.holla@arm.com>,
 rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Jolly Shah <jollys@xilinx.com>
Subject: Re: [PATCH v5 3/4] drivers: firmware: xilinx: Add sysfs interface
To: Jolly Shah <jolly.shah@xilinx.com>
References: <1519154467-2896-1-git-send-email-jollys@xilinx.com>
 <1519154467-2896-4-git-send-email-jollys@xilinx.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <573acd04-85c4-829d-a0d6-36b3958ac1ec@arm.com>
Date: Thu, 1 Mar 2018 14:44:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519154467-2896-4-git-send-email-jollys@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592948932748631222?=
X-GMAIL-MSGID: =?utf-8?q?1593746871338982585?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 20/02/18 19:21, Jolly Shah wrote:
> Add Firmware-ggs sysfs interface which provides read/write
> interface to global storage registers.
> 
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> ---
>  .../ABI/stable/sysfs-driver-zynqmp-firmware        |  50 ++++
>  drivers/firmware/xilinx/zynqmp/Makefile            |   2 +-
>  drivers/firmware/xilinx/zynqmp/firmware-ggs.c      | 297 +++++++++++++++++++++
>  drivers/firmware/xilinx/zynqmp/firmware.c          |  13 +
>  include/linux/firmware/xilinx/zynqmp/firmware.h    |   2 +
>  5 files changed, 363 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/stable/sysfs-driver-zynqmp-firmware
>  create mode 100644 drivers/firmware/xilinx/zynqmp/firmware-ggs.c
> 
> diff --git a/Documentation/ABI/stable/sysfs-driver-zynqmp-firmware b/Documentation/ABI/stable/sysfs-driver-zynqmp-firmware
> new file mode 100644
> index 0000000..b04727a
> --- /dev/null
> +++ b/Documentation/ABI/stable/sysfs-driver-zynqmp-firmware
> @@ -0,0 +1,50 @@
> +What:		/sys/devices/platform/zynqmp-firmware/ggs> +Date:		January 2018
> +KernelVersion:	4.15.0
> +Contact:	"Jolly Shah" <jollys@xilinx.com>
> +Description:
> +		Read/Write PMU global general storage register value,
> +		GLOBAL_GEN_STORAGE{0:3}.
> +		Global general storage register that can be used
> +		by system to pass information between masters.
> +

What kind of information ? Is there any semantics for that ?
Why does EEMI lack APIs for that if it's critical, giving access to
such information to userspace may not be good idea.

> +		The register is reset during system or power-on
> +		resets. Three registers are used by the FSBL and
> +		other Xilinx software products: GLOBAL_GEN_STORAGE{4:6}.
> +

FSBL ?

For what is it used ?

> +		Usage:
> +		# cat /sys/.../zynqmp-firmware/ggs0
> +		# echo <mask> <value> > /sys/.../zynqmp-firmware/ggs0
> +
> +		Example:
> +		# cat /sys/.../zynqmp-firmware/ggs0
> +		# echo 0xFFFFFFFF 0x1234ABCD > /sys/.../zynqmp-firmware/ggs0
> +
> +Users:		Xilinx
> +
> +What:		/sys/devices/platform/zynqmp-firmware/pggs*
> +Date:		January 2018
> +KernelVersion:	4.15.0
> +Contact:	"Jolly Shah" <jollys@xilinx.com>
> +Description:
> +		Read/Write PMU persistent global general storage register
> +		value, PERS_GLOB_GEN_STORAGE{0:3}.
> +		Persistent global general storage register that
> +		can be used by system to pass information between
> +		masters.
> +

Ditto

> +		This register is only reset by the power-on reset
> +		and maintains its value through a system reset.
> +		Four registers are used by the FSBL and other Xilinx
> +		software products: PERS_GLOB_GEN_STORAGE{4:7}.
> +		Register is reset only by a POR reset.
> +

Ditto

-- 
Regards,
Sudeep
