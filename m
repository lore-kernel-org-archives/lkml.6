Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 201ACC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA57208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntCKsRSr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA57208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932963AbeFLLnx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 07:43:53 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:34693 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754019AbeFLLnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 07:43:51 -0400
Received: by mail-ot0-f195.google.com with SMTP id r18-v6so13185694otk.1;
        Tue, 12 Jun 2018 04:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=n7EOqQTRPF9XI+2b894weAYj/hPS2OyKbWBt3ey6gmk=;
        b=ntCKsRSrLeQHBMb19+FYtFn0qq+TX93ZybiyaiC9nsJ7ZlgUBiVqEeWkNFvaDnb5iR
         eUFAKeAPnV+5PvvS7lcPlC85rt4OpGzMEtMUYIIWDJZpNiiW9VdePV6IHHPc6shsVuK4
         peRC9ilh/SFMkiNxjakW1IQJKBGtReiGta/5+WWsixsuqEtpX6XCelCshR6olQdku4Zk
         VYe5p0RQCp/AYnLZMGhr4nYg8Nm/Y0ih60f7Pij3pPM3l+aYSpXd8bFJ0uBzDtSlCI0g
         phrrlS+atMJ7GEctsejRoiYkiapfqzcahvEzU3zyNXP6XoxCRCkbd9OyDKSCALpJEyEM
         rUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=n7EOqQTRPF9XI+2b894weAYj/hPS2OyKbWBt3ey6gmk=;
        b=KYZWDxCoEaQvyieAYhx94BlB2S3cHVr4y4qUYfhv3SwvIaAGh8MuesuPwDCeIOopeU
         Cc5a9HLRaPa8PgbVt1GuYOrImKzJdAS0SVcr35O/ld/7uOXcS5cACS9NPAnpswqZsIdj
         vceusi9b9NSy2HaVAUrVsqyJzj4H1yD3Vow4CFlkg6Ts1QdJVcIioSDHJWV8aD1GDxip
         9nWNijZgOgSRcaIXhNlcOQ5fJPdZKr2YorFAU9nAVhIjsQlYGLTf3vHwH2JN5OFNUJao
         U8KCtnwjPkfwyBgECmbIe+bUXa3m5/aBljSv6ev1EK0y0Beez3GQwir1ljVfkyHm3sRS
         ua+A==
X-Gm-Message-State: APt69E3LWKmeO3b+MJt2u+uz6YjaUqqp4RSx7ekqKk++GukXFylNGQAx
        UvsbKck+8vV84VFy+lXWCjiF5BePaE1PiU6ooHw=
X-Google-Smtp-Source: ADUXVKIDxxXi+ovCh5PVqWTInnDlcDC0HmPxCOabTUhV9GCta6QDAMOKeb/uCRWPA96lKXF4D9GL/9CbXOlmj1IHQPo=
X-Received: by 2002:a9d:2ed3:: with SMTP id w77-v6mr3410ota.123.1528803830389;
 Tue, 12 Jun 2018 04:43:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:7019:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 04:43:49
 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1806121155450.2157@nanos.tec.linutronix.de>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-7-yu-cheng.yu@intel.com>
 <CALCETrU6axo158CiSCRRkC4GC5hib9hypC98t7LLjA3gDaacsw@mail.gmail.com>
 <1528403417.5265.35.camel@2b52.sc.intel.com> <CALCETrXz3WWgZwUXJsDTWvmqKUArQFuMH1xJdSLVKFpTysNWxg@mail.gmail.com>
 <CAMe9rOr49V8rqRa_KVsw61PWd+crkQvPDgPKtvowazjmsfgWWQ@mail.gmail.com> <alpine.DEB.2.21.1806121155450.2157@nanos.tec.linutronix.de>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Tue, 12 Jun 2018 04:43:49 -0700
Message-ID: <CAMe9rOoCiXQ4iVD3j_AHGrvEXtoaVVZVs7H7fCuqNEuuR5j+2Q@mail.gmail.com>
Subject: Re: [PATCH 06/10] x86/cet: Add arch_prctl functions for shadow stack
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
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

On Tue, Jun 12, 2018 at 3:03 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Thu, 7 Jun 2018, H.J. Lu wrote:
>> On Thu, Jun 7, 2018 at 2:01 PM, Andy Lutomirski <luto@kernel.org> wrote:
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
> That works for stuff which loads all libraries at start time, but what
> happens if the program uses dlopen() later on? If CET is force locked and
> the library is not CET enabled, it will fail.

That is to prevent disabling CET by dlopening a legacy shared library.

> I don't see the point of trying to support CET by magic. It adds complexity
> and you'll never be able to handle all corner cases correctly. dlopen() is
> not even a corner case.

That is a price we pay for security.  To enable CET, especially shadow
shack, the program and all of shared libraries it uses should be CET
enabled.  Most of programs can be enabled with CET by compiling them
with -fcf-protection.

> Occasionally stuff needs to be recompiled to utilize new mechanisms, see
> retpoline ...
>
> Thanks,
>
>         tglx
>



-- 
H.J.
