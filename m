Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-353908-1527091004-2-11965240224996389147
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527091004; b=Doy9lUwDfys3I4qUa51OPFwPkJxfGZu8/gHATQHtoNoXabJBbC
    ufoPDWmgG8YY7piglNgswsiO5HASBWMHbehotlDUp9oTm48G3zURLTIJ9hJglvCD
    KoMhyQ89g35OPkmXrbox7yUAfhd10TfnsqeoanxoOsv+Tx54Wjr00CbPp5PdFC3X
    cxXXboMkbLFywyZg5SGtM+uoelvKqp1IK+mt8PLpAUk3wfVLPHuYWWiGEBB//Bk/
    ggj3upeSf0A3UuLAonmgv36TqN+7kOqF3fkQSzPuQ3HYqO5W7skQ3CACxIrQJfzy
    E2jPKk6AHd8c07kbcDnMs1YCtqbbnsDP8e3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:message-id:to:cc:subject:from
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527091004;
    bh=Hx5I3lORi/XSc8fEpiN5ydGLZueEvZlLg/qI+GiGL8M=; b=iPKJOXqSYvR/
    J/KdeDtojpdGKA9PXJnhKT4LNtoyghmRKhNdHNOyB+1pHub2TqXENi9JMFDxA6Bc
    5RLmN0Y6D/Phe1IgO0fOPGkkEUGoXIXLL+FrDdqQZkoZ8/mFIzLNqXxYrGtZYOyw
    85rDt01PCpo5dtr+rvQtHJ9qV6shepzNoKzHDnME7DwI7INaCMHqIVVT4i2NzU+Z
    N5Vgtn2GtIk/Oi5uuVOb2KklLvqfUSimkAxCslfu/Fz2uyZZyyx7wJBNejCELP/C
    iiR3RKESrTCtUxeFOheM5SyxV79ghFkslGzS3stnWgVoIj948zSdBQpoifbk6CKp
    1niw7ZD2tA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=davemloft.net header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=davemloft.net header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAQC1FRN8u2l1MB7m5bWKFr8epbwWwkwN8mdsSei16YZBhweJjmnj4a1ZY3BSujhtFDlImL/NKLc+buO3MOHMHIaXDwb0uQULpvmWHNnq+EbUo5MkWGk
    3lMaJAA3F997BQWobf8zhTwM2nRVoaHZLvC7H1UKWI7eSvTWy1i07uvS+LJkCjEmn3BRqCH0xMIhd6It65WjjJgukhGkUfrTNURneUbUNL0mwu2ix2zTY8gN
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=0lcLQbBPoozJf6cEvj0A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932391AbeEWP4j (ORCPT <rfc822;linux@kroah.com>);
        Wed, 23 May 2018 11:56:39 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:58836 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751201AbeEWP4i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 May 2018 11:56:38 -0400
Date: Wed, 23 May 2018 11:56:36 -0400 (EDT)
Message-Id: <20180523.115636.2241611659399097483.davem@davemloft.net>
To: g.nault@alphalink.fr
Cc: ebiggers3@gmail.com, linux-ppp@vger.kernel.org, paulus@samba.org,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        ebiggers@google.com
Subject: Re: [PATCH] ppp: remove the PPPIOCDETACH ioctl
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180523135708.GB1569@alphalink.fr>
References: <20180523032958.GE658@sol.localdomain>
        <20180523035952.25768-1-ebiggers3@gmail.com>
        <20180523135708.GB1569@alphalink.fr>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Guillaume Nault <g.nault@alphalink.fr>
Date: Wed, 23 May 2018 15:57:08 +0200

> I'd rather add
> +	if (cmd == PPPIOCDETACH) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> 
> Making PPPIOCDETACH unknown to ppp_generic means that the ioctl would
> be handled by the underlying channel when pf->kind == CHANNEL (see the
> chan->ops->ioctl() call further down). That shouldn't be a problem per
> se, but even though PPPIOCDETACH is unsupported, I feel that it should
> remain a ppp_generic thing. I don't really want its value to be reused
> for other purposes in the future or have different behaviour depending
> on the underlying channel.
> 
> Also PPPIOCDETACH can already fail with -EINVAL. Therefore, if ever
> there really were programs out there using this call, they'd already
> have to handle this case. Unconditionally returning -EINVAL would
> further minimise possibilities for breakage.

I agree.
