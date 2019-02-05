Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDBCC282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B44D2070C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7TCpRGF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbfBEJDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:03:51 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39720 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbfBEJDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 04:03:51 -0500
Received: by mail-yw1-f67.google.com with SMTP id k188so1396568ywa.6;
        Tue, 05 Feb 2019 01:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iiLzaNANibauf4WDgP9oQJ7qsEJ7GeQ8Co2yEFUHTIY=;
        b=M7TCpRGFwBPB1IAhENhKs1QF/a46qPSjmqeRs3zKzekzh4em/YGC8RsQGRf/UyJKhY
         M94T3ExmxV8td1HycDiMeIYWJATjymIjspEGi36ns4QHwEVT1ByPbgTpZHEozl/kDshd
         z9/0F32EdKPdrmk21msVPKSr51OP7upVQ/He+j0aepxVNFGGPBFOQa18TFhD7pi9x+2w
         sb4i6d2T27RRBgBih0cxgcGruO4O2fegbHI1XGGWJt2nY79W/26GUrrE5In0FtHtLbP5
         poZZ5brFGjXxsTiqb+hwwNvtkfwQ/1E/9dGP3+pnftHhkB1+i/joqbXE1xn6/zVPODEG
         Mm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iiLzaNANibauf4WDgP9oQJ7qsEJ7GeQ8Co2yEFUHTIY=;
        b=YxC4j0zApwIu16fhTwXJ/4a4oW5YPj8rCHMnm+cmZVJdXM8m1zfD9VZ9lkeJX5nSoL
         Y7plRaee33KewMzrmPX4BcFGQLmUFGoV+LSfzlbwXDtSNWenTcfrA9F5u4XHLKbG1LcQ
         86q+fz/PibExbP5cG6t8ytnq5Qnhd7LOo0esUq80lTsy53+2p9phWbII7YuTcwsvCbba
         uHZ6MEmM8kN73NYKzr6Gl+a4W48HY2GHvVvgul4CgF6pXSDIdXlVBoXuTgVt1lB8TD2v
         4lspOlcu+w98H3qpidPhV5OiXyyHuDXCxC1eSVMnWV58pOJ0dOpzoanvXbEIk07+vfUX
         U8og==
X-Gm-Message-State: AHQUAuZM4dFVV19+9MngCmr8lR+cBMHevv/fLRHmRszkAL2e3GUPr3qC
        dzAkQZCZXyd2mb7xc2N79rI=
X-Google-Smtp-Source: AHgI3IYEVOw5QrKXj8H8lemNUvI0jmUElJMn+NPfl6e6MupMXqPWylkV9RxkZ0L0f9/SikFyHUah9w==
X-Received: by 2002:a81:2514:: with SMTP id l20mr3002708ywl.3.1549357429310;
        Tue, 05 Feb 2019 01:03:49 -0800 (PST)
Received: from [10.33.115.182] ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id e9sm1047040ywb.45.2019.02.05.01.03.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 01:03:48 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2 04/20] fork: provide a function for copying init_mm
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20190205085311.GH21801@zn.tnic>
Date:   Tue, 5 Feb 2019 01:03:45 -0800
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Damian Tometzki <linux_dti@icloud.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>, Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Transfer-Encoding: 7bit
Message-Id: <BF9D1501-5EFF-46FB-8DAB-8C7A2088DB42@gmail.com>
References: <20190129003422.9328-1-rick.p.edgecombe@intel.com>
 <20190129003422.9328-5-rick.p.edgecombe@intel.com>
 <20190205085311.GH21801@zn.tnic>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Feb 5, 2019, at 12:53 AM, Borislav Petkov <bp@alien8.de> wrote:
> 
> On Mon, Jan 28, 2019 at 04:34:06PM -0800, Rick Edgecombe wrote:
>> From: Nadav Amit <namit@vmware.com>
>> 
>> - * Allocate a new mm structure and copy contents from the
>> - * mm structure of the passed in task structure.
>> +/**
>> + * dup_mm() - duplicates an existing mm structure
>> + * @tsk: the task_struct with which the new mm will be associated.
>> + * @oldmm: the mm to duplicate.
>> + *
>> + * Allocates a new mm structure and copy contents from the provided
> 
> s/copy/copies/

Thanks, applied (I revised this sentence a bit).

