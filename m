Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0F2C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 16:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E9D20891
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 16:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing-com.20150623.gappssmtp.com header.i=@juliacomputing-com.20150623.gappssmtp.com header.b="CtO+JUDe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2E9D20891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=juliacomputing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934323AbeFQQtE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 12:49:04 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:51763 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933989AbeFQQtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 12:49:03 -0400
Received: by mail-it0-f68.google.com with SMTP id n7-v6so8917879itn.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 09:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qH2Xjve5YhaOSPUA80W94AgzgoRNT2ulp4Ibpbqyp18=;
        b=CtO+JUDeUg0SCni/FFwtaaM5S6UA4WEgqN59qybzmXKfRhSXNNkaoo0jdJQvvggoUJ
         wOspM/A6oZAelmvS9qOf9inDnr4LparBpEN5ERLPgdr7Eu0GFzatNz+WQUiwMDttgAjl
         Ibn5U4ulA8MtV0LImr2LLG+lpixC1dYCk1XV2aGe6gIQQCAnUBpjmlFp6IsU+nuJs6cV
         hK3CQ3ewWH2L2/goX0ct2KOUVsN+106jFySNEaXG6MkcOP1stYgQlerIfUNdRoGoykpr
         KFu1harrQxu1E5MWObGieiUeX3w/dv0VR3mrT5PaktSX6iETPhguTHRlT5yGIbkGxkV8
         Rb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qH2Xjve5YhaOSPUA80W94AgzgoRNT2ulp4Ibpbqyp18=;
        b=Iu7cU1+fe/C0x9dHFS5NrZpRi7YBxqXB7yn6PrhXHegYV+w8XpEuDbtT9PkfQ1IdRr
         k91PeD0HQlQWa2whCwsBp66q3kBh8EaA+fnIBubip2cg+jtpYoVQw/kzojPLthi0v2N9
         J6VlxGaq3y7PVbak4lNP6BcRXYBWtI3AyryVZDz45zsmtmex4rWlk82ejZb0g/M0gOJ+
         4XWlulp4tUVALe2az0KpfuxUNxfhfQ95fWWcWkKa95/PAwep34RumVTJ2huAh8GjVagk
         3R2V1j0hqLkA04QOi7u+FZI3GF2AJHq2cMfI7geVpgXlls5RnRkqGB72evAVICxNG8Om
         ncVA==
X-Gm-Message-State: APt69E1s8TnssQBFiBOcI+bzz8j+2rM11KvKtsal8ZFyol/fovUZjA3c
        d/qFzF48CegWZ6ZQU/V4V7VXBTWRTxgSH3ajXIZpbw==
X-Google-Smtp-Source: ADUXVKJQE3/LuSBWjetjEPPd4RY/4JZez2JprtCaEq5KPa6wwMOdkS78yprE2ROs+ZKPExSM/wax8ZHn14/kGhzKxAA=
X-Received: by 2002:a24:e983:: with SMTP id f125-v6mr6865037ith.99.1529254142743;
 Sun, 17 Jun 2018 09:49:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:494a:0:0:0:0:0 with HTTP; Sun, 17 Jun 2018 09:48:22
 -0700 (PDT)
In-Reply-To: <20180617163530.rvwf7fcukmoletgo@two.firstfloor.org>
References: <1529195582-64207-1-git-send-email-keno@alumni.harvard.edu> <20180617163530.rvwf7fcukmoletgo@two.firstfloor.org>
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Sun, 17 Jun 2018 12:48:22 -0400
Message-ID: <CABV8kRyf2R=a2zezgovByK9Lc8HhDXyfZ4OPE_DHfKKg34bNfw@mail.gmail.com>
Subject: Re: [RFC PATCH] x86/arch_prctl: Add ARCH_SET_XCR0 to mask XCR0 per-thread
To:     Andi Kleen <andi@firstfloor.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Kyle Huey <khuey@kylehuey.com>,
        "Robert O'Callahan" <robert@ocallahan.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Patch seems pointless if you can already control CPUID, which rr
> supports. Just disable AVX512 in CPUID. All code using AVX should check
> cpuid (or will fail anyways).

Unfortunately, that is insufficient. Almost difference in CPU behavior
between the replayer
and the replayee. In particular, the problems for rr here are
1) xgetbv, which can introduce differing register contents (and if
code branches on this,
    potentially differences in control flow).
2) xsave writing more memory than the trace expects, causing
divergence in the memory
contents of the process.

Robert O'Callahan has a blog post that goes into some detail here:
https://robert.ocallahan.org/2018/04/cpuid-features-xsave-and-rr-trace.html

I hope that makes sense. Please let me know if you'd like me to explain the
problem in more detail or give an example. FWIW, I do have a version of rr
that uses the proposed feature in this patch and it does fix our problem with
replaying AVX traces on skylake machines. Without this patch, rr does emulate
the cpuid response of the recording machine, but the replay fails because
of the mentioned issue.
