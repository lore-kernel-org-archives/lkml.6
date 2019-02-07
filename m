Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50A1C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF0D21721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vsLAuHKR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfBGVRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 16:17:38 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:40893 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfBGVRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 16:17:38 -0500
Received: by mail-it1-f194.google.com with SMTP id h193so3565270ita.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 13:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hqqxov8gRyPq/xhODXY8JWNy05W7l38l172yYtTHsN8=;
        b=vsLAuHKRpl058OVYjYTv275eyLPGTIfCFAwmNiFzYmD6lveC1ATrDFYCLrKT1j7ss7
         k/rUGjQAYTq5p4w3MDn56vlMXRH3FpOugB7wtrg6zzM/qtbpElJ/Ii/hh1p/R2w5rwoQ
         TZXCkOgic/d3PrJO6FEJ2gyzXcCy8TbH/KCeEwwtImDPD8N4uhjPjoClLXf1WzooeaJF
         NkahjrP4xhzNq17l+olwBEvv6nwMxjjsx/CS+BdNuQDeH0Qv5jw0AX8T1pQBvgD9ds0q
         3pdTacd+q2HDzuv1LIBmJEAyCrE0lWuyFI8pksdSXStC4KP9o4LgJmfRLunSsml9VnJ/
         KVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hqqxov8gRyPq/xhODXY8JWNy05W7l38l172yYtTHsN8=;
        b=P/RPf198ydmuiU2O5Fk5RDBgvjwaqgVAtxFqUQIQ/VzwXIdjJ8n36RDo1ZSMwXBOOm
         AuNxYQi461VSk8T6juqD5cB8F3JxFIlvPuuERZ71Q5IA1rTeKtDqi/K2ENI94fSyEpCD
         kjNuAjSLXLsmjPZj6VPlynK+m6ME+c1w+VPtKEJsyywa0cffuyFkFZWCXN3E+wbifLzS
         zma+y69aeru+MRvqPRs47eHBaFc4gpKltBaRWetjZJKjpAFA/NTQltCtZk/lzlrs2H0L
         FWqOeV91kpWoaMRni7IRS0+4pB9EkSWZ6gpORay1MC9NQpdb0eTVsjGLnkFi2BSxuvtE
         wakw==
X-Gm-Message-State: AHQUAuasorgWPNV0BN0V/m0GFDSa4RR3FPVb7YhcdqTtAaRGU+zox2Zx
        F/onatVUzkB+hAGIJqqzVDJDzLI/uI+C3RiWTsSYBQ==
X-Google-Smtp-Source: AHgI3IagPpjpuV6oLVpFimiyCjvFG66fPRBSB4fTbe/T8N90BMmcP9Y4JUravLl6LAG/NLGh1TxzFldC3DT0WY3s8Q8=
X-Received: by 2002:a6b:9355:: with SMTP id v82mr10814958iod.40.1549574256958;
 Thu, 07 Feb 2019 13:17:36 -0800 (PST)
MIME-Version: 1.0
References: <20190207104214.8142-1-vkuznets@redhat.com>
In-Reply-To: <20190207104214.8142-1-vkuznets@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 7 Feb 2019 13:17:26 -0800
Message-ID: <CALMp9eQXUWjde5_7HNsDN=xx9WeccQ1Hp0_hGOWKd+Sjv4bbfg@mail.gmail.com>
Subject: Re: [PATCH] x86/kvm/nVMX: read from MSR_IA32_VMX_PROCBASED_CTLS2 only
 when it is available
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 2:42 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> SDM says MSR_IA32_VMX_PROCBASED_CTLS2 is only available "If
> (CPUID.01H:ECX.[5] && IA32_VMX_PROCBASED_CTLS[63])". It was found that
> some old cpus (namely "Intel(R) Core(TM)2 CPU 6600 @ 2.40GHz (family: 0x6,
> model: 0xf, stepping: 0x6") don't have it. Add the missing check.
>
> Reported-by: Zdenek Kaspar <zkaspar82@gmail.com>
> Tested-by: Zdenek Kaspar <zkaspar82@gmail.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
