Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF603C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED8C222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JhzP8kTS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbfBLSBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:01:12 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39473 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfBLSBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:01:11 -0500
Received: by mail-it1-f195.google.com with SMTP id a6so9814681itl.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 10:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D/0El9tNzDiMcL+LuSg4WRrJJTsM8A4H9SHaXZAORDY=;
        b=JhzP8kTSngjzzbwBRqUyBzeYlGcndPYhiyYHyjvQTueYvIYF1hoIO1idEt66SEe0x2
         tX/DeoRgZHfULPFCbk9vha52ngMWoyG3bBWy4zjhPVNP8859tdlCn8sSmMWwQrvGFHOu
         nCwDRySF3dff42/RdokmHAkOPjo2FrMw1QFrBT/L884cx5WMH7MQG2BNIZyvB5rMJuaS
         /6TaexkbgcQ4+EZf/3utXgLDSCUMC4NA1Qn17xNuEJZA8iAYKldftd8rfAZAfaUtVkMB
         nn0fTW8B95TOFNI+Fn0T+HWVxT4VbnBcZR8OsC/5LRwMijxoj42Y04H9wLwAMXe51Ie0
         4WfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D/0El9tNzDiMcL+LuSg4WRrJJTsM8A4H9SHaXZAORDY=;
        b=T9LNIg7nv0Ig4IdWamy4WlQJ6GO+rKnqK/1QFCM4LCY97TuFSZH/tRpqVh2jzjd9cw
         bgUltmWVCai4+w8N+0KP0Lj4nQ+cTwjATpwh8rtm8XAW+Jqf2JJFpH8RMHL3VMCVQ76d
         JsyH22uES+YbJoRImKScv75EpZhqXGISKfy9Z3wQxVvIb6rrvOn3mxRvoHAUDxjBGCtt
         wfgF2P7DIhhXtukN+qIpginAh+mRBB2RPZmWexh/6jJWUy2yZ9voL2F+ZnkwfEzJjOjA
         ZQC5mapfjVLhWPNJ+n40HnEvYgUbAwGOQHrgD3oA3zY82/L4ET2DlHnz5z2nVDGFWJ7M
         ajIQ==
X-Gm-Message-State: AHQUAuam7Rn3JSHf/q5fBFhffgSyioddwU04Vs0jw4MP3qXQwq7e50+w
        oyuttMovZ0BY8XbX9qIfjvOqQaQm6TEvH97qTXaIfg==
X-Google-Smtp-Source: AHgI3IYPamtcUcl/DJWH0uriFa1gYc38E0oROG/epKc5Oz7DKWjBJV7W4IdjO9gVeYPAQCu0a+ObX16vbOGLJK/k5rU=
X-Received: by 2002:a24:4a95:: with SMTP id k143mr37841itb.77.1549994470804;
 Tue, 12 Feb 2019 10:01:10 -0800 (PST)
MIME-Version: 1.0
References: <20190207104214.8142-1-vkuznets@redhat.com> <CALMp9eQXUWjde5_7HNsDN=xx9WeccQ1Hp0_hGOWKd+Sjv4bbfg@mail.gmail.com>
 <9cbc28ac-77bb-5507-d82c-d63d3941a2c7@redhat.com>
In-Reply-To: <9cbc28ac-77bb-5507-d82c-d63d3941a2c7@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 12 Feb 2019 10:00:59 -0800
Message-ID: <CALMp9eRV8KmA1KQf3C8GX3p5voBvLMspR-XRSb4BLmZhLKQLKA@mail.gmail.com>
Subject: Re: [PATCH] x86/kvm/nVMX: read from MSR_IA32_VMX_PROCBASED_CTLS2 only
 when it is available
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 6:16 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 07/02/19 22:17, Jim Mattson wrote:
> >> SDM says MSR_IA32_VMX_PROCBASED_CTLS2 is only available "If
> >> (CPUID.01H:ECX.[5] && IA32_VMX_PROCBASED_CTLS[63])". It was found that
> >> some old cpus (namely "Intel(R) Core(TM)2 CPU 6600 @ 2.40GHz (family: 0x6,
> >> model: 0xf, stepping: 0x6") don't have it. Add the missing check.
> >>
> >> Reported-by: Zdenek Kaspar <zkaspar82@gmail.com>
> >> Tested-by: Zdenek Kaspar <zkaspar82@gmail.com>
> >> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> >
> > Reviewed-by: Jim Mattson <jmattson@google.com>
>
> Queued, thanks.
>
> Paolo

Alternatively, rdmsr could be changed to rdmsr_safe.
