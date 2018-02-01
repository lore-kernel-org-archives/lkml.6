Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2578270-1517463190-2-8915070382965763016
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517463189; b=WxTzhhGoNkkLad56fsLMVrU5iui0ylmy6pGoJLzVpFcBz9d
    /mC1rnv0Ek3jPIJQ/F27A7zEDvdDB0mxWmfukIGM14Ryyf1PlIFa3RXWsrm1UmlE
    WUtj5vcbQsM2NlmQjo8yWMBpdtYxV7inzXqDuhNK46knu2Ls+WCNY5mp7dR4gzCI
    H+rwO8tRdjpXnqMLNyL/pTNuMOs9YsQc8gim+q028Zu+x3QFQBqLBMORHTla4hea
    /qi8Ubi9OeFzLnNQpo0J1OSmgh0rUEHPHtotPu92MuwevTR9Dx/IpB4BYwPjar1r
    8alc6CMCr97vBOL+w4TLgqDMr2k56v5V9QgKzQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517463189; bh=72MmgBJDzzxcv9WKaewJqu7O2U
    6U/y+Kv6eReHRFRsE=; b=IIGptOv1vZ8q2vXXpAHxTc6t0kJ78fJ0mxfgaXS4d/
    YocliDiV3ILGqZTUjluU6naoLTNfYCcMmVcwj00OkrICrMU+zmJfxck5FY1XQtSM
    rOeBUYi554sDmJx7ymhHuL9twD+jcZFMMzN4aCyUUCfIOW2uqecmPx1xvbv/MI85
    wX8rpZbuARoHjbC8+ivkrIN4xSNBC+e5IW6MRHMXO0ybuoD1cm2fllmv2WbENI5h
    NUSB9e40oOYDJRD98CBw+o3EJ3LZku1uSHa66PaYvEidSk0QC14NNFdFABuWEaa4
    c0JybA8zeAV5EthlP83LVse3QkxygmdLHz31KPJ+pqng==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750985AbeBAFdG (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 00:33:06 -0500
Received: from mga05.intel.com ([192.55.52.43]:8155 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750936AbeBAFdG (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 1 Feb 2018 00:33:06 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,443,1511856000";
   d="scan'208";a="200310304"
Date: Thu, 1 Feb 2018 13:23:45 +0800
From: Wu Hao <hao.wu@intel.com>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>
Subject: Re: [PATCH v3 16/21] fpga: dfl: add fpga region platform driver for
 FME
Message-ID: <20180201052345.GA10393@hao-dev>
References: <1511764948-20972-1-git-send-email-hao.wu@intel.com>
 <1511764948-20972-17-git-send-email-hao.wu@intel.com>
 <CANk1AXTBprjzr71xa=YD5jR77822xugVEQMboxhzAJFY8YFMxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXTBprjzr71xa=YD5jR77822xugVEQMboxhzAJFY8YFMxw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Jan 31, 2018 at 02:46:28PM -0600, Alan Tull wrote:
> On Mon, Nov 27, 2017 at 12:42 AM, Wu Hao <hao.wu@intel.com> wrote:
> 
> Hi Hao,
> 
> Just fix the SPDX, otherwise it looks good.

Sure, will fix it. Thanks for the review. :)

Thanks
Hao

> 
> > This patch adds fpga region platform driver for FPGA Management Engine.
> > It register an fpga region with given fpga manager / bridge device.
> >
> > Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> > Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> > Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> > Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> Acked-by: Alan Tull <atull@kernel.org>
> 
> 
> > diff --git a/drivers/fpga/fpga-dfl-fme-region.c b/drivers/fpga/fpga-dfl-fme-region.c
> > new file mode 100644
> > index 0000000..0b988ab
> > --- /dev/null
> > +++ b/drivers/fpga/fpga-dfl-fme-region.c
> > @@ -0,0 +1,92 @@
> > +/*
> > + * FPGA Region Driver for FPGA Management Engine (FME)
> > + *
> > + * Copyright (C) 2017 Intel Corporation, Inc.
> > + *
> > + * Authors:
> > + *   Wu Hao <hao.wu@intel.com>
> > + *   Joseph Grecco <joe.grecco@intel.com>
> > + *   Enno Luebbers <enno.luebbers@intel.com>
> > + *   Tim Whisonant <tim.whisonant@intel.com>
> > + *   Ananda Ravuri <ananda.ravuri@intel.com>
> > + *   Henry Mitchel <henry.mitchel@intel.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL version 2.
> > + * SPDX-License-Identifier: GPL-2.0
> > + */
> > +
> > +#include <linux/module.h>
> 
> Thanks,
> Alan
