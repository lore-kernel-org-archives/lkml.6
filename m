Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5204C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9034421479
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbfBRIv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:51:29 -0500
Received: from mga12.intel.com ([192.55.52.136]:33430 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbfBRIv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:51:28 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2019 00:51:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,384,1544515200"; 
   d="scan'208";a="147713706"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 18 Feb 2019 00:51:25 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 18 Feb 2019 10:51:24 +0200
Date:   Mon, 18 Feb 2019 10:51:24 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Chen Yu <chenyu56@huawei.com>, Jun Li <jun.li@nxp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/9] device connection: Add support for device graphs
Message-ID: <20190218085124.GA1605@kuha.fi.intel.com>
References: <20190213074557.66028-1-heikki.krogerus@linux.intel.com>
 <20190214101043.GA4316@kroah.com>
 <20190215124715.GA10182@kuha.fi.intel.com>
 <20190218080727.GA21246@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218080727.GA21246@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 09:07:27AM +0100, Greg Kroah-Hartman wrote:
> On Fri, Feb 15, 2019 at 02:47:15PM +0200, Heikki Krogerus wrote:
> > Hi Greg,
> > 
> > On Thu, Feb 14, 2019 at 11:10:44AM +0100, Greg Kroah-Hartman wrote:
> > > On Wed, Feb 13, 2019 at 10:45:48AM +0300, Heikki Krogerus wrote:
> > > > Hi,
> > > > 
> > > > This is the third version of my proposal to add device graph parsing
> > > > to the device connection API. There was only one problem reported in
> > > > v2 by Jun - kernel-doc entry was missing for the new fwnode member in
> > > > struct usb_role_switch_desc - and it's now fixed.
> > > > 
> > > > The second version of the series:
> > > > https://lkml.org/lkml/2019/1/30/622
> > > > 
> > > > The commit message from v1:
> > > > 
> > > > This series adds support for OF and ACPI device graph parsing to the
> > > > device connection API.
> > > > 
> > > > Handling the graph is straightforward, but because I'm adding that
> > > > fwnode member to struct device_connection, I had to make sure all the
> > > > existing users consider it.
> > > > 
> > > > The plan is to only support matching with fwnode in the future, so no
> > > > more device name matching. The software fwnodes that we now have in
> > > > kernel should make that possible, once we add support for references
> > > > to them.
> > > > 
> > > > The original RFC:
> > > > https://lkml.org/lkml/2018/10/24/619
> > > 
> > > All now merged, thanks.
> > 
> > It looks like you have not followed the order of the patches in this
> > series.
> > 
> > You applied at least the patch 4/9 ("device connection: Add fwnode
> > member to struct device_connection") as the last patch to your
> > usb-next branch. The rest of the series, patches starting from 5/9,
> > depend on that patch.
> 
> Ugh, did I just apply them out of order?  I can't rewrite my tree now,
> sorry about that, odd that my sorting didn't work.
> 
> I think all of the patches are now in the tree, so I didn't miss
> anything, is there anything I can do now?  Want me to revert them and
> then add them back in the correct order?

The problem is with bisecting, so I'm not sure if reverting helps. I
don't think there's anything else that can be done about this now.


thanks,

-- 
heikki
