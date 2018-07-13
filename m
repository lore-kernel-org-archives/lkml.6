Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377E8ECDFAA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 02:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC549214AB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 02:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="gBsa3UPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC549214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388074AbeGMCeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 22:34:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38595 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388021AbeGMCeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 22:34:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3-v6so4468718pgq.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 19:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VMG98WkTF/mPvmh0b4ZGZibMeOHdZxDMpo96QUx+54Q=;
        b=gBsa3UPN96SxMI/gVLHmOB3r3xQrFYHl+Y8KlJy+B2X818xJkTBTlmp56gYg9ICowf
         8BVhqjSal6A76Q4QKd1doUr3db+iDI75H5Jfo7qaay1nMdM6MutIjAeU3ut3AokwtrDY
         wcDvdXfAzqai9JGkmVd+D10lH+s0Ect9F0tzWPu9LMVG/3+EhvlfLp/bwE4TwHkvKm1j
         kh/sZxOI6k0S1H2Fw8nzyUumS1ywKUOxABt4+0KPcbVL02COwiia+OHBWYhrcR332XPI
         5X0UK6iyqGRpKoaubmSexjD9UMVuA7v0GYmkoXUFMkYTAdeie72GZDBm5qXfG4Y/dWaM
         El1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VMG98WkTF/mPvmh0b4ZGZibMeOHdZxDMpo96QUx+54Q=;
        b=GehH7sr9sXZBn2popFTmaBMPBD+NWtcyUZbuQIM7Y8s+hA9nFLdrnp4OWTREPwvcrx
         K17W+8CSKBTJPdW2vI26RvdXgeF50Oh0Y8BwmeXT55ke6nnWQj5W60EKIamWMWA0C6Yx
         rjE9xZtg3/Ticqo7/qubX1bgNJWoOeZePG+NQ2KqdDhx/6NCrrzHnHCR8aAq5g/SOCZX
         YbesKf6WVbbj2jYT0ZwAnML6L0bKq3/thXP+YnjUCxTrIN33LwD4UzdU1e9y4gTYMAqm
         /syTOMpUstYe734dvMmitu+4Z96UFfAITfnOten+Iwuu/XW6hmNZbrOyh45ZxIZLADLv
         Ljng==
X-Gm-Message-State: AOUpUlHiF8H8cyFgmEB1TmW/3s2nlaKo0Xb2wzPqifiXdZyGOPaO7tFD
        b31Z84ZMiUbcIfNqX+6SmvMIvA==
X-Google-Smtp-Source: AAOMgpfGMw8dfnxP2DIYRSVsrRbQp6mwqxV7HfhqrbJs7jULkqYDJkgjsLFNGjRuGS6DZEvX2lPvQg==
X-Received: by 2002:a62:404e:: with SMTP id n75-v6mr4937887pfa.232.1531448505785;
        Thu, 12 Jul 2018 19:21:45 -0700 (PDT)
Received: from ?IPv6:2600:1011:b01e:e4d1:54df:ba07:cac1:aeab? ([2600:1011:b01e:e4d1:54df:ba07:cac1:aeab])
        by smtp.gmail.com with ESMTPSA id n18-v6sm62228505pfa.50.2018.07.12.19.21.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 19:21:44 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v2 18/27] x86/cet/shstk: Introduce WRUSS instruction
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <167645aa-f1c7-bd6a-c7e0-2da317cbbaba@intel.com>
Date:   Thu, 12 Jul 2018 19:21:42 -0700
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromiun.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <55A0592D-0E8D-4BC5-BA4B-E82E92EEA36A@amacapital.net>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com> <20180710222639.8241-19-yu-cheng.yu@intel.com> <bbb487cc-ac1c-f734-eee3-2463a0ba7efc@linux.intel.com> <1531436398.2965.18.camel@intel.com> <46784af0-6fbb-522d-6acb-c6248e5e0e0d@linux.intel.com> <167645aa-f1c7-bd6a-c7e0-2da317cbbaba@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 12, 2018, at 6:50 PM, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
> On 07/12/2018 04:49 PM, Dave Hansen wrote:
>>>> That seems like something we need to call out if so.  It also means we
>>>> need to update the SDM because some of the text is wrong.
>>> It needs to mention the WRUSS case.
>> Ugh.  The documentation for this is not pretty.  But, I guess this is
>> not fundamentally different from access to U=3D1 pages when SMAP is in
>> place and we've set EFLAGS.AC=3D1.
>=20
> I was wrong and misread the docs.  We do not get X86_PF_USER set when
> EFLAGS.AC=3D1.
>=20
> But, we *do* get X86_PF_USER (otherwise defined to be set when in ring3)
> when running in ring0 with the WRUSS instruction and some other various
> shadow-stack-access-related things.  I'm sure folks had a good reason
> for this architecture, but it is a pretty fundamentally *new*
> architecture that we have to account for.

I think it makes (some) sense. The USER bit is set for a page fault that was=
 done with user privilege. So a descriptor table fault at CPL 3 has USER cle=
ar (regardless of the cause of the fault) and WRUSS has USER set.

>=20
> This new architecture is also not spelled out or accounted for in the
> SDM as of yet.  It's only called out here as far as I know:
> https://software.intel.com/sites/default/files/managed/4d/2a/control-flow-=
enforcement-technology-preview.pdf
>=20
> Which reminds me:  Yu-cheng, do you have a link to the docs anywhere in
> your set?  If not, you really should.

I am tempted to suggest that the whole series not be merged until there are a=
ctual docs. It=E2=80=99s not a fantastic precedent.=
