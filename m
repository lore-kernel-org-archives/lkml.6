Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id xWWLMp4BGlv7YQAAmS7hNA
	; Fri, 08 Jun 2018 04:10:10 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5B101607E4; Fri,  8 Jun 2018 04:10:10 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/OmBTnO"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C8FF1606FA;
	Fri,  8 Jun 2018 04:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C8FF1606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751063AbeFHEKG (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 00:10:06 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:41109 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbeFHEJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 00:09:59 -0400
Received: by mail-ot0-f193.google.com with SMTP id d19-v6so8605144oti.8;
        Thu, 07 Jun 2018 21:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3YxVFb3V959wocR3NdoEsznAFl1SruV1TEp0gMLHw34=;
        b=J/OmBTnOsI6EA82c9ZlA8BSibgI2emfj92vWvImiE1022bJBtzJ2+0HJaJ0aTrunZU
         1LcO64PE9PTntTW+8ExaW+mpDUaLrVZqvwQd0/7h65Ao6Tz0DlUOHgmnT9E5u9I/7yMU
         yC+o7s/kf0DoA1CYz3VwIGciVXrbDEsg3fIMGEUXBpx49SmavRnMemGQF8rCfJ/6+GQV
         JzsmqOu7UI159/JW2qRsGFfPNAFZqhVQAEPOb951kXNiLUdI5Ejir1h8R3mQw/4hOhLl
         xE1dd8IVXIetnhCSCOfro7OMqAsV6x4xyN6dBDW+Z/Aah09f/6xdXuJYUwArl9sYyS6s
         MeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3YxVFb3V959wocR3NdoEsznAFl1SruV1TEp0gMLHw34=;
        b=HeWrr/MHSO4SVjKC0HBT1kZzAa85Ae1VIIOh3AxUM0UkjOvJf78E1k8+3TA+4QCsnD
         EMD32Tyi7pbjdmt0ig+Jmi2MethBEFMv2E/PP7GmzXnu1TufzJIH/rJjK1y9aW7JLYXv
         qOVJyxd8RuEv1QNv6mKZUNlTvHv1NVZl7jAAMN8Q49EwiHyK4hlEiErk1P6DUJzVb9Kl
         2KWuKui9YuFCZc/z99M1gFzMuebos1YMevijpSFKoUzz71qWainKizjm0PPrKHM/5nRw
         /pETdX2UiBtv7QtSOdAnwtuwdPTe6Mvxr2yhGwtuieHiXMidfKErpn/xrlOPK7vuhpSV
         B89Q==
X-Gm-Message-State: APt69E13RD3Q5hmKNFfFPbIe13vhg3sAOp5wOXX+BNvpADaWyDQrerdp
        fX2AkQQEW0c+Xef4yodb9vErNiwHe0tUJ4kPnIY=
X-Google-Smtp-Source: ADUXVKIUFXRqaf75rKjEbGOtTAlujZtxVd/fB5/Su+S3EeLy1KwsHLOvN+VKR8vnTaFAoCyC5u6wb1sxdTHr8aKpyso=
X-Received: by 2002:a9d:322f:: with SMTP id t47-v6mr2912567otc.7.1528430998903;
 Thu, 07 Jun 2018 21:09:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:7019:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 21:09:58 -0700 (PDT)
In-Reply-To: <CALCETrV1GG5rq_kwxkS-o3x8Ldr72ThdYgkJKQ9cx9Q63SxgTQ@mail.gmail.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-7-yu-cheng.yu@intel.com>
 <CALCETrU6axo158CiSCRRkC4GC5hib9hypC98t7LLjA3gDaacsw@mail.gmail.com>
 <1528403417.5265.35.camel@2b52.sc.intel.com> <CALCETrXz3WWgZwUXJsDTWvmqKUArQFuMH1xJdSLVKFpTysNWxg@mail.gmail.com>
 <CAMe9rOr49V8rqRa_KVsw61PWd+crkQvPDgPKtvowazjmsfgWWQ@mail.gmail.com> <CALCETrV1GG5rq_kwxkS-o3x8Ldr72ThdYgkJKQ9cx9Q63SxgTQ@mail.gmail.com>
From: "H.J. Lu" <hjl.tools@gmail.com>
Date: Thu, 7 Jun 2018 21:09:58 -0700
Message-ID: <CAMe9rOpeDrkwi-AG0vsiZy4NwkmavhB5Empv58FSHxtr3rpapw@mail.gmail.com>
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

On Thu, Jun 7, 2018 at 4:01 PM, Andy Lutomirski <luto@kernel.org> wrote:
> On Thu, Jun 7, 2018 at 3:02 PM H.J. Lu <hjl.tools@gmail.com> wrote:
>>
>> On Thu, Jun 7, 2018 at 2:01 PM, Andy Lutomirski <luto@kernel.org> wrote:
>> > On Thu, Jun 7, 2018 at 1:33 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>> >>
>> >> On Thu, 2018-06-07 at 11:48 -0700, Andy Lutomirski wrote:
>> >> > On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>> >> > >
>> >> > > The following operations are provided.
>> >> > >
>> >> > > ARCH_CET_STATUS:
>> >> > >         return the current CET status
>> >> > >
>> >> > > ARCH_CET_DISABLE:
>> >> > >         disable CET features
>> >> > >
>> >> > > ARCH_CET_LOCK:
>> >> > >         lock out CET features
>> >> > >
>> >> > > ARCH_CET_EXEC:
>> >> > >         set CET features for exec()
>> >> > >
>> >> > > ARCH_CET_ALLOC_SHSTK:
>> >> > >         allocate a new shadow stack
>> >> > >
>> >> > > ARCH_CET_PUSH_SHSTK:
>> >> > >         put a return address on shadow stack
>> >> > >
>> >> > > ARCH_CET_ALLOC_SHSTK and ARCH_CET_PUSH_SHSTK are intended only for
>> >> > > the implementation of GLIBC ucontext related APIs.
>> >> >
>> >> > Please document exactly what these all do and why.  I don't understand
>> >> > what purpose ARCH_CET_LOCK and ARCH_CET_EXEC serve.  CET is opt in for
>> >> > each ELF program, so I think there should be no need for a magic
>> >> > override.
>> >>
>> >> CET is initially enabled if the loader has CET capability.  Then the
>> >> loader decides if the application can run with CET.  If the application
>> >> cannot run with CET (e.g. a dependent library does not have CET), then
>> >> the loader turns off CET before passing to the application.  When the
>> >> loader is done, it locks out CET and the feature cannot be turned off
>> >> anymore until the next exec() call.
>> >
>> > Why is the lockout necessary?  If user code enables CET and tries to
>> > run code that doesn't support CET, it will crash.  I don't see why we
>> > need special code in the kernel to prevent a user program from calling
>> > arch_prctl() and crashing itself.  There are already plenty of ways to
>> > do that :)
>>
>> On CET enabled machine, not all programs nor shared libraries are
>> CET enabled.  But since ld.so is CET enabled, all programs start
>> as CET enabled.  ld.so will disable CET if a program or any of its shared
>> libraries aren't CET enabled.  ld.so will lock up CET once it is done CET
>> checking so that CET can't no longer be disabled afterwards.
>
> Yeah, I got that.  No one has explained *why*.

It is to prevent malicious code from disabling CET.

> (Also, shouldn't the vDSO itself be marked as supporting CET?)

No. vDSO is loaded by kernel.  vDSO in CET kernel is CET
compatible.

-- 
H.J.
