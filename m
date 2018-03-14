Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1800801-1521035946-2-5227929127579780415
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
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521035945; b=RjyEvQBFOmgqJBX1d6lyG2jlVdxGTZO/C+qsfV6xORwfE+v
    s7IBs7mVZhgWTXUbasAkmhWZM7jkR8XEfjaWni3IDJpfme7F9hKnSOq7E+7ynJCg
    CyZGUFFi9FReR1ajvDdV9gdOuMqZ8vlySzxJN/wCYhE8N+AtDZMCemSSL7hvwWdn
    MyNDz/AGacCPzGIzXzhD78dColuLodnouHCGmoRMjKYtV966GCmBuA7kPy1v/+so
    iZfHDXT7Um2eBIKe9OV9ERZOv1YdmKL+vFdUB0w/N/6xzQx9bSyuCpxfNmwvByeW
    cMe+jIXO2pGTCWhr/AqjeBU5kwaYQ0TrYfmBqlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521035945; bh=a0rOsNzs4gvba674vQeH8fHvGp
    VlDnMkv3CZXUTk/wo=; b=Y67ko7bmrUmaIBpmwK3kfgE8wM2ZUZp+507fTN9zQc
    C4dqoqZl2w5xdzkmhuLYVNJOiBUppSRoHUzpmlM/HM1qU3pgskoRbIGQoaPsDjbZ
    a93vRnAZIu4V74sx31L0/XciV/e258Th8Rk9D8RI+xkTsULazvrNqTVxsThim92e
    zIXcrrZSvmSLfzBg2wSg+YXLK5QLev9yCpZeV5uBWRIXoZu4dQKgrCBNDwRtESdC
    XnFrjXYmPitaNPStp3ggNWpI3ACkCRdtkn/odZ0KOs90t/xU9qQc9v5vHQk+4rr8
    EaIhBDoOGw2VztwjigR3SAdhsuYzDTcd+4MNaiafmG5g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751302AbeCNN7E (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 09:59:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38290 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbeCNN7D (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Mar 2018 09:59:03 -0400
Date: Wed, 14 Mar 2018 14:59:02 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: stable@vger.kernel.org, Evgeniy Polyakov <zbr@ioremap.net>,
        "Andrew F. Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] w1: gpio: fix problem with platfom data in w1-gpio
Message-ID: <20180314135902.GA21622@kroah.com>
References: <20180218170629.6045-1-paweldembicki@gmail.com>
 <20180218171927.6414-1-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180218171927.6414-1-paweldembicki@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 18, 2018 at 06:19:26PM +0100, Pawel Dembicki wrote:
> In devices, where fdt is used, is impossible to apply platform data
> without proper fdt node.
> 
> This patch allow to use platform data in devices with fdt.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> Acked-by: Andrew F. Davis <afd@ti.com>
> ---
>  drivers/w1/masters/w1-gpio.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Patch does not apply at all to my tree :(
