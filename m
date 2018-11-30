Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB19C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16322080A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tSkaYdTj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A16322080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbeLAHw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:52:26 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:53984 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbeLAHw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 02:52:26 -0500
Received: by mail-it1-f193.google.com with SMTP id g85so455294ita.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 12:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UGzlbEHyQpRjNgnk/y53o4YKfWhvlK/jvTzIurpOwYg=;
        b=tSkaYdTjxjAFpitoB+emWiZ/Vd/S3V6IOp31KAReemBv/ZNsiapinXAIMlMtdgW8IP
         jMf69dknA9PF7TFlz+iEA0SE2R2tnbR9SfN7QZdcCgX1VsyreAlzHpPw9LHhyWquN0tv
         oGv9XVGMFXJVldF0fWXdcjbtte37tp11Qy6KBcUj+4+4YfJ65L47eENhFzhnKGXZymAC
         af8Hhe2098w017RAJOrUD6dMOL0Htd9mhiYPGbroJZ/x1cQQGKm7fQISrmEDukkP3J1a
         njUFqro3rfM6xpLw4KV+0dcYBUQIOoLY0LBWeT6VScBiW3vLT7xLi4LeQAIsOFs8PjMb
         2B/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UGzlbEHyQpRjNgnk/y53o4YKfWhvlK/jvTzIurpOwYg=;
        b=rZG6f7xLJXATLwqCIRDEdb1v5LJKT9rpnueRrXWsypD66L3dWxf8ugEhkCyOGOA3Hy
         4sUUBRPgleGKOKUt6RgWXKblQaw6+0s7wxp/CLVtgfsXIZNEIKzktilZ8+Alf807i7TX
         pdkSVmpTPVXSrEmMeiyBHKXLCc+9crrE9ByjbsKmLbfGLI24z5ync87xRJtiRSF+XCUQ
         bXvqkfEVSGepwrGqkeBEBJVxTFipxy09vui4i35gtoVqX5TaKvnlymHiuOO3XCfxzuTG
         Tbf4B1MT9YUnJWg1cET0if+qMH4BJlSLl5HZJGWPlAZy8zGdQRWWdGr2WH7a0PReN5Er
         nT4Q==
X-Gm-Message-State: AA+aEWbikR75E53YZ/eRs0FMbdFM5V5F8Run/a6Slgpb+QSHxeFtzm2a
        8Kv3fhVMbrR7YP/AhaWLyZiSGHfpdI+oEB1D08mMcw==
X-Google-Smtp-Source: AFSGD/VFio3RvDsrdY9yBhURcCgZArOSYuvgm4MEH5CgsqN25LdPAVkwXIuBXfRUGuRfE2Ghn25J45JcArm7hJ/gqQw=
X-Received: by 2002:a24:6e88:: with SMTP id w130mr244126itc.103.1543610515315;
 Fri, 30 Nov 2018 12:41:55 -0800 (PST)
MIME-Version: 1.0
References: <1541483728-7826-1-git-send-email-jingqi.liu@intel.com>
In-Reply-To: <1541483728-7826-1-git-send-email-jingqi.liu@intel.com>
From:   Eric Northup <digitaleric@google.com>
Date:   Fri, 30 Nov 2018 12:41:44 -0800
Message-ID: <CAG7+5M0XNw6KOTw6JyqT67fp3cAX=MseT1A0_1Zpb6UM_O3fLw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] KVM: x86: expose direct stores instructions into VM.
To:     jingqi.liu@intel.com
Cc:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        KVM <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tao3.xu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 10:01 PM Liu Jingqi <jingqi.liu@intel.com> wrote:
>
> Direct stores instructions MOVDIRI and MOVDIR64B will be available in
> Tremont and other future x86 processors,
> and need to be exposed to guest VM.

It seems like KVM's emulator should be able to complete these
instructions to emulated MMIO before exposing CPUID to guests in any
default or supported configurations.

It'll be much simpler for usermode to implement that property if the
KVM-reported supported CPUID table doesn't get updated before the KVM
emulator does.

-Eric
