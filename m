Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3374528-1525393582-2-14586069031976342096
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525393582; b=LZflzthexDlivGztvpXPfI3Scj+6WPYMdC3CEgu6H9rz/DDsGt
    JryMplsY1Ie2620wFVeluGWVMQpqs4d0cI0wdSz0N01N8YNNlGuN+buK3nPRvF1q
    tcOiI1rHohPjJ2WXtMIaf8RRsA1VelXFDWoIV2rJw3ub8yFxwiK6NxAURzfZrrK6
    iUKhzZCy0vGn5E7/18+uSWCrFaxYcxBwxvX5vxtwBJNsymlSYj08BiQijTPAt/Pi
    G37eH08Us0RXuU/MPKUHemRO977pO2f5WJPfW5LkIGJqsmeI2D3X2c+tt+O6C1tk
    T6LBGvySv+7/iIxzh40SpUccd3PXhiJOcMyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525393582; bh=sM3hjVxiAU8qL1nOelaZBP6+JHlGBC
    HIU+i2hbFiO3s=; b=QnTjuXZZ5ODgtTKFe/8B8UDmWNkD5KW4MkmfFY53ELBw/u
    ZIoqdBEKP8FiuuafLv7R8ZtBVCDYA3lVIPPPiDx3mG/4j3Ya6aP8vQ7kop9ecwOo
    u3OfiZBs3evFOvA0XhhcFfVgswgH+1XLRyX6m3kZL5072l5y4Zs9PdMltTyl+IxI
    gBc7z5cDj35ISI3Ws5G87bQQVWzNYanT9yWOeBGVNNOwe/YSa1oAy1zyOBqRSof4
    Wz4sR+70BqrzEvzV3e30YVL7p/bnTR6cZPzf8xJChg4lJemPwS1rKPg+17e2u0eZ
    uIdd0jxY6jawoiiyZk8ScbNC69ymvfIbP6INoy3g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJLIOoWZXFCzeY1XRkXtZVZxypHzS1hJAa5M1d3IfwAYke49ibhVMsqtxeJhneyiwmRE0YZuZfXw/U2OzIGUXmo5sIv6/gaLh6FEYPotZxaZYvk52auu
    7i8zVcbGrP/+ceLkwBeqCtQU2D7qXjMc9QAQ1oBl2bErSdPVJY+a++Oi1RTX+PVXh35w53qlYPRXJsyj5WFXM0xnvKlAAAPhLOS7U93qMKV00Z4/nCI3AUrv
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=p52eVAkfQVKo4GjskZ4A:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751161AbeEDA0K (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 20:26:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:41626 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750911AbeEDA0J (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 3 May 2018 20:26:09 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,360,1520924400";
   d="scan'208";a="38539275"
Date: Fri, 4 May 2018 08:15:28 +0800
From: Wu Hao <hao.wu@intel.com>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>
Subject: Re: [PATCH v5 00/28] FPGA Device Feature List (DFL) Device Drivers
Message-ID: <20180504001528.GA31101@hao-dev>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
 <CANk1AXSFQzBoZWQu4R9aYQSXFbr76UQ_-39ENe5hSOncKuDq+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXSFQzBoZWQu4R9aYQSXFbr76UQ_-39ENe5hSOncKuDq+A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 04:14:48PM -0500, Alan Tull wrote:
> On Tue, May 1, 2018 at 9:50 PM, Wu Hao <hao.wu@intel.com> wrote:
> > Hi All,
> >
> > Here is v5 patch-series adding drivers for FPGA DFL devices.
> >
> > This patch series provides a common framework to support FPGA Device Feature
> > List (DFL), and also feature dev drivers under this DFL framework to provide
> > interfaces for userspace applications to configure, enumerate, open, and
> > access FPGA accelerators on DFL based FPGA device and enables system level
> > management functions such as FPGA partial reconfiguration, power management
> > and virtualization.
> 
> Hi Hao,
> 

Hi Alan,

Thanks for your review on this patch set.

> I've started looking at your v5 here.  It's 5212 lines of code, so
> it's not tiny.
> 
> I see a lot of renaming from 'fpga' to 'dfl', thanks for doing that.
> 
> The main thing that stands out at first look is a new method of
> registering port ops.  It would be better if the fpga bridge framework
> were expanded or changed somehow to do that.  It's like we have two
> bridge frameworks now.

I only limit this change in DFL framework, because introduce a port ops
here to DFL framework is to resolve the hard dependency between DFL
driver modules (e.g DFL FME and port), this sounds like a DFL specific
thing, and I am not sure if there is some real need or benefit for other
non-DFL module, so i didn't modify the common fpga bridge code.

> 
> I see that there isn't a way of specifying which FPGA mgr driver to
> use, so dfl-fme-mgr.c is tied to dfl-fme-pr.c.  It would be better if
> the DFL could specify which fpga manager driver to use.

Hm.. I think we discussed this against v4. It could be a different sub
feature with different id to support different PR hardware.  In that
case, we could still reuse sub feature driver provided by dfl-fme-pr.c
(specify a new id which reuses the same pr_mgmt_ops)

        {
                 .id = FME_FEATURE_ID_PR_MGMT,
                 .ops = &pr_mgmt_ops,
        },

Inside dfl-fme-pr.c, it could parse the different id to create different
platform devices for different FPGA mgrs.

Could we leave this a later change? as i don't have a different hardware
like this at this moment (maybe future) and I don't see current framework
block us on reusing these code.

> 
> Maybe I'm repeating myself here, the biggest question I'm asking
> region, how much of this code can be reused?  I would hope that all of
> it could except for the fpga manager/bridge drivers.  That was the
> intent of the original FPGA framework.  

I fully understand that it's better to make code reusable, this is what
we are trying to do in these patchsets. But it's still not very clear that
who others or which products will use this DFL framework and how, what's
the difficulty they will face and what kind of help or changes we could
provide. so maybe we could defer some work when people really need it, if
there is no hard blocking issue on architecture level.

> I'll have more time next week to look in more depth.

Looking forward to your feedback. Thanks again for your review. :)

Hao

> 
> Alan
> 
