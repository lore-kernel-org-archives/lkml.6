Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2638020-1517462708-2-9408753163121520494
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
    t=1517462707; b=ahzaGxKgNiADIV1ehI0ijBmiUCwSg6iMTOTXx/56iB2feCa
    L9tjNpFLPBazkadEtt+aQ9YJZ6bqgAAA6DZmRzCHRXQxvrsWCHekKeF5g6r4edi+
    MS4Lx2T9dAawTalHMvq2TxVRK1KQkE3fO9bTX/n+iByrYdTDXJNlRm8Z9JURsTZ+
    l/gsTOOXr8kjjKKdCYf8jOt/OBcH+4PI/+DOKQIn6Emc2FEk2Ike2o+zX2FXWt6G
    8G+JsgsqvOWjIK+T0hMmPCcVvklBRpXklQEL5B4OpIHhdZ6tdFgkA3V3qjmE9oP6
    dODugdsAfORBSPcvXDSH+G6if3vHBW7al/SnCJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517462707; bh=zmSwC14Hmgjjwi3AUOLZ1TvBvw
    iYL2f3ANTR+yFavRw=; b=fDkEetXmlLhm15318y1MlD1EmcbdwYYVLmMWw6PQ4b
    DDtwIlOoauXkisY3+Fc75icuo7V+uW38riI3ZkeMvEqqUudDY3ogdI8ybtt47G65
    P/b4yN3SI3Wifbvg7XI2CYrE9rx2t7NXzneIB7oGnf60gH8ucxgDcYsMArCL+O9q
    CuKqlCEOQ3EsY5EBkffwOaCVxWMurU+kmlwIl7h9w4pczpkKYBBT+KcMRugJhFi7
    mWNhN6v5x8074RGdpGpXZthNdWG7FJmManjxRMupssqjmCS/adh160W12fQ/YuPk
    RysP+q10Swna9VmK4k1cZV2lSFTy8zwol0jHap4EJZFg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750985AbeBAFZE (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 00:25:04 -0500
Received: from mga05.intel.com ([192.55.52.43]:7775 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750936AbeBAFZE (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 1 Feb 2018 00:25:04 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,443,1511856000";
   d="scan'208";a="200309045"
Date: Thu, 1 Feb 2018 13:15:43 +0800
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
Subject: Re: [PATCH v3 15/21] fpga: dfl: add fpga bridge platform driver for
 FME
Message-ID: <20180201051543.GC10273@hao-dev>
References: <1511764948-20972-1-git-send-email-hao.wu@intel.com>
 <1511764948-20972-16-git-send-email-hao.wu@intel.com>
 <CANk1AXS-ioW2svMS3QwrQCF5TiHp_nwaongC=d2Z2MfT8BEMMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXS-ioW2svMS3QwrQCF5TiHp_nwaongC=d2Z2MfT8BEMMw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Jan 31, 2018 at 09:16:58AM -0600, Alan Tull wrote:
> On Mon, Nov 27, 2017 at 12:42 AM, Wu Hao <hao.wu@intel.com> wrote:
> 
> Hi Hao,
> 
> One fix below.  Besides that, please add my ack.
> 
> > This patch adds fpga bridge platform driver for FPGA Management Engine.
> > It implements the enable_set call back for fpga bridge.
> >
> > Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> > Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> > Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> > Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> 
> Acked-by: Alan Tull <atull@kernel.org>
> 
> > diff --git a/drivers/fpga/fpga-dfl-fme-br.c b/drivers/fpga/fpga-dfl-fme-br.c
> > new file mode 100644
> > index 0000000..db2603b
> > --- /dev/null
> > +++ b/drivers/fpga/fpga-dfl-fme-br.c
> > @@ -0,0 +1,87 @@
> > +/*
> > + * FPGA Bridge Driver for FPGA Management Engine (FME)
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
> 
> If we're using the SPDX, then please get rid of the above line.
> 
> > + * SPDX-License-Identifier: GPL-2.0
> > + */
> 
> The SPDX line should be the first line of the file with a // (for .c
> files), please see:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/process/license-rules.rst
> 
> Same thing for other files.

Thanks for the review.

Sure, will fix this for all driver files in the next version.

Thanks
Hao

> 
> Alan
