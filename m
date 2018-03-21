Return-Path: <groeck7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521612596; cv=none;
        d=google.com; s=arc-20160816;
        b=A+cnInN9wYElSbBZZEdLljVGIAdTzjCHUT8dKrkIJza/Kquxs1POBpAwO6duuEHbbR
         4v4h8VrYNW+d24pbteNQ6Q0jkEzuBnDhfGR3lJEwCqSgeBLinEFsfHVlNoIQH1vB3Bm8
         boC+XYAwgLmtZc+VwvyP9p8aCexmd9FrGeUGf0EgXvKK8R7gitXQpUGQzNVgp05kyPZX
         ZlLoCq2j5XHZynHvN7xAioHBZ++j1+xU5BP9vdeHEgsw8TD4M2pGlQzW4tTiVWfH7sTP
         Ocj04oJszwhp7i4wBqRaUB9DigtLsd30dOTL15gOZlS04NGd34UNp8gppg/Ee50Y4tPW
         Oe5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:sender
         :dkim-signature:arc-authentication-results;
        bh=ertvYdK6iqR/JfTTa1x7BCp7s+I//ClF1xezB1zn3d0=;
        b=SaOOLyNaI60FMs1wpaECsPFbLeyXhfs1PnDMCprc+kY/BCEH5HqU+WIPBmONquMtFI
         saHPc4Hk4xapX/OushCbHbXVoLZDevj+rtJV1Le4KWazIbk7fkV6mBVVCXTQ/W9AGWq7
         R99scQA9hztOoEZNHxSDfAq9AKJvWBkGbB/bDxUZ8xq+IDukoIjAG8YUnw90pSYAYlbO
         6tbFDjLozrIXo2ZTOGdO/xndQnTcWgyAr7kHqRH4tnUKsr+gAs6iEpRTSPXzQpXn0Hcl
         93INlMQaa7+/71+t4D0Ixp9sxksG/Lr2f0XtgnC+B5Bi/c1S9FhdATSMa9xsjharjJiG
         Q01Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MtoDtYFm;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MtoDtYFm;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
X-Google-Smtp-Source: AG47ELumbqZ0oblAAePdt5zjgDxow7Voh5jvRDU4nsJBEdgo/m1gCJcV+ZCBFKhN3XqlJ2bvAvhhww==
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH V2 7/9] hwmon: pwm-fan: add sysfs node to read rpm of fan
To: Rajkumar Rampelli <rrajk@nvidia.com>, robh+dt@kernel.org,
 mark.rutland@arm.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
 jdelvare@suse.com, corbet@lwn.net, catalin.marinas@arm.com,
 will.deacon@arm.com, kstewart@linuxfoundation.org,
 gregkh@linuxfoundation.org, pombredanne@nexb.com, mmaddireddy@nvidia.com,
 mperttunen@nvidia.com, arnd@arndb.de, timur@codeaurora.org,
 andy.gross@linaro.org, xuwei5@hisilicon.com, elder@linaro.org,
 heiko@sntech.de, krzk@kernel.org, ard.biesheuvel@linaro.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, ldewangan@nvidia.com
References: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
 <1521607244-29734-8-git-send-email-rrajk@nvidia.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <0da71848-1f75-62a3-75cb-a9b5cd887798@roeck-us.net>
Date: Tue, 20 Mar 2018 23:09:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521607244-29734-8-git-send-email-rrajk@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595520919303322117?=
X-GMAIL-MSGID: =?utf-8?q?1595526449868161895?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/20/2018 09:40 PM, Rajkumar Rampelli wrote:
> Add fan device attribute fan1_input in pwm-fan driver
> to read speed of fan in rotations per minute.
> 
> Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
> ---
> 
> V2: Removed generic-pwm-tachometer driver and using pwm-fan driver as per suggestions
>      to read fan speed.
>      Added fan device attribute to report speed of fan in rpms through hwmon sysfs.
> 
>   drivers/hwmon/pwm-fan.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index 70cc0d1..8dda209 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -98,11 +98,34 @@ static ssize_t show_pwm(struct device *dev,
>   	return sprintf(buf, "%u\n", ctx->pwm_value);
>   }
>   
> +static ssize_t show_rpm(struct device *dev, struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct pwm_fan_ctx *ptt = dev_get_drvdata(dev);
> +	struct pwm_device *pwm = ptt->pwm;
> +	struct pwm_capture result;
> +	unsigned int rpm = 0;
> +	int ret;
> +
> +	ret = pwm_capture(pwm, &result, 0);
> +	if (ret < 0) {
> +		pr_err("Failed to capture PWM: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (result.period)
> +		rpm = DIV_ROUND_CLOSEST_ULL(60ULL * NSEC_PER_SEC,
> +					    result.period);
> +
> +	return sprintf(buf, "%u\n", rpm);
> +}
>   
>   static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, show_pwm, set_pwm, 0);
> +static SENSOR_DEVICE_ATTR(fan1_input, 0444, show_rpm, NULL, 0);
>   
>   static struct attribute *pwm_fan_attrs[] = {
>   	&sensor_dev_attr_pwm1.dev_attr.attr,
> +	&sensor_dev_attr_fan1_input.dev_attr.attr,

This doesn't make sense. The same pwm can not both control the fan speed
and report it.

Guenter

>   	NULL,
>   };
>   
> 
