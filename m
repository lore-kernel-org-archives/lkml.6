Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2467728-1524403254-2-9145350472008045071
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
    1524403254; b=g5GshkpFk3WgU8+N/16YNDYGd4onUSJfhFpCsTA7FnwsimIw0/
    mv7ZfxxrHkIbJIO4oR18SqIrHNOhsbrmIgzsdBuqRhN/ndVE9fIeTyAuJc/5GRJ0
    z0A6QANwKv/RsCVl5ZCXV9owyuaUuRpykJy9R4wCZPMvyQyfjyz/Tvd4J6yAWQo5
    y7xg6IOuB+vTyz4cvXZBr3xH951pyqL+JhPOmDDG2Pty3iY2NoO3ZH2v9Hiwp9eF
    KDjgoBXRW0pNrlCzyWW4gNMsyP8rU41+fRLzYg+dD0BYB85rjTuTzsgdgb3tGVUj
    ZkYLuVbPTMT+XdsteWT7LFj/YKYLQxl+zB1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524403254; bh=IcRVqyIPX+28xrEHm+3VTRYBVFLzeD
    ir2qhXzLxMXcY=; b=FNFpQSzaR0nsP0sur++dgtnupwjw0gnwL7Xi8HdqaP6SVp
    Gffv165kzdijGqntMIuaKeCn4lBu1dV0pczfDey8Q0kaTl+twxFoIb4aN1xeSsPh
    0nlMV2YGOwusNRL8Hfu8bhvU9fFG/NqId8m5imfvVwR2Xf89nlXGlEp/rGLsQWyP
    yQG9r7cpdhq5wyfqgscaBrLOt4wB7Rcn3R6QzjgK7I5McH7/5dcpdzTqxZx9g4hE
    CMSuIcSBMaQfWXxQiGx2tt/fsfl0OECWmFP4f3O2aWbRbwFN/q1+fbQGUsRCylqK
    EahYqKM8kYoaVL5+/ZpeN6p0a2BPxiv/T8V941VA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfFNSA9z1uUfxNsnf4UEWG9It6XIRItdOOo2FHdw1zYCt/Q4I8TJsvZhvvK0BPQQXReOIROZkPdGqGrB49sDg+PsTh/Xmc32ESZHVehvXDdH0X3Bzdcjy
    tWski3Orma794UP2ucjLw/cXDti8eI9JNwlaJBs/qBUgbo6zgWDJV3+tvVds2ZcSF49PwqEOaP3b/iytExMdowpgY3rel0zQ4lGX2PYkBpkzVXlFfL1tbYgG
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=YJBv31aMLckNN4fe_3AA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751426AbeDVNUk (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 09:20:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57758 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbeDVNUj (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sun, 22 Apr 2018 09:20:39 -0400
Date: Sun, 22 Apr 2018 15:20:33 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Randy Dunlap <rdunlap@infradead.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH] usb: always build usb/common/ targets; fixes
 extcon-axp288 build error
Message-ID: <20180422132033.GA15242@kroah.com>
References: <d2641585-65d8-76d4-0668-a278955967d8@infradead.org>
 <9632a61d-fb15-4764-93ae-d6f4049cba82@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9632a61d-fb15-4764-93ae-d6f4049cba82@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 11:01:41AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 17-04-18 07:14, Randy Dunlap wrote:
> > From: Randy Dunlap <rdunlap@infradead.org>
> > 
> > The extcon-axp288 driver selects USB_ROLE_SWITCH, but the USB
> > Makefile does not currently build drivers/usb/common/ (where
> > USB_ROLE_SWITCH code is) unless USB_COMMON is set, so modify
> > the USB Makefile to always descend into drivers/usb/common/
> > to build its configured targets.
> > 
> > Fixes these build errors:
> > 
> > ERROR: "usb_role_switch_get" [drivers/extcon/extcon-axp288.ko] undefined!
> > ERROR: "usb_role_switch_set_role" [drivers/extcon/extcon-axp288.ko] undefined!
> > ERROR: "usb_role_switch_get_role" [drivers/extcon/extcon-axp288.ko] undefined!
> > ERROR: "usb_role_switch_put" [drivers/extcon/extcon-axp288.ko] undefined!
> > 
> > An alternative patch would be to select USB_COMMON in the EXTCON_AXP288
> > driver Kconfig entry, but this would build more code in
> > drivers/usb/common/ than is necessary.
> 
> Ah, that variant of fixing this got posted yesterday and I acked that,
> but I agree that this version is better.
> 
> Greg, what is your take on this fix?

I'll take the patch from Arnd for this.

thanks,

greg k-h
