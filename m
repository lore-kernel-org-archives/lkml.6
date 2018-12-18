Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA85C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 04:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9892217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 04:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545108919;
	bh=hm37NK8+07WNPhfUTNJSwfaSFCHQ57lLMeJNDoUbpYo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bTpadSkA+qQ9f7+EbXTUyVBX1M8hwaQnKQDuROekDbDu4r/F6pIi+JbiG1JNhF0zl
	 wRUT0ZbA1rTd/VIxeV+RdtKXVrcnEwVn/7L7urfpufHu2f99oc13GNOlI7shB+3Uyv
	 e7TQpyIgnkJ3pN3OBHnG9lSbH7mMidlOWo4VpnII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbeLREzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 23:55:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:41056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbeLREzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 23:55:18 -0500
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42AC2217D9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 04:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545108917;
        bh=hm37NK8+07WNPhfUTNJSwfaSFCHQ57lLMeJNDoUbpYo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nwsq4h2zZQXNpRmpXzFtgWecH74Nat0wAa2CbleDMHyM10pLVaSPskwtmkK2EQ3v/
         CwtLHDe/XB8qHL5jgzLNOuq2sF6QujVkR/3naceBaPvzIk7rUNA44erg/xJqhXUGoG
         W6zuHuo9PJek7lR0nD1UL6LjkWZGHdT7qFRKDcFE=
Received: by mail-wm1-f49.google.com with SMTP id b11so1232663wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 20:55:17 -0800 (PST)
X-Gm-Message-State: AA+aEWYeqrv00xv9sShBnJDSmZs2W7rP13IJBxFXR9GIJEqkkNuMH61p
        Gvt+DdzekZeDSL1orT35uaccaXR7JSscPtC2lnrRBg==
X-Google-Smtp-Source: AFSGD/WhXbKKrBtATO6MnFIm1QmNzoGGRKo1/Jz+6Kym7Pfoq0711hLzOY3QhA7Tb6Putecdmzw3rnR0RBsrtmVWfk0=
X-Received: by 2002:a1c:b1d5:: with SMTP id a204mr1639599wmf.32.1545108913807;
 Mon, 17 Dec 2018 20:55:13 -0800 (PST)
MIME-Version: 1.0
References: <20181116010412.23967-1-jarkko.sakkinen@linux.intel.com>
 <20181116010412.23967-19-jarkko.sakkinen@linux.intel.com> <7d5cde02-4649-546b-0f03-2d6414bb80b5@intel.com>
 <20181217180102.GA12560@linux.intel.com> <20181217183613.GD12491@linux.intel.com>
 <20181217184333.GA26920@linux.intel.com> <ccfb67a0-fd8d-82c8-8018-fd68e901f287@intel.com>
 <CALCETrX0W4dhFJBHEbDbKed_QZxmw6ZNMajfsoVgqGqhMB0nDg@mail.gmail.com>
 <20181217222047.GG12491@linux.intel.com> <20181218013918.GC333@linux.intel.com>
In-Reply-To: <20181218013918.GC333@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 17 Dec 2018 20:55:02 -0800
X-Gmail-Original-Message-ID: <CALCETrUy25OJ8Q4eH81hwtvQyLGTmYCMMkEs+m8uNWqoFVt=-g@mail.gmail.com>
Message-ID: <CALCETrUy25OJ8Q4eH81hwtvQyLGTmYCMMkEs+m8uNWqoFVt=-g@mail.gmail.com>
Subject: Re: [PATCH v17 18/23] platform/x86: Intel SGX driver
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-sgx@vger.kernel.org, nhorman@redhat.com,
        npmccallum@redhat.com, "Ayoun, Serge" <serge.ayoun@intel.com>,
        shay.katz-zamir@intel.com,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Svahn, Kai" <kai.svahn@intel.com>, mark.shanahan@intel.com,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 5:39 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Mon, Dec 17, 2018 at 02:20:48PM -0800, Sean Christopherson wrote:
> > The only potential hiccup I can see is the build flow.  Currently,
> > EADD+EEXTEND is done via a work queue to avoid major performance issues
> > (10x regression) when userspace is building multiple enclaves in parallel
> > using goroutines to wrap Cgo (the issue might apply to any M:N scheduler,
> > but I've only confirmed the Golang case).  The issue is that allocating
> > an EPC page acts like a blocking syscall when the EPC is under pressure,
> > i.e. an EPC page isn't immediately available.  This causes Go's scheduler
> > to thrash and tank performance[1].
>
> I don't see any major issues having that kthread. All the code that
> maps the enclave would be removed.
>
> I would only allow to map enclave to process address space after the
> enclave has been initialized i.e. SGX_IOC_ENCLAVE_ATTACH.
>

What's SGX_IOC_ENCLAVE_ATTACH?  Why would it be needed at all?  I
would imagine that all pages would be faulted in as needed (or
prefaulted as an optimization) and the enclave would just work in any
process.
