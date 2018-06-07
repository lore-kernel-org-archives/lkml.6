Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id aF+/KI6SGVsROwAAmS7hNA
	; Thu, 07 Jun 2018 20:16:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8955B6089E; Thu,  7 Jun 2018 20:16:14 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ku+w0Ps+"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0BA2460452;
	Thu,  7 Jun 2018 20:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0BA2460452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753535AbeFGUQM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:16:12 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32852 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753038AbeFGUQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:16:09 -0400
Received: by mail-pg0-f67.google.com with SMTP id e11-v6so5282615pgq.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 13:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PndY8nt6hDX2QEieL/x341vl4p6ilpI0NckdBwu1Ens=;
        b=ku+w0Ps+Ofn7mq6JmFt8mRBP3XcSawR1n5qVoQqW9A8l3g/tOJfT5400Z1w601FDgO
         tqEk48opUSYG6n2qps1k2ETC83XBG2xoG9UNvAUEW2lhpZzEbN576Tnq/V9DvU1W5XU5
         7X0Z6MqmzFPLfGuop66fv5pAwfuRQ4imFL5Eu+cxJ228g9HVuBfEWG6lBJU4NtIRJUbq
         UwIG12ZUoDZzs24tpeE7iGFoXJtKf1/XLZ6bkZuzfIuzQPmuX0XXnA2+/6kPIsMwmxmC
         O4iwBAA36cu15BYygNBM6fbZJTtJoaVaEqF6ueUDv1JA+kJRKm7oN1Nd2G2Ys2DqUmSN
         Qxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PndY8nt6hDX2QEieL/x341vl4p6ilpI0NckdBwu1Ens=;
        b=kfpbKZXxK0TU4T+08WMNibf90CHXORi1ytGAOQlkfZEfngyy2keDl0bTU64K2hGQyU
         Tr4q3ktSvWfHq+CAb05Z8dfjK6AIIW9KSt5YzJsBIei8zxThqmf3mTEdwgHw1k1Bi+cX
         +Kcmss8r0tFLWYOyApw9zx7Fu7owk24LBblgXqSCreQ6EL56WbnWuuhqMzCxapmPXuAJ
         +azYxrk2/Ox0sVM6dj/xKYjmvbvd3cHtBSqHtX3qyZvBGCdsCQJD53oQi9tM2xa/30H8
         8ZkFjFO4JkjzNMzfVMAeTUIrVTRpnyvkFo7QixXv75Ca1Gvr/tG7t/9s4i07otmK7F9i
         hjDw==
X-Gm-Message-State: APt69E2YzAPzF0pVaJaUzL0BkscLqA5cO+g3+2NuiuEZ7qIWQHRwoMT+
        etfYE8oQX0vQl99XL2IlSJ7UNzMHnZsjgCcWmx9n2Q==
X-Google-Smtp-Source: ADUXVKLHcMlAiIyiWQuNfar3V/y2/1TDeserioU50WLey5Uav6zRGufvayVOjQhYtaIObFbJ5qVAUlwIKa7k/zXwC4M=
X-Received: by 2002:a63:ad46:: with SMTP id y6-v6mr2733682pgo.10.1528402568646;
 Thu, 07 Jun 2018 13:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180607183219.192973-1-ndesaulniers@google.com>
 <20180607183219.192973-3-ndesaulniers@google.com> <2f7fc4bf-d0fe-0d3a-ffdd-02cc82c83747@linux.intel.com>
In-Reply-To: <2f7fc4bf-d0fe-0d3a-ffdd-02cc82c83747@linux.intel.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 7 Jun 2018 13:15:55 -0700
Message-ID: <CAKwvOdkhoOG=Ki-hLL-GtE_++TJ_fy6G_D+xER_vS-aZSjH61A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] x86/asm: add _ASM_ARG* constants for argument
 registers to <asm/asm.h>
To: "H. Peter Anvin" <hpa@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, hpa@zytor.com,
        mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        x86@kernel.org, virtualization@lists.linux-foundation.org,
        Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Greg Hackmann <ghackmann@google.com>, sedat.dilek@gmail.com,
        tstellar@redhat.com, Kees Cook <keescook@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        geert@linux-m68k.org, Will Deacon <will.deacon@arm.com>,
        mawilcox@microsoft.com, Arnd Bergmann <arnd@arndb.de>,
        David Rientjes <rientjes@google.com>, acme@redhat.com,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        boris.ostrovsky@oracle.com, "J. Kiszka" <jan.kiszka@siemens.com>,
        rostedt@goodmis.org, kirill.shutemov@linux.intel.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        akataria@vmware.com, brijesh.singh@amd.com,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        jarkko.sakkinen@linux.intel.com, jgross@suse.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Matthias Kaehlcke <mka@chromium.org>, thomas.lendacky@amd.com,
        Thiebaud Weksteen <tweek@google.com>, mjg59@google.com,
        joe@perches.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 1:14 PM H. Peter Anvin <hpa@linux.intel.com> wrote:
>
> On 06/07/18 11:32, Nick Desaulniers wrote:
> >
> > Suggested-by: Sedat Dilek <sedat.dilek@gmail.com>
>
> If this was suggested by Sedat, I didn't see that suggestion...

I took his suggestion which was to fix the typo in the commit message.
https://lkml.org/lkml/2018/6/5/776

-- 
Thanks,
~Nick Desaulniers
