Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4138796-1519297732-2-4816188147463086745
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519297731; b=cTWrkYAqd0iUU4cZbHhne+t261G5uDKKNW3VURWT9SG+Q+C
    goUaRLMgtDP1Ybigco+oizxWEBftF8lAomkG3SKkGcXXRJ7D0DyxEO4aVa0VTGgT
    jydSzrhpo7vP80MOXplCARJZ4iN9U2NsqyfvYOdzFKZnD2UzC3S01Lz7j70rX21W
    kNWrtmGkAv9t1MA5uhcMzWK3/Cm1sQPpdUaBecRcfVSUIlj7n8Xs30JmkMpthfid
    EgF058b8plwbwsUslw69oHipUbwSrPFULGxKryZy0c2+6xjx1iBCaxUygrxiE5D6
    f9smcLKG2GDTAiwmEs6KQLAbXezwEJCx9wwexyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519297731; bh=e2ZIMcbJnr6uM86qPAUvlQTjG8
    yrUUGX3J2n0rujxnI=; b=n1M8UwQxYVU6cuqA7E5lMuyWOtADaegiML86cN1QAU
    w13q0a6xJ1uB2TGBGPgh2Hm0rn9QM46MmfE5helJEptZXfZ+zQvtuV1ALxrar19U
    k2mF4Nkhm32C6KHtCm/YFoUMgdCoDvlJJSQZLgUSOqXbwkG5nOQF9j/4X9DCDGbe
    oOlClEx9oIyCNXUXv82q8o8kDxY3nHeCAcC7Ep/1nOjh/RKmHHGBDB3CzoywGNJ6
    dIPc09aUFfQJc+VPkVnSgzTkP1MAdlwVQ6v+bbYkOWysLoCtb8d1WCGzz4A/1d4o
    9lNNoqcWhdya97RUIS5HN23bmJa2xyglPGaTPgbgEPLQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753607AbeBVLIh (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 06:08:37 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:33228 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753600AbeBVLIf (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Feb 2018 06:08:35 -0500
Date: Thu, 22 Feb 2018 12:08:35 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Yves-Alexis Perez <corsac@debian.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 4.9 34/77] powerpc: fix build errors in stable tree
Message-ID: <20180222110835.GA22572@kroah.com>
References: <20180221124432.172390020@linuxfoundation.org>
 <20180221124433.618725458@linuxfoundation.org>
 <87k1v5rg66.fsf@concordia.ellerman.id.au>
 <1519292030.2388.14.camel@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519292030.2388.14.camel@debian.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 22, 2018 at 10:33:50AM +0100, Yves-Alexis Perez wrote:
> On Thu, 2018-02-22 at 12:01 +1100, Michael Ellerman wrote:
> > So I guess this patch is OK for now, but we do need a full back port of
> > 222f20f to 4.9.
> 
> Hi,
> 
> in the light of this, do you know the full status of protections against
> Meltdown on powerpc/ppc64el architecures on 4.9?

Did you look at /sys/devices/system/cpu/vulnerabilities/ to see what the
files there say?

thanks,

greg k-h
