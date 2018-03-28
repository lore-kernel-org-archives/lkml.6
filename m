Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1982828-1522230697-2-789139578370502306
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522230696; b=WxM4VpD7YS8Nb4J4pbwLmX+rUwJQzf9oogDGyjSdw376mtY
    BNJva1QyQcUe+6mkAqXrhG+MYkZSrDP4TWAe99VHa5boE+kHlqYj4FYcC2ldh6IL
    N+DzmP2PTKot6O9MQ6q9WYxnWUsX4o0VQ+Qp1BUc6jD2RPHmR0MYUYbdA5gT12Yw
    dfIGC5SspVdrqXCH7NIY6oBSWBSdFcz1tjiluRnSBaBeG0CdlL1cVCPsIv2lkeaR
    BRWY7l7a5Ky8+Yt3WTqlZZ/jOcvnU85Tu3chvT0aDEueou5Im+HVG7ehwCEHSZ71
    VFuk/yvAtckk5Mhj8BA+/NSQ2+Do6lgUW7Kk5OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522230696; bh=BGcGIaReR16pPK5e2ho30ghCDM
    J+SQmxNYsKaiooGj4=; b=tUlhIY9IE4Y5pV6lJu4uABT8Xn2lWutwJzDYdRcnoQ
    rQj/qyKj+P+nmfJ3w6elIOKsa87C3t5bocA3lKpR/1kw8YA85le7MDa8dfj/Db04
    Y85HAvX1Uhy/3oKrA2wP3ZjTbeiHUZ4nFxh+oEz7E9YDCv5beOE5ohdsvX7UN/X/
    zqfubCryZLu6FVZ9r4rzwTrpwhJduIsKnY1nzqVYNU8RiIov07aaXEcurwjzT9yZ
    lUCykX9YvdhP2c4sUwEjq9WTD8RC+EqERISZYsxoSkdxdcG5ai7lBuNHCwM4S8UE
    XlXsMuIusMgbh1WiQNXf3GFnWkl7pWqbynKz8iNJ2rMw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ1T5DEdylMJX0xok5TfKThckm0e/eSF6AYNJZRBwRg0ZPn5+/wNeSMceTH2gu4XjUp9lrzZBwc+Cn410246VYzo5iZdMIBAy/89UJOVbF53xB/PfX6S
    +t9Vcx6TV2CszLskCyW+cAE6peJ6p6+/X1hhBg/m9JA+Wl1QMfduDHWaE8mMaM+tO2FvM+G3Z03V3HHnbd3UEOJftuhh3jpdpxNSc2Ga+0B8LjQFk8BWkwik
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=Ikd4Dj_1AAAA:8 a=VwQbUJbxAAAA:8 a=Vbzdcb65T8TEjLJneLMA:9 a=CjuIK1q_8ugA:10
    a=1R1Xb7_w0-cA:10 a=OREKyDgYLcYA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752225AbeC1Jve (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 05:51:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48144 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbeC1Jvd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Mar 2018 05:51:33 -0400
Date: Wed, 28 Mar 2018 11:51:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Aniruddha Banerjee <aniruddha.nitd@gmail.com>
Cc: marc.zyngier@arm.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, aniruddhab@nvidia.com,
        stable@vger.kernel.org, vipink@nvidia.com, strasi@nvidia.com,
        swarren@nvidia.com, jonathanh@nvidia.com, talho@nvidia.com,
        treding@nvidia.com
Subject: Re: [PATCHv3] irqchip: arm-gic: take gic_lock when updating irq type
Message-ID: <20180328095130.GA20664@kroah.com>
References: <20180328085430.3401-1-aniruddha.nitd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328085430.3401-1-aniruddha.nitd@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 02:24:30PM +0530, Aniruddha Banerjee wrote:
> The kernel documentation states that the locking of the irq-chip
> registers should be handled by the irq-chip driver. In the irq-gic,
> the accesses to the irqchip are seemingly not protected and multiple
> writes to SPIs from different irq descriptors do RMW requests without
> taking the irq-chip lock. When multiple irqs call the request_irq at
> the same time, there can be a simultaneous write at the gic
> distributor, leading to a race. Acquire the gic_lock when the
> irq_type is updated.
> 
> Signed-off-by: Aniruddha Banerjee <aniruddhab@nvidia.com>
> ---
> Changes from V1:
> 
> * Moved the spinlock from irq-gic to irq-gic common, so that the fix
> is valid for GIC v1/v2/v3.
> 
> Change from V2:
> 
> * Fixup the Signed-off-by line.
> 
>  drivers/irqchip/irq-gic-common.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
