Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7E8C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58C82084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbfBLLZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 06:25:00 -0500
Received: from mga12.intel.com ([192.55.52.136]:36639 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728993AbfBLLY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 06:24:56 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 03:24:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,361,1544515200"; 
   d="scan'208";a="146162956"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 12 Feb 2019 03:24:53 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 12 Feb 2019 13:24:52 +0200
Date:   Tue, 12 Feb 2019 13:24:52 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Jun Li <jun.li@nxp.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Chen Yu <chenyu56@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 6/9] usb: roles: Find the muxes by also matching
 against the device node
Message-ID: <20190212112452.GC32070@kuha.fi.intel.com>
References: <20190130160259.46919-1-heikki.krogerus@linux.intel.com>
 <20190130160259.46919-7-heikki.krogerus@linux.intel.com>
 <VI1PR04MB4558283CA9D752D5452FA09989640@VI1PR04MB4558.eurprd04.prod.outlook.com>
 <20190211104629.GE16987@kuha.fi.intel.com>
 <VI1PR04MB4558F4F7BC10D82FC1BE71B489650@VI1PR04MB4558.eurprd04.prod.outlook.com>
 <20190212085033.GB32070@kuha.fi.intel.com>
 <VI1PR04MB45581A938E8BC3FA50960A7589650@VI1PR04MB4558.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB45581A938E8BC3FA50960A7589650@VI1PR04MB4558.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 12, 2019 at 10:41:28AM +0000, Jun Li wrote:
> > @@ -32,6 +32,7 @@ typedef enum usb_role (*usb_role_switch_get_t)(struct
> > device *dev);
> >   * usb_role_switch_register() before registering the switch.
> >   */
> >  struct usb_role_switch_desc {
> > +	struct fwnode_handle *fwnode;
> You may add some description for this new member
> /**
>  * struct usb_role_switch_desc - USB Role Switch Descriptor
>  * @ fwnode 

You are correct. I need to fix that one.

thanks,

-- 
heikki
