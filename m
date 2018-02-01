Return-Path: <daniel.thompson@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1517483206; cv=none;
        d=google.com; s=arc-20160816;
        b=mNHw+GvU6YnUfPHlj2BKFuUAkMJgK4L6vJqiZ6FRkTQl0WmpfsAxNjABvynHTP1+4t
         Cb8RbHt2ojRNdqQSKsE7J4VuY4+RoIHOOppXMKreY4PtB7QO2Q68kpVC3KIByTzRl2yb
         76OScVRophX5D6NKfzO8oKdIHpQ6C7t/XKbKqec3fUs753ogrum6eyRtZ3CdVEE5v6uH
         odq8xVTu0fcxg+wPvDuLeOvcUJbvEH68s7dEP8sIOkVnx7JfsuOlHcw7LSArw6GwPrJJ
         ntTIYm9SYMNvvFKjPGBt8QA0pMoQut30XGC0IxOwsIQfbQF7K5zKsoXRCw+D+wyY+Drb
         wQ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=S9Avuc8ZPH2VQzITUwgsjRyhYM5SvXmGuZaxJpiX8Oo=;
        b=OI/gLKQ7WuIZRRnLe6bvvw3FiQq04BYaaCcEPbDq3iCd+XIkqo7VX8A+QWx5YDGYxJ
         QoBFINXpAkwjyHepHHZDnb4gdPsvX4jJwl7Ge6tZp6QNWEp210XQj/cPYkj0xIZfDFPK
         Ng3FDf06IbOPONUBjpz3fjPryaEFQcubrXM2cA3GgGfxnFWe5RLYJHFxceM2CSdKW2Fj
         mfmS3RxbXk7QD9+6kgQSu+rM42MZ+PJGY+LUN3RvssN61RqC3g8iCF020xSjw5hqrzoY
         q+Blr5CApEAJIfhvnp/cihvEaAsMa9UYQWXMTxsqEx6+ww+9f4Ymixtu6HvD1Oe6evHL
         eEFg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=UpX6mH3K;
       spf=pass (google.com: domain of daniel.thompson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=daniel.thompson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=UpX6mH3K;
       spf=pass (google.com: domain of daniel.thompson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=daniel.thompson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AH8x224mp3WUJqsUsdwsZtQ+9QIpqfZC3PlUoNXyKCkI7dOmKRT96r1ArniqOpB1ekELy0dQTJW9uA==
Date: Thu, 1 Feb 2018 11:06:42 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Aishwarya Pant <aishpant@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>, Milo Kim <milo.kim@ti.com>,
	Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 2/5] backlight: lp855x: document sysfs attributes
Message-ID: <20180201110642.qyjwyrdwglevlk5f@oak.lan>
References: <cover.1516978005.git.aishpant@gmail.com>
 <09cd01366bf3b5c3030ad25450b46a9a3bc8a747.1516978005.git.aishpant@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09cd01366bf3b5c3030ad25450b46a9a3bc8a747.1516978005.git.aishpant@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590667129799888264?=
X-GMAIL-MSGID: =?utf-8?q?1591196470461654618?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Jan 26, 2018 at 08:23:00PM +0530, Aishwarya Pant wrote:
> Add documentation for sysfs interface of Texas Instruments lp855x
> backlight driver by reading code and looking through git commit logs.
> 
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
> ---
>  .../ABI/testing/sysfs-class-backlight-lp855x          | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-backlight-lp855x
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-backlight-lp855x b/Documentation/ABI/testing/sysfs-class-backlight-lp855x
> new file mode 100644
> index 000000000000..5b9d38958875
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-backlight-lp855x
> @@ -0,0 +1,19 @@
> +sysfs interface for Texas Instruments lp855x backlight driver
> +------------------------------------------------------------
> +
> +What:		/sys/class/backlight/<backlight>/chip_id
> +Date:		Mar, 2012
> +KernelVersion:	v3.10
> +Contact:	Milo Kim <milo.kim@ti.com>
> +Description:
> +		(RO) Displays the lp8755x chip id. Possible values are:
> +		lp8550, lp8551, lp8552, lp8553, lp8555, lp8556 or lp8557.
> +
> +
> +What:		/sys/class/backlight/<backlight>/bl_ctl_mode
> +Date:		Mar, 2012
> +KernelVersion:	v3.10
> +Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
> +Description:
> +		(RO) Displays whether the brightness is controlled by the pwm
> +		input("pwm based) or the i2c register("register based").

Since like the first patch in the series, these look like they are for
debugging. That thread is still active but whatever the outcome of that
thread please assume it also applies to this patch.


Daniel.
