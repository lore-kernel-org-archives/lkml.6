Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E25C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C552146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbfBSOpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:45:41 -0500
Received: from mga14.intel.com ([192.55.52.115]:35668 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbfBSOpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 09:45:41 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 06:45:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="148047966"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 19 Feb 2019 06:45:38 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 19 Feb 2019 16:45:38 +0200
Date:   Tue, 19 Feb 2019 16:45:38 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] usb: typec: mux: remove redundant check on
 variable match
Message-ID: <20190219144538.GA27637@kuha.fi.intel.com>
References: <20190219134333.10142-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219134333.10142-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 01:43:33PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> All the code paths that lead to the return statement are where
> match is always true, hence the check to see if it is true is
> redundant and can be removed.
> 
> Detected by CoverityScan, CID#14769672 ("Logically dead code")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/mux.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
> index a5947d98824d..b94e2920eb38 100644
> --- a/drivers/usb/typec/mux.c
> +++ b/drivers/usb/typec/mux.c
> @@ -184,7 +184,7 @@ static void *typec_mux_match(struct device_connection *con, int ep, void *data)
>  		if (dev_fwnode(mux->dev) == con->fwnode)
>  			return mux;
>  
> -	return match ? ERR_PTR(-EPROBE_DEFER) : NULL;
> +	return ERR_PTR(-EPROBE_DEFER);
>  }
>  
>  /**
> -- 
> 2.20.1

thanks,

-- 
heikki
