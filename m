Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED11C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 06:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E155F20882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 06:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="g+3P7mPZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="g+3P7mPZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E155F20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbeIMLry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 07:47:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41214 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbeIMLrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 07:47:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D887D6083E; Thu, 13 Sep 2018 06:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536820788;
        bh=fHhFfgAbL28dDVVHDInBJ66EHSgFhUlG1KpXWpprjng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g+3P7mPZntVM/lH7izj8pLiiE5/j5Altb8PjBFmEq4jXW3UOxvoWg2cEMSWggY7cq
         xlVtFuigEhCeCfsDhoUS65SKHUJZaPAmaSssTnx5XF1y5HfSAMZEWcXMfOWCZdsAwx
         2vWD1PY8E5pDonPp9x1gSYuyPHtrumGD3Q2d0T0Q=
Received: from jackp-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jackp@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2C8F360452;
        Thu, 13 Sep 2018 06:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536820788;
        bh=fHhFfgAbL28dDVVHDInBJ66EHSgFhUlG1KpXWpprjng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g+3P7mPZntVM/lH7izj8pLiiE5/j5Altb8PjBFmEq4jXW3UOxvoWg2cEMSWggY7cq
         xlVtFuigEhCeCfsDhoUS65SKHUJZaPAmaSssTnx5XF1y5HfSAMZEWcXMfOWCZdsAwx
         2vWD1PY8E5pDonPp9x1gSYuyPHtrumGD3Q2d0T0Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2C8F360452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jackp@codeaurora.org
Date:   Wed, 12 Sep 2018 23:39:43 -0700
From:   Jack Pham <jackp@codeaurora.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] typec: tcpm: Add option to maintain current limit at
 Vsafe5V
Message-ID: <20180913063943.GA13306@jackp-linux.qualcomm.com>
References: <20180913021113.18150-1-badhri@google.com>
 <20180913021113.18150-2-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913021113.18150-2-badhri@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Badhri,

On Wed, Sep 12, 2018 at 07:11:13PM -0700, Badhri Jagan Sridharan wrote:
> During hard reset, TCPM turns off the charging path.
> The spec provides an option for Sink to either drop to vSafe5V or vSafe0V.

This doesn't make sense. By definition the sink isn't sourcing VBUS, so
how can it control whether to allow the voltage to be 5V or 0V?

> From USB_PD_R3_0
> 2.6.2 Sink Operation
> ..
> Serious errors are handled by Hard Reset Signaling issued by either Port
> Partner. A Hard Reset:
> resets protocol as for a Soft Reset but also returns the power supply to
> USB Default Operation (vSafe0V or vSafe5V output) in order to protect the
> Sink.

I can see how the wording here "vSafe0V *or* vSafe5V" is misleading, as
I think it actually is both. In later parts of the spec, the source's
VBUS behavior is well defined in that it must first drop to vSafe0V
and then return to vSafe5V. Please refer to section 7.1.5.

> Add a config option to tcpc_dev and let the device specific driver decide
> what needs to be done.
> 
> Signed-off-by: Badhri Jagan Sridharan <Badhri@google.com>
> ---
>  drivers/usb/typec/tcpm.c | 7 ++++++-
>  include/linux/usb/tcpm.h | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
> index a4e0c027a2a9..350d1a7c4543 100644
> --- a/drivers/usb/typec/tcpm.c
> +++ b/drivers/usb/typec/tcpm.c
> @@ -3269,7 +3269,12 @@ static void run_state_machine(struct tcpm_port *port)
>  	case SNK_HARD_RESET_SINK_OFF:
>  		memset(&port->pps_data, 0, sizeof(port->pps_data));
>  		tcpm_set_vconn(port, false);
> -		tcpm_set_charge(port, false);
> +		if (port->tcpc->config->vsafe_5v_hard_reset)

Therefore I think this config option doesn't make sense.

> +			tcpm_set_current_limit(port,
> +					       tcpm_get_current_limit(port),
> +					       5000);

But I do think this might still be useful at least in ensuring the sink
returns to drawing only default power during the transition before
re-establishing a contract. Given that the sink can't control when
exactly VBUS will go to 0V, is it ok to call set_current_limit() even if
VBUS is momentarily 0V, so at least it is in preparation for when VBUS
turns back on? Or would it be safer to do it during the
SNK_HARD_RESET_SINK_ON state after we know VBUS is back to vSafe5V?

> +		else
> +			tcpm_set_charge(port, false);

Regards,
Jack
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
