Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6771CC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F0B21568
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="MY9tHArU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F0B21568
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbeI0ExI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:53:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41283 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbeI0ExI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:53:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id j15-v6so502429wrt.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 15:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tjCid2raywD9TiP/EG3nqgGcPqMQjzebtE2YnSs0iIk=;
        b=MY9tHArUFddizrowgA6vJAy3w3tm5x2TojafHcyCfxTRxYObxe4Qnnwfb9rLI5t+0B
         ly/JSX+avKDjEVPoP8bFX/6fMWvxIntu5CE+o7mXV0Hdt5lOa2RNO71xvdCh8EcCoaeD
         JKPlSZwnmMhWXtFWid5dNRVWx5po1ymQcOS3ZWzgoFok+D2Ow9xh2K6arumybw4aYDGj
         q2C3KlL40kjL2CY9vKTrWuVkmuBNEAboQZ35A29qtpR3AlR4APJiUTz4lowX88Lt6gZx
         e5ObnkbkKawEhxozfAQVx4PDUqasIAs5NpTDIJ86YRAdNIAya3E/S+k+o33WStzSA9yl
         VMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tjCid2raywD9TiP/EG3nqgGcPqMQjzebtE2YnSs0iIk=;
        b=HdcZs6p+zlcrrUfjgfzR0PKwl6hKxhGNZ+KHTGwQgYiBc7zTrq/Xp7I0lJhwFtKeND
         DCryMKW+akkIlnK+/MfJJt4lUM/HtgVaQnMlq3PoI2s9GDbubh9DCaWpZcXPoSCK7fak
         muwEXbgqEZ55YT62SrBP0Ftp2sTaz2S+ZMpGfZLolxjsycEIgHEpgVLojcDzliN6Fjwy
         HR/Y2D87OY9Esh+Dbqe42gCgDeYAmka+cLhKKEme2CeAqFQuFQsvjUbiDWQ33EwX9Hoo
         6vabyF0ZZG9CMygWxb+hUT3csF069OhuscAJ9VbFEEgBsWJcwyjOZJvgBH/DT50FQ7SY
         y5bQ==
X-Gm-Message-State: ABuFfoiaqWpsMBixEh9rpBhQsQcj90quHCF8dA5Vzd+HbLodMu4BLjEM
        6NSDdK5QifvTiWDoyiMs4HS6fLzk48H1ZSnj0jUAqw==
X-Google-Smtp-Source: ACcGV62KdfoXCLWz4mKm4KMSAVF/KS4dcv8+OiqQ+yH16Q1rbeD7TzgUQsL9CtmXPwTpF0FHfgeVN6kd5r2UA6xyAyo=
X-Received: by 2002:adf:dcc1:: with SMTP id x1-v6mr6644969wrm.21.1538001476929;
 Wed, 26 Sep 2018 15:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180925130845.9962-1-jarkko.sakkinen@linux.intel.com>
 <20180925130845.9962-10-jarkko.sakkinen@linux.intel.com> <CALCETrVAhiwv+g5fzVO3ZSHZgcQKbeeG8r3HUcXO9k7Gi94NdQ@mail.gmail.com>
 <20180926173516.GA10920@linux.intel.com> <2D60780F-ADB4-48A4-AB74-15683493D369@amacapital.net>
 <9835e288-ba98-2f9e-ac73-504db9512bb9@intel.com> <20180926204400.GA11446@linux.intel.com>
 <b7e14c6e-fc05-93fa-eef9-5e3f06ab4729@intel.com> <CALCETrXByb2UVuZ6AXUeOd8y90NAikbZuvdN3wf_TjHZ+CxNhA@mail.gmail.com>
 <992b1d6d-cc0f-776f-d938-2a1f7cad52c8@intel.com>
In-Reply-To: <992b1d6d-cc0f-776f-d938-2a1f7cad52c8@intel.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 26 Sep 2018 15:37:45 -0700
Message-ID: <CALCETrXyjRh1sBk1V21iTtjdhiWGCYsHnUNktkJC5xFiZy6c9A@mail.gmail.com>
Subject: Re: [PATCH v14 09/19] x86/mm: x86/sgx: Signal SEGV_SGXERR for #PFs w/ PF_SGX
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        X86 ML <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        nhorman@redhat.com, npmccallum@redhat.com,
        "Ayoun, Serge" <serge.ayoun@intel.com>, shay.katz-zamir@intel.com,
        linux-sgx@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 2:45 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 09/26/2018 02:15 PM, Andy Lutomirski wrote:
> > Could we perhaps have a little vDSO entry (or syscall, I suppose) that
> > runs an enclave an returns an error code, and rig up the #PF handler
> > to check if the error happened in the vDSO entry and fix it up rather
> > than sending a signal?
>
> Yeah, signals suck.
>
> So, instead of doing the enclave entry instruction (EENTER is it?), the
> app would do the vDSO call.  It would have some calling convention, like
> "set %rax to 0 before entering".  Then, we just teach the page fault
> handler about the %RIP in the vDSO that can fault and how to move one
> instruction later, munge %RIP to a value that tells about the error,
> then return from the fault.  It would basically be like the kernel
> exception tables, but for userspace.  Right?

Yeah.  Maybe like this:

xorl %eax,%eax
eenter_insn:
ENCLU[whatever]
eenter_landing_pad:
ret

And the kernel would use the existing vdso2c vdso-symbol-finding
mechanism to do the fixup.

>
> How would a syscall work, though?  I assume we can't just enter the
> enclave from ring0.

My understanding of how AEX works is a bit vague, but maybe a syscall
could reuse the mechanism?  The vDSO approach seems considerably
simpler.

We do need to make sure that a fault that happens on or after return
from an AEX event does the right thing.  But I'm still vague on how
that works, sigh.

--Andy
