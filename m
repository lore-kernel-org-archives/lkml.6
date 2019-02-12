Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTTP_ESCAPED_HOST,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD0FC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237E72083B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbfBLLbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 06:31:21 -0500
Received: from mga17.intel.com ([192.55.52.151]:32556 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbfBLLbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 06:31:21 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 03:31:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,361,1544515200"; 
   d="scan'208";a="146163989"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 12 Feb 2019 03:31:17 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 12 Feb 2019 13:31:16 +0200
Date:   Tue, 12 Feb 2019 13:31:16 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Jun Li <jun.li@nxp.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Chen Yu <chenyu56@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/9] device connection: Add support for device graphs
Message-ID: <20190212113116.GD32070@kuha.fi.intel.com>
References: <20190130160259.46919-1-heikki.krogerus@linux.intel.com>
 <VI1PR04MB4558A1B67430533C843EA47D89650@VI1PR04MB4558.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI1PR04MB4558A1B67430533C843EA47D89650@VI1PR04MB4558.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 10:44:35AM +0000, Jun Li wrote:
> Hi
> > -----Original Message-----
> > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Sent: 2019年1月31日 0:03
> > To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Andy Shevchenko <andy.shevchenko@gmail.com>; Chen Yu
> > <chenyu56@huawei.com>; Jun Li <jun.li@nxp.com>; Hans de Goede
> > <hdegoede@redhat.com>; linux-usb@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: [PATCH v2 0/9] device connection: Add support for device graphs
> > 
> > Hi,
> > 
> > This is the second version of this series. On top the two code style improvements
> > requested by Andy, I also renamed the connection identifiers used with the USB
> > Type-C muxes for something that I felt are better, especially after we start using
> > them to name reference device properties in fwnodes. That's why the first patch is
> > now split in two, 1/9 and 3/9.
> > 
> > Hans! Please note that there is no functional change. The alt mode device is still
> > getting a handle to the mux, just like before.
> > That was actually happening also in the first version of the series.
> > 
> > The commit message from v1:
> > 
> > This series adds support for OF and ACPI device graph parsing to the device
> > connection API.
> > 
> > Handling the graph is straightforward, but because I'm adding that fwnode member
> > to struct device_connection, I had to make sure all the existing users consider it.
> > 
> > The plan is to only support matching with fwnode in the future, so no more device
> > name matching. The software fwnodes that we now have in kernel should make that
> > possible, once we add support for references to them.
> > 
> > The original RFC:
> > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%
> > 2Flkml%2F2018%2F10%2F24%2F619&amp;data=02%7C01%7Cjun.li%40nxp.co
> > m%7C2fd7c8c28d67434354be08d686cc6b55%7C686ea1d3bc2b4c6fa92cd99c5c
> > 301635%7C0%7C0%7C636844609858846167&amp;sdata=AWDD9WaO%2BXxM
> > Izlli6GUNEq%2FqUpa5hSyLbBsjICdLIo%3D&amp;reserved=0
> > 
> > thanks,
> > 
> > Heikki Krogerus (9):
> >   platform/x86: intel_cht_int33fe: Prepare for better mux naming scheme
> >   usb: typec: Rationalize the API for the muxes
> >   platform/x86: intel_cht_int33fe: Remove old style mux connections
> >   device connection: Add fwnode member to struct device_connection
> >   usb: typec: mux: Find the muxes by also matching against the device
> >     node
> >   usb: roles: Find the muxes by also matching against the device node
> >   usb: typec: Find the ports by also matching against the device node
> >   device connection: Prepare support for firmware described connections
> >   device connection: Find device connections also from device graphs
> > 
> >  drivers/base/devcon.c                    | 62 ++++++++++++++-
> >  drivers/platform/x86/intel_cht_int33fe.c | 15 ++--
> >  drivers/usb/roles/class.c                | 21 +++++-
> >  drivers/usb/typec/class.c                | 31 ++++++--
> >  drivers/usb/typec/mux.c                  | 96 ++++++++++++++++++++----
> >  include/linux/device.h                   |  6 ++
> >  include/linux/usb/role.h                 |  1 +
> >  include/linux/usb/typec_mux.h            |  3 +-
> >  8 files changed, 195 insertions(+), 40 deletions(-)
> > 
> > --
> > 2.20.1
> 
> I tested this series on dwc3+typec, for usb role switch and typec switch common part
> Reviewed-by: Jun Li <jun.li@nxp.com>
> Tested-by: Jun Li <jun.li@nxp.com>

Thanks Jun.

I'm going to send one more version, and fix the description of the
struct usb_role_switch_desc like you proposed.

Since the fix will only add one comment line to the code, I'm going to
take the liberty to add your Reviewed-by and Tested-by tags this
time (I don't usually like to carry them to new versions of patches).
I'll do the same with the others.


thanks,

-- 
heikki
