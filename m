Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-610692-1526292546-2-11778339589707157981
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526292546; b=L3OpgGm8gf7fhfmJF9tGdUoSs4Q7IhCtkW973XTyI2jwVr3pl8
    EQn6JHuzrjR3q3p/4BJO8G2/jt0flL5l8JgLyuGiVJ9Ke/KLisYiiIX6qdxFfYSa
    rbh/pEA/C3Akp4UBtwzPHiy5FzTXFBH5ZgG2NIx9RfQkZBBU2yURc0TJmxPtyWVx
    E5hRA4kspi3Td+5PGXWxGO/TYHuPcmUjGfxHIPzoziXyN1J20BkIMgtw9pBVCFfU
    /tMXVz1xkbqw3JHzDtJDbYfZAoK3YtwBeOdPxfaZP+cIY3tt2QolXLSjg6v4JxNk
    pUZLvAyPO3y8H6WTcspybWtMtemI2T0nNwtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526292546; bh=n6C+sayc5gf4P+5qJw21UP9GqY5vjq
    nGdzS3iM5wLXU=; b=bnulPGu6mjnEDYe45UuQjfH86URsLIAlDQmEX2tSvsPizF
    QotUojiIm9F9qzvG9BhwX3sPO+WjoLyUMff/yq1Yg6iy9SvW/IsofeDK7grQveNd
    xDsi+U6a85U18bENxuPT2rkI9km+u/lveEKX2kLnpyz+E+Ukqf4uc4UV+nqSCC5l
    fz4vDP3I7B1PhYeP+czXox12b9w0F29jgOhpF4rE4vBn/c1vT5d+sceBesmozeiO
    QNENari0QRytnPAlNTobchL2L4gQwh5x0RBSq5RcolELXvhOhim0uLsouyiuIsjA
    XGh0SmQMn+udmLZXRHuRERHIYB3N/4ThSuI3M/9g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCT3IfcwmTayqQzCQHNk2kSZ7wQ4OhzCJO9pOIpyHh9b0G09RjYBbWYrOKVsE0BwllOmVn7gP8Aoew+N3hvyEzo8zH/VqBcOZU835godKVSSbFNT7pCN
    HKlZbrkYGyjLNABgHIUzQgEWD0xOu7oH5qqtRBYYAJ3dLTmzCDw7daEqpUZc6Gr6SP/SWMkUlSiOwUtme6OiTWWt+REdieNxk6j0ODPDZUepDWMloOlgT5TG
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=3PFpBmu2suRobjpcoOMA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751927AbeENKJE (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 06:09:04 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39004 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750917AbeENKJE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 May 2018 06:09:04 -0400
Date: Mon, 14 May 2018 11:08:59 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        james.morse@arm.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/18] arm64: move SCTLR_EL{1,2} assertions to
 <asm/sysreg.h>
Message-ID: <20180514100858.4xjp5d3axbyy74ap@lakrids.cambridge.arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-3-mark.rutland@arm.com>
 <20180514100053.GX7753@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514100053.GX7753@e103592.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 11:00:53AM +0100, Dave Martin wrote:
> On Mon, May 14, 2018 at 10:46:24AM +0100, Mark Rutland wrote:
> > -/* Check all the bits are accounted for */
> > -#define SCTLR_EL2_BUILD_BUG_ON_MISSING_BITS	BUILD_BUG_ON((SCTLR_EL2_SET ^ SCTLR_EL2_CLEAR) != ~0)
> > -
> > +#if (SCTLR_EL2_SET ^ SCTLR_EL2_CLEAR) != 0xffffffff
> > +#error "Inconsistent SCTLR_EL2 set/clear bits"
> > +#endif
> 
> Can we have a comment on the != 0xffffffff versus != ~0 here?
> 
> The subtle differences in evaluation semantics between #if and
> other contexts here may well trip people up during maintenance...

Do you have any suggestion as to the wording?

I'm happy to add a comment, but I don't really know what to say.

Thanks,
Mark.
