Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-375240-1527093622-2-5587354971014844234
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527093622; b=Cvsa5Y7ff77DvNO3ZGXzf8B7Lc78CB8OHbjsDn5sSeHcmAI8Jx
    L7E+ucQmv9sJzDHksPb5TQ0iyXncnzgwYl5DKWVYOD5w4RnVZF//ukn6XiBP5j5V
    lse6N+gaLMjpjxw+4GKRNfsdBssppZzvJ+mkp7cSCLx3TO5JcIBekP1TXVdEcAsz
    nmWlT2qLFS9qMqDfFcsAilqn23M+xTy9iYU7qS1o3Py2rqWMMF2SQri2cZLlM3vO
    Pss3G/kJREbJ7LYVHs3cogJK0u3dN9aPpkHqZNUmgArb12pS/4Vz+RHwQaOgULN7
    hMcRyoLdnyM5PcpUu1IoyxVbEI4pdzp2HQqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527093622; bh=2DC8tZQwp2yPlOJEvJ9gCiijOBzw6R
    zadyYaxdm4780=; b=MZQIPul7LE40yLjXEvNofknjiKWEZ0qIn7NfB8jBcawfaQ
    Gtx01prg2yGzWoz6Lsf4rtyLtbe8gb0DgSx8x2QcKr7GAGGNta9pSnO6N2A2V6Lh
    Ua1tH87+Btrdr0oYhmAWPcP76NiwcEBxgo+vjfPD34vCCIDtjtfm0GBUwLk2VYNP
    N7uKmFlwVAZtOppEB83Igdg4sXk11s3nRl27BC5I6VK+Y5pKwiyRBH/j6EfKZvPY
    wH5EqyFXv1k7pC2ZziXwPXv0i0eU9B3hMOOQDtK8/8NzUaYv53GuOQo5hoc9TY0/
    dmvZ+YnfkS4Y9p3E/S8PtSgMah+TTrh8ewJ4BHYw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=xyZwh8Cy x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=xyZwh8Cy x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGVUutSsMeCKIM3GkKYTbl3bQnzyrsi2/3nMKqRsUMTt/a3tZBFF/IiCaerxsDYTqFwxfYmQ5yV6bGRS/8LNBl/sfHMn9rKvmvqbIvzMNL+FnbDmqTHz
    8PzPbQsKUtFGLTD7fLzOY30q6BogVme3C/85pMwtimpMmLKVH78oZ+HG0DahbuCb/zJr2IEMmW8qnlk7nqk5zpFXlAHoNnMuF82I1MT8Wc/A5szFQplSDRaD
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=oIxziwFaEq1Biwc6ZicA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933756AbeEWQkB (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 12:40:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933662AbeEWQjy (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 23 May 2018 12:39:54 -0400
Date: Wed, 23 May 2018 18:39:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Nicolas Boichat <drinkcat@chromium.org>, linux-usb@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Eugene Korenevsky <ekorenevsky@gmail.com>,
        Peter Chen <peter.chen@nxp.com>,
        Daniel Drake <drake@endlessm.com>,
        Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>,
        Richard Leitner <richard.leitner@skidata.com>,
        linux-kernel@vger.kernel.org, groeck@chromium.org
Subject: Re: [PATCH] usb: hub: Per-port setting to use old enumeration scheme
Message-ID: <20180523163936.GE12456@kroah.com>
References: <20180523021656.122455-1-drinkcat@chromium.org>
 <Pine.LNX.4.44L0.1805230958590.1481-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1805230958590.1481-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 23, 2018 at 10:03:55AM -0400, Alan Stern wrote:
> On Wed, 23 May 2018, Nicolas Boichat wrote:
> 
> > The "old" enumeration scheme is considerably faster (it takes
> > ~294ms instead of ~439ms to get the descriptor).
> > 
> > It is currently only possible to use the old scheme globally
> > (/sys/module/usbcore/parameters/old_scheme_first), which is not
> > desirable as the new scheme was introduced to increase compatibility
> > with more devices.
> > 
> > However, in our case, we care about time-to-active for a specific
> > USB device (which we make the firmware for), on a specific port
> > (that is pogo-pin based: not a standard USB port). This new
> > sysfs option makes it possible to use the old scheme on a single
> > port only.
> > 
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > ---
> > 
> > There are other "quirks" that we could add to reduce further
> > enumeration time (e.g. reduce USB debounce time, reduce TRSTRCY
> > to 10ms instead of 50ms as used currently), but the logic is quite
> > similar, so it'd be good to have this reviewed first.
> 
> I'm not opposed to the idea in principle, although I don't like your
> implementation because it breaks the original old_scheme_first
> parameter.
> 
> Let's see what some other people think.
> 
> Yours is a rather special case, because you know exactly what device
> will be attached to a specific port.  Still, I can see that sort of
> thing happening in constrained and special-purpose settings.
> 
> How do you arrange to set the new quirk before the device is 
> discovered?

Yeah, this last question is what I had when looking at this.  Or does it
not matter at first boot and only matters for wake-up?

thanks,

greg k-h
