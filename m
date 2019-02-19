Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADABC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248F221904
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfBSHsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:48:11 -0500
Received: from mga01.intel.com ([192.55.52.88]:22919 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727233AbfBSHsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:48:10 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2019 23:48:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,387,1544515200"; 
   d="scan'208";a="147957512"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 18 Feb 2019 23:48:07 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 19 Feb 2019 09:48:06 +0200
Date:   Tue, 19 Feb 2019 09:48:06 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH -next] usb: typec: mux: Fix unsigned comparison with less
 than zero
Message-ID: <20190219074806.GC1626@kuha.fi.intel.com>
References: <20190219065750.9004-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219065750.9004-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 02:57:50PM +0800, YueHaibing wrote:
> The return from the call to fwnode_property_read_u16_array is int, 
> it can be a negative error code however this is being assigned to
> an size_t variable 'nval', hence the check is always false.
> Fix this by making 'nval' an int.
> 
> Detected by Coccinelle ("Unsigned expression compared with
> zero: nval < 0")
> 
> Fixes: 96a6d031ca99 ("usb: typec: mux: Find the muxes by also matching against the device node")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/mux.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
> index a5947d9..54d7497 100644
> --- a/drivers/usb/typec/mux.c
> +++ b/drivers/usb/typec/mux.c
> @@ -126,7 +126,7 @@ static void *typec_mux_match(struct device_connection *con, int ep, void *data)
>  {
>  	const struct typec_altmode_desc *desc = data;
>  	struct typec_mux *mux;
> -	size_t nval;
> +	int nval;
>  	bool match;
>  	u16 *val;
>  	int i;

thanks,

-- 
heikki
