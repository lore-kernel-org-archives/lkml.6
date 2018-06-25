Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0869C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7AB82551D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGNm8KM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7AB82551D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752415AbeFYHYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 03:24:46 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37913 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752204AbeFYHYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 03:24:43 -0400
Received: by mail-wm0-f68.google.com with SMTP id 69-v6so8696808wmf.3;
        Mon, 25 Jun 2018 00:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uOTQYQa8K4kzhU9jNZET3iWzo0h6B0N16fLmsOgI28k=;
        b=kGNm8KM+sWTOJXQUTeuw2dUAsP88afOYLMJqMIhvtkfSdX92LfzriwGLHrGpeb8/Ve
         3PkdBVHWU+Pu5hGOXgee4TJ2AlBVq2TLOQzOO7XrqgNbQd1fXIh5GcxlKu0AIuobBFZG
         PjWzXkrM0bUbNG0/YBym6Y8fKleGic7UUSMkmxoNYwz0IE5Yt85ZqKEOv8SY6zRt6A5P
         LKMxnR8irUOOB62cHlLeeu9HDHgnEosY887/dIEDnOaqGcQI4MyjtHUWp+TMlE4PwbHR
         es6jAP9fQj9YSAQRGsLoBLSJUJmmt8ZRcHPRZN1fqqU1b3W9+m1UTQRYhTnhwASC0i5A
         3bxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=uOTQYQa8K4kzhU9jNZET3iWzo0h6B0N16fLmsOgI28k=;
        b=NeNB0bhRaTVB19KSVyg1Ab6wqGD2IlOJgGvt9DX7j1p3eQNKVf+59pI39OKXc/0Wgj
         XyIWQ7RorjVhasCwcATG1YbFY0lxFVtA4KSyDRqBAHL/TLIVdculjY/sAsHeA8bwe/a8
         KWUNjEhLQIcRv48IdqReu8hAzZsanTSjSvkTgAMSdPNV6JTiPEtFWYhnJFketR5OGXR7
         cxcy8XV4XyCEOhCSl9IrGYMmBzQrQgX4dMi/VR0IvhwXdHDFV3jhKbeljKC52BGj/6Gk
         yLFPWsiXCSB/1GldzqLBPIR2zRf1klTNf/tBUVEFDGkKah49TvhA0g6fVcBncOgaGwNh
         8MDg==
X-Gm-Message-State: APt69E3Uy9e+8gf+ykep11WKMSx7rSybYZiXSTXqslnusR6eAU3JUwfL
        X+XDRVuEB4owWjKSpFpCJIY=
X-Google-Smtp-Source: AAOMgpfE/IPCcVfxKrHbXtjcpa2kFl1JoEUBvn/OX82txYrmAPyhc26bXOgff0JnxRXKQcfM8yDYNQ==
X-Received: by 2002:a1c:e48a:: with SMTP id b132-v6mr7160wmh.129.1529911482008;
        Mon, 25 Jun 2018 00:24:42 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id m145-v6sm8422126wma.19.2018.06.25.00.24.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 00:24:41 -0700 (PDT)
Date:   Mon, 25 Jun 2018 09:24:38 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-crypto@vger.kernel.org,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        tglx@linutronix.de, jpoimboe@redhat.com, luto@kernel.org,
        peterz@infradead.org, brgerst@gmail.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, dvlasenk@redhat.com,
        h.peter.anvin@intel.com,
        linux-tip-commits <linux-tip-commits@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] x86/crypto: Add missing RETs
Message-ID: <20180625072438.GA19063@gmail.com>
References: <tip-51bad67ffbce0aaa44579f84ef5d05597054ec6a@git.kernel.org>
 <1529235613.4572.7.camel@gmx.de>
 <20180617120012.GB16877@zn.tnic>
 <1529242717.4472.3.camel@gmx.de>
 <1529244178.4674.1.camel@gmx.de>
 <20180617194747.GA21160@zn.tnic>
 <1529289279.31745.3.camel@gmx.de>
 <20180623103622.GA2760@zn.tnic>
 <20180624071105.GA29407@gmail.com>
 <20180624104449.GA20159@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180624104449.GA20159@avx2>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Alexey Dobriyan <adobriyan@gmail.com> wrote:

> On Sun, Jun 24, 2018 at 09:11:05AM +0200, Ingo Molnar wrote:
> > > Add explicit RETs to the tail calls of AEGIS and MORUS crypto algorithms
> > > otherwise they run into INT3 padding due to
> > > 
> > >   51bad67ffbce ("x86/asm: Pad assembly functions with INT3 instructions")
> > > 
> > > leading to spurious debug exceptions.
> > > 
> > > Mike Galbraith <efault@gmx.de> took care of all the remaining callsites.
> > 
> > Note that 51bad67ffbce has been zapped because it caused too many problems like 
> > this, but the explicit RETs make sense nevertheless.
> 
> So commit which found real bug(s) was zapped.
> 
> OK

No, what happened is that the commit was first moved into WIP.x86/debug showing 
its work-in-progress status, because it was incomplete and caused bugs:

   https://lore.kernel.org/lkml/20180518073644.GA8593@gmail.com/T/#u

... and finally, after weeks of inaction I zapped it because I didn't see progress 
and you didn't answer my question.

If a fixed patch with updated tooling to detect these crashes before they occur on 
live systems is submitted we'll reconsider - it didn't get NAK-ed, it's just 
incomplete in the current form.

Thanks,

	Ingo
