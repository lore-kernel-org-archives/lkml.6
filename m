Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-295341-1526675002-2-5257214922912369809
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526675002; b=XQo37bDNI2NXd3KzCaVKSbvsUFrt+7ETyapnHv/9J2eiyLzKI7
    I+2Dg+liIXLj16/o1OV6XefKdt7fy4dfYsFiVEl5HJY5tX3qXotipIQa/zzMZQM/
    h8MvRaAXvYDsGLI8SgBmDJH4e6VfLXwAkwqoyDrnYVKX1ISurz40U5JUz8wpD4di
    j9VSW54j4jKXp5sedSi0ecPwj3iHnK7FT2TI7wNwbupWK4yGefjaHuQfE99Cg3TV
    RtlJc+YReq+674IXdfOyE7YpmTU4aTMG7FFT724JynoQJFurgxA7RKkUpb6lAKy1
    OYgysdkYRnL6dTezpd1cOOCCDNItizlcsaxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526675002; bh=tiy4zQOsF4ZIy6ROH6tXgawml26b1d
    DOLo1X07hxHDQ=; b=WLQ2+LSKR+t626m/LFoQGLimeN3otlIKvXG8+jJtZ3iafK
    V0e8YrvY1aP4QFzsIxRWUQN6Y4DHvwi7Cx0cAhiuoTx/GbbC9dMK8l/C502M1Ake
    IIctb6sQ2E1PVeP5i7mX6b59gObQAHvoITwQSm2hieY8FG/6J/T4jZZwxfXKlpl2
    nsbIIFewmGtzdxg/EZj+SgspGyD26FlecTB+ELBOi73PKu5JPGxQCvATw5yQhJQc
    3bVI+jPmLBrwZqPUgsgrUQALnFqVt3ecoV0oUv6Shc+FqGoMbk/lxnFgF+9nn4Zh
    BHsD0H/gwu09cL+7vxznYZqTDQgbbflRLD04w//Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=zeniv.linux.org.uk header.mx.error=NOERROR
    header.result=warn header_org.domain=linux.org.uk
    header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=zeniv.linux.org.uk header.mx.error=NOERROR
      header.result=warn header_org.domain=linux.org.uk
      header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPb1sDumxqR33kNNpXTl9WZkpipQvIx8my6PyNDunIVyybW0Q1URvWeyVeKvqZdL/b0iEuTjA4DXA0DfCAink7vEunZXcopde8bGZk1TR1l/iWJ9hRyD
    ZzFj7yQQZDCqy9NFV+vpj2YXDKLN7XMdgXWgLTV094mkHffF6yTzHP33tYZr+CofxDH6/6FYQMsmLYxetrXanN/VfNCg3wxCWGXWZOb8ZSGW6eu5jBXxo4ut
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=UEmMxE9i7U51DHZ0YP0A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751924AbeERUXR (ORCPT <rfc822;linux@kroah.com>);
        Fri, 18 May 2018 16:23:17 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52592 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751446AbeERUXR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 May 2018 16:23:17 -0400
Date: Fri, 18 May 2018 21:23:15 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@lst.de
Subject: Re: [PATCH -vfs] proc: don't maintain sizeof(struct proc_dir_entry)
Message-ID: <20180518202315.GU30522@ZenIV.linux.org.uk>
References: <20180518200213.GA8006@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518200213.GA8006@avx2>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 18, 2018 at 11:02:13PM +0300, Alexey Dobriyan wrote:
> Automatically cap sizeof(struct proc_dir_entry) at 192/128 bytes or
> 256/192 bytes if spinlock debugging/lockdep is enabled.

> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -61,13 +61,15 @@ struct proc_dir_entry {
>  	char *name;
>  	umode_t mode;
>  	u8 namelen;
> +	char inline_name[];
> +} __randomize_layout;
> +

Hmm...  proc_root initialization relies upon a gccism after that...
Speaking of which, why the hell do we even bother with proc_root.name?
