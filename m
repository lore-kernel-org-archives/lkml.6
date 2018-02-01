Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2638020-1517462438-2-12522729663306293819
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
    t=1517462438; b=BeC16JiRvkI1TinTKAY4zsY8zfkLZhFIN0S5F4ffqFtmU1c
    N85iSSDQTOAojFO8tOIYi1tVw1cvbFB3CXoZwjNNS3FgiQKYp4h1TePm8BKDFzRr
    DKPFq1lBZKz5lDyuA+3VSIMPKQHGaPOW4DKtB9XaPF4aTs5nEv4U4WnNS8DTsvvb
    CoCJgW9OlrHrvrQM7WEI6MKeaz9WxuQ/W1VXZGlVNd/Bs/KVD6WL6Yz6Y0pNl8+3
    RFbcdkifPbvc+gsMN2Nn3n515H93ChCNu9sXUsMIlXdTeVH4t66RDJnUHYUYss2q
    KMEo2ThyvGlthk7KLXLnm5C1tvlScZuO1kqsuNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517462438; bh=B7xpUkhMcotkqirBiSqToWdrH1
    bMbUR+kP9mxpGYARA=; b=R+yOxDHLWQ+dkRBNn2Qs6XhUtW5LTFR2tb1EVMuEFh
    o/YRiTh38Bxfvdk/UcWnOazmJg7Yi10wZIXJNSsmVAx1h73zTtXlY6mcZp4fMcc3
    TK7yp7JPvs6bX+Thtz3GpSPfcAtvD88sLsb4ghGI6EWFs+g2OXVcKI0R5cOmhKqE
    6ACUdOBhcljo5FOdYCBOyOIwEV/cnApGasfdc9MOugujCgJoc5I/18Cpv+dN9r/+
    LioACK73Kq2JcygJYcw5JSvesIrXWQIOWChtt4bv8A0Qo37RM5b2loffcqxlmijF
    lDBV0pHh8JTKTfNCyykDgadCWj24IwRJZpLktWodNOJw==
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
        id S1751505AbeBAFUd (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 00:20:33 -0500
Received: from mga07.intel.com ([134.134.136.100]:15440 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750978AbeBAFUb (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 1 Feb 2018 00:20:31 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,443,1511856000";
   d="scan'208";a="24041532"
Date: Thu, 1 Feb 2018 13:11:07 +0800
From: Wu Hao <hao.wu@intel.com>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Subject: Re: [PATCH v3 12/21] fpga: dfl: fme: add
 FPGA_GET_API_VERSION/CHECK_EXTENSION ioctls support
Message-ID: <20180201051107.GB10273@hao-dev>
References: <1511764948-20972-1-git-send-email-hao.wu@intel.com>
 <1511764948-20972-13-git-send-email-hao.wu@intel.com>
 <CANk1AXT4OiH=Wj3o5AjsS7DiUitudMetVu860Qz1RjodDfM18g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXT4OiH=Wj3o5AjsS7DiUitudMetVu860Qz1RjodDfM18g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Jan 31, 2018 at 09:31:59AM -0600, Alan Tull wrote:
> On Mon, Nov 27, 2017 at 12:42 AM, Wu Hao <hao.wu@intel.com> wrote:
> 
> Hi Hao,
> 
> One fix again, otherwise please add my ack to subsequent versions.

Sure. Thanks for the review.

> 
> > FPGA_GET_API_VERSION and FPGA_CHECK_EXTENSION ioctls are common ones which
> > need to be supported by all feature devices drivers including FME and AFU.
> > Userspace application can use these ioctl interfaces to get the API info
> > and check if specific extension is supported or not in current driver.
> >
> > This patch implements above 2 ioctls in FPGA Management Engine (FME)
> > driver.
> >
> > Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> > Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> > Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> > Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> > Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> 
> Acked-by: Alan Tull <atull@kernel.org>
> 
> > diff --git a/include/uapi/linux/fpga-dfl.h b/include/uapi/linux/fpga-dfl.h
> > new file mode 100644
> > index 0000000..b46d124
> > --- /dev/null
> > +++ b/include/uapi/linux/fpga-dfl.h
> > @@ -0,0 +1,50 @@
> > +/*
> > + * Header File for FPGA DFL User API
> > + *
> > + * Copyright (C) 2017 Intel Corporation, Inc.
> > + *
> > + * Authors:
> > + *   Kang Luwei <luwei.kang@intel.com>
> > + *   Zhang Yi <yi.z.zhang@intel.com>
> > + *   Wu Hao <hao.wu@intel.com>
> > + *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL version 2.
> 
> Please remove above line.  My understanding is that we are supposed to
> not combine SPDX with other license statements.
> 
> > + * SPDX-License-Identifier: GPL-2.0
> > + */
> 
> // SPDX-License-Identifier: GPL-2.0
> 
> As first line of file.

Sure, I will fix this in the next version.

Thanks
Hao

> 
> Thanks,
> Alan
