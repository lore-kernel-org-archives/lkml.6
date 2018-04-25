Return-Path: <vinod.koul@intel.com>
X-Google-Smtp-Source: AIpwx48O/lt4xPQt5tlMl+++YWNG80PIXiZr0X0i1WU5xFnAZPc1uqWw2fuAoYl5fX7bePPHWWza
ARC-Seal: i=1; a=rsa-sha256; t=1524624409; cv=none;
        d=google.com; s=arc-20160816;
        b=XYKNBbK1DeAIsuBfMJ5zxLN3uSFVuNgLyfhAyL7YwT9jYGTfSXF98kdB4gUKVpWnGK
         aQyf/19gLNOSXZm5nRDTQn9uOrQdRa1dv2bt9db42zS6HJt0FqejogqawEKKURielHb0
         E5+CDLToRW1Zr1EBddaqWyilCd/cOzIOeMpnQTbg76qZbkoHa1oRujR3TnA3oHC3DanA
         3/bi/KY5yXAFv+Uf2ZQa7/wa1HlG58wZ0L7h5k7Lag6UqVsVd5ffluWLkYLKEjCowi1z
         eq5M+9b5nTF+0VqUbUcr6B+iV0IqzliIhHB9D+/YApkUlTlcHgFJR7/iupt9LKQgPKyz
         nu8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=v0dTKSjAa2+eTkZ/GMxsvdoAH56LI9UmuKNQebF2Xqo=;
        b=UaUgRGpHM9SLRhYq2eETl9g/vMnRGHdCQ8ZjuUURRiv0RwM4wCFh8w6iOWffr6yjZ0
         YwCiqsS0TVnFuLzF2E6jsyYSl1uJ6h0h0pxNOjkAYggRbGVCtu78Py1STaS15GTLH6Ft
         mO3UP8z4+ShpNKIWIubPHpbs47XmvypB+wdhmdAgQDpW9F+d+XmB05pB52/SWoQ0+Fm7
         TA6CF91xfZb7pYF4Bawh64gSt2hvXlcIEqv28n9hOhnRt7CwyWkbGX1eLFrOm10QoQgr
         FQ3Z19sX64mxmVgf6ZHinKkkjIHm5RcCq+YD6qXqic0ahfNRuTlo7R13r/E1GpRx0zRb
         wCog==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of vinod.koul@intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=vinod.koul@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of vinod.koul@intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=vinod.koul@intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,325,1520924400";
   d="scan'208";a="35932813"
Date: Wed, 25 Apr 2018 08:21:25 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Simon Glass <sjg@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, C Shapiro <shapiroc@chromium.org>,
	Aaron Durbin <adurbin@chromium.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Alex Hung <alex.hung@canonical.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jean Delvare <jdelvare@suse.com>,
	sayli karnik <karniksayli1995@gmail.com>,
	Sagar Dharia <sdharia@codeaurora.org>
Subject: Re: [PATCH] firmware: dmi: Add access to the SKU ID string
Message-ID: <20180425025125.GH6014@localhost>
References: <20180424211111.140374-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424211111.140374-1-sjg@chromium.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598663453447525196?=
X-GMAIL-MSGID: =?utf-8?q?1598684564752494041?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 03:11:11PM -0600, Simon Glass wrote:
> This is used in some systems from user space for determining the identity
> of the device.
> 
> Expose this as a file so that that user-space tools don't need to read
> from /sys/firmware/dmi/tables/DMI

sysfs is an ABI and needs to be documented, I don't see that in this patch,
pls add.

> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  drivers/firmware/dmi-id.c       | 2 ++
>  drivers/firmware/dmi_scan.c     | 1 +
>  include/linux/mod_devicetable.h | 1 +
>  3 files changed, 4 insertions(+)
> 
> diff --git a/drivers/firmware/dmi-id.c b/drivers/firmware/dmi-id.c
> index 951b6c79f166a..fe78c7f801163 100644
> --- a/drivers/firmware/dmi-id.c
> +++ b/drivers/firmware/dmi-id.c
> @@ -48,6 +48,7 @@ DEFINE_DMI_ATTR_WITH_SHOW(product_version,	0444, DMI_PRODUCT_VERSION);
>  DEFINE_DMI_ATTR_WITH_SHOW(product_serial,	0400, DMI_PRODUCT_SERIAL);
>  DEFINE_DMI_ATTR_WITH_SHOW(product_uuid,		0400, DMI_PRODUCT_UUID);
>  DEFINE_DMI_ATTR_WITH_SHOW(product_family,	0444, DMI_PRODUCT_FAMILY);
> +DEFINE_DMI_ATTR_WITH_SHOW(product_sku,		0444, DMI_PRODUCT_SKU);
>  DEFINE_DMI_ATTR_WITH_SHOW(board_vendor,		0444, DMI_BOARD_VENDOR);
>  DEFINE_DMI_ATTR_WITH_SHOW(board_name,		0444, DMI_BOARD_NAME);
>  DEFINE_DMI_ATTR_WITH_SHOW(board_version,	0444, DMI_BOARD_VERSION);
> @@ -193,6 +194,7 @@ static void __init dmi_id_init_attr_table(void)
>  	ADD_DMI_ATTR(product_serial,    DMI_PRODUCT_SERIAL);
>  	ADD_DMI_ATTR(product_uuid,      DMI_PRODUCT_UUID);
>  	ADD_DMI_ATTR(product_family,    DMI_PRODUCT_FAMILY);
> +	ADD_DMI_ATTR(product_sku,       DMI_PRODUCT_SKU);
>  	ADD_DMI_ATTR(board_vendor,      DMI_BOARD_VENDOR);
>  	ADD_DMI_ATTR(board_name,        DMI_BOARD_NAME);
>  	ADD_DMI_ATTR(board_version,     DMI_BOARD_VERSION);
> diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
> index 54e66adef2525..f2483548cde92 100644
> --- a/drivers/firmware/dmi_scan.c
> +++ b/drivers/firmware/dmi_scan.c
> @@ -447,6 +447,7 @@ static void __init dmi_decode(const struct dmi_header *dm, void *dummy)
>  		dmi_save_ident(dm, DMI_PRODUCT_VERSION, 6);
>  		dmi_save_ident(dm, DMI_PRODUCT_SERIAL, 7);
>  		dmi_save_uuid(dm, DMI_PRODUCT_UUID, 8);
> +		dmi_save_ident(dm, DMI_PRODUCT_SKU, 25);
>  		dmi_save_ident(dm, DMI_PRODUCT_FAMILY, 26);
>  		break;
>  	case 2:		/* Base Board Information */
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index 7d361be2e24f4..cb8487e29d3ae 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -491,6 +491,7 @@ enum dmi_field {
>  	DMI_PRODUCT_SERIAL,
>  	DMI_PRODUCT_UUID,
>  	DMI_PRODUCT_FAMILY,
> +	DMI_PRODUCT_SKU,
>  	DMI_BOARD_VENDOR,
>  	DMI_BOARD_NAME,
>  	DMI_BOARD_VERSION,
> -- 
> 2.17.0.484.g0c8726318c-goog
> 

-- 
~Vinod
