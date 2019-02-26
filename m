Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96E5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC8F21852
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BTpBcq2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbfBZTtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 14:49:12 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:33918 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfBZTtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 14:49:11 -0500
Received: by mail-io1-f67.google.com with SMTP id e1so11525068iok.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 11:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vOx1ZmSkQAaybngNdfzFBv6eH9pUxDtduE3wCio0URg=;
        b=BTpBcq2oeSNakpyRRhfA0V+0z3LMufszODZ2HLRF7Oe4UhCwOwYpY8UH7fViKDcofB
         hDvLoBmpjIxNAZW8GQNKR1CBk8SLtMSO37WXhs2Vf8ktLcm/97kZodHZBBLr1MlvjRQE
         kyRUkKS4PoGZtzGTIsZJ/+DR7kZiXYV5e4Fv30zpLlkW900ro6igD/OsbcKym0iOtV+b
         e+T4SX9+4nlZQaFInhEvBqMQkiMvINlwOtfybtU0HDl/bOOdpnDSB62a03hV6BhJ/fVn
         9Q0IqsqN2+At9oDsESRjiMHPp9FSvrbIezL1St1ircdV4LXe6De1YEt+kVPneG0bwQmu
         P/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vOx1ZmSkQAaybngNdfzFBv6eH9pUxDtduE3wCio0URg=;
        b=S9IVPlOqjtq2vJ7CmtqQRKVZPZ22lzR1vzpF41coHZBe9Pl3H4AomeBrenz9BRxY0x
         0qNIRvBdLxtp5YKxw2R1qtCUmR2aOpkFA0We50l+BNldNap/fPrmqXbJ8Mt59tYpXVEO
         a4YCECCYr0r2BrsPkMUmmq+CFCK20V4xIQtff/uG1vWC4d+T44PN/eDad4fUwake9g1u
         drzf9MgibB1KpzDSnTJ+dSkQeR1CAyrMjm7TcIjFCMIwIDhONUTk1vz+sC+f6J1U7A+/
         qrAfv58mBV9hs1odaceq+UfeSg60N/JVe7R21kCePP0iO3IblyEtq//gkJtFg2W/Cp/0
         XDPw==
X-Gm-Message-State: AHQUAuZ+LRuVAHiY2i4+b002McjnswuCahZ4+NohSpLodHtiL+33M7XW
        SZ4lJddc8gMSmvBiHTryaIa/WQWXkSqPxVIlP5rrcQ==
X-Google-Smtp-Source: AHgI3IaINITEIjTc+2a+QsfQj4XNau9/6feTCxSVFvG/juJSDY1o374+6uuBl+6UZ1FvZFIBf2hr65D9o1OzqH/i1HA=
X-Received: by 2002:a6b:c545:: with SMTP id v66mr14161803iof.40.1551210550511;
 Tue, 26 Feb 2019 11:49:10 -0800 (PST)
MIME-Version: 1.0
References: <20190225132716.6982-1-weijiang.yang@intel.com> <20190225132716.6982-3-weijiang.yang@intel.com>
In-Reply-To: <20190225132716.6982-3-weijiang.yang@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 26 Feb 2019 11:48:59 -0800
Message-ID: <CALMp9eRJ_ayTPbDC5nOuJ00GjRxqd+je0qAyCoeyU9zT698XhA@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] KVM:CPUID: Define CET CPUID bits and CR4.CET
 master enable bit.
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, yu-cheng.yu@intel.com,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 10:32 PM Yang Weijiang <weijiang.yang@intel.com> wrote:
>
> Guest queries CET SHSTK and IBT support by CPUID.(EAX=0x7,ECX=0),
> in return, ECX[bit 7] corresponds to SHSTK feature, and EDX[bit 20]
> corresponds to IBT feature.
> CR4.CET[bit 23] is CET master enable bit, it controls CET feature
> availability in guest OS.
>
> Note: Although SHSTK or IBT can be enabled independently,
>       either of the features is controlled by CR4.CET.
>
> Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>

Am I missing something? X86_CR4_CET and X86_FEATURE_SHSTK and
X86_FEATURE_IBT don't appear to be defined in Linus' tree.
