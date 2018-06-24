Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EA0C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 10:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2715D24E96
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 10:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAsaj2mB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2715D24E96
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752145AbeFXKo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 06:44:57 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40692 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751721AbeFXKoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 06:44:55 -0400
Received: by mail-wm0-f66.google.com with SMTP id z13-v6so744243wma.5;
        Sun, 24 Jun 2018 03:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HBKFEOi8H4Y0IfQR40zprY6I9roHWIge0POh0XCtUZ8=;
        b=JAsaj2mBIa75vWL6lmW1NVBmdYIkDKZw2e/0kCIIDwQr1SSK8pTC1jgBlI7wjHucF1
         2vqA/cYU1XNkXbZwD3ULjQbAGx0QASmRTVd+jFeKi9a35B0bF+Fil0u32y0QjTLwsUKp
         HwxpFdDWME0NnZGg5i9YgctkjWKyEx0Xr4oPaTnawppUOPvT7vZnHqdH7XUGnsfd10v7
         lLmeUlXtB+tEpvOC9AkWJ50++6CbjRD1uoQEEtp+W53Yw+bXYzPxU1BajFnKrZV6JjNv
         97rLXidgdmfVGewKhDGFcsJWZsj2nEykgPBPnNC6OD+8tW04p0FgyejI12HHtPjCkmVg
         s1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HBKFEOi8H4Y0IfQR40zprY6I9roHWIge0POh0XCtUZ8=;
        b=TSxty0XNwwLL0yGmcx5qOkB9ZqdKWIQAwOX4sJoccK8qUm3rok4BU6Bui8UWgDrcfl
         LXP0pwHf+ygVviAOmfbSfRdlPJgm1IBrgKIFJ2y34Fh0gtwuXeTUUnUhPe9Hdst7Xkt8
         6tZPyS8hl0mtvAGHYjbLbR5nJFPbJ1SKI18P3ixA6ywBnsyfeOXyM6FCyGfkicB9oUAX
         4i+Z717z+vK7hPKmUJAXFz4N4StPX/sFFZbga0L9xdofH4WzKFaJe7pW2xA6Ionu7Jyg
         NSA30TungaH8fo9/Ld0ZTFanNi/QYfpd8GCLNAxywjTViRNCoDN/L9MTmsrZxy/wySK1
         KMmQ==
X-Gm-Message-State: APt69E1+HfEJ0o1fGrmpsg+IlxiaGlnhRhLdlsakiVQ5hkE7Po//erIb
        b/MZmZLRCWbAYwPllUhJSA==
X-Google-Smtp-Source: ADUXVKLL09XWO+ptylP9Shn/T+x+SpPdWRAhGmvrWNTVCQrvFhnSMjueC8IbrI3meFU42WHPRT7Fdg==
X-Received: by 2002:a1c:5c93:: with SMTP id q141-v6mr6283805wmb.77.1529837094223;
        Sun, 24 Jun 2018 03:44:54 -0700 (PDT)
Received: from avx2 (nat7-minsk-pool-46-53-221-92.telecom.by. [46.53.221.92])
        by smtp.gmail.com with ESMTPSA id e63-v6sm8426659wma.46.2018.06.24.03.44.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 03:44:53 -0700 (PDT)
Date:   Sun, 24 Jun 2018 13:44:49 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, linux-crypto@vger.kernel.org,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        tglx@linutronix.de, jpoimboe@redhat.com, luto@kernel.org,
        peterz@infradead.org, brgerst@gmail.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, dvlasenk@redhat.com,
        h.peter.anvin@intel.com,
        linux-tip-commits <linux-tip-commits@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] x86/crypto: Add missing RETs
Message-ID: <20180624104449.GA20159@avx2>
References: <20180507213755.GA32406@avx2>
 <tip-51bad67ffbce0aaa44579f84ef5d05597054ec6a@git.kernel.org>
 <1529235613.4572.7.camel@gmx.de>
 <20180617120012.GB16877@zn.tnic>
 <1529242717.4472.3.camel@gmx.de>
 <1529244178.4674.1.camel@gmx.de>
 <20180617194747.GA21160@zn.tnic>
 <1529289279.31745.3.camel@gmx.de>
 <20180623103622.GA2760@zn.tnic>
 <20180624071105.GA29407@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180624071105.GA29407@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 24, 2018 at 09:11:05AM +0200, Ingo Molnar wrote:
> > Add explicit RETs to the tail calls of AEGIS and MORUS crypto algorithms
> > otherwise they run into INT3 padding due to
> > 
> >   51bad67ffbce ("x86/asm: Pad assembly functions with INT3 instructions")
> > 
> > leading to spurious debug exceptions.
> > 
> > Mike Galbraith <efault@gmx.de> took care of all the remaining callsites.
> 
> Note that 51bad67ffbce has been zapped because it caused too many problems like 
> this, but the explicit RETs make sense nevertheless.

So commit which found real bug(s) was zapped.

OK
