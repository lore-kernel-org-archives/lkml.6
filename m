Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2952182-1522132095-2-13395646552828860226
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
    t=1522132095; b=WMSH4DoGO3J7BZUGpsiF39Uk6/Ts82FjSL+0koQxrO58Vb7
    Sm0rh+goz/ztnbMYWS/PkLId3EO+vdPEseYVFdT9NvAcwQAaYd7C12R/6+RZERhZ
    7y22CPlMTqi7RVkJnjkQQzhuovoMPnOQQ9x+zqWqOwSSrR6WMWFD/F7FEzDPQVw9
    3nmts2AVf1wdKt8iDwDrqcZgqWAF0zY6X+yRBdWpkDNExDcsVOSCW85GhFHO7CfE
    0b4chNAMhRypsmARbRLSG/4RW8ZYGvVSsb5TunBQsVGCuIlZSeHA3yozXzIVD6TU
    Eddn9eW4F8wCBfsxPQVHyoiI578g50QNWVfjpLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522132095; bh=tVVpvM5H3obLc8rsIJW8OuRMtj
    TzGxhkazV3Z//+Dlk=; b=iyx+YjLRKzH/i8D78aKuuTpJelmdHBeQs8wplMWjrK
    9fHmvscuWFIKLdkVTm6aJlJmkRVtYDC8CHpKRg4W1KegNYDHntZQnaWOu3/l5Nqf
    xB2ZU+o4LF+FxCGAiG8yZBPWhvlhF4doAXUYWtZzux8SPR/1p/JGIuQWXFqaHIrp
    GfOqJyH4FRHSFsmwDDYe+gH0DJwbqdJsKof0QAqfmOnoVU/H7s3uBDXPKPjcywn4
    IOdaL+eEd5WtgU13jtYpqJwXAFbHJawfZJdJzBi/Ok+tvMs+p5lFbJL+v7Uq7bFu
    81gOLUt4r4hADcG96y6Ah7Nfgmzl6FwU9WE2C4Ce1xpA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDsnIIrRmvk7j/2R4IY/PWqUVPnK8j6wpWukWxEpUa4Pc6KRB1g8Lr8e+r5mKfuzJnvNyNAho4u1Fvk7H8czrjbIeIRrbjClcWM+lpjZ/9o/GCWX/3j1
    NhzvPLTguop3KtGqedYGW5ISO5tOdAoCYJuOst9lzoHHvvVAqsbTMGewyR2InoumkWLP8r8cc6UUnG/2PrFkz0jkD/z48qOJ1fRIJ1PtTuMCFr2Shzys2Wl5
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=DWDKLPo_AOAA:10
    a=v2DPQv5-lfwA:10 a=BtMwgljeTHcjuMn2n30A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeC0G2N (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 02:28:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52106 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751192AbeC0G2M (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 02:28:12 -0400
Date: Tue, 27 Mar 2018 08:28:08 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kash Pande <kash@tripleback.net>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/109] 4.14.28-stable review
Message-ID: <20180327062808.GC28908@kroah.com>
References: <20180316152329.844663293@linuxfoundation.org>
 <7ec4a6aa-72cb-9fb6-5168-d1c4d49f1a6c@tripleback.net>
 <20180319182032.GA23774@roeck-us.net>
 <6b6fca54-9cd9-3c62-6c0f-b5e8477947ac@tripleback.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b6fca54-9cd9-3c62-6c0f-b5e8477947ac@tripleback.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 01:54:18PM -0400, Kash Pande wrote:
> On 2018-03-19 02:20 PM, Guenter Roeck wrote:
> > Ryzen and Threadripper are only supported in v4.15+.
> 
> 
> Nope, the offset for 1900X is not available in 4.15, I've had to
> manually patch all systems otherwise monitoring complains they idle at 53C.

I don't understand, what patch are you talking about here?

greg k-h
