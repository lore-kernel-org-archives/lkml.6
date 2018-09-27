Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DEBC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D03C2159D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D03C2159D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbeI0RMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:12:51 -0400
Received: from mga11.intel.com ([192.55.52.93]:49926 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbeI0RMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:12:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2018 03:55:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,310,1534834800"; 
   d="scan'208";a="93767810"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 27 Sep 2018 03:54:44 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 27 Sep 2018 13:54:43 +0300
Date:   Thu, 27 Sep 2018 13:54:43 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        support.opensource@diasemi.com
Subject: Re: [PATCH 1/2] usb: typec: fusb302: Correct spelling mistake for
 toggling state
Message-ID: <20180927105443.GP11965@kuha.fi.intel.com>
References: <cover.1537975081.git.Adam.Thomson.Opensource@diasemi.com>
 <8ef602efbb7ee84ec86225ae4b9e1d138154e51b.1537975081.git.Adam.Thomson.Opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ef602efbb7ee84ec86225ae4b9e1d138154e51b.1537975081.git.Adam.Thomson.Opensource@diasemi.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 04:23:51PM +0100, Adam Thomson wrote:
> There's a typo in the enum name of the 'OFF' state for toggling
> (TOGGLINE instead of TOGGLING). This commit resolves that trivial
> spelling inconsistency.
> 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

Reviewed-by:  Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/fusb302.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> index 6e9370a..fd851d8 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -42,7 +42,7 @@
>  #define T_BC_LVL_DEBOUNCE_DELAY_MS 30
>  
>  enum toggling_mode {
> -	TOGGLINE_MODE_OFF,
> +	TOGGLING_MODE_OFF,
>  	TOGGLING_MODE_DRP,
>  	TOGGLING_MODE_SNK,
>  	TOGGLING_MODE_SRC,
> @@ -594,7 +594,7 @@ static int fusb302_set_toggling(struct fusb302_chip *chip,
>  	chip->intr_comp_chng = false;
>  	/* configure toggling mode: none/snk/src/drp */
>  	switch (mode) {
> -	case TOGGLINE_MODE_OFF:
> +	case TOGGLING_MODE_OFF:
>  		ret = fusb302_i2c_mask_write(chip, FUSB_REG_CONTROL2,
>  					     FUSB_REG_CONTROL2_MODE_MASK,
>  					     FUSB_REG_CONTROL2_MODE_NONE);
> @@ -626,7 +626,7 @@ static int fusb302_set_toggling(struct fusb302_chip *chip,
>  		break;
>  	}
>  
> -	if (mode == TOGGLINE_MODE_OFF) {
> +	if (mode == TOGGLING_MODE_OFF) {
>  		/* mask TOGDONE interrupt */
>  		ret = fusb302_i2c_set_bits(chip, FUSB_REG_MASKA,
>  					   FUSB_REG_MASKA_TOGDONE);
> @@ -702,7 +702,7 @@ static int tcpm_set_cc(struct tcpc_dev *dev, enum typec_cc_status cc)
>  		ret = -EINVAL;
>  		goto done;
>  	}
> -	ret = fusb302_set_toggling(chip, TOGGLINE_MODE_OFF);
> +	ret = fusb302_set_toggling(chip, TOGGLING_MODE_OFF);
>  	if (ret < 0) {
>  		fusb302_log(chip, "cannot stop toggling, ret=%d", ret);
>  		goto done;
> @@ -1292,7 +1292,7 @@ static int fusb302_handle_togdone_snk(struct fusb302_chip *chip,
>  		tcpm_cc_change(chip->tcpm_port);
>  	}
>  	/* turn off toggling */
> -	ret = fusb302_set_toggling(chip, TOGGLINE_MODE_OFF);
> +	ret = fusb302_set_toggling(chip, TOGGLING_MODE_OFF);
>  	if (ret < 0) {
>  		fusb302_log(chip,
>  			    "cannot set toggling mode off, ret=%d", ret);
> @@ -1388,7 +1388,7 @@ static int fusb302_handle_togdone_src(struct fusb302_chip *chip,
>  		tcpm_cc_change(chip->tcpm_port);
>  	}
>  	/* turn off toggling */
> -	ret = fusb302_set_toggling(chip, TOGGLINE_MODE_OFF);
> +	ret = fusb302_set_toggling(chip, TOGGLING_MODE_OFF);
>  	if (ret < 0) {
>  		fusb302_log(chip,
>  			    "cannot set toggling mode off, ret=%d", ret);
> -- 
> 1.9.1

-- 
heikki
