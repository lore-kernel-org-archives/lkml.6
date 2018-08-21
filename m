Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098D7C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB32F20895
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB32F20895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbeHUQmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 12:42:54 -0400
Received: from mga04.intel.com ([192.55.52.120]:6092 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbeHUQmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 12:42:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2018 06:22:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,269,1531810800"; 
   d="scan'208";a="83209653"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 21 Aug 2018 06:22:28 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 21 Aug 2018 16:22:27 +0300
Date:   Tue, 21 Aug 2018 16:22:27 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans de Goede <hdegoede@redhat.com>, Li Jun <jun.li@nxp.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, support.opensource@diasemi.com
Subject: Re: [PATCH 3/3] usb: typec: fusb302: Populate tcpc fwnode for TCPM
 property handling
Message-ID: <20180821132227.GB31230@kuha.fi.intel.com>
References: <cover.1534853047.git.Adam.Thomson.Opensource@diasemi.com>
 <5ab35968fea28abb54326423523af38dd887ddcc.1534853047.git.Adam.Thomson.Opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ab35968fea28abb54326423523af38dd887ddcc.1534853047.git.Adam.Thomson.Opensource@diasemi.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 01:28:23PM +0100, Adam Thomson wrote:
> This update populates the tcpc handle's fwnode pointer with the
> child usb-connector node, if it exists, so that TCPM can perform
> generic property handling to define the ports capabilities.
> 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/fusb302/fusb302.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/typec/fusb302/fusb302.c b/drivers/usb/typec/fusb302/fusb302.c
> index 82bed98..1b464c9 100644
> --- a/drivers/usb/typec/fusb302/fusb302.c
> +++ b/drivers/usb/typec/fusb302/fusb302.c
> @@ -1736,6 +1736,9 @@ static int fusb302_probe(struct i2c_client *client,
>  	chip->tcpc_dev.config = &chip->tcpc_config;
>  	mutex_init(&chip->lock);
>  
> +	chip->tcpc_dev.fwnode =
> +		device_get_named_child_node(dev, "connector");
> +
>  	if (!device_property_read_u32(dev, "fcs,operating-sink-microwatt", &v))
>  		chip->tcpc_config.operating_snk_mw = v / 1000;

Thanks,

-- 
heikki
