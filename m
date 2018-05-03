Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AB8JxZo6t8JNGv3p1OewJujJUHu083z3a3SgXkB4/4EgmNmVBDyx1xLY2Lp6PtHksH/+Hff2KwsW
ARC-Seal: i=1; a=rsa-sha256; t=1525391052; cv=none;
        d=google.com; s=arc-20160816;
        b=m8YlJ4gDNF6xx+Psn4JPrKaWbzol+PsQIHYD24vOAmEjG/VpG4T37BSARldh5ozVY/
         lMBg1irGPtf2XhyfgXgoaMcgE6ENRBzMdcegw8n2+lB1MnJPFAg1fDDFtSdCZxUGHUxj
         dWiGLnC1smYkNepNFuriTMRsPst5hlDcdnK0EMNRwCYKQ3LFrGzoaay+cCWM2ys8raJ0
         khk5PY2syGzqZbthUKB1VwwZw5JYLtP2ba5WsG+ztQpPe9l6MnlNKm+HqU4NeEsZDXJi
         ByzzrPi/wsHTkra/DVf+rgU1P8O8AVbHGonfrfRvG/HupcQ+fbvmKasgJaSz8yjpwCX/
         2I3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=b02VrmtzLt1qKv9+z6i4i80q5PgDT9jD8eF6rCPB+f8=;
        b=VLbeAMvwr7GZZ5tlxqX1Qs7sJ7fCgN4YVVydGgPrI7QPNL2z3aX4uer3QQtP3p8JCi
         y3l/oJqcE2M9HjkERL2LxC/dsdLAh7eXcDD728BE9y+CRQr83USyzZIoBgO3iX0HzR0S
         lOz2TTXssg3rQJIR78Zx4jIHnF2MsVB8sMtzVXst4E/eFeBHU1RhLblYGE7BR1EJPQhI
         o6TcVHntrR2+cCIZZe8g5nsndV0FTpSYWVPu9DFbA/0B2mA7rIwE0bEECSaig/1p+3sD
         jmVHC0ZFy8vOlhrqS1UHz1Cb3zrqvXV+XJu7Hcr5ajMTuwQDqDl1gUTUczlMwAr00DU/
         lf+A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Thu, 3 May 2018 23:44:09 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Andres Rodriguez <andresx7@gmail.com>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	mcgrof@kernel.org, alexdeucher@gmail.com, christian.koenig@amd.com,
	kvalo@codeaurora.org, arend.vanspriel@broadcom.com,
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
	hdegoede@redhat.com, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 7/9] firmware: use rename fw_sysfs_fallback to use the
 firmware_ prefix
Message-ID: <20180503234409.GY27853@wotan.suse.de>
References: <20180423201205.20533-1-andresx7@gmail.com>
 <20180423201205.20533-8-andresx7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423201205.20533-8-andresx7@gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598569153121101514?=
X-GMAIL-MSGID: =?utf-8?q?1599488447931941545?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 04:12:03PM -0400, Andres Rodriguez wrote:
> Use the correct prefix for symbols exported by firmware_loader(). This
> is done since firmware_sysfs_fallback() is now exposed through
> kernel-doc.
> 
> Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
> ---
>  drivers/base/firmware_loader/fallback.c | 8 ++++----
>  drivers/base/firmware_loader/fallback.h | 4 ++--
>  drivers/base/firmware_loader/firmware.h | 6 +++---
>  drivers/base/firmware_loader/main.c     | 2 +-
>  4 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
> index 1a47ddc70c31..fc186b5bccce 100644
> --- a/drivers/base/firmware_loader/fallback.c
> +++ b/drivers/base/firmware_loader/fallback.c
> @@ -661,10 +661,10 @@ static bool fw_run_sysfs_fallback(enum fw_opt opt_flags)
>  	return fw_force_sysfs_fallback(opt_flags);
>  }
>  
> -int fw_sysfs_fallback(struct firmware *fw, const char *name,
> -		      struct device *device,
> -		      enum fw_opt opt_flags,
> -		      int ret)
> +int firmware_sysfs_fallback(struct firmware *fw, const char *name,
> +			    struct device *device,
> +			    enum fw_opt opt_flags,
> +			    int ret)

Since we may get more than one fallback later I'll usee the firmware_fallback_sysfs() here.
I'll do this change and resubmit myself.

>  {
>  	if (!fw_run_sysfs_fallback(opt_flags))
>  		return ret;
> diff --git a/drivers/base/firmware_loader/fallback.h b/drivers/base/firmware_loader/fallback.h
> index a3b73a09db6c..8cfaa3299bb7 100644
> --- a/drivers/base/firmware_loader/fallback.h
> +++ b/drivers/base/firmware_loader/fallback.h
> @@ -31,7 +31,7 @@ struct firmware_fallback_config {
>  };
>  
>  #ifdef CONFIG_FW_LOADER_USER_HELPER
> -int fw_sysfs_fallback(struct firmware *fw, const char *name,
> +int firmware_sysfs_fallback(struct firmware *fw, const char *name,
>  		      struct device *device,
>  		      enum fw_opt opt_flags,
>  		      int ret);
> @@ -43,7 +43,7 @@ void fw_fallback_set_default_timeout(void);
>  int register_sysfs_loader(void);
>  void unregister_sysfs_loader(void);
>  #else /* CONFIG_FW_LOADER_USER_HELPER */
> -static inline int fw_sysfs_fallback(struct firmware *fw, const char *name,
> +static inline int firmware_sysfs_fallback(struct firmware *fw, const char *name,
>  				    struct device *device,
>  				    enum fw_opt opt_flags,
>  				    int ret)
> diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
> index a405d400a925..59836d50c5bd 100644
> --- a/drivers/base/firmware_loader/firmware.h
> +++ b/drivers/base/firmware_loader/firmware.h
> @@ -15,12 +15,12 @@
>   * enum fw_opt - options to control firmware loading behaviour
>   *
>   * @FW_OPT_UEVENT: Enables the fallback mechanism to send a kobject uevent
> - *                  when the firmware is not found. Userspace is in charge
> - *                  to load the firmware using the sysfs loading facility.
> + *                 when the firmware is not found. Userspace is in charge
> + *                 to load the firmware using the sysfs loading facility.

This change was really not part of this patch, so I'll merge it in with the
other patch.

>   * @FW_OPT_NOWAIT: Used to describe the firmware request is asynchronous.
>   * @FW_OPT_USERHELPER: Enable the fallback mechanism, in case the direct
>   *                     filesystem lookup fails at finding the firmware.
> - *                     For details refer to fw_sysfs_fallback().
> + *                     For details refer to firmware_sysfs_fallback().
>   * @FW_OPT_NO_WARN: Quiet, avoid printing warning messages.
>   * @FW_OPT_NOCACHE: Disables firmware caching. Firmware caching is used to
>   *                  cache the firmware upon suspend, so that upon resume
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index 58aaadf81e12..f009566acd35 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -581,7 +581,7 @@ _firmware_request(const struct firmware **firmware_p, const char *name,
>  			dev_warn(device,
>  				 "Direct firmware load for %s failed with error %d\n",
>  				 name, ret);
> -		ret = fw_sysfs_fallback(fw, name, device, opt_flags, ret);
> +		ret = firmware_sysfs_fallback(fw, name, device, opt_flags, ret);
>  	} else
>  		ret = assign_fw(fw, device, opt_flags);
>  
> -- 
> 2.14.1
> 
> 

-- 
Do not panic
