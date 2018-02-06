Return-Path: <daniel.thompson@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1517925459; cv=none;
        d=google.com; s=arc-20160816;
        b=rLyext3ZgcCjbK0NnK8fO+SEPjycUWBIqRf3SppvwtJrOvr/x0D//Kty/uw3dLroWS
         FkfBOLy6IZ4/V/Ynf09iiUcPI1EAwbMMp0jeQuzYTh2o8DU9WRwsXrXKN/sQpV9tlhoq
         +GTOIu7+j1/wli6Qja/ILTAoACUNXWuqLJkpcehqHLpV1vON3D1cKSAiDuXv9K3rgvfe
         1ey/2R9wTp6ExZ46eA0PmsmwI9cWEf1J5IamTIwe3M4QgFZbFArj7qdS8qVVANBwaAA1
         VLH2ncNhuigI+dv7an2UZ3uVwXRw1LqCJiQQiMDwhZQIs6g1d+BbGyjMThg1V6sO5PrX
         aOlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=jyup3LP+niPM9ax+c6xTalXnkh0uNphWHdvODlYD25U=;
        b=VS+lpnqSJIWvI4bK9BCR7aJxLtVx3GcWJziOBWihmv1kMdQiJPTdNj7hrEN856uLmy
         1E1sPVAANfcsAOFk+X2HSjMqBCfj+fOAl1faqK23NAdSAlOoLFpYIRKMRXyl54qqwS4N
         TQKWrEfRRanNhESBGUHvQxuspz8075c9VSXPGTlr9r62kVbUDQrKqQU74r70FPQDEqGD
         X53779HdTxnWOVC/pNxBqrj/P+PuV2vHHOQrMGcQvhSCRPKEGag6y+nvWT0BgOs3SEBD
         HkG3OEM/x6xQN1KOLCb6bNI0eFcf7c/L15ZGPibq8UyINuKs8i5s5gGf0kXhFXTCBxTO
         HIRA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=gj7Bauy8;
       spf=pass (google.com: domain of daniel.thompson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=daniel.thompson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=gj7Bauy8;
       spf=pass (google.com: domain of daniel.thompson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=daniel.thompson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AH8x226APYG1gIIrjWSkX5dAZ0LuwSfQ2XSpWv/ut0D3S+zjbJPgQwIonCuTdBBvtSzNes53W7TE0w==
Date: Tue, 6 Feb 2018 13:57:35 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Aishwarya Pant <aishpant@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH v2 3/3] backlight: adp8860: document sysfs attributes
Message-ID: <20180206135735.zywr2sdkuiejpvcm@oak.lan>
References: <cover.1517902411.git.aishpant@gmail.com>
 <4a486ddca7b33844765f6773fd41e91f1fa9b2fb.1517902411.git.aishpant@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a486ddca7b33844765f6773fd41e91f1fa9b2fb.1517902411.git.aishpant@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591636530950975861?=
X-GMAIL-MSGID: =?utf-8?q?1591660206398530369?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 06, 2018 at 01:11:12PM +0530, Aishwarya Pant wrote:
> Add documentation for sysfs interface of adp8860 series backlight
> devices by reading through code and git commits.
> 
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
> Acked-by: Michael Hennerich <michael.hennerich@analog.com>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  .../ABI/testing/sysfs-class-backlight-adp8860      | 54 ++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-backlight-adp8860
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-backlight-adp8860 b/Documentation/ABI/testing/sysfs-class-backlight-adp8860
> new file mode 100644
> index 000000000000..54d61c788b1b
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-backlight-adp8860
> @@ -0,0 +1,54 @@
> +sysfs interface for analog devices adp8860 backlight driver
> +-----------------------------------------------------------
> +
> +The backlight brightness control operates at three different levels for the
> +adp8860, adp8861 and adp8863 devices: daylight (level 1), office (level 2) and
> +dark (level 3). By default the brightness operates at the daylight brightness
> +level.
> +
> +What:		/sys/class/backlight/<backlight>/ambient_light_level
> +Date:		Apr, 2010
> +KernelVersion:	v2.6.35
> +Contact:	Michael Hennerich <michael.hennerich@analog.com>
> +Description:
> +		(RO) 13-bit conversion value for the first light sensor—high
> +		byte (Bit 12 to Bit 8). The value is updated every 80 ms (when
> +		the light sensor is enabled).
> +
> +
> +What:		/sys/class/backlight/<backlight>/ambient_light_zone
> +Date:		Apr, 2010
> +KernelVersion:	v2.6.35
> +Contact:	Michael Hennerich <michael.hennerich@analog.com>
> +Description:
> +		(RW) Read or write the specific level at which the backlight
> +		operates. Value "0" enables automatic ambient light sensing, and
> +		values "1", "2" or "3" set the control to daylight, office or
> +		dark respectively.
> +
> +
> +What:		/sys/class/backlight/<backlight>/l1_daylight_max
> +What:		/sys/class/backlight/<backlight>/l2_office_max
> +What:		/sys/class/backlight/<backlight>/l3_dark_max
> +Date:		Apr, 2010
> +KernelVersion:	v2.6.35
> +Contact:	Michael Hennerich <michael.hennerich@analog.com>
> +Description:
> +		(RW) Maximum current setting for the backlight when brightness
> +		is at one of the three levels (daylight, office or dark). This
> +		is an input code between 0 and 127, which is transformed to a
> +		value between 0 mA and 30 mA using linear or non-linear
> +		algorithms.
> +
> +
> +What:		/sys/class/backlight/<backlight>/l1_daylight_dim
> +What:		/sys/class/backlight/<backlight>/l2_office_dim
> +What:		/sys/class/backlight/<backlight>/l3_dark_dim
> +Date:		Apr, 2010
> +KernelVersion:	v2.6.35
> +Contact:	Michael Hennerich <michael.hennerich@analog.com>
> +Description:
> +		(RW) Dim current setting for the backlight when brightness is at
> +		one of the three levels (daylight, office or dark). This is an
> +		input code between 0 and 127, which is transformed to a value
> +		between 0 mA and 30 mA using linear or non-linear algorithms.
> -- 
> 2.16.1
> 
