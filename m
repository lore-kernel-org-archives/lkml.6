Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F85C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9314C20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="nYKwJRP+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JRe8llau"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9314C20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967258AbeFSUMb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 16:12:31 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:41879 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967134AbeFSUM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 16:12:29 -0400
Received: by mail-yb0-f195.google.com with SMTP id f14-v6so379136ybg.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 13:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=oWIfvz80g+YqP3UR0vC/UhDUK++WrxVmhWHGNnT0OOE=;
        b=nYKwJRP+rwXm7LMSZseOvBpGXoumzVlxyFNb9GcBq45NqdK/IqB0564RcRN8CcBDC1
         nC6e0YscQ4Janh+B4cW5CQ3yrhStEnYIPG2ptf1G7eXV54o66XOK7NHuZL6NB4ayG8AW
         vEHVNMps9ZAZjhCkDZFRa724xDPjrb4tOkloFyAqJedKkA38zR7gHQtgKJuiAqmmzO4n
         rAiqm90qR8m9E0AM2BdrY5jkg0RP2BS4TT6qSAfI5A84LACCxag7VZpgGAYtyapUav1H
         IF/8Jma/toWO0lJ+x7ERXF4T3CpbCByl1izktQJLSAzj4RN4wkbNA4u5QkBY4JN3O16b
         a5jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=oWIfvz80g+YqP3UR0vC/UhDUK++WrxVmhWHGNnT0OOE=;
        b=JRe8llauyCtc7zPDHxQpUQD4By/JGvALC8f+gOtmPgAgW4yEEmNEow8iCS9whltWIt
         OFh1/gt5fsM4DnNtoRcTHIGyvSmEAXekPRSo+bEkT5Vzzg/FR9OiaxWjkBSTBHLt34cv
         /0ovfaji+M/Z/C2ACU8cOlq7ycQ4g2DAEHDYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=oWIfvz80g+YqP3UR0vC/UhDUK++WrxVmhWHGNnT0OOE=;
        b=GYyNATkKDddhJu8SZ+eDSciGlmDBUZdfLrjOppJKIQU5f7veWGl6/GtJcSw3d5CO0d
         HhrygMS0Msn4WgN2hApDhi9lrUqLW2YNaZwiGltbiwJQUquQQWZ/YuorUm8+Mbe/VIGE
         hmOXbjyYx1vcZJWNoaXVyzHc+FfxUnDwmKPv3/wJb3/QVilRt2SMRQiOEZpxWt7FUL03
         eJrSFeLL4NzhnE78R1LV8SyeUzAOU5EJGprkqIQecrL7n8yV7xj/7trp6cjSJ39ciIgy
         sNoGflL9AFWigxEZe1Ox0jEFhPhH9rG6stviIisgVcD98cw0lRU4WSua7vhothDzm9mm
         AJ4g==
X-Gm-Message-State: APt69E0tprSFIvr2A3ZzSbiDbPoVV4I2Xxlst8lZkSIVGuZwU/g3nDCx
        TEANRNT6PzgbGSkXKhNpVt+MsAvhXoqtfKlBFRlQfg==
X-Google-Smtp-Source: ADUXVKIWgPwZvaltNpuo1a3VfowDZ3K99bSvmbAsS+QSuclE04qgLs/9GxMiEET94slx/6CYdo7xIssPsoZzTkOg65Q=
X-Received: by 2002:a25:a301:: with SMTP id d1-v6mr9564103ybi.193.1529439148432;
 Tue, 19 Jun 2018 13:12:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d6c5:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 13:12:26
 -0700 (PDT)
In-Reply-To: <0AF8B71E-B6CC-42DE-B95C-93896196C3D7@amacapital.net>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-7-yu-cheng.yu@intel.com>
 <CALCETrU6axo158CiSCRRkC4GC5hib9hypC98t7LLjA3gDaacsw@mail.gmail.com>
 <1528403417.5265.35.camel@2b52.sc.intel.com> <CALCETrXz3WWgZwUXJsDTWvmqKUArQFuMH1xJdSLVKFpTysNWxg@mail.gmail.com>
 <CAMe9rOr49V8rqRa_KVsw61PWd+crkQvPDgPKtvowazjmsfgWWQ@mail.gmail.com>
 <alpine.DEB.2.21.1806121155450.2157@nanos.tec.linutronix.de>
 <CAMe9rOoCiXQ4iVD3j_AHGrvEXtoaVVZVs7H7fCuqNEuuR5j+2Q@mail.gmail.com>
 <CALCETrXO8R+RQPhJFk4oiA4PF77OgSS2Yro_POXQj1zvdLo61A@mail.gmail.com>
 <CAMe9rOpLxPussn7gKvn0GgbOB4f5W+DKOGipe_8NMam+Afd+RA@mail.gmail.com>
 <CALCETrWmGRkQvsUgRaj+j0CP4beKys+TT5aDR5+18nuphwr+Cw@mail.gmail.com>
 <CAMe9rOpzcCdje=bUVs+C1WrY6GuwA-8AUFVLOG325LGz7KHJxw@mail.gmail.com>
 <alpine.DEB.2.21.1806122046520.1592@nanos.tec.linutronix.de>
 <CAMe9rOrGjJf0aMnUjAP38MqvOiW3=iXGQjcUT3O=f9pE85hXaw@mail.gmail.com>
 <CALCETrVsh5t-V1Sm88LsZE_+DS0GE_bMWbcoX3SjD6GnrB08Pw@mail.gmail.com>
 <CAGXu5jK0gospOXRpN6zYiQPXOZeE=YpVAz2qu4Zc3-32v85+EQ@mail.gmail.com>
 <569B4719-6283-4575-A16E-D0A78D280F4E@amacapital.net> <CAGXu5jJNgu4bW_Zthqjfpe9gLxK0zxG8QFEqqK+pJNebz6tUaw@mail.gmail.com>
 <1529427588.23068.7.camel@intel.com> <CAGXu5jJ4ivrvi-kG0iY=4C0mQQXBDXwPdfY36Dk+JqOpX19n0w@mail.gmail.com>
 <0AF8B71E-B6CC-42DE-B95C-93896196C3D7@amacapital.net>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 19 Jun 2018 13:12:26 -0700
X-Google-Sender-Auth: wDXQ7pEPyX9jYVnskNOC4GIqgMY
Message-ID: <CAGXu5jLEMy_T_5OtXLT+pUCt=Nk53nBbuRvrUgJBhq-4RZ=yCA@mail.gmail.com>
Subject: Re: [PATCH 06/10] x86/cet: Add arch_prctl functions for shadow stack
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com, Florian Weimer <fweimer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 10:20 AM, Andy Lutomirski <luto@amacapital.net> wrote:
>
>> On Jun 19, 2018, at 10:07 AM, Kees Cook <keescook@chromium.org> wrote:
>>
>> Does it provide anything beyond what PR_DUMPABLE does?
>
> What do you mean?

I was just going by the name of it. I wasn't sure what "ptrace CET
lock" meant, so I was trying to understand if it was another "you
can't ptrace me" toggle, and if so, wouldn't it be redundant with
PR_SET_DUMPABLE = 0, etc.

-Kees

-- 
Kees Cook
Pixel Security
