Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1187135-1524489627-2-9353840363610621964
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524489626; b=DN16CXUyMHsumEhahjC24FL2i6jaEQQlWAbdxGWAAL/HZ2Y0ae
    16S+zT7U6gQBh3HcW9JZpLuZhb7nuzFPv5XpH///sx0BNGAS/b/kE7bJTvwlVaCv
    L7uhJiUehuic8bRkW8YTgt5YjkGJJ9NQmrhygoBkR2XUejV71J4RDe4XtM4se6EG
    lJ9DgzbyC5vQKObNEM+ndJWmfGCDVmRC+kgr09wnjefmbkKejkMMxIPrEjNMMD4P
    CJlyE1QXg4okepTZ5mY8J+2EB2OFFaPp/ayDchiCgsLdypEkhJHIe+hYqD1Acn8Z
    6A/7T3OQbPmYgUqi/WR5hDP3iAao4aorVf7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524489626; bh=BAwduiylb35o3ZW2r0Zr80JGXzYT1c
    HTK3yZhNC7QGA=; b=YSzztxK7acrLLVU0z91L+Mfex/7lLg1Ow5z/QirRHSVHAC
    lsDyF4P6jTY2yFlCNpPe3RFg66mVyKkRGxo2/Pm41WDAhYA31hLN0b1wzTVt99uA
    G2mAx4nY1XG4BNfuqyFojym40+YqeyMe3GU3aemoDiDrfCmX8HIsGIaQLEUr3J69
    yTXscRzWyepoKE3h9tYvuThvKS+cSXxMXxkOUq+cC6wlPWBEnoaKfkBHie0q9E3n
    kx2z/JnZ6ncdefr08AlRKZZ+nQItx2PppToMdM5KiaKWVHfTq80Shf9a5NeY0lxD
    rL1us+kF8p1oxvI05uXokSs+JMnDPxugd/y11tTQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHhZNzSviP7rGLTeFTTJxUAoQz1aTs8WzNLTZtngRBDwxfHSaGun/SQqYgZou55iwR296uUKMIWdEIB58p6yBTMIkhafdC9NUBtSBOjX05+PK92omK48
    gv3JDN+Dma/YoOTI0wwgZPR0xEOc8jCXR/tNvWjWaL1++aaLJZNviISaaeSBdztgSvqUriiM+KNXje/YW+oQl/5/3n6dzdj23YARW2GbV75CJdfRhUr1gXTc
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=X3a0BiUdAAAA:8 a=QyXUC8HyAAAA:8 a=_jlGtV7tAAAA:8 a=VwQbUJbxAAAA:8
    a=GRn4D3hxeF3T8L-P_xcA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=aWu3muFgq6otJbhCXpL5:22 a=nlm17XC03S6CtCLSeiRr:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754940AbeDWNUW (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 09:20:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33346 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754802AbeDWNUV (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 23 Apr 2018 09:20:21 -0400
Date: Mon, 23 Apr 2018 15:20:14 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: Re: [PATCH v7 1/6] typec: tcpm: Add core support for sink side PPS
Message-ID: <20180423132014.GB24093@kroah.com>
References: <cover.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
 <daf72dd237653e55c0485e930108c19a4996aa4f.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
 <20180422140508.GA21446@kroah.com>
 <2E89032DDAA8B9408CB92943514A0337014C1E6AAD@SW-EX-MBX01.diasemi.com>
 <2E89032DDAA8B9408CB92943514A0337014C1E6B41@SW-EX-MBX01.diasemi.com>
 <20180423082528.GA20868@kroah.com>
 <2E89032DDAA8B9408CB92943514A0337014C1E6D67@SW-EX-MBX01.diasemi.com>
 <20180423112818.GA22932@kroah.com>
 <2E89032DDAA8B9408CB92943514A0337014C1E6D83@SW-EX-MBX01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337014C1E6D83@SW-EX-MBX01.diasemi.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 12:47:47PM +0000, Adam Thomson wrote:
> On 23 April 2018 12:28, Greg Kroah-Hartman wrote:
> 
> > On Mon, Apr 23, 2018 at 11:06:25AM +0000, Adam Thomson wrote:
> > > On 23 April 2018 09:25, Greg Kroah-Hartman wrote:
> > >
> > > > On Mon, Apr 23, 2018 at 07:49:38AM +0000, Adam Thomson wrote:
> > > > > On 22 April 2018 21:58, Adam Thomson wrote:
> > > > >
> > > > > > On 22 April 2018 15:05, Greg Kroah-Hartman wrote:
> > > > > >
> > > > > > > On Fri, Mar 23, 2018 at 10:12:20AM +0000, Adam Thomson wrote:
> > > > > > > > This commit adds code to handle requesting of PPS APDOs. Switching
> > > > > > > > between standard PDOs and APDOs, and re-requesting an APDO to
> > > > > > > > modify operating voltage/current will be triggered by an
> > > > > > > > external call into TCPM.
> > > > > > > >
> > > > > > > > Signed-off-by: Adam Thomson
> > <Adam.Thomson.Opensource@diasemi.com>
> > > > > > > > Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > > > > > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > > > > > > > ---
> > > > > > > >  drivers/usb/typec/tcpm.c | 517
> > > > > > > ++++++++++++++++++++++++++++++++++++++++++++++-
> > > > > > > >  include/linux/usb/pd.h   |   4 +-
> > > > > > > >  include/linux/usb/tcpm.h |   1 +
> > > > > > > >  3 files changed, 509 insertions(+), 13 deletions(-)
> > > > > > >
> > > > > > > This patch adds build warnings to the tree, so I can't take it, sorry.
> > > > > > > Please fix up and resend.
> > > > > >
> > > > > > No problem. Sorry for that. Will take a look and resolve the warnings.
> > > > >
> > > > > Sadly this is going to be a bit more than 'resolve the warnings' task now as Jun
> > > > > Li's patch set has now made it in before me which means I need to rebase PDO
> > > > > Selection because of his changes. :(
> > > >
> > > > Someone was going to have to do that, sorry :(
> > >
> > > Just as an FYI, this patch will produce warnings until the associated
> > > power_supply interface patch (number 5 in the series previously sent) is
> > > included as that makes use of the new API. Not sure how I can get around that
> > > so I guess we have to wait on Sebastian to give the nod for the rest of the
> > > power_supply patches before this can make it through.
> > 
> > That's not good.  There has to be a way to prevent a build warning from
> > happening...
> 
> If we're ok with '__maybe_unused' then I can add that. Wasn't sure if something
> like that would be acceptable for this scenario.

I don't remember what the warning was, or what the code was either,
sorry...
