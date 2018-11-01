Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53409C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1045E205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzM2gZrc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1045E205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbeKAXhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:37:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33871 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbeKAXhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:37:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id f1-v6so1917300wmg.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 07:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=doC4a68ijO/gdT3cIlg+bwo6fuYr/HydJ/wMXO1+oO4=;
        b=fzM2gZrciwxBzvpjalznnpMW1h+znxViaT9pxKpW363vnKptTcTsFRwKGxxJA2Umdh
         klNiaY9BYQmiiOXKXrHA/KAi5jOTQuRGDZQP41Ve3mxs0eah2VAe9LQK66YOJOsLmTTz
         QaYdIWW2tDlD+Kh/GpV+DukJh9OPf1kR1RPTxJYSXNTlwOfrjLmGkGvV2L2nCrMr5YFA
         89ZN1ntALb7zgWq/T/ofL8aCOi5oiDGPtgTZAIhhnxsZW6xIBWjs1wRMWZ76O+zLBQtH
         sYOfJmS81nmOzR8D5imO8YAS9IW/HDvdKqfzvs2X380E0oh4vB81x/4sCniecEF7NH4S
         lnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=doC4a68ijO/gdT3cIlg+bwo6fuYr/HydJ/wMXO1+oO4=;
        b=prgtg+niMl47pQr3PqXItUpVVsYvijxfvaKQJ3Huvjyn7wLfM3Pls1R0FQqrNYPE1C
         iSQVsLtkRsgbukrka9yPZPo7qNUIHTsJQD0gQy3FwD3Lts9uMhJ9eN1mMPsfNWhdTDK2
         J0qNALxS6gjgrR16DYV6DAXCYC0gS4nF3KflNja8sgV1OIzu4et6QjAdz3XS/85FifuW
         UosNro7xURnB495oZ3FVikWSHhGLmfrewFV8JURdWsJBCf2hH/uqf0siPr9pTolWUC7Q
         szIcBt86CHIyrx4WdjGh282/nj9o+jeaLp+ON/dcvSxpfsXCKx4oCk3rxbTtSY04pgde
         p0Kw==
X-Gm-Message-State: AGRZ1gIxdDIdK7WZ9qnx5ipYWCDbEwsWKmHCM1GZdyux5li+15BVW3La
        ukwATcsV4ITkiziLSNVmeUY=
X-Google-Smtp-Source: AJdET5dzA39rnBkVQgZ4NZkz8YCDEGQmTL3k6mFFOWpBU+M5qYzzE/KqBRXRHZQYtOm5LIZsTRzRzg==
X-Received: by 2002:a1c:32ca:: with SMTP id y193-v6mr5710658wmy.29.1541082865800;
        Thu, 01 Nov 2018 07:34:25 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id g76-v6sm24702360wmd.25.2018.11.01.07.34.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 07:34:24 -0700 (PDT)
Date:   Thu, 1 Nov 2018 15:34:21 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Woodhouse, David" <dwmw@amazon.co.uk>,
        "zhenzhong.duan@oracle.com" <zhenzhong.duan@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@suse.de" <bp@suse.de>,
        "srinivas.eeda@oracle.com" <srinivas.eeda@oracle.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "michal.lkml@markovi.net" <michal.lkml@markovi.net>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "luto@kernel.org" <luto@kernel.org>
Subject: Re: [PATCH v2 1/2] retpolines: Only enable retpoline support when
 compiler support it
Message-ID: <20181101143421.GA81370@gmail.com>
References: <991cbe9b-1e31-4b12-b572-91fde5c79699@default>
 <20181101095002.GA118944@gmail.com>
 <90a9eed724b28d5af57a71694a95b4cd92728ccc.camel@amazon.co.uk>
 <alpine.DEB.2.21.1811011317400.1642@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1811011317400.1642@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Thu, 1 Nov 2018, Woodhouse, David wrote:
> > On Thu, 2018-11-01 at 10:50 +0100, Ingo Molnar wrote:
> > > * Zhenzhong Duan <zhenzhong.duan@oracle.com> wrote:
> > > 
> > > > Since retpoline capable compilers are widely available, make
> > > > CONFIG_RETPOLINE hard depend on it.
> > > > 
> > > > The check of RETPOLINE is changed to CONFIG_RETPOLINE.
> > > > 
> > > > This change is based on suggestion in https://lkml.org/lkml/2018/9/18/1016
> > > > 
> > > > Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > 
> > > Please turn such 'based on suggestions' into proper tags as well, i.e. 
> > > something like:
> > > 
> > >   Suggested-by: David Woodhouse <dwmw2@infradead.org>
> > 
> > I think the suggestion came from PeterZ; I just acked it.
> > 
> > Although on furthe reflection, I think I'd prefer a build break if
> > retpoline is enabled in the kernel config and the compiler doesn't
> > support it. This patch would make it silently fail to be secure.
> 
> Agreed.

Yeah, I agree that that's the best policy: if someone wants retpoline 
support it shouldn't silently turn off just because the wrong toolchain 
was used to build the kernel ...

Thanks,

	Ingo
