Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id qbk2FnwEGlv4egAAmS7hNA
	; Fri, 08 Jun 2018 04:22:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3B7FB606FA; Fri,  8 Jun 2018 04:22:20 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8VxCiK0"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A30D260275;
	Fri,  8 Jun 2018 04:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A30D260275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751143AbeFHEWS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 00:22:18 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39416 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbeFHEWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 00:22:15 -0400
Received: by mail-oi0-f66.google.com with SMTP id t22-v6so10676434oih.6;
        Thu, 07 Jun 2018 21:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=k5mD3v2tbRF39pHp31qH5+ZJN6X27TzDlTaHW4MA27E=;
        b=X8VxCiK0wD710ngM4miuPE8oC7erX0+/auyhTud8wMhN08vHj0WKADV14OqqRWDN3x
         4tQXfOMrqBzYEwrQqtf1gzEQzOjEcnDRxIDKTR4L4cPExOtLKIjblwa3NKSEUU5XuGck
         TgJoV6xMSNK/iqKr1LB2jTKEVIIspvanR5joP4taZEoXg4AUeU4dxrF8m1JqHh6YdVoC
         fzbVlKOCcK0zQ52bSzDg/sTmGVzP1N5rOKvnruBjhDMozEHzc+Gg9bcPSj7RPjOnPGTy
         guukJkaopUZ4a52wgD9oazhgUXrCDEeisMNVIVcDSNjq9/3prSJKy4BEPI2mHG+ssSPf
         eMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=k5mD3v2tbRF39pHp31qH5+ZJN6X27TzDlTaHW4MA27E=;
        b=DfJwI79xK8L0LRCsighaYyvc7EQtD12CVwk8+v493WxUfKkZSneHBksKgLo9xOcGWm
         sYzkuXl3qQjCI/SBdqzn5Wm1Ty3KnnGptDNT4LPXvUBzeZyHW+GykuqzPeuOnkfYeelq
         Nz+XutcTUVYJ6ZlGb8x+5dxbIff7RbS8cj2zK9vbKCzF6CmtWqFYT4P8KAEDJWfX/AUE
         kd4LgT0xFWekxGxHYQ+XnKpb5HYvGRQKnDW05z7K8iT8TK0hk5za11WhOWWE8cI3H9PD
         EHQobIYf3bLFoVjbcTTMD9XwmKSgKJL1hpC9tsG6tumo5B3ac2ngx1vyy/7fHbzbLjNn
         fOlA==
X-Gm-Message-State: APt69E2b/fl5c0aeW8UUAmYLcIvsk5SkmXc6LiIowqjOHrY/0aiDUbHs
        a5SMLo/FrAItFvkrahgD62PVR3pmwNtdw1Ys9Jg=
X-Google-Smtp-Source: ADUXVKLSUkeQcsoGeBcO7rE3+l4PKlv+gq+/CocAqah6DzInfgYgGd18QabflDrCMpbsM5v6/chbYjOC0CrcqOwvmW4=
X-Received: by 2002:aca:df54:: with SMTP id w81-v6mr2544697oig.104.1528431734163;
 Thu, 07 Jun 2018 21:22:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:7019:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 21:22:13 -0700 (PDT)
In-Reply-To: <CAMe9rOr49V8rqRa_KVsw61PWd+crkQvPDgPKtvowazjmsfgWWQ@mail.gmail.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-7-yu-cheng.yu@intel.com>
 <CALCETrU6axo158CiSCRRkC4GC5hib9hypC98t7LLjA3gDaacsw@mail.gmail.com>
 <1528403417.5265.35.camel@2b52.sc.intel.com> <CALCETrXz3WWgZwUXJsDTWvmqKUArQFuMH1xJdSLVKFpTysNWxg@mail.gmail.com>
 <CAMe9rOr49V8rqRa_KVsw61PWd+crkQvPDgPKtvowazjmsfgWWQ@mail.gmail.com>
From: "H.J. Lu" <hjl.tools@gmail.com>
Date: Thu, 7 Jun 2018 21:22:13 -0700
Message-ID: <CAMe9rOphjpPd3HnKAdU-RmG0RGj6c2oAbnq+C2Jd1srsqTA7=w@mail.gmail.com>
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

On Thu, Jun 7, 2018 at 3:02 PM, H.J. Lu <hjl.tools@gmail.com> wrote:
> On Thu, Jun 7, 2018 at 2:01 PM, Andy Lutomirski <luto@kernel.org> wrote:
>> On Thu, Jun 7, 2018 at 1:33 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>>>
>>> On Thu, 2018-06-07 at 11:48 -0700, Andy Lutomirski wrote:
>>> > On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>>> > >
>>> > > The following operations are provided.
>>> > >
>>> > > ARCH_CET_STATUS:
>>> > >         return the current CET status
>>> > >
>>> > > ARCH_CET_DISABLE:
>>> > >         disable CET features
>>> > >
>>> > > ARCH_CET_LOCK:
>>> > >         lock out CET features
>>> > >
>>> > > ARCH_CET_EXEC:
>>> > >         set CET features for exec()
>>> > >
>>> > > ARCH_CET_ALLOC_SHSTK:
>>> > >         allocate a new shadow stack
>>> > >
>>> > > ARCH_CET_PUSH_SHSTK:
>>> > >         put a return address on shadow stack
>>> > >

>> And why do we need ARCH_CET_EXEC?
>>
>> For background, I really really dislike adding new state that persists
>> across exec().  It's nice to get as close to a clean slate as possible
>> after exec() so that programs can run in a predictable environment.
>> exec() is also a security boundary, and anything a task can do to
>> affect itself after exec() needs to have its security implications
>> considered very carefully.  (As a trivial example, you should not be
>> able to use cetcmd ... sudo [malicious options here] to cause sudo to
>> run with CET off and then try to exploit it via the malicious options.
>>
>> If a shutoff is needed for testing, how about teaching ld.so to parse
>> LD_CET=no or similar and protect it the same way as LD_PRELOAD is
>> protected.  Or just do LD_PRELOAD=/lib/libdoesntsupportcet.so.
>>
>
> I will take a look.

We can use LD_CET to turn off CET.   Since most of legacy binaries
are compatible with shadow stack,  ARCH_CET_EXEC can be used
to turn on shadow stack on legacy binaries:

[hjl@gnu-cet-1 glibc]$ readelf -n /bin/ls| head -10

Displaying notes found in: .note.ABI-tag
  Owner                 Data size Description
  GNU                  0x00000010 NT_GNU_ABI_TAG (ABI version tag)
    OS: Linux, ABI: 3.2.0

Displaying notes found in: .note.gnu.property
  Owner                 Data size Description
  GNU                  0x00000020 NT_GNU_PROPERTY_TYPE_0
      Properties: x86 ISA used:
[hjl@gnu-cet-1 glibc]$ cetcmd --on -- /bin/ls /
Segmentation fault
[hjl@gnu-cet-1 glibc]$ cetcmd --on -f shstk -- /bin/ls /
bin   dev  export  lib   libx32      media  mnt  opt root  sbin  sys  usr
boot  etc  home    lib64  lost+found  misc   net  proc run   srv   tmp  var
[hjl@gnu-cet-1 glibc]$ cetcmd --on -f ibt -- /bin/ls /
Segmentation fault
[hjl@gnu-cet-1 glibc]$

-- 
H.J.
