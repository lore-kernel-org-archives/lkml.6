Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87683C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 18:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447FF208EA
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 18:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing-com.20150623.gappssmtp.com header.i=@juliacomputing-com.20150623.gappssmtp.com header.b="P5B3/gQd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 447FF208EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=juliacomputing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934232AbeFQSWq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 14:22:46 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:33065 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933681AbeFQSWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 14:22:42 -0400
Received: by mail-it0-f68.google.com with SMTP id k17-v6so9701297ita.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 11:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=F3b9mSDTLxAXC3vPoImR7BVGUYWlsn2TsGSfQvsIQ+I=;
        b=P5B3/gQdUXHo+G8jxiWSdOaisnbJy+GQiLr4oRHLylEsWb75nY/2/Sd8+eoP0/XtPk
         Psa6YAHN3Vg07jnz7eZX+ceD94GkVTR1mUS3H1Fo9eGY4tX7iEXfr7fB5GLcPj8VEglT
         bI2kQIYkOapiD0h9gIqZ81uDS4xTWf6MNeZddEsc+qR4XSLiXrABlGg4/O698clc9d/Y
         UGPIKW3rubyahoMKpoPu9TE84eIlXtjWLssLVnlVZfVbZDBKJrQH5ldr3zWvvX9DWpWZ
         7sn1xrPjuWDZnCYTq2EJmz9S4otuAvwtOv0AWX3/xZ+I5DzExyR9D3kzoMWJSZYsAOvS
         yjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=F3b9mSDTLxAXC3vPoImR7BVGUYWlsn2TsGSfQvsIQ+I=;
        b=M8sc/1rtGSBl34Og5PsD2D2t5xfmB8Wg0oUDv8A75G9zPfAJ2OEIkJEUDuLPGK4eUq
         suAJHA4CsdL/5staLWShZAhF1gBv3bH2x/yamrR4pNOXZO1xWTMqro/tvK/zaNQQ23rz
         3nvfiBojB0K+fAcINSMMfA0TM5Iv8fk0D5nY55v0qonVxdSHqlrwTcw9/CKaUqQqEunQ
         92YEGTpFVRiO2IHtL+9wMsSfTvqJQmV0Kism9G7x9+h0R1zcj8Z281rM/VLWGSXtVyJA
         WQnRSA5kLvMMHpEip/dykRYA7TNX657veiAzIAuJ5LmYtSzrB28l3p0Mav1e7R3I1Ftt
         tr4g==
X-Gm-Message-State: APt69E2FODAgis0r2Wfffa8p4w+0AgYDXO8Pfo2Sa21i3UzPICgDepey
        SCNIRGrTJc0JUPrj/UhT94yM6qRt03T7y2m2XFl4z490dfcfmA==
X-Google-Smtp-Source: ADUXVKJlJk1GVGRozVNgr82FQt3sn+0TCFvcK3w65t3a3iF8fXZOwMvuu2mjwg+i9w8Kia7UVWRjk0D7k9iD8HYDf6w=
X-Received: by 2002:a24:2f12:: with SMTP id j18-v6mr7764768itj.28.1529259761873;
 Sun, 17 Jun 2018 11:22:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:494a:0:0:0:0:0 with HTTP; Sun, 17 Jun 2018 11:22:01
 -0700 (PDT)
In-Reply-To: <CABV8kRyf2R=a2zezgovByK9Lc8HhDXyfZ4OPE_DHfKKg34bNfw@mail.gmail.com>
References: <1529195582-64207-1-git-send-email-keno@alumni.harvard.edu>
 <20180617163530.rvwf7fcukmoletgo@two.firstfloor.org> <CABV8kRyf2R=a2zezgovByK9Lc8HhDXyfZ4OPE_DHfKKg34bNfw@mail.gmail.com>
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Sun, 17 Jun 2018 14:22:01 -0400
Message-ID: <CABV8kRyuD6h_EGrxxQJ43FEaL9zuh3oYNYbt6ULqLaZZEiyoSg@mail.gmail.com>
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

> Almost difference in CPU behavior
> between the replayer and the replayee.

Not sure what happened to this sentence.
What I meant to say was:

Almost any difference in CPU behavior between
the replayer and the replayee will cause problems
for the determinism of the trace.

To elaborate on this, even if a register whose content
differs between the recording and the replay, it can
still cause problems down the line, e.g. if it is spilled
to the stack and that stack address is then re-used later.
In order for rr to work, we basically rely on the CPU
behaving *exactly* the same during the record and the
replay (down to counting performance counters the same).
This works well, but there are corner cases (like this XCR0
one).
