Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E19FC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC658205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC658205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbeJYP7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 11:59:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:37268 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbeJYP7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 11:59:40 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2018 00:28:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,423,1534834800"; 
   d="scan'208";a="102327310"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 25 Oct 2018 00:28:07 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 25 Oct 2018 10:28:05 +0300
Date:   Thu, 25 Oct 2018 10:28:05 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] driver core: Add fwnode member to struct
 device_connection
Message-ID: <20181025072805.GD2034@kuha.fi.intel.com>
References: <20181024150525.11552-1-heikki.krogerus@linux.intel.com>
 <20181024150525.11552-2-heikki.krogerus@linux.intel.com>
 <a00ff7d0-4cac-2454-7c12-7844aecb68f1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a00ff7d0-4cac-2454-7c12-7844aecb68f1@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 08:33:53AM -0700, Randy Dunlap wrote:
> On 10/24/18 8:05 AM, Heikki Krogerus wrote:
> > This will prepare the device connection API for connections
> > described in firmware.
> > 
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> >  include/linux/device.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index 90224e75ade4..a964a0d614fa 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -753,11 +753,17 @@ struct device_dma_parameters {
> >  
> >  /**
> >   * struct device_connection - Device Connection Descriptor
> > + * @fwnode: The device node of the connected device
> >   * @endpoint: The names of the two devices connected together
> >   * @id: Unique identifier for the connection
> >   * @list: List head, private, for internal use only
> > + *
> > + * NOTE: @fwnode is not used together with @endpoint. @fwnode is used when
> > + * platform firmware defines the connection. When the connection is registeded
> 
> for your next version:)                                                registered

OK.

thanks,

-- 
heikki
