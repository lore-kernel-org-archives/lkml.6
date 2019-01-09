Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C30AC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 00:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 433C520821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 00:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ACzw+Eio"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbfAIA4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 19:56:20 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:44592 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfAIA4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 19:56:19 -0500
Received: by mail-vk1-f194.google.com with SMTP id h128so1300276vkg.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 16:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dlYr/ZqWt1FJi6LhSmArG7GGSdTsSEGg3UlhZXP6Sz0=;
        b=ACzw+EioQ4XV20niUVGmyVN+RW8uFyrRnd5tpztaSBUs0PsaaNqn1ZVyh5mR4BjvkH
         LPAxgFJuK/Afl62ZBgPY4F/CqK7IcpEcDXkgLjfOjxRo/+6G1X3OESgKWYo25ZUTVIDb
         1+Oo+PnLD0++JyP8qvwYW+N4QPvdWIsdPSJg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dlYr/ZqWt1FJi6LhSmArG7GGSdTsSEGg3UlhZXP6Sz0=;
        b=XyfiT5QbJrXZ+hv4fo5u+7NUYY0CIcqxffJRsHJ1IOUKeE+Yz4HxlE508Fnz0k0wJB
         tMzg3qlDddQUR51UBj6jV6ppuHJUvP3RFds8D1g151tysBlQhmqBsO2c1tRQP0Ig7TA/
         ym9O1q3rH7cejXku4mgBqcXr/IxP/asiztYrxhsFz89CK3PxcmwHa60B3COnxOwqXgsf
         oxippjYj+qKOXkwE2VaY+3XPWBjKuMiFE/gDbvf7/7EIEaHaIDtvH23z3nrqcH5Ex2AI
         M31Urif8BBsg102+rII1mq+d0AoONejO5xUu+hcMPQT5SopIXR3A8cZ1vIoz2SuS15DB
         gnqg==
X-Gm-Message-State: AJcUukdTlE7IwMRwOML/Ay1lGCkwuiwPoMu2KTsH7LLsaMd2Yk2rFSog
        0iJU+2dpYUFFALfj5m93zChtipAPybU=
X-Google-Smtp-Source: ALg8bN6DPLZXG6Uqlb19kiJ4iZmo4LiueJzZM16/EhmSHCOXaZluHYQS1wB9aLaYtuEcCH+P/goG0g==
X-Received: by 2002:a1f:a051:: with SMTP id j78mr1424143vke.35.1546995376592;
        Tue, 08 Jan 2019 16:56:16 -0800 (PST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id j95sm35834890uad.6.2019.01.08.16.56.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 16:56:15 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id v205so3729043vsc.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 16:56:14 -0800 (PST)
X-Received: by 2002:a67:2c13:: with SMTP id s19mr1655473vss.172.1546995374184;
 Tue, 08 Jan 2019 16:56:14 -0800 (PST)
MIME-Version: 1.0
References: <20181026195146.9C7C1136@viggo.jf.intel.com> <0e5fd8bc-0b18-ea88-ed95-ec81a44d0783@intel.com>
 <CAGXu5jLbWT62xHk1jVCeo8nrqCj9ECSqGpEFWKXP6qd5jxiRpw@mail.gmail.com>
In-Reply-To: <CAGXu5jLbWT62xHk1jVCeo8nrqCj9ECSqGpEFWKXP6qd5jxiRpw@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 8 Jan 2019 16:56:03 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+Jy=3OcpcF21n=1khArR8DscLXSPnBpT1Jqn4Q7NbMvw@mail.gmail.com>
Message-ID: <CAGXu5j+Jy=3OcpcF21n=1khArR8DscLXSPnBpT1Jqn4Q7NbMvw@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/pkeys: copy pkey state at fork()
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        Daniel Micay <danielmicay@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 1:14 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Oct 26, 2018 at 12:59 PM, Dave Hansen <dave.hansen@intel.com> wrote:
> > On 10/26/18 12:51 PM, Dave Hansen wrote:
> > ...
> >> The result is that, after a fork(), the child's pkey state ends up
> >> looking like it does after an execve(), which is totally wrong.  pkeys
> >> that are already allocated can be allocated again, for instance.
> >
> > One thing I omitted.  This was very nicely discovered and reported by
> > danielmicay@gmail.com.  Thanks, Daniel!
>
> Thread ping. Is there a v2 of this, or can this go in as-is? Looks good to me:
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Ingo, can you take these two patches? Use of pkeys is still buggy
without it. (And probably should have a Cc: stable tag too.)

-Kees

-- 
Kees Cook
