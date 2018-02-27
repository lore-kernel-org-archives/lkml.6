Return-Path: <borntraeger@de.ibm.com>
X-Google-Smtp-Source: AG47ELvt2f2F22ssPEGPDJu7h4rg4hPhZN2hI1dYZQv6G15bkn0x264JZgy0QFsA+xkdt0mdFVMg
ARC-Seal: i=1; a=rsa-sha256; t=1519723426; cv=none;
        d=google.com; s=arc-20160816;
        b=zwfCRVgLYBtFJtByYMFgnS4mrivy1TgXsbTUhLWZPxEksLNv2n8s77cfjuUBGL3SM7
         S43cEONZZ2zJ7SrVY6YeXM+EAWPkK++4eeCdb+VxSavTUfgEjl0GtM03zBomFKh6uCWl
         g9TM2+LSlFk//yTowgAqzSXZk4rZDwM4nqlFSTfaYv5w7RpOvQ3/fKsHpB87fo/AiCJU
         VgZ5j8z0by+2jM2eyhDN+TFyeQaEPrSQY24CVm9jQ1SeREnehXiGx/SojndFNscI598u
         wKQgtrG663Lm1ssVrc/UPap0uOc/JXnQFHnwTdnDSWApWT9FV27ND+39mJDF4AAj8HhX
         0Tvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=wL6rDFmo41ebIvHps3TOdaubk6ClrsZ3OfLxXph6Bfg=;
        b=F9cecHomYjAg2aUhHA9v2/pGUoL3L1YttyzbXCLXEBTzBcx29Kn+YLZjKHeEO9T3TT
         fgTALLP1keacxNLogj2kUfawJ9PfjaGO2DLF9Vg7xsf4kbJfvRN8ZreSrqNjVTfwgVst
         ekkqgHGQ55lHpd/K3B86BSf6c5yfbCi2MupTglAHfxSAfII+UGDQZ0USEEbPIW8jzAkK
         /ovFLlkcUobRxAIYMnFt0FyBwHtmLok+4IKqOeZeC61nNheKI3he39fd4+4k8G5HANdK
         6CKS1uGjtDE6QLZ9pWtfvVrcPq0dxIlVYQFnR/DcVAv428aX9xvuhNsJP7GS3LpdRTw2
         HQ8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of borntraeger@de.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=borntraeger@de.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of borntraeger@de.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=borntraeger@de.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v4 1/3] Kconfig : Remove HAS_IOMEM dependency for Graphics
 support
To: Farhan Ali <alifm@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-s390@vger.kernel.org,
        b.zolnierkie@samsung.com
Cc: thuth@redhat.com, cohuck@redhat.com, tomi.valkeinen@ti.com,
        geert@linux-m68k.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <cover.1519315352.git.alifm@linux.vnet.ibm.com>
 <6e8ef238162df5be4462126be155975c722e9863.1519315352.git.alifm@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 27 Feb 2018 10:23:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6e8ef238162df5be4462126be155975c722e9863.1519315352.git.alifm@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18022709-0008-0000-0000-000004D4F672
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022709-0009-0000-0000-00001E681583
Message-Id: <05a0da63-1d9a-875a-738c-ce453dd59505@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-27_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802270114
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1593545512360953090?=
X-GMAIL-MSGID: =?utf-8?q?1593545512360953090?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This one has been in linux-next for some days. I can carry this via the kvm/s390
tree, but I would like to get ack from at least Bartlomiej. Please also look at 
patch 3 which also touches  drivers/video/console/Kconfig.

Adding Greg, as I would like an ack from him for patch 3.

On 02/22/2018 05:22 PM, Farhan Ali wrote:
> The 'commit e25df1205f37 ("[S390] Kconfig: menus with depends on HAS_IOMEM.")'
> added the HAS_IOMEM dependecy for "Graphics support". This disabled the
> "Graphics support" menu for S390. But if we enable VT layer for S390,
> we would also need to enable the dummy console. So let's remove the
> HAS_IOMEM dependency.
> 
> Move this dependency to sub menu items and console drivers that use
> io memory.
> 
> Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  drivers/video/Kconfig         | 5 ++++-
>  drivers/video/console/Kconfig | 6 +++---
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 3c20af9..4f950c6 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -3,7 +3,8 @@
>  #
> 
>  menu "Graphics support"
> -	depends on HAS_IOMEM
> +
> +if HAS_IOMEM
> 
>  config HAVE_FB_ATMEL
>  	bool
> @@ -36,6 +37,8 @@ config VIDEOMODE_HELPERS
>  config HDMI
>  	bool
> 
> +endif # HAS_IOMEM
> +
>  if VT
>  	source "drivers/video/console/Kconfig"
>  endif
> diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
> index 7f1f1fb..9485857 100644
> --- a/drivers/video/console/Kconfig
> +++ b/drivers/video/console/Kconfig
> @@ -9,7 +9,7 @@ config VGA_CONSOLE
>  	depends on !4xx && !PPC_8xx && !SPARC && !M68K && !PARISC && !FRV && \
>  		!SUPERH && !BLACKFIN && !AVR32 && !MN10300 && !CRIS && \
>  		(!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) && \
> -		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC
> +		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC && HAS_IOMEM
>  	default y
>  	help
>  	  Saying Y here will allow you to use Linux in text mode through a
> @@ -85,7 +85,7 @@ config MDA_CONSOLE
> 
>  config SGI_NEWPORT_CONSOLE
>          tristate "SGI Newport Console support"
> -        depends on SGI_IP22 
> +        depends on SGI_IP22 && HAS_IOMEM
>          select FONT_SUPPORT
>          help
>            Say Y here if you want the console on the Newport aka XL graphics
> @@ -153,7 +153,7 @@ config FRAMEBUFFER_CONSOLE_ROTATION
> 
>  config STI_CONSOLE
>          bool "STI text console"
> -        depends on PARISC
> +        depends on PARISC && HAS_IOMEM
>          select FONT_SUPPORT
>          default y
>          help
> 
