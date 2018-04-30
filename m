Return-Path: <lee.jones@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525082058; cv=none;
        d=google.com; s=arc-20160816;
        b=pYvJxtvNca/Lf6mWRTvg/tUjE6+DFm9MIMBLjgtDmSm+UirT967SscvGbSVX50pZGO
         9lhTN8JIhccVbhRYpxDP8J3WwL2mjdJNsD+O3frf6H2AWv4DaNhswsEEalBv4iB0c3mt
         AGHosjuDq9y3Qbk3W1gyXojF7mkQP0v4DGCz8sWv4h/HRA0d45Pz+DLA+4q/3KK5GzGa
         jFg9Ng5XFx5lJUj3Aj+C/IkqrhZN7zCYQn8DAN/HP6gBrMOgf26rW0dsSu/cFdG2LUOn
         ONKn+StCOJGkLFd/JUhuyUxprOQCGvScNl7fDmHyFSSltdGt99jlbrVzzAqL9cAlwLde
         FvyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=tnfa2ji37OGEt41BnhHgOgenHFOUinkDkNCJvR7IrWU=;
        b=hOn3yKpodBrZFB2mNp1TTtoXURwwHFuvI8nEfWIDWnk4gQVaQFOf8rzgNDJCpb+YuO
         sb+yeBSklvl1KN8rGmBkA5JydzQBnyVvhR1mi/gGHtvQhk6BJlGtbKyhx+e6rjW1q0tf
         yAr8Z8jtvVT+UdH9UYKuUi57u4cvC09GJHI5bevzZZTbVozWxGWFj2a+Yb/H6TAex7iE
         DlfcjE9qDBtaZdMX98b0bTyRn0+EtEGQw4n/gBiVHWi60dKqw4AYx+YKS62qns/+6F0l
         8mh30Jzi4V5e9kLzSN0KPcLw1ps4BQgacwyPS173eaPL6KGlKnHV4OliijaRnojxRD6x
         BD+w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=NThekE52;
       spf=pass (google.com: domain of lee.jones@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=lee.jones@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=NThekE52;
       spf=pass (google.com: domain of lee.jones@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=lee.jones@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZo+u3VWbk7asqJVkVOUjP0/cQ3MN0cTpRCq9IEzaEYkuSIU70cXqC1G8aMbGMrNnvRHbqCvdg==
Date: Mon, 30 Apr 2018 10:54:15 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>, gregkh@linuxfoundation.org,
	thomas.petazzoni@free-electrons.com
Cc: DRI Development <dri-devel@lists.freedesktop.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 4/6] staging/fbtft: Stop using BL_CORE_DRIVER1
Message-ID: <20180430095415.GB5147@dell>
References: <20180425174253.4616-1-daniel.vetter@ffwll.ch>
 <20180425174253.4616-4-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180425174253.4616-4-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1599164444626352562?=
X-GMAIL-MSGID: =?utf-8?q?1599164444626352562?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Greg, Thomas,

On Wed, 25 Apr 2018, Daniel Vetter wrote:
> Leaking driver internal tracking into the already massively confusing
> backlight power tracking is really confusing.
> 
> Luckily we have already a drvdata structure, so fixing this is really
> easy.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> ---
>  drivers/staging/fbtft/fbtft-core.c | 4 ++--
>  drivers/staging/fbtft/fbtft.h      | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)

Do you want a pull-request for this patch or can I just take it?

> diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
> index 0e36b66ae5f7..731e47149af8 100644
> --- a/drivers/staging/fbtft/fbtft-core.c
> +++ b/drivers/staging/fbtft/fbtft-core.c
> @@ -246,7 +246,7 @@ static int fbtft_request_gpios_dt(struct fbtft_par *par)
>  static int fbtft_backlight_update_status(struct backlight_device *bd)
>  {
>  	struct fbtft_par *par = bl_get_data(bd);
> -	bool polarity = !!(bd->props.state & BL_CORE_DRIVER1);
> +	bool polarity = par->polarity;
>  
>  	fbtft_par_dbg(DEBUG_BACKLIGHT, par,
>  		"%s: polarity=%d, power=%d, fb_blank=%d\n",
> @@ -296,7 +296,7 @@ void fbtft_register_backlight(struct fbtft_par *par)
>  	/* Assume backlight is off, get polarity from current state of pin */
>  	bl_props.power = FB_BLANK_POWERDOWN;
>  	if (!gpio_get_value(par->gpio.led[0]))
> -		bl_props.state |= BL_CORE_DRIVER1;
> +		par->polarity = true;
>  
>  	bd = backlight_device_register(dev_driver_string(par->info->device),
>  				       par->info->device, par,
> diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
> index e19e64e0d094..c7cb4a7896f4 100644
> --- a/drivers/staging/fbtft/fbtft.h
> +++ b/drivers/staging/fbtft/fbtft.h
> @@ -229,6 +229,7 @@ struct fbtft_par {
>  	ktime_t update_time;
>  	bool bgr;
>  	void *extra;
> +	bool polarity;
>  };
>  
>  #define NUMARGS(...)  (sizeof((int[]){__VA_ARGS__})/sizeof(int))

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
