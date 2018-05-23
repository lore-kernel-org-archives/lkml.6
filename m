Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-685316-1527110238-2-1718952826191790390
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527110238; b=HmysjzaariOtxrlFTwYzShQKUFudN3se8YXVXq7wU9UdtHwZf2
    5DlFRIQfW1KwnhnGXj68ge7a9yH34SbrqnrvzWcgjXKR39pnbogS2odoQbsBN3d2
    meoOc+kxx5PapJ5aEElIvQsle9MhZmQnzcULP4LywIzsDqqSfE+AyG5dpnl7dFDq
    5ZEPVO+KUuw3YRxpSWAQwn30nGYebCP/lea3PI7x5Yx8kzJlQ3LkGY0zNY82Mspr
    yhRSYgjL5JAfuN+7qnnCu+1RcJhcSfZcNxuOeeF/U0Azdg8V0LWXs4jMkHBFtfdp
    P/mUOGd2awFzk4cNT3PJLvutNLGc3CPLiqYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527110238; bh=4pcF4hbif9MsjUC2Pv9tie7cg38Wmr
    JovneHIDSKfnw=; b=jOLx2nqdnY3ao5C3FmYX5ws0/tCzERIpNGiFkNcweTcSNc
    XVLZyiOTCCf6yDeudzftHublHEPTY2+D5lPN0mwbZnThT4/WtLb1ytIXMmruL6jM
    K17n8ma8urFmhHLzzabrM4o9U4/SRRQlvCJ1efCljne/okv85OTLddkJYuELYKTx
    FMrbc0QRJg+SX17ObVW4wfL6Cshfc4hHbhIPpfRnJXlsfv0/2BkKpIbDAFDjHaQd
    eo3im3mat+bgxhqSdVgpkSt5T5/B/n38zr4gYJD2Z/20Qydc3tEVtWy+B2IQe83u
    AbsLreqxFJdaCPyEM9eBj6rt8sL+7ntYxiQRYgqg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=dSXGrBtS x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=jmhkRWnT;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=dSXGrBtS x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=jmhkRWnT;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG3q4cOzdKi7VsCyHuPHqZD9E297Drl9uvwyekRNK8aMqPHO1FQZC7z8yjWoyRhj5xmK5+EgRyp6C3A/Y63Q0VxMVZ8CKhm5f4s1o77B3XxIDuM5P4g7
    DHDn7PWSdabG+GOqk3mMjeRR5tcRBvGFOP5V+mRrfxVO7I0oXRLZ7a/JJis5TVArKmEPoxILGQMePQFvi3+7B0IcC9WWXvJzFDUBLU3igSId/3KAn7OZBdMY
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=6HZ6NwbpNn0A:10 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10 a=hjhKt9R0p12O-1U3sJsA:9
    a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934017AbeEWVRO (ORCPT <rfc822;linux@kroah.com>);
        Wed, 23 May 2018 17:17:14 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42857 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933886AbeEWVRM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 May 2018 17:17:12 -0400
X-Google-Smtp-Source: AB8JxZqihUsh0MgzyyKboEFm2TMs4evk6RN300pH9GEUR8i7OWWbSzJNYIZ0Ai++g0DaARWNuzePow==
Date: Wed, 23 May 2018 14:17:09 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: David Miller <davem@davemloft.net>
Cc: g.nault@alphalink.fr, linux-ppp@vger.kernel.org, paulus@samba.org,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        ebiggers@google.com
Subject: Re: [PATCH] ppp: remove the PPPIOCDETACH ioctl
Message-ID: <20180523211709.GA63112@gmail.com>
References: <20180523032958.GE658@sol.localdomain>
 <20180523035952.25768-1-ebiggers3@gmail.com>
 <20180523135708.GB1569@alphalink.fr>
 <20180523.115636.2241611659399097483.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523.115636.2241611659399097483.davem@davemloft.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 23, 2018 at 11:56:36AM -0400, David Miller wrote:
> From: Guillaume Nault <g.nault@alphalink.fr>
> Date: Wed, 23 May 2018 15:57:08 +0200
> 
> > I'd rather add
> > +	if (cmd == PPPIOCDETACH) {
> > +		err = -EINVAL;
> > +		goto out;
> > +	}
> > 
> > Making PPPIOCDETACH unknown to ppp_generic means that the ioctl would
> > be handled by the underlying channel when pf->kind == CHANNEL (see the
> > chan->ops->ioctl() call further down). That shouldn't be a problem per
> > se, but even though PPPIOCDETACH is unsupported, I feel that it should
> > remain a ppp_generic thing. I don't really want its value to be reused
> > for other purposes in the future or have different behaviour depending
> > on the underlying channel.
> > 
> > Also PPPIOCDETACH can already fail with -EINVAL. Therefore, if ever
> > there really were programs out there using this call, they'd already
> > have to handle this case. Unconditionally returning -EINVAL would
> > further minimise possibilities for breakage.
> 
> I agree.

Okay, I'll do that and leave the ioctl number reserved.
I will add a pr_warn_once() too.

Thanks,

- Eric
