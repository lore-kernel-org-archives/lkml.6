Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2060698-1517566907-2-6565346544331660942
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517566906; b=wWgxNiQzI8wc51uulYzhhAWpy3+1IPh56dxMzarwwZShJ+o
    yND8id+S162mQadAkTqB6QhaYh35SKwQW52gMEz+ZHeFjtVuR9bVWJuHkPHFZ5M8
    he0ZUXoKfuTPv4ettLOHPHwGvyYUMPuU9C0ytCNyNe1Qa8fufyLNYp20QUDEDX5g
    oXSOsBGis9rpHSAbQNZM+qrcBAA9KIDXZiIGw8LWYy+lUfNtb4CYbFAwKfKjkYqH
    BCxcmJ8OVdI8ir67LP1+qEVZ+nSP2yF7NG6wEYZ6NjE0hO7Kl+Fejj+Y68u5V4wd
    gVhfK4Sb8D9FRtZOnzEoN8XUJRRvMwaMK6/RbaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517566906; bh=d7FB7y4ksQtQq/aIeqKkEkDiVJ
    x0PiR0kZ1vBrDRqa0=; b=nSBz8xaF9iIdBRY1UBwkcUhD4Gqa8BmmPJxkwU0wZ+
    3WDtOEPmb5Bsz9LYxs+JySy1AeDrQwSpYAx+Rm1oY+CQvfinNsiDo7UVtAXvf/8v
    5Rv4r3mGLwjV5bnQ8HYqWkrAg7CukRSrRDBx0Kl4ie6eunjod/nCWBiLz53dr3/C
    kCn5TCdsUWcr6G388/IZ6RTMIiJ3a3W+zK4ALEncO2C6vyu5dd1ISM29RHC9xt4Q
    HnYYGyE0a8RzvSYSuvioO5In8jaMxKnib7/MTKYDWZdAb8m8CfrUwAvgd4zfZJUe
    lNW1+SEj7Jlpzg5EebjTCxElyGnJNiKIdmDnwHbPYeHw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751461AbeBBKVo (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 05:21:44 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38646 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751376AbeBBKVn (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 05:21:43 -0500
Date: Fri, 2 Feb 2018 11:21:39 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: valentina.manea.m@gmail.com, shuah@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9] usbip: vhci_hcd: clear just the USB_PORT_STAT_POWER
 bit
Message-ID: <20180202102139.GA22855@kroah.com>
References: <20180126185435.15577-1-shuahkh@osg.samsung.com>
 <20180128121425.GB26619@kroah.com>
 <e1b58cac-fef6-f81f-d3da-9956950a02e4@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1b58cac-fef6-f81f-d3da-9956950a02e4@osg.samsung.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Jan 29, 2018 at 01:13:32PM -0700, Shuah Khan wrote:
> On 01/28/2018 05:14 AM, Greg KH wrote:
> > On Fri, Jan 26, 2018 at 11:54:35AM -0700, Shuah Khan wrote:
> >> Upstream commit 1c9de5bf4286 ("usbip: vhci-hcd: Add USB3 SuperSpeed
> >> support")
> > 
> > Hm, I think you have the wrong commit id here.
> > 
> > I don't see any commit upstream with the Subject you have here, what are
> > you referring to?
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> That is odd. Th commit went in a while back. Here are the details:
> 
> This is the commit from upstream:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/usb/usbip/vhci_hcd.c?id=1c9de5bf428612458427943b724bea51abde520a
> 
> commit 1c9de5bf428612458427943b724bea51abde520a
> Author: Yuyang Du <yuyang.du@intel.com>
> Date:   Thu Jun 8 13:04:10 2017 +0800
> 
>     usbip: vhci-hcd: Add USB3 SuperSpeed support
>     
>     This patch adds a USB3 HCD to an existing USB2 HCD and provides
>     the support of SuperSpeed, in case the device can only be enumerated
>     with SuperSpeed.
>     
>     The bulk of the added code in usb3_bos_desc and hub_control to support
>     SuperSpeed is borrowed from the commit 1cd8fd2887e162ad ("usb: gadget:
>     dummy_hcd: add SuperSpeed support").
>     
>     With this patch, each vhci will have VHCI_HC_PORTS HighSpeed ports
>     and VHCI_HC_PORTS SuperSpeed ports.
>     
>     Suggested-by: Krzysztof Opasiak <k.opasiak@samsung.com>
>     Signed-off-by: Yuyang Du <yuyang.du@intel.com>
>     Acked-by: Shuah Khan <shuahkh@osg.samsung.com>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> 
> I isolated and backported a one line fix to the problem I saw in 4.9
> and 4.4 stables.

Ah, the "isolation" part is what I missed here, sorry about that.  You
are right, I'll go queue this up now, sorry for the noise.

greg k-h
