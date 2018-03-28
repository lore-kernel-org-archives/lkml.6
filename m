Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2466908-1522247823-2-12456662363310398447
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522247821; b=rYTvLwFzJLke6JJnwluVgRr59yFdiim5HhFwerMmW5NCOYE
    p9XAiado2eAzdyS42CBIWbf8uPnHZGnMNk6V3/v3H48fjoX9LXtB/adFB1zd0aPe
    MpK/XA1sXnBUTO2FDu2ieZ054es7hR7dGdjWnc2Zw8H3ejycpWan0w4tGIAyGuoN
    be4KZMK751H8tDiZ0nl5iaPbU3KSPBN1x6lvjKmnJwOAd7SOJgqjJsOjT3+uleHq
    FggngJVeAtGYMKN8Q9+6QvHWs8mJ6p4cwH8jJp9v23s1yneJn37+8lJdZNT7Mu8J
    1UTyUFxabElhLp+WBN5vwKqygY5rTt+PXFb+BWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:message-id:from:to:cc:subject
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522247821; bh=Xf7r5KGb4JaHUAXGXgrdRCWEWE
    /e9KHHs8EoCR9obUQ=; b=mE8xFmCpNr7ul5Ujg+/73Ng2xIIwNXwQjXbQW78iXs
    C8ZgzP1eK7Hm6xiVhhUZCZqdivAOwwNMyLzHv2ubsIyRXakEYfI9HL3MQlBN6l9c
    qzPX5YURmv3G8qd+2AVUsSSnQ8ehgK/Q8vOCTpVdh1JQF+nASxhcvsCjjOe5eS7U
    Q2Pok7Hq2xfcpFrHvLWuzwrmzJ3aThOvroXSLgupkmeetgZdVjrjtWV/TfkoRGC5
    lmzz+33A23FE9eKr03s3LHqtQ1ODaW+P1b2OSgk4j61GpMoVsWTtca9Iv7rd23tt
    F46SzcPZPRFDi4RA1yd0D75p/YrvYMNxrxCSAL2OM0tg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFOQEWH1+TU5/KuT6BNoJlRPa09IIisUnXK7bXwQd74h5Seql0l4RhHzExfQJ8x5obPxBXs1ZALOgfw8Of/X8v1tvywjOKHJ0bA6Bp4NyF487zacEwGB
    wwctmQGd4iOvCQsj7Y3s+7J2Xo0R9sf+Sw0k1eyrZ1xt87sBW9vMsEeQeUQ1LChaR9bQKgPVWK0inSHUNtlBjQdBsNdZQAhE6e+nhygb5lpgrhVFpIZ1zNnV
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=Ikd4Dj_1AAAA:8 a=VwQbUJbxAAAA:8 a=ZT99ZMyLIs6YAo3Tj4AA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753663AbeC1OhA (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 10:37:00 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45060 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753403AbeC1Og7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 28 Mar 2018 10:36:59 -0400
Date: Wed, 28 Mar 2018 15:36:53 +0100
Message-ID: <86370ks1ve.wl-marc.zyngier@arm.com>
From: Marc Zyngier <marc.zyngier@arm.com>
To: Aniruddha Banerjee <aniruddha.nitd@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        aniruddhab@nvidia.com, stable@vger.kernel.org, vipink@nvidia.com,
        strasi@nvidia.com, swarren@nvidia.com, jonathanh@nvidia.com,
        talho@nvidia.com, treding@nvidia.com
Subject: Re: [PATCHv4] irqchip: arm-gic: take gic_lock when updating irq type
In-Reply-To: <20180328134200.7435-1-aniruddha.nitd@gmail.com>
References: <20180328134200.7435-1-aniruddha.nitd@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM/1.14.9 (=?ISO-8859-4?Q?Goj=F2?=) APEL/10.8 EasyPG/1.0.0 Emacs/25.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Organization: ARM Ltd
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 28 Mar 2018 14:42:00 +0100,
Aniruddha Banerjee wrote:
> 
> From: Aniruddha Banerjee <aniruddhab@nvidia.com>
> 
> The kernel documentation states that the locking of the irq-chip
> registers should be handled by the irq-chip driver. In the irq-gic,
> the accesses to the irqchip are seemingly not protected and multiple
> writes to SPIs from different irq descriptors do RMW requests without
> taking the irq-chip lock. When multiple irqs call the request_irq at
> the same time, there can be a simultaneous write at the gic
> distributor, leading to a race. Acquire the gic_lock when the
> irq_type is updated.
> 
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Aniruddha Banerjee <aniruddhab@nvidia.com>

I've applied this after having reworked the commit log a bit.

Thanks,

	M.

-- 
Jazz is not dead, it just smell funny.
