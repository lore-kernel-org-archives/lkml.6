Return-Path: <dan.rue@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521507594; cv=none;
        d=google.com; s=arc-20160816;
        b=zwqnmNWZf3vPdnYfplHKGvWXh8sQdCqWAOdxRNY8hRilsByhhlVqWkv2dBXDHkM+Zu
         VopM8KZSL30j5WkWrTqb9zGx/drc+t431WsuU/THz3dMJTcyfAYwln5OWsN5lURstlSo
         Rr7L11shbzI3FXC4eWlPXmEosycGpePIjYS/4NLVXuWIKW147vNEGjXYAZ+sIv3xK3ja
         f2S0tdXLf+R9VuHy+X2UcEs/g7NNC6QQ2FS9aiEPMhV6vrZlNuM2Ksd6JenaBGw1eoG9
         JV5qd9cpSjGLgdftZeQ81f0pE8tFU86MYUaAV9eVuLd0TOGvORuKjm5ocLBRdwNcFsYv
         ux0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=YDuLVeyugJZwnhQdUmTZmokbFB9MPKI7iGI+2cxXs9I=;
        b=YrYhKNl77fE5MBn4bGVTbEllyGdXTb6KdkRjfwLKDZoYrp+hb7aWBJ0gUJEUbh+pV9
         8y9l15xLkcAVszatEIeR4KTze6xgvrQX3eCxA0ZuXC4xG4eFG3Ct7JJWV/d26qjCKaEa
         7jodfarIGpsQh4YPwe7gVDavSrMagaxFDDp7ZLb/qOHEUASPyWZng9XV+1zNstAn8KG2
         6mdT6gMcT0i8UFB5YJWz7ERJ1dCzGlD+gdQU3L4myxNnisiPF6pZl/X6n2pXDzibl0oU
         1D0cvKbn41y1fIO/p55IIvJAlzt7TWPu6q7yI22cehusUcO1EShmPlyl+cl7os3lKu1A
         DBDQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=HuR0jldC;
       spf=pass (google.com: domain of dan.rue@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=dan.rue@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=HuR0jldC;
       spf=pass (google.com: domain of dan.rue@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=dan.rue@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELuTXo9qSVcF1t5M5OHDllvKwl8mcGcXCVnfx9cHWw5ps34t0RWkSWYZ6852KVsydl9OHK5QpQ==
Date: Tue, 20 Mar 2018 08:59:51 +0800
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, ben.hutchings@codethink.co.uk,
	shuahkh@osg.samsung.com, lkft-triage@lists.linaro.org,
	patches@kernelci.org, stable@vger.kernel.org,
	akpm@linux-foundation.org, torvalds@linux-foundation.org,
	linux@roeck-us.net
Subject: Re: [PATCH 4.9 000/241] 4.9.89-stable review
Message-ID: <20180320005951.ulw66htokgtdmfav@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, ben.hutchings@codethink.co.uk,
	shuahkh@osg.samsung.com, lkft-triage@lists.linaro.org,
	patches@kernelci.org, stable@vger.kernel.org,
	akpm@linux-foundation.org, torvalds@linux-foundation.org,
	linux@roeck-us.net
References: <20180319180751.172155436@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
User-Agent: NeoMutt/20180223
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595391137042363427?=
X-GMAIL-MSGID: =?utf-8?q?1595416348050646871?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 07:04:25PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.89 release.
> There are 241 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 21 18:07:03 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.89-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.

I needed to revert the following in order to successfully build arm32
and arm64 with default configs:

9b18a27ddaa0 ("ARM: dts: silk: Correct clock of DU1")
181e698aaf8c ("ARM: dts: r8a7794: Correct clock of DU1")
2bbf316eee1b ("soc/tegra: Fix link errors with PMC disabled")
0a576d2dfcc6 ("dmaengine: bcm2835-dma: Use vchan_terminate_vdesc() instead of desc_free")
67ee5b1dfe12 ("clk: sunxi-ng: a33: Add offset and minimum value for DDR1 PLL N factor")
9294024e21e3 ("ARM: DRA7: hwmod_data: Prevent wait_target_disable error for usb_otg_ss")

I'm not sure the best way to report the specific issues with those, or
why there have been so many arm32/64-related build issues lately. Let me
know if you want more details.

Dan
