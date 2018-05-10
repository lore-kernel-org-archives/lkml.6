Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AB8JxZqhdHxENb2E0wxOgglBKsdpOwF/pX9GJybMXYbSsaXWhG6XyV7IMS21r0Lgld9ZxrR3o91Z
ARC-Seal: i=1; a=rsa-sha256; t=1525961358; cv=none;
        d=google.com; s=arc-20160816;
        b=TJvtZLkaL56+Zu24Vo1IhCEIuyAnBqxY87tK0UHtcchaSonXNzB6WFd5m4n4vE05K0
         v2IYQmCgn0AZuolLypPrvdFW/+IVpltmNJBdWKRFlQbmdyn6mrfUQLdLhbE34Alj2b9K
         211qvfmwdgHasJf7HJZNBdFR+uuekWv4X8q7Wypv8dT+OLRRG4z/3GwBbn0MRcH0o6Zn
         JZbG653PSbbeclCR5JCag1xSuNu2EseS6mr8btjVV+A5Bb+dL+YwgcvsPkLhGudPpyjH
         gtvkZvoGydYE71YWJNrgVkH5dSZVPqKh1AvCBJCbiuEHyrpa7uQcNne9FtbTDjz9M7Ql
         HoKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=LR3QIpThfFVy8/4i0OmO4GDo8UP4JPfw0sBw5rwUe9Y=;
        b=goOq6RiBCPhefdhsZMz5vONyQgAesbchRnvnoBpCXn35B7rAAn+cX3aavJWrgxBVPO
         8sWNfSvnWJzUpYWPORpJnYuLAG0DZiatCAMCjLYIsohJgIwVj7FEubgPO3LSlZcW/1OC
         zfze6tAE51xQakzlnI231HzU+jGv/wG3NLvFOvN4rqBKBeN8KWYKDKfWuXe8R4FtnK5A
         y9mwh0Pcn/5uRXi0tFFODwuk4RBu8CA7DOxS1nFsb5OwAA0/T1I8G+CENmvb6blH1d/j
         qLBpkLQW9SgpNTbFo3rbagWxRt3EaA/4JJTTJzgZhsXMMl9J+DiRZ8OY94wgQNlDiWIL
         5cSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>, rajanv@xilinx.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Jolly Shah <jollys@xilinx.com>
Subject: Re: [PATCH v6 03/11] firmware: xilinx: Add zynqmp IOCTL API for
 device control
To: Jolly Shah <jolly.shah@xilinx.com>, ard.biesheuvel@linaro.org,
 mingo@kernel.org, gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
 hkallweit1@gmail.com, keescook@chromium.org, dmitry.torokhov@gmail.com,
 mturquette@baylibre.com, sboyd@codeaurora.org, michal.simek@xilinx.com,
 robh+dt@kernel.org, mark.rutland@arm.com, linux-clk@vger.kernel.org
References: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
 <1523389127-14243-4-git-send-email-jollys@xilinx.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <c351b9a3-5f26-7202-7171-0dcc7adef7c0@arm.com>
Date: Thu, 10 May 2018 15:09:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523389127-14243-4-git-send-email-jollys@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597389330509199100?=
X-GMAIL-MSGID: =?utf-8?q?1600086456806299521?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 10/04/18 20:38, Jolly Shah wrote:
> From: Rajan Vaja <rajanv@xilinx.com>
> 
> Add ZynqMP firmware IOCTL API to control and configure
> devices like PLLs, SD, Gem, etc.
> 
> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> ---
>  drivers/firmware/xilinx/zynqmp.c     | 20 ++++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h |  2 ++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 490561a..44b43fa 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -239,8 +239,28 @@ static int get_set_conduit_method(struct device_node *np)
>  	return 0;
>  }
>  
> +/**
> + * zynqmp_pm_ioctl() - PM IOCTL API for device control and configs
> + * @node_id:	Node ID of the device
> + * @ioctl_id:	ID of the requested IOCTL
> + * @arg1:	Argument 1 to requested IOCTL call
> + * @arg2:	Argument 2 to requested IOCTL call
> + * @out:	Returned output value
> + *
> + * This function calls IOCTL to firmware for device control and configuration.
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
> +			   u32 *out)
> +{
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id, ioctl_id,
> +				   arg1, arg2, out);
> +}
> +
>  static const struct zynqmp_eemi_ops eemi_ops = {
>  	.get_api_version = zynqmp_pm_get_api_version,
> +	.ioctl = zynqmp_pm_ioctl,
>  };
>  
>  /**
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index cb63bed..2eec6e7 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -34,6 +34,7 @@
>  
>  enum pm_api_id {
>  	PM_GET_API_VERSION = 1,
> +	PM_IOCTL = 34,

I am not for this API. IIUC there are more fined grained well defined
APIs(if I am not wrong from enum 2 upto 33). This is open ended API
which allows user to do whatever setting it needs. And that defeats the
purpose of other APIs.

I will look through the series for the usage of this to understand this
better, but I am guessing how it can be (ab)used.

-- 
Regards,
Sudeep
