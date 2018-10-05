Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5ABC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EEC320875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ra/93R9z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EEC320875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbeJETvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 15:51:23 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51066 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbeJETvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 15:51:22 -0400
Received: by mail-wm1-f67.google.com with SMTP id s12-v6so1786893wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 05:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yFXLkNbB8/pRPPIUTxLN9N9EtFvGRDMKDzHzGrT3+bg=;
        b=Ra/93R9zhuWhXyCRGx+lfmZpVfwOVsHK8sKYkmWy/+hY69hXNqV2HBHbRDe6bUmywN
         /Q2JJG+tf6Sm+wg6fygBaFgKc3HR1WcsZAh0mG2MMQnmunL2jzT3kUJD571lcHyujmMY
         oaSf3uvW6tzQZZ/FwTJg+nebszx3PnUn7y5c/xLcG6n5JLS7iTepru2Rhymam4dHsbpk
         n09btlFMNzRYgFPHFOTvyQUAYMW90BSVQlkwxdQRUOg+VQM3Zi3NKhaGtN7TCKLuV3R1
         5aUihigOFOslV/yCx25/WdX/S9kcTyV/arAQ4y4cqXE6OTpaAIGx++MdihekXq/wmnHR
         VQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yFXLkNbB8/pRPPIUTxLN9N9EtFvGRDMKDzHzGrT3+bg=;
        b=hBT2LbFqxRYbl9bDK+HsJH2+spj9YZ33zmyXnrXB53G0Edc/2WnLBAM1W2ia3g3C0a
         nBYWqunCCDXHR5CnccGPIv+HFdRBrVEX7fwK2fKhrVxPAMOyQWi8f18HhVFOFcWM9mqK
         l1T4snnIVzwFD6l2coDFU7mCJXpaajh7Pg5+fDGGA5D3si5MyZKhRBGVZE4cZ19zkLLQ
         PCzCCB654my3XvjlkzZOUvRlUDEgIfo9wIZ+bL6ve9hlNlow9g0tR4MkJMlK31Azm0o0
         zx0j6+vc3UxHSfdCRD3tOUdLiBr0+nlVvJgAY0QuLCAdQzt8ZiJLVuBIXvX1gzo/tGqS
         i8ow==
X-Gm-Message-State: ABuFfoiJp/SoTXAJ52ldomLTTtr/NXg7Ory222jesN/9E8dzfZOr0OBl
        wQaIOkmpzrnqHSG/NqS88hY=
X-Google-Smtp-Source: ACcGV63PjZUREQ6HTPqBEVTuqCEzMpsg86RKrniVeZmNfPMZas4SYb2yixL6oDPbx7lSPN8LhgrWfw==
X-Received: by 2002:a1c:80d4:: with SMTP id b203-v6mr8113257wmd.100.1538743965037;
        Fri, 05 Oct 2018 05:52:45 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 67-v6sm1729590wmd.1.2018.10.05.05.52.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 05:52:44 -0700 (PDT)
Date:   Fri, 5 Oct 2018 14:52:41 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Nadav Amit <namit@vmware.com>, "hpa@zytor.com" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v9 04/10] x86: refcount: prevent gcc distortions
Message-ID: <20181005125241.GA4671@gmail.com>
References: <20181004075755.GA3353@gmail.com>
 <20181004083333.GA9802@gmail.com>
 <10D29A50-C352-4407-A824-0C3C06CD8592@zytor.com>
 <A5DED74C-A95A-48D8-AF68-39E23696385F@vmware.com>
 <20181004091222.GB21864@gmail.com>
 <D42AB116-BFA4-4CF0-BF45-41C579A9B4C7@vmware.com>
 <20181004094519.GA97692@gmail.com>
 <29591D3B-D49B-4D7A-B280-85A2C3F63F9C@vmware.com>
 <20181005093108.GA24723@gmail.com>
 <20181005112010.GC10285@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005112010.GC10285@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> On Fri, Oct 05, 2018 at 11:31:08AM +0200, Ingo Molnar wrote:
> > 
> > * Nadav Amit <namit@vmware.com> wrote:
> > 
> > > > Are you using defconfig or a reasonable distro-config for your tests?
> > > 
> > > I think it is best to take the kernel and run localyesconfig for testing.
> > 
> > Ok, agreed - and this makes the numbers you provided pretty representative.
> > 
> > Good - now that all of my concerns were addressed I'd like to merge the remaining 3 patches as 
> > well - but they are conflicting with ongoing x86 work in tip:x86/core. The extable conflict is 
> > trivial, the jump-label conflict a bit more involved.
> 
> FWIW, gcc guys are not too averse to the idea of enhancing gcc inline
> asm syntax with a statement which specifies its size so that gcc can use
> it to do better inlining cost estimation than counting lines.
> 
> Lemme work the process ...

Thanks!

	Ingo
