Return-Path: <daniel.thompson@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1517925431; cv=none;
        d=google.com; s=arc-20160816;
        b=L5uadCXKYS+8aT+4/3DB3sR5Q23sEFynLZznuf4JmkQqesbLjei4uGxGw3+JStPI46
         I44zG+o9xmVM6GoxlMUKPt1twVdQ5cEcigZMtn9K0bPmTe2AO2aZA15niOgOfSOy5tcj
         HqgqeQEPR0rTK1iMD0bfHQn0MPWvu7wjIdud10Z2c3Md1CUzIUFIWcqxUv7lzasHBzPj
         5p4D7lWqXIIuL5Hhujg0KwNtBW8d/XFvVPZZ91KO6RRVngVSf8DTWv5Ky87aeb6xr00y
         XzbJWM5eXbkXMDGyMINtfQ1Gi0rxITDRGSJNR7QJWCXGM/n3q45zbNENFBGuHDEgjDRE
         ZluA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=5h88kgU8TuVanHc4BsvXxOTM0takxGzBRGW5e44OLw0=;
        b=bu9BjwvCs7qa/vxTizD/aATBKFLBbOw9d4q6GOHHxkCaEkDs70T2GJ+IH+0+ml+SID
         +tP2MdnnDNrPOgfEvQCScb61ObE/hfgAuMXGmFDeEkAJAYSptdNtEvOYmq3Rg3iKI9SA
         /Wo9v4unxRkgWW5fiNvkUdyXn88WzlN+O+c+N2kUmTnHyToOjS1pNY62fd0v+EW0kYlz
         TYXU63GB9UR/OBL1DUypITGyzYzWqPBBpyfUc9PZfpRoGTCBiIjLcMs01W+gDabstXpC
         o4Zj/mOxgVsWZbU/q1Ch+OgjO/qUn3MWwN0irXg/+8M2Ti1tRs2R2boalHEFPW7cDneT
         NnXw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=JXOHXNR1;
       spf=pass (google.com: domain of daniel.thompson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=daniel.thompson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=JXOHXNR1;
       spf=pass (google.com: domain of daniel.thompson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=daniel.thompson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AH8x226xUSqWFdJ9okpN+gJ5MwEZYNlLu7/AbstMX0BuHNH8aIgFEA77m22EUTvyMBUdOB39Hlei5A==
Date: Tue, 6 Feb 2018 13:57:08 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Aishwarya Pant <aishpant@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH v2 2/3] backlight: adp5520: document sysfs attributes
Message-ID: <20180206135708.2pmadwxreqj2x5qt@oak.lan>
References: <cover.1517902411.git.aishpant@gmail.com>
 <dfaf338847058807a8b897bd4e555b6a47efeece.1517902411.git.aishpant@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfaf338847058807a8b897bd4e555b6a47efeece.1517902411.git.aishpant@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591636481965855286?=
X-GMAIL-MSGID: =?utf-8?q?1591660177529199483?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 06, 2018 at 01:10:26PM +0530, Aishwarya Pant wrote:
> Add documentation for sysfs interface of adp5520/adp5501 analog devices
> backlight driver by reading code and looking through git commit logs.
> 
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
> Acked-by: Michael Hennerich <michael.hennerich@analog.com>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  .../ABI/testing/sysfs-class-backlight-adp5520      | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-backlight-adp5520
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-backlight-adp5520 b/Documentation/ABI/testing/sysfs-class-backlight-adp5520
> new file mode 100644
> index 000000000000..34b6ebafa210
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-backlight-adp5520
> @@ -0,0 +1,31 @@
> +sysfs interface for analog devices adp5520(01) backlight driver
> +---------------------------------------------------------------
> +
> +The backlight brightness control operates at three different levels for the
> +adp5520 and adp5501 devices: daylight (level 1), office (level 2) and dark
> +(level 3). By default the brightness operates at the daylight brightness level.
> +
> +What:		/sys/class/backlight/<backlight>/daylight_max
> +What:		/sys/class/backlight/<backlight>/office_max
> +What:		/sys/class/backlight/<backlight>/dark_max
> +Date:		Sep, 2009
> +KernelVersion:	v2.6.32
> +Contact:	Michael Hennerich <michael.hennerich@analog.com>
> +Description:
> +		(RW) Maximum current setting for the backlight when brightness
> +		is at one of the three levels (daylight, office or dark). This
> +		is an input code between 0 and 127, which is transformed to a
> +		value between 0 mA and 30 mA using linear or non-linear
> +		algorithms.
> +
> +What:		/sys/class/backlight/<backlight>/daylight_dim
> +What:		/sys/class/backlight/<backlight>/office_dim
> +What:		/sys/class/backlight/<backlight>/dark_dim
> +Date:		Sep, 2009
> +KernelVersion:	v2.6.32
> +Contact:	Michael Hennerich <michael.hennerich@analog.com>
> +Description:
> +		(RW) Dim current setting for the backlight when brightness is at
> +		one of the three levels (daylight, office or dark). This is an
> +		input code between 0 and 127, which is transformed to a value
> +		between 0 mA and 30 mA using linear or non-linear algorithms.
> -- 
> 2.16.1
> 
