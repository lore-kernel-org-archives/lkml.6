Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A230C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DBA720862
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DBA720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbeG0JzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:55:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:16560 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729420AbeG0JzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:55:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jul 2018 01:34:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,408,1526367600"; 
   d="scan'208";a="57585674"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga007.fm.intel.com with ESMTP; 27 Jul 2018 01:34:12 -0700
Message-ID: <3e17e519a59e2a23669be054a44ded9ea90de088.camel@linux.intel.com>
Subject: Re: [PATCH] serial: 8250_dw: Add ACPI support for uart on Broadcom
 SoC
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, vikram.prakash@broadcom.com,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Date:   Fri, 27 Jul 2018 11:34:11 +0300
In-Reply-To: <1532664066-30056-1-git-send-email-srinath.mannam@broadcom.com>
References: <1532664066-30056-1-git-send-email-srinath.mannam@broadcom.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-27 at 09:31 +0530, Srinath Mannam wrote:
> Add ACPI identifier HID for UART DW 8250 on Broadcom SoCs
> to match the HID passed through ACPI tables to enable
> UART controller.
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Reviewed-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com
> >
> Tested-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>

One comment below, after addressing it,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> ---
>  drivers/tty/serial/8250/8250_dw.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c
> b/drivers/tty/serial/8250/8250_dw.c
> index aff04f1..7ea94ec 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -708,6 +708,7 @@ static const struct acpi_device_id
> dw8250_acpi_match[] = {
>  	{ "AMD0020", 0 },
>  	{ "AMDI0020", 0 },
>  	{ "HISI0031", 0 },
> +	{ "BRCM2032", 0 },

Let's keep this in order (yes, I know about INT* ones above, but that is
not related to this patch right now)

>  	{ },
>  };
>  MODULE_DEVICE_TABLE(acpi, dw8250_acpi_match);

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
