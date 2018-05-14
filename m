Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-798120-1526301810-2-16119966721989293575
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526301810; b=M3AFfr8QuXHnlHHnlvM5KUEPcTJCAJEqGzryAl/IGpZ3EI4aZm
    8Ph3/KUeViJurJsubm+QnjpTuGv6PYQF5VAicLuBMFsU2fZPPnCzPiZITrJocyp2
    lggeapYF7wKjqvgpow8QPfl7yV6jgBVnoJC0fbtS1Jf7KsRRltiwV7fxwUnNQNDA
    7JeP3dPyNgooWT6Y2vjuE9lkncoRklXhicYMKa8hsbNeyjj/W/b05bE2cPkqa1o6
    XE10VvSZ8auLAe733DXuoeRef1u0L2RnTxZYRIpwIOTazESPqWyjMXhqSZhDyGVp
    CGCkeLNOvFiNmQWoCYiu6VgnNDvvkc+CVWHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526301810; bh=1yUbaVFlPQ2T26EGGcvEzRxX7SZu3P
    Q1rEDMxEAKUc8=; b=nGG8Senk/iJa1+4SL/wuEG/sUwGP8c7r3v/pEm/fQjHXxu
    YocZ1gXAlJwf4NetfPDxJkse2reRJ289yGE11SE0h6EeewYtwcyd0mqKSInWdNbp
    b4+aozzFD54lCnaeCvdto+HT7KAbGzaEIYVNrBoROUwJtPsd0ovI8bqnsUXI9DbF
    XuD4ixmqoUYXGKx6W073IxtuWaedLHwIlJp22HnOibjQd6PuRsW9eIK4+hUlwmTa
    lb/8wfgpUcgbsr4TvJfwKQZNV6bvaSLqVJgR/YA8MFs8KFLSEYd0lZwnWF254F4e
    mEL4oCL21xbUJjIjriapfJN0jrMbvci9nAolHnrA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfMzT0ddYlVuIDz72yZym9NVdXXHyYB0rikNE4lPLDMyYDxq96cLGW8yFaSDrPw4gT9PINl+F6Y9lufsoH8QHDK+BWNrZ8Hyz4gOd0nibKsWzErKw30eJ
    GXuIpRa3FQ6gdG1PHO7BCpbcFLrArhEuCwIgj5DIYO7nZRyPb+44GRStoX1mEXB4elNfOiOVSzkZot9gUFiM8/FCg+ZX8sMv2jo0aVbrIXJkdhmr4oBJ8i0I
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=12p-IiCEWuCQOxQH0RgA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753437AbeENMn0 (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 08:43:26 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41600 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753144AbeENMnY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 May 2018 08:43:24 -0400
Date: Mon, 14 May 2018 13:43:19 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, dave.martin@arm.com, james.morse@arm.com,
        linux@dominikbrodowski.net, linux-fsdevel@vger.kernel.org,
        marc.zyngier@arm.com, viro@zeniv.linux.org.uk, will.deacon@arm.com
Subject: Re: [PATCH 17/18] arm64: convert compat wrappers to C
Message-ID: <20180514124318.pwmz63cduxibwfom@lakrids.cambridge.arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-18-mark.rutland@arm.com>
 <20180514121022.GB11638@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514121022.GB11638@infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 05:10:22AM -0700, Christoph Hellwig wrote:
> > +COMPAT_SYSCALL_DEFINE3(aarch32_statfs64, const char __user *, pathname,
> > +		       compat_size_t, sz, struct compat_statfs64 __user *, buf)
> > +{
> > +	if (sz == 88)
> > +		sz = 84;
> > +
> > +	return kcompat_sys_statfs64(pathname, sz, buf);
> 
> This really needs a comment, and it looks very obviously bogus.
> In case it isn't it needs a very good explanation.

Per arch/arm/kernel/sys_oabi-compat.c:

    struct statfs64 has extra padding with EABI growing its size from
    84 to 88.  This struct is now __attribute__((packed,aligned(4)))
    with a small assembly wrapper to force the sz argument to 84 if it is 88
    to avoid copying the extra padding over user space unexpecting it.

This is the behaviour for both EABI and OABI on 32-bit arm, and thus we
must do the same for compat (and have done since day one of arm64).

I'll add a comment.

Thanks,
Mark.
