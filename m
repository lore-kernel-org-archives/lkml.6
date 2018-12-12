Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2CFC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04CB2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544638039;
	bh=HVI/enzlKFrr9FI9luIG0NKhuCYbRDq9evDkRIAm+iI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UvCqnBkozV7bjLj+HyJoBsYTdpuBFCxpFvOo95ao8Ssirft36OkSg1FwQ8CZJSmKj
	 FdAgDs2DX85v6OViLn+teMa3YBzgMQpjkyXAC/gQOGlqUDWbAIqKBHMFgKbCFZ375x
	 94SC8IbEe2ozH3sgiIXFkTjIjS8bLLO+Zu3dKHj8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E04CB2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbeLLSHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:07:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:58590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727900AbeLLSHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:07:17 -0500
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A4352084E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 18:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544638036;
        bh=HVI/enzlKFrr9FI9luIG0NKhuCYbRDq9evDkRIAm+iI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KRej3QLgKqrySi8OV3BiO7kUOfmWP99bh4axSdyq+JnvkLPWU6caGgLPrcuYh5h/V
         nrs8eLgNB9IiBvVc9/Spr08CyxxBo0FCJob7GxiGRuouOQVpL4RFDalQmFWql1X3U8
         /VA8LaGs4zEAIovE84sh2hqDPUCit1+nxf85xkTg=
Received: by mail-wr1-f53.google.com with SMTP id t27so18630046wra.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 10:07:16 -0800 (PST)
X-Gm-Message-State: AA+aEWasZ25sSvg7l1SSjmwVvDnyWNt6VJjzBbANYmPPsTlDfF0+qW+S
        YtsNr4wVeV5KMJhuqS078d6mNEoTXOuHpzlixiWcQw==
X-Google-Smtp-Source: AFSGD/WYkLTyJZErKI5xug2q4TBPiAcgz8RAcBQog7dzTHWeFXUeTF4xFjlHanjGgULbdIn17rCuGaSsb2W6yNJ0w24=
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr17399870wro.77.1544638035005;
 Wed, 12 Dec 2018 10:07:15 -0800 (PST)
MIME-Version: 1.0
References: <20181211222326.14581-1-bp@alien8.de> <20181211222326.14581-5-bp@alien8.de>
 <CALCETrVArfAAbQKJ-g_5pOy6dMVgx-FC_mjdC9xzL1jU9T07jw@mail.gmail.com>
 <59aad362-4a5b-dd8b-642f-0dc3f83cf7ee@amd.com> <20181211233901.GV27375@zn.tnic>
 <CALCETrXvZ4avdUh2bTLVTTz3Jxogo3zK5akWTsJ=rkJpf1XiDg@mail.gmail.com> <20181212100814.GB6653@zn.tnic>
In-Reply-To: <20181212100814.GB6653@zn.tnic>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 12 Dec 2018 10:07:03 -0800
X-Gmail-Original-Message-ID: <CALCETrWSG5825HrxwEJGqbSoRz=A_2O-GSBD+K_q9YPHu2TB6A@mail.gmail.com>
Message-ID: <CALCETrWSG5825HrxwEJGqbSoRz=A_2O-GSBD+K_q9YPHu2TB6A@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] x86/TSC: Use RDTSCP
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 2:08 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Dec 11, 2018 at 06:24:44PM -0800, Andy Lutomirski wrote:
> > This makes me nervous, since no one knows what =E2=80=9Cserializing=E2=
=80=9D means.
>
> Why no one? If you wanna say that X86_FEATURE_LFENCE_SERIALIZING is not
> really telling, so is X86_FEATURE_LFENCE_RDTSC, TBH. :)

You're proving my point, I think.  CPUID, IRET, MOV to CR, etc are
"serializing".  LFENCE, on many CPUd and depending on MSRs, is a
different kind of serializing.  MFENCE is something else.  All LOCK
instructions are some kind of barrier, but I don't think anyone calls
them "serializing".

The uaccess users of barrier_nospec() are presumably looking for a
speculation barrier in the sense of "CPU, please don't execute the
code after this until you're sure that this code should be executed
for real and until all inputs are known, not guessed."

The property I want for RDTSC ordering is much weaker: I want it to be
ordered like a load.  Imagine that, instead of an on-chip TSC, the TSC
is literally a location in main memory that gets incremented by an
extra dedicated CPU every nanosecond or so.  I want users of RDTSC to
work as if they were reading such a location in memory using an
ordinary load.  I believe this gives the real desired property that it
should be impossible to observe the TSC going backwards.  This is a
much weaker form of serialization.
