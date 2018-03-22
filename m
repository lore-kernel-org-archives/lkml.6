Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2590670-1521720039-2-14312056988702554251
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521720039; b=GvYtPE+0DN68rKC/DoJrIuaIh+Bub2r9L24YgmUk644o+1r
    DRIGMNUImppvaav593eWqt6NZYqC4TPRlgMNTi0qQnEvC6jERIfRmhXHEt+STwAC
    i6Yt8bn5tCmZphwMmEvr6owKv92Cc6BPY7G/3+i6PkKi/9oJCjPjtTpyGQCEAG+i
    RRYUREVwwBEawnlEReRqFMKTMuCeYUtB3udozzcQpgS8j9xwPn/XxxViOokuBh3k
    /HrCKldej5cru/zGNPub0cBnt+NV11zAAC5HaaPjU5oUdwACzsW+mJSsRVQerOgx
    Gk0YG0oSbnp0dKiQqwDj7BUW7ZYJ+fW2HL3IkNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521720039; bh=ixiCXIW0Yoqjxa1YC9Ay2En0Xk
    7qK1DFKex+u9uE/E0=; b=aPCjxSSZcZcAf3cJ6ul6K04qHqEzWH6EcOVtgnL3Vd
    9pKrl6Elh6QZ9BLoWa0ujJfDkAbna5izhdxPZ8xZWypqK7Q9LWMb8flVRsxtC7l2
    MsRsEar3DnxUuzy6rwr3uAazTclSN/ycmWV2OkJ1nGxm8LgPyKWsVSnrmiRr0sHj
    dqPClTRdJV0G4bSuhBV4UkT5Gh3BViWjM3vbBJSW6lIgLJ0YkkMROhm0R5MxaC63
    IGrm3V9/en6JYNpwchbuJJkQ+/5vTKQK9wIi9gZrd6ppqf29Nq8LRt7tj1miuPbA
    7zidn0XIzCWo+ZOgFr+kQl4l+1GHG6qEvt/8c2FUgwww==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753274AbeCVMAY (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 08:00:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55772 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752060AbeCVMAY (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 22 Mar 2018 08:00:24 -0400
Date: Thu, 22 Mar 2018 13:00:21 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Roger Quadros <rogerq@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [usb-next, v2 PATCH] usb: xhci: skip phys initialization of
 shared hcd
Message-ID: <20180322120021.GA3304@kroah.com>
References: <643701fef843f91931e3a68779afe053c63c96f6.1521707846.git.chunfeng.yun@mediatek.com>
 <20180322090127.GA12048@kroah.com>
 <1521710486.3717.146.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521710486.3717.146.camel@mhfsdcap03>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 22, 2018 at 05:21:26PM +0800, Chunfeng Yun wrote:
> hi, 
> On Thu, 2018-03-22 at 10:01 +0100, Greg Kroah-Hartman wrote:
> > On Thu, Mar 22, 2018 at 04:39:20PM +0800, Chunfeng Yun wrote:
> > > The phys has already been initialized when add primary hcd,
> > > including usb2 phys and usb3 phys also if exist, so needn't
> > > re-parse "phys" property again.
> > > 
> > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > ---
> > >  drivers/usb/core/hcd.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > What changed from version 1?
> V1: skip phys initialization when add shared HCD by setting
> xhci->shared_hcd->skip_phy_initialization=1;
> for both xhci-plat.c & xhci-mtk.c files.
> 
> V2: fix it in hcd.c suggested by Roger

Please put it in the patch itself, resend v3 with this info.

thanks,

greg k-h
