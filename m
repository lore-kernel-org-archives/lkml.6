Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0195BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 04:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81E320840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 04:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731855AbfAPEYi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 23:24:38 -0500
Received: from mga18.intel.com ([134.134.136.126]:50645 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729203AbfAPEYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 23:24:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2019 20:24:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,484,1539673200"; 
   d="scan'208";a="126396932"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga002.jf.intel.com with ESMTP; 15 Jan 2019 20:24:37 -0800
Received: from fmsmsx158.amr.corp.intel.com (10.18.116.75) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 15 Jan 2019 20:24:37 -0800
Received: from bgsmsx151.gar.corp.intel.com (10.224.48.42) by
 fmsmsx158.amr.corp.intel.com (10.18.116.75) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 15 Jan 2019 20:24:37 -0800
Received: from bgsmsx104.gar.corp.intel.com ([169.254.5.227]) by
 BGSMSX151.gar.corp.intel.com ([169.254.3.74]) with mapi id 14.03.0415.000;
 Wed, 16 Jan 2019 09:54:30 +0530
From:   "Gopal, Saranya" <saranya.gopal@intel.com>
To:     Nikolay Yakimov <root@livid.pp.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] USB: Fix configuration selection issues introduced in
 v4.20.0
Thread-Topic: [PATCH] USB: Fix configuration selection issues introduced in
 v4.20.0
Thread-Index: AQHUrO1tcNtp2QCCK0m5HD3lqJDdwKWxQnqw
Date:   Wed, 16 Jan 2019 04:24:30 +0000
Message-ID: <C672AA6DAAC36042A98BAD0B0B25BDA94CB280EC@BGSMSX104.gar.corp.intel.com>
References: <20190115161354.6806-1-root@livid.pp.ru>
In-Reply-To: <20190115161354.6806-1-root@livid.pp.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDg5YjYxOTItMjkwMC00YjZkLWI5ZDctYWM2ODk3YjRlNWRmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiblZDTDZzNGE3WWs4RTI5Q3d2ZHFqQUZ2dnhRMGpqcEhTNlh2XC9DTmlLNUlVNnNCb3pxbFJNcG00ZFRZbk5QWkEifQ==
x-originating-ip: [10.223.10.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yakimov,

As per UAC3 configuration, the first configuration will always be backward-compatible.
So, there cannot be any UAC3-compatible device which has first configuration as UAC3.
And secondly, the commit ff2a8c532c14 does not break the pre-existing logic.
I also thought so much about moving the code above Ethernet check while preparing ff2a8c532c14.
But, then, it doesn't break the existing logic and so decided against moving it.

Thanks,
Saranya
> -----Original Message-----
> From: Nikolay Yakimov [mailto:root@livid.pp.ru]
> Sent: Tuesday, January 15, 2019 9:44 PM
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Nikolay Yakimov <root@livid.pp.ru>; Gopal, Saranya
> <saranya.gopal@intel.com>; linux-usb@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH] USB: Fix configuration selection issues introduced in v4.20.0
> 
> Commit f13912d3f014a introduced changes to the usb_choose_configuration
> function
> to better support USB Audio UAC3-compatible devices. However, there are a
> few
> problems with this patch. First of all, it adds new "if" clauses in the middle
> of an existing "if"/"else if" tree, which obviously breaks pre-existing logic.
> Secondly, since it continues iterating over configurations in one of the branches,
> other code in the loop can choose an unintended configuration. Finally,
> if an audio device's first configuration is UAC3-compatible, and there
> are multiple UAC3 configurations, the second one would be chosen, due to
> the first configuration never being checked for UAC3-compatibility.
> 
> Commit ff2a8c532c14 tries to fix the second issue, but it goes about it in a
> somewhat unnecessarily convoluted way, in my opinion, and does nothing
> to fix the first or the last one.
> 
> This patch tries to rectify problems described by essentially rewriting
> code introduced in f13912d3f014a. Notice the code was moved to *before*
> the "if"/"else if" tree.
> 
> Signed-off-by: Nikolay Yakimov <root@livid.pp.ru>
> ---
>  drivers/usb/core/generic.c | 44 ++++++++++++++++++++++----------------
>  1 file changed, 25 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/usb/core/generic.c b/drivers/usb/core/generic.c
> index f713cecc1f41..1ac9c1e5f773 100644
> --- a/drivers/usb/core/generic.c
> +++ b/drivers/usb/core/generic.c
> @@ -118,6 +118,31 @@ int usb_choose_configuration(struct usb_device
> *udev)
>  			continue;
>  		}
> 
> +		/*
> +		 * Select first configuration as default for audio so that
> +		 * devices that don't comply with UAC3 protocol are supported.
> +		 * But, still iterate through other configurations and
> +		 * select UAC3 compliant config if present.
> +		 */
> +		if (desc && is_audio(desc)) {
> +			/* Always prefer the first found UAC3 config */
> +			if (is_uac3_config(desc)) {
> +				best = c;
> +				break;
> +			}
> +
> +			/* If there is no UAC3 config, prefer the first config */
> +			else if (i == 0)
> +				best = c;
> +
> +			/* Unconditional continue, because the rest of the code
> +			 * in the loop is irrelevant for audio devices, and
> +			 * because it can reassign best, which for audio devices
> +			 * we don't want.
> +			 */
> +			continue;
> +		}
> +
>  		/* When the first config's first interface is one of Microsoft's
>  		 * pet nonstandard Ethernet-over-USB protocols, ignore it
> unless
>  		 * this kernel has enabled the necessary host side driver.
> @@ -132,25 +157,6 @@ int usb_choose_configuration(struct usb_device
> *udev)
>  #endif
>  		}
> 
> -		/*
> -		 * Select first configuration as default for audio so that
> -		 * devices that don't comply with UAC3 protocol are supported.
> -		 * But, still iterate through other configurations and
> -		 * select UAC3 compliant config if present.
> -		 */
> -		if (i == 0 && num_configs > 1 && desc && is_audio(desc)) {
> -			best = c;
> -			continue;
> -		}
> -
> -		if (i > 0 && desc && is_audio(desc)) {
> -			if (is_uac3_config(desc)) {
> -				best = c;
> -				break;
> -			}
> -			continue;
> -		}
> -
>  		/* From the remaining configs, choose the first one whose
>  		 * first interface is for a non-vendor-specific class.
>  		 * Reason: Linux is more likely to have a class driver
> --
> 2.20.1

