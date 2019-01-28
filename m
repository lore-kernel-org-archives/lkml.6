Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9E1C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158952147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfA1P2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:28:35 -0500
Received: from mga17.intel.com ([192.55.52.151]:5131 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfA1P2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:28:35 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2019 07:28:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,534,1539673200"; 
   d="scan'208";a="142040420"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 28 Jan 2019 07:28:31 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 28 Jan 2019 17:28:30 +0200
Date:   Mon, 28 Jan 2019 17:28:30 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen Yu <chenyu56@huawei.com>, Jun Li <jun.li@nxp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/8] usb: typec: Rationalize the API for the muxes
Message-ID: <20190128152830.GH7262@kuha.fi.intel.com>
References: <20190125131519.88416-1-heikki.krogerus@linux.intel.com>
 <20190125131519.88416-3-heikki.krogerus@linux.intel.com>
 <CAHp75VctbnJcLdTrGfPju708StpNPzmzTCBb-B-gmKZzOQwteg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VctbnJcLdTrGfPju708StpNPzmzTCBb-B-gmKZzOQwteg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 11:50:31AM +0200, Andy Shevchenko wrote:
> On Fri, Jan 25, 2019 at 3:18 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > We can replace the second parameter that is passed to the
> > typec_mux_get() function with alt mode description
> > structure, and simply pass NULL with accessory modes.
> >
> > With accessory modes there is no need for additional
> > identification (in practice the accessory mode can only be
> > Audio Accessory if muxing is needed), only with alternate
> > modes we need to identify the exact alternate mode.
> 
> > +struct typec_mux *typec_mux_get(struct device *dev,
> > +                               const struct typec_altmode_desc *desc)
> >  {
> >         struct typec_mux *mux;
> >
> >         mutex_lock(&mux_lock);
> > -       mux = device_connection_find_match(dev, name, NULL, typec_mux_match);
> > +       mux = device_connection_find_match(dev, "typec-mux", (void *)desc,
> > +                                          typec_mux_match);
> 
> Not related to this series, but shouldn't
> device_connection_find_match() be improved to avoid dropping const
> qualifier?

I'll see if we can do that already.

thanks,

-- 
heikki
