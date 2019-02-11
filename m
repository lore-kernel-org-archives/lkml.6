Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C41DC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F56E20863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfBKIjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:39:35 -0500
Received: from mga17.intel.com ([192.55.52.151]:48867 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726930AbfBKIjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:39:35 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 00:39:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,358,1544515200"; 
   d="scan'208";a="145815851"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 11 Feb 2019 00:39:30 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 11 Feb 2019 10:39:29 +0200
Date:   Mon, 11 Feb 2019 10:39:29 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen Yu <chenyu56@huawei.com>, Jun Li <jun.li@nxp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 7/9] usb: typec: Find the ports by also matching
 against the device node
Message-ID: <20190211083929.GD16987@kuha.fi.intel.com>
References: <20190130160259.46919-1-heikki.krogerus@linux.intel.com>
 <20190130160259.46919-8-heikki.krogerus@linux.intel.com>
 <CAHp75Vdq+T4vKsihhUJjV85-mkWfY2G=npJLPaGiGjbzD_m32w@mail.gmail.com>
 <20190131133537.GA13072@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131133537.GA13072@kuha.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Thu, Jan 31, 2019 at 03:35:37PM +0200, Heikki Krogerus wrote:
> On Wed, Jan 30, 2019 at 06:51:56PM +0200, Andy Shevchenko wrote:
> > On Wed, Jan 30, 2019 at 6:03 PM Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> > >
> > > When the connections are defined in firmware, struct
> > > device_connection will have the fwnode member pointing to
> > > the device node (struct fwnode_handle) of the requested
> > > device, and the endpoint will not be used at all in that
> > > case.
> > 
> > > +       /*
> > > +        * FIXME: Check does the fwnode supports the requested SVID. If it does
> > > +        * we need to return ERR_PTR(-PROBE_DEFER) when there is no device.
> > > +        */
> > > +       if (con->fwnode)
> > > +               return class_find_device(typec_class, NULL, con->fwnode,
> > > +                                        typec_port_fwnode_match);
> > > +
> > > +       dev = class_find_device(typec_class, NULL, con->endpoint[ep],
> > > +                               typec_port_name_match);
> > > +
> > > +       return dev ? dev : ERR_PTR(-EPROBE_DEFER);
> > 
> > Just  to be clear, this one takes a reference on dev. Is it taken into account?
> 
> Yes. That is what we want it to do.

Gentle ping. Is the series OK?

thanks,

-- 
heikki
