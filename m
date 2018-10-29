Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DB8C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 00:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D59020827
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 00:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=steffenvogel.de header.i=@steffenvogel.de header.b="HZRAppbE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D59020827
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=steffenvogel.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbeJ2JPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 05:15:48 -0400
Received: from nag.0l.de ([207.154.252.120]:38334 "EHLO nag.0l.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbeJ2JPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 05:15:47 -0400
Date:   Mon, 29 Oct 2018 01:29:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540772968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xXztPpAw4nhIHGFYUQeJufCT35jDR0E904dyR7V04lA=;
        b=HZRAppbEMFmMGh9A9q2cgqgk2tOAJNvLb5brhF6nAhKq7mrz7Wns0pr5p93df7MHVFZnZI
        avixhx7M/BR00ExHPs4nbVwgbL7Yxd6JY04o8EyorPCW+j63YlxEfchkaXfEUyf3cJmhOV
        +nzUkdy3cYpb3XFJEYQAb/lvpLSi3mafoYwJ2LHviDlCUuxHVnYNY/qOfuUbiwuGrJxhyS
        JpasZbs+mDjaKw8L1xi2cG+PUl2Fk9jl10/YIk363P/oFjce1IxWE6Pzarw1SicUyKcS0F
        GQTylxyfVPWXb0olCazKPTeYw13by1zTd1G6/eV2wZI8mkeGYV7+vZYRoYknXw==
From:   Steffen Vogel <post@steffenvogel.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     lkml <linux-kernel@vger.kernel.org>
Subject: Re: w1: coding style and checkpatch fixes
Message-ID: <20181029002919.3cek4f27mdrnrgkj@cam.home.0l.dn42>
References: <20181028220927.56227-1-post@steffenvogel.de>
 <CAADWXX89jMiTp-Nz887tv+6YwWkrWF8qYfpuTkmk2OE3_SqeGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADWXX89jMiTp-Nz887tv+6YwWkrWF8qYfpuTkmk2OE3_SqeGA@mail.gmail.com>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540772968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xXztPpAw4nhIHGFYUQeJufCT35jDR0E904dyR7V04lA=;
        b=COkzf6Es3HaSjQ4aq0kdJazELq5Kxr2hzTZe11O4SWt3UwQq+bFGwAGcVhG7zcxw7bmUVg
        XbOm/cAkYwEGw5GyXq3EGwCZgI/bnyLJhtVxI53gEEgPJFVD/P0ZmO2mMCLamtkyVefpxV
        +XuocyJq3MRx7nmtsMedXCb9EYzaDqWyfoxM1Z0Zklxjv4oV7Elfa4aVB/u2zhrEJ5+xIn
        xko2wJ7f9DQLyeX+BiEK77IMiwHRQm1H4Ks83JkYe/lF1Py71D9iWdZ2xtAskRiEOyhDCk
        arEssL3wCEa8fGobzP4j0NRjRI5fTGLJvuYPv673zqHxe3QCXRtH+JgP/eMpYA==
ARC-Seal: i=1; s=2017; d=steffenvogel.de; t=1540772968; a=rsa-sha256;
        cv=none;
        b=JlwliiHxC2qcqXXaIcxxtsNHF3UZAiXGCyfpQPJkAiP7tSHns6ABYtZQ7zVmMSrp0nGi4x9+NfQrp+RteWR2H4y8+ndrAwjpS9hrbTfR9qL+nA+AExoIG7rZ11dd37x9qnDRoqZIC/dThq5F0KLhN4sYoiWtSwYJUp3jnNFGPzzLn173hzf6sXq5b44/UdUnfzSBzLZuUjHakqtyQMWK6wQ0AKj5X88kizkyW/UOBpZf8N6+4k1K7IjVrlvL214+GLhMHYc8YbjAsdQ6EYguBbh3Tnm0xCbpj4HLVgAMIlEqsW0N1st1U280lu7a7SWifa/UNrfJwqk1A0ixij8X6w==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=stv0g@0l.de smtp.mailfrom=post@steffenvogel.de
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=stv0g@0l.de smtp.mailfrom=post@steffenvogel.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Thanks! Its hopefully fixed now.

For those who are interested. Rspamd, by default, includes the sender
address into the list of signed headers:
https://www.rspamd.com/doc/modules/dkim_signing.html#default-sign_headers-after-173

> End result: the DKIM signature is guaranteed to fail after the email
> has gone through a mailing list.

There is RFC6377 which discusses this problem. On possible solution is
a mailing list service which understands DKIM and can check/sign the
messages.

See: https://tools.ietf.org/html/rfc6377

> You do have a few other oddities in there (the duplication of the
> common fields), but they shouldn't matter.

This is actually according to RFC. Listing signed header-fields
multiple times prohibits them from beeing modified and resigned my other
MTAs.

Thanks again,
Steffen

On Sun, Oct 28, 2018 at 03:53:07PM -0700, Linus Torvalds wrote:
> [ This is not about your patch series per se, only about your email settings ]
> 
> On Sun, Oct 28, 2018 at 3:20 PM Steffen Vogel <post@steffenvogel.de> wrote:
> >
> > This is my first series of patches for the Linux kernel.
> > I started by familiarizing myself with coding style and
> > satisfying my inner OCD by cleaning the 1-wire subsystem.
> 
> Sadly, your DKIM setup is wrong, causing all the emails to be marked
> as spam when they go through a mailing list.
> 
> Your DKIM header looks like this:
> 
>   DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
>           s=2017; t=1540764601;
> h=from:from:sender:reply-to:subject:subject:date:date:
>           message-id:message-id:to:to:cc:cc:mime-version:mime-version:
>           content-type:content-transfer-encoding:content-transfer-encoding:
>           in-reply-to:in-reply-to:references:references;
> 
> and the problem with that is the "sender" field in there.
> 
> A good mailing list will not change the contents of your email, or
> most of the other headers, but it *will* set the sender field to the
> mailing list.
> 
> 
> In other words, putting the sender field as part of the DKIM-checked
> headers is just wrong. It's a somewhat common mistake, but it's still
> wrong. I wonder where people get their setups from, because I think
> there is some DKIM guide on the internet that is actively spreading
> this bad behavior.
> 
> 
>                  Linus
