Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id pXLFMmzOGVvTKAAAmS7hNA
	; Fri, 08 Jun 2018 00:31:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AEAA66074D; Fri,  8 Jun 2018 00:31:40 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHGIQg/q"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3737A606DD;
	Fri,  8 Jun 2018 00:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3737A606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbeFHAbi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 20:31:38 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35956 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752364AbeFHAbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 20:31:36 -0400
Received: by mail-oi0-f66.google.com with SMTP id 14-v6so10332333oie.3;
        Thu, 07 Jun 2018 17:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OSYjGIENvG29sYpiyyH9ynx5R7L4hWBQAaJEqveB8j8=;
        b=SHGIQg/q7rNC2ehV3yXlGpz6lVhGkDRKQ3xYuwirvGCRzpkkeW4K5xfCn/ykeVsSHS
         t3SeboknUdDEGEmTy1pSnFuPDb+D+loBW7g/EZ3YV/TcrVT0mKQHnYju16H13mWqnsID
         bUty+39GYfGb/3oVr/bBJLXpjuVBjhrvAu+cyRujgo9uHOcKgKO+4qjHN7Ir1qdZhhDy
         +J4o4gF8jaq/dsls4dYOBgmrte4hOe+DlYAfp8s2GcwJ0IiGzJDs4YGV30uBCrz17v6Z
         MWqgpSEH30ManYo0G+TKXluzbbESFWoAkR/nUDK2HbxeqzuqEVq0uNGvChtWztMO803h
         XgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OSYjGIENvG29sYpiyyH9ynx5R7L4hWBQAaJEqveB8j8=;
        b=CHGzovyIiyTekfbVtlRGULlQ/9Fo/fC34FnI+GTNDkSXFTp5bMujGm8qk+UV5OrRH8
         OnGMOHn0eVxsiIjDGsLzyU3RhCe8O7Yy9WLCs/D4rOAuhvpnjRy16rKgA+UmcmD3ckBs
         cHhQ0/kzEyJwkURfGms2il6wNsVSylcFf5ZtqPcOAHg56j/RQnk7q78vpRRuEpvGGjoA
         1fiq6PfN2we/NyyWTta17lD3z8HRknCFWhrLGycX/RleT2t9pidjME6H+YasKgtO+Shv
         YnHH0SGTJwsDJ+zezH4b4qRV/BQ9anE4o6BryZ4CHwky8AkD7Z28pcSh+LfUSyW0Moiu
         +Mcw==
X-Gm-Message-State: APt69E2ICg0vjvC1MLCyZK5PNlkJEMPWmpHNAuYn+/eFnjNbA9jj3FRy
        cONaDYehYwYixpRUjj5XTRhia7g4f4ehfC5Y570=
X-Google-Smtp-Source: ADUXVKKuWjlYoC83e1B1ZgasizI0DRWbxLb3MK/Epar6pelS7/5o0+IwSOUkyGClVHFI4Z0BXluANgwlOwmcgfDVoGc=
X-Received: by 2002:aca:df54:: with SMTP id w81-v6mr2259653oig.104.1528417895456;
 Thu, 07 Jun 2018 17:31:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:7019:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 17:31:34 -0700 (PDT)
In-Reply-To: <CALCETrXOc3-2QLks3iaTTvEE=4+2Oi3PORa8HPbYiDTtKV6CLQ@mail.gmail.com>
References: <20180607143855.3681-1-yu-cheng.yu@intel.com> <20180607143855.3681-6-yu-cheng.yu@intel.com>
 <CALCETrVRH8LeYoo7V1VBPqg4WS0Enxtizt=T7dPvgoeWfJrdzA@mail.gmail.com>
 <CAMe9rOp9YtNnTzsDPFXukK6ps7VNa2MU6o0GwnoES5Ma_AC65A@mail.gmail.com> <CALCETrXOc3-2QLks3iaTTvEE=4+2Oi3PORa8HPbYiDTtKV6CLQ@mail.gmail.com>
From: "H.J. Lu" <hjl.tools@gmail.com>
Date: Thu, 7 Jun 2018 17:31:34 -0700
Message-ID: <CAMe9rOphRmP4aEGGwmM=d+D7GyZWrC_hMTWaiy1tEtBd0PLdxA@mail.gmail.com>
Subject: Re: [PATCH 5/7] x86: Insert endbr32/endbr64 to vDSO
To: Andy Lutomirski <luto@kernel.org>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 4:00 PM, Andy Lutomirski <luto@kernel.org> wrote:
> On Thu, Jun 7, 2018 at 3:03 PM H.J. Lu <hjl.tools@gmail.com> wrote:
>>
>> On Thu, Jun 7, 2018 at 1:50 PM, Andy Lutomirski <luto@kernel.org> wrote:
>> > On Thu, Jun 7, 2018 at 7:42 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>> >>
>> >> From: "H.J. Lu" <hjl.tools@gmail.com>
>> >>
>> >> When Intel indirect branch tracking is enabled, functions in vDSO which
>> >> may be called indirectly should have endbr32 or endbr64 as the first
>> >> instruction.  We try to compile vDSO with -fcf-protection=branch -mibt
>> >> if possible.  Otherwise, we insert endbr32 or endbr64 by hand to assembly
>> >> codes generated by the compiler.
>> >
>> > Wow, that's... a genuine abomination.  Do we really need to support
>> > CET on kernels built with old toolchains?
>> >
>>
>> Yes.  GCC 7 should be able to build CET kernel.
>>
>
> Why?  Presumably people running distros that use CET are going to have
> kernels build with a CET-supporting compiler.
>

Good point.  It was needed before GCC 8 was released.   We can drop
arch/x86/entry/vdso/endbr.sh now.

-- 
H.J.
