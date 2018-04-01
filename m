Return-Path: <ben.hutchings@codethink.co.uk>
X-Google-Smtp-Source: AIpwx4+v84YHjjfEkn+pFh56MzKbCAXqSnj+8JuQPkxZlYxExYY3WKai4QhDIc/UY4bM+cl1H/yc
ARC-Seal: i=1; a=rsa-sha256; t=1522615782; cv=none;
        d=google.com; s=arc-20160816;
        b=R7xumIuD0Vd64++byQgqhltKsEojXNlBdBIY7cJ3CNoyQmT3bdd1T5+UsUCCxlr1aP
         Ni+J0OIa+PbeXJa/bgk2yzaN36NAXtAHmgtXZb6f2/FrvapHmOPFU82tx5ulilMVEgr+
         66CYBR+s0u2GWPuXdQTZvUdGIRMiK40PTYShEPtJVVTxmp0zwhhi7KKYzkE3sXamkLSi
         rvBvpfzv0+81gWzgoQRTyMJImq6BINqiU/FWAms3FNzBUrSdHKQN9bZYIs58xOaQAXOT
         1kU8Xk3zH2bEBHAsYCrpj2JYAQoChTnoMqL4mAobPkjBwO/0sRybTqHo2iZ5ZLtCp0Cx
         Qf/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=I56ZJOIMQBKUUyKO+gH/VYdSUpRb+hyZ5kgGw2amXR4=;
        b=rYbjrNu9lI4O9JBcc3DJWNXKnSPmkHUxkRbkCTTMRKzbkh42zREOgOlc1nAlhU7xfV
         orPjzx2vG3qLL0Hh+AFPtskBeiQNPAL6DsoLZM5Hqq3OG/zvLUGk0ujLLwZwoa7Ly1zZ
         eXPEGa5iRaFyRrcVDzDYtnZOYUkI5wqZsOrYMA926JohgspnfZYC1TvuNva1uOsH2YBV
         7yk3VJSO/11tl7P1tkE5f9TDQPPbErRZtI68F12Gls7jm9IBUBw9c3WBo948qAVukaMj
         t7ORC2WnPHDrIWx5pXAK480mQMD3xpw1F6pnD/Kugbs2h/tu9X7x3voVmuwH5LkZgeGF
         IUHg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben.hutchings@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=ben.hutchings@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben.hutchings@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=ben.hutchings@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Message-ID: <1522615780.2654.76.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 089/134] ARM: dts: omap3-n900: Fix the audio CODECs
 reset pin
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>, Tony Lindgren
	 <tony@atomide.com>, Sasha Levin <alexander.levin@microsoft.com>
Date: Sun, 01 Apr 2018 21:49:40 +0100
In-Reply-To: <20180319171902.160796295@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
	 <20180319171902.160796295@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595390608912985115?=
X-GMAIL-MSGID: =?utf-8?q?1596578366304743864?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-03-19 at 19:06 +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: "Andrew F. Davis" <afd@ti.com>
> 
> 
> [ Upstream commit 7be4b5dc7ffa9499ac6ef33a5ffa9ff43f9b7057 ]
> 
> The correct DT property for specifying a GPIO used for reset
> is "reset-gpios", fix this here.

This also depends on a driver change.  Please revert it for all stable
branches.

Ben.

> Fixes: 14e3e295b2b9 ("ARM: dts: omap3-n900: Add TLV320AIC3X support")
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/arm/boot/dts/omap3-n900.dts |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -488,7 +488,7 @@
>  	tlv320aic3x: tlv320aic3x@18 {
>  		compatible = "ti,tlv320aic3x";
>  		reg = <0x18>;
> -		gpio-reset = <&gpio2 28 GPIO_ACTIVE_HIGH>; /* 60 */
> +		reset-gpios = <&gpio2 28 GPIO_ACTIVE_LOW>; /* 60 */
>  		ai3x-gpio-func = <
>  			0 /* AIC3X_GPIO1_FUNC_DISABLED */
>  			5 /* AIC3X_GPIO2_FUNC_DIGITAL_MIC_INPUT */
> @@ -505,7 +505,7 @@
>  	tlv320aic3x_aux: tlv320aic3x@19 {
>  		compatible = "ti,tlv320aic3x";
>  		reg = <0x19>;
> -		gpio-reset = <&gpio2 28 GPIO_ACTIVE_HIGH>; /* 60 */
> +		reset-gpios = <&gpio2 28 GPIO_ACTIVE_LOW>; /* 60 */
>  
>  		AVDD-supply = <&vmmc2>;
>  		DRVDD-supply = <&vmmc2>;

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
