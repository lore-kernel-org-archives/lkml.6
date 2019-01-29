Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6738C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9FE21848
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TtrDl0sI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfA2SB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:01:27 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:52317 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfA2SB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:01:27 -0500
Received: by mail-it1-f194.google.com with SMTP id d11so6007073itf.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 10:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HFLcmZRdtfOMUjL6y+ITpWj0h4Prto3YXF8EnuxSDIA=;
        b=TtrDl0sIu0GDlmZOahDDcYoLakqDLdBMnqbxeqaV3Tb7QsmEMGni7EBN+uy75sNcbH
         JTk47qrF8MZkhXnWpOCD0zCZpop+ohMPVEMUDzd2y7jGmsw2+lLv/OJBqsI0Sd3PAYOF
         Cm4mBALmjAcNYd6XP6nJ3dRAkRjcz3cgm1QPOmvx63FtID0u6r3yUHrBziHTRNSB85rV
         YL7Mr6c8ZRFebCSPvzpyd24f7YT7q3BDXQJvj21yukg8eKF2xIpJhX55gaNjxAB6NFeU
         rKV2vzJB5WMzBlr7wyOJ5Qe6NYLFhe9ta/l6KVVEPcMxcrvhcXXEF9Lk5UX8v0BUqHgz
         +qlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HFLcmZRdtfOMUjL6y+ITpWj0h4Prto3YXF8EnuxSDIA=;
        b=j78HKxqmYljl8ImWJWFu3jPCTRKeWnDpurEBCYfhDbVwhqa6vEzfUl3OJsPjHTIGTm
         C38H9iZSbIFIHZq4P48gl3EPeF3J2CtaVKzOCC/EU1c3jkXP4Hw5ufn1odzQaExv8pFC
         S1+G5tg+Vu2ll4Q2HpvmtEReaE6oKAXqt9baTcf48k4mCXySvABfTnR61DBsyACe8Via
         04xw4sL4JIaEZAOa8N2C/AsLGm5rbx+za62D0fTpD0JOeKfC2dVJkpLVOeo010BObatP
         /Eg1KshioqJAbLKX2Wihmmo6iGD6hJlMc716vpT4qJ9ApAIzslNvoxH321+A7Cmo+FdA
         DGcQ==
X-Gm-Message-State: AHQUAubr1wDUTBmfL/cGIlYL1ca84UUyHawrXPUxi7caVacHrCPOraO+
        87Dyer/mka7Ate3Nua/OtKUX/+PsQbAHEyfgTwUtWw==
X-Google-Smtp-Source: AHgI3Iby8mIyl7dJxmik1yVXa6mfOpYWEd66nlwv5adyBG7r7PYJ8PwmMY+1YIz6cAERynLWVWj2+GwNCW0FbIrFCCA=
X-Received: by 2002:a24:e302:: with SMTP id d2mr1576787ith.155.1548784886132;
 Tue, 29 Jan 2019 10:01:26 -0800 (PST)
MIME-Version: 1.0
References: <20190122205909.24165-1-weijiang.yang@intel.com>
 <20190122205909.24165-2-weijiang.yang@intel.com> <CALMp9eQGg-g54zjWRcU3kkSR2kSHA0g18PURVvC1QLnC4fSYTA@mail.gmail.com>
In-Reply-To: <CALMp9eQGg-g54zjWRcU3kkSR2kSHA0g18PURVvC1QLnC4fSYTA@mail.gmail.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 29 Jan 2019 10:01:15 -0800
Message-ID: <CALMp9eR_KbgNWfpXJr+FzP2e68isK3RsXwN1QgH72ni8VHwzfA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] KVM:VMX: Define CET VMCS fields and bits
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, yu-cheng.yu@intel.com,
        yi.z.zhang@intel.com, hjl.tools@gmail.com,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 9:47 AM Jim Mattson <jmattson@google.com> wrote:
>
> On Wed, Jan 23, 2019 at 6:06 AM Yang Weijiang <weijiang.yang@intel.com> wrote:
> > Note: Although these VMCS fields are 64-bit, they don't have high fields.
>
> This statement directly contradicts the SDM, volume 3, appendix B.2:
>
> "A value of 1 in bits 14:13 of an encoding indicates a 64-bit field.
> There are 64-bit fields only for controls and for guest state. As
> noted in Section 24.11.2, every 64-bit field has two encodings, which
> differ on bit 0, the access type. Thus, each such field has an even
> encoding for full access and an odd encoding for high access."

Ah! They're not actually 64-bit fields. If you look at the encodings
(0x68XX and 0x6cxx), they're natural-width fields! Natural-width
fields don't have a high component.
