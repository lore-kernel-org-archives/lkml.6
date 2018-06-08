Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id C8ZsEsBzGlvURwAAmS7hNA
	; Fri, 08 Jun 2018 12:17:44 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6D8DD608B8; Fri,  8 Jun 2018 12:17:44 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWRVwNVZ"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D8F19607A4;
	Fri,  8 Jun 2018 12:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D8F19607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751524AbeFHMRm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 08:17:42 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:45875 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751019AbeFHMRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 08:17:39 -0400
Received: by mail-ot0-f196.google.com with SMTP id a5-v6so15397677otf.12;
        Fri, 08 Jun 2018 05:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=X0YZgJR9shrJ358aexkdlVVyiXBZAoU28ywamvZJBFg=;
        b=MWRVwNVZ956DdqzxUiZ8fqgHKiGM7XBvi594/VVE2lqlkNU+L0H9er3HHXmY8wFQli
         gN3FLhDvEhJ4vTy+7mVcex6pOgfbYmOsInETC1aS6C3go4t8EXyQXJP8nkhgoZU8tn5L
         uNcnsfdtJdSHTmgBCeDt8s2h7B0pL92x6QVl5Drz0mc2FMgnCRCqMBP9tG/AcdnkqSDa
         F8amopPk2ztKy+XRgo2uTK7FA3A65o3pCbB4DOlV2lyFOBLCKQAFUf1Ofm97UwGF1B9j
         9A5P+2++OiJTKTjhT/BgsChKvQ1VhBPySvyvhQmkqAHUGJXqeMm/ux4GLyg2GA3oocTb
         kq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=X0YZgJR9shrJ358aexkdlVVyiXBZAoU28ywamvZJBFg=;
        b=blHL8uCfKvvt7lC9Yyqfe6oYT0O1Y6bFREebGG5bTD+9ZXsNUpBbNfM9T7Rplyzav+
         V1m/6VVtHyt4ifpvrFcfw6puekAyHfGo6TAi/Hx+foglUAlIVnR4EsVAE9Gtsiwo5+/J
         PLPeGzsoKyvdzE7pSsHsH2B2eRYhnnEv+NfsNsIbuWLsk9Zy732/kYGy1JRB87nE54gv
         FI1S95UYrGQWwhmYda3eScwDDr3cW73rt32VFwztEuFwDaotfVSab5Iynopx4UOfaJdl
         De0T+KNTnGh4fDFwabqIabO1rWF4zq/+5/IqWeKAb5fhkU/SBSlcpqYp0c/UfvpYHvdU
         VAVg==
X-Gm-Message-State: APt69E1JYQRMw4JcXktU9Nq2G74XqahFGLld92hZxD8rxpKRCA32jPhj
        qVyNPpiVo4dn2nP0fq8AfJauRHBO70BpOT23Txc=
X-Google-Smtp-Source: ADUXVKJfuBD07DPMMCRvQJzsZUkeX5MPpq7E/SIHVhAbdyRVjmBM4BOABSR0tsJB/X1Z8DqisDWvQs28+LqvKhI7Ad8=
X-Received: by 2002:a9d:2ed3:: with SMTP id w77-v6mr3702318ota.123.1528460259078;
 Fri, 08 Jun 2018 05:17:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:7019:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 05:17:38 -0700 (PDT)
In-Reply-To: <CALCETrWd+1iNmt36EFiLxMv8bQ-GodU=XygPRGb4h+xanhHHLQ@mail.gmail.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-7-yu-cheng.yu@intel.com>
 <CALCETrU6axo158CiSCRRkC4GC5hib9hypC98t7LLjA3gDaacsw@mail.gmail.com>
 <1528403417.5265.35.camel@2b52.sc.intel.com> <CALCETrXz3WWgZwUXJsDTWvmqKUArQFuMH1xJdSLVKFpTysNWxg@mail.gmail.com>
 <CAMe9rOr49V8rqRa_KVsw61PWd+crkQvPDgPKtvowazjmsfgWWQ@mail.gmail.com>
 <CAMe9rOphjpPd3HnKAdU-RmG0RGj6c2oAbnq+C2Jd1srsqTA7=w@mail.gmail.com> <CALCETrWd+1iNmt36EFiLxMv8bQ-GodU=XygPRGb4h+xanhHHLQ@mail.gmail.com>
From: "H.J. Lu" <hjl.tools@gmail.com>
Date: Fri, 8 Jun 2018 05:17:38 -0700
Message-ID: <CAMe9rOrrh70RKcpiOas9JVm0bc_xg+cTN+N9o4krOJxdXObpDw@mail.gmail.com>
Subject: Re: [PATCH 06/10] x86/cet: Add arch_prctl functions for shadow stack
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

On Thu, Jun 7, 2018 at 9:35 PM, Andy Lutomirski <luto@kernel.org> wrote:
> On Thu, Jun 7, 2018 at 9:22 PM H.J. Lu <hjl.tools@gmail.com> wrote:
>>
>> On Thu, Jun 7, 2018 at 3:02 PM, H.J. Lu <hjl.tools@gmail.com> wrote:
>> > On Thu, Jun 7, 2018 at 2:01 PM, Andy Lutomirski <luto@kernel.org> wrote:
>> >> On Thu, Jun 7, 2018 at 1:33 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>> >>>
>> >>> On Thu, 2018-06-07 at 11:48 -0700, Andy Lutomirski wrote:
>> >>> > On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>> >>> > >
>> >>> > > The following operations are provided.
>> >>> > >
>> >>> > > ARCH_CET_STATUS:
>> >>> > >         return the current CET status
>> >>> > >
>> >>> > > ARCH_CET_DISABLE:
>> >>> > >         disable CET features
>> >>> > >
>> >>> > > ARCH_CET_LOCK:
>> >>> > >         lock out CET features
>> >>> > >
>> >>> > > ARCH_CET_EXEC:
>> >>> > >         set CET features for exec()
>> >>> > >
>> >>> > > ARCH_CET_ALLOC_SHSTK:
>> >>> > >         allocate a new shadow stack
>> >>> > >
>> >>> > > ARCH_CET_PUSH_SHSTK:
>> >>> > >         put a return address on shadow stack
>> >>> > >
>>
>> >> And why do we need ARCH_CET_EXEC?
>> >>
>> >> For background, I really really dislike adding new state that persists
>> >> across exec().  It's nice to get as close to a clean slate as possible
>> >> after exec() so that programs can run in a predictable environment.
>> >> exec() is also a security boundary, and anything a task can do to
>> >> affect itself after exec() needs to have its security implications
>> >> considered very carefully.  (As a trivial example, you should not be
>> >> able to use cetcmd ... sudo [malicious options here] to cause sudo to
>> >> run with CET off and then try to exploit it via the malicious options.
>> >>
>> >> If a shutoff is needed for testing, how about teaching ld.so to parse
>> >> LD_CET=no or similar and protect it the same way as LD_PRELOAD is
>> >> protected.  Or just do LD_PRELOAD=/lib/libdoesntsupportcet.so.
>> >>
>> >
>> > I will take a look.
>>
>> We can use LD_CET to turn off CET.   Since most of legacy binaries
>> are compatible with shadow stack,  ARCH_CET_EXEC can be used
>> to turn on shadow stack on legacy binaries:
>
> Is there any reason you can't use LD_CET=force to do it for
> dynamically linked binaries?

We need to enable shadow stack from the start.  Otherwise function
return will fail when returning from callee with shadow stack to caller
without shadow stack.

> I find it quite hard to believe that forcibly CET-ifying a legacy
> statically linked binary is a good idea.

We'd like to provide protection as much as we can.

-- 
H.J.
