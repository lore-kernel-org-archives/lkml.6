Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AH8x225D84qthMlc4FGhyKX0kulHMcnzE4++XxASa+SNDl/jlLUeaO2aQPzE0ooD7RFF5lfuV540
ARC-Seal: i=1; a=rsa-sha256; t=1519584686; cv=none;
        d=google.com; s=arc-20160816;
        b=bq9yIpEuILwLuJA6IllLLT+ZTGYzGS2V2QT7/hF47v00+Vbw+EvxMiK6HV0VHQ/ceN
         Lkx2NJejqHPCL6O5wf0AwmVjCHBEgq4eiwTSaAj2KMFViCj+UtwWOvnT9bmmmGcp+qNm
         7OW9uAWY35n3+SIiVZN0kYlcq0UAVvIPdEmMPpHOZGxU4u9Zqyil4Y2vuftlTTnWmuE8
         8Dvyy62rf1HfWE55lEAX3+W+nydu0yh44L5fEae8spKSNjvUC/XLk7YhSVJ74SlOkBfj
         E7BZBETWXBdht1SfIUSidrVUbfIXfZVgcxqGHpfnm8GO7CNRjlQrf2nX4/1HzaH/ipHM
         GPPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=gkh/yKWq/ZROITZ63rIsjO5+2id+ztRMTe4DgTySeFg=;
        b=p2fe7RIQNHLIU/UA1EPEktYAiSNOfew3hqiKa5gt7hhs1RbPMX7717eIJBhDbZ+jji
         sV3C92VMtzWBgfCNPCgaJK5OkQAgQF7hkVFA4K3IG88jCNa69ewhWm4rj1MlZgZ6/MQL
         TPhkShaovdKxZoTZ3hCxlHjGOIVte08gRl0rZl//8Jp/ba72qP6T+FfbbEXY7wrewoA6
         ZGZ3AsU95qkAnx045VKmLHlDqdkCrF1sOF91rgSuSTQz0I6HFrTfBylOTCqmCy+xO4Gd
         9qOSRu2laBu+vnkVhxhgyKrxw7efkFwSW2YXshPNZgHG87m6qO3pItxyDGe4YhNQvNa4
         /RcA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=lofuy6I6;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=lofuy6I6;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH v2 12/12] extcon: axp288: Set USB role where necessary
To: Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>,
 Andy Shevchenko <andy@infradead.org>, MyungJoo Ham
 <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Guenter Roeck <linux@roeck-us.net>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20180225152510.10159-1-hdegoede@redhat.com>
 <20180225152510.10159-13-hdegoede@redhat.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2e3c62b0-0d9b-4d30-654b-750055e6f515@infradead.org>
Date: Sun, 25 Feb 2018 10:51:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180225152510.10159-13-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592554260273548820?=
X-GMAIL-MSGID: =?utf-8?q?1593400032746438621?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 02/25/2018 07:25 AM, Hans de Goede wrote:
 
> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
> index a7bca4207f44..de15bf55895b 100644
> --- a/drivers/extcon/Kconfig
> +++ b/drivers/extcon/Kconfig
> @@ -30,7 +30,8 @@ config EXTCON_ARIZONA
>  
>  config EXTCON_AXP288
>  	tristate "X-Power AXP288 EXTCON support"
> -	depends on MFD_AXP20X && USB_PHY
> +	depends on MFD_AXP20X && USB_SUPPORT && X86

Could that be:
	depends on MFD_AXP20X && USB_SUPPORT && (X86 || COMPILE_TEST)

or is there some reason that it won't even build on other $ARCH?

> +	select USB_ROLE_SWITCH
>  	help
>  	  Say Y here to enable support for USB peripheral detection
>  	  and USB MUX switching by X-Power AXP288 PMIC.

thanks,
-- 
~Randy
