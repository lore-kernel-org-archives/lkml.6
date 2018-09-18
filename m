Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C5FECE560
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94AA8206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MxjZVDGA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94AA8206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbeIRRJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 13:09:28 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37880 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbeIRRJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 13:09:28 -0400
Received: by mail-yw1-f67.google.com with SMTP id x83-v6so623061ywd.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 04:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=t9Y+jyPUH5P+1FKYGLzh+is3Z4n4lE1pjVBr0R3FxVI=;
        b=MxjZVDGAAzQPQDx1CerTQdc8iZTO/Svp3RAm3SBDMuHCK866vSXAULxezF3LiDyKeK
         XhCBCvZsJFEE+TQZhVXkl0BP7rTRnDP83LBBjTjYee+TRgMScOFFoRZF3stXzyJMu20e
         PpEVgoUL7UsxQdQfU9sYl3rmFp+8Qz7EyN0rU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=t9Y+jyPUH5P+1FKYGLzh+is3Z4n4lE1pjVBr0R3FxVI=;
        b=QgfjpRZPxtWjVsVAoPQYjHhLrCqwVihm8U87IWjMroAuufQNY1hLDYG5mosulO183O
         krVsl9/AJ7xzjM+GXzymngkOA9IeY4aSsoch7iubzUxxQ4QgkBwW01lefC+WTdTEMeEn
         Yd6fCHBCeox0AfA0aLAfxtuiDPEB6sUbzhHWVK1X59upGPW92WpGboeEoLcNfoJadMZt
         74k8EDmPWKNT8eV5Kx5rjv3T0q/i/LqQX+QPcPuuQu68kZRsTIu1bjVOCsYlF7oF9HsD
         +qfD2rPxSYuASwMNYUqMIamYbbONVmIOeC7snubg+BVLniP5OmawSL5WSRb0a/RhD+Uz
         KpPA==
X-Gm-Message-State: APzg51BoYXb+1FR7n9Tm/A6jKdgOXvuMtB2ri3ydX87OjYzIVQcFfp2t
        rpXO99iD7UxG16daOYf9qfi5U9ZbdUK5ZjSIdvddcw==
X-Google-Smtp-Source: ANB0VdZjpRBt8lkDg3fz8wt/eCdJ0l0NgQ3+NuE3+2cGFPGkEcC28Cn0qZ8c87oUXrrYEzyjlr7CXd/G57AA3kVG+8Y=
X-Received: by 2002:a81:9851:: with SMTP id p78-v6mr11847159ywg.175.1537270636651;
 Tue, 18 Sep 2018 04:37:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0d:cc4f:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 04:37:16
 -0700 (PDT)
In-Reply-To: <CAK8P3a0cfk6MG2SBRhJZ41suHw4D-dyCYGhqV9YeD_1rSMrGqQ@mail.gmail.com>
References: <1536036087-15260-1-git-send-email-firoz.khan@linaro.org>
 <1536036087-15260-4-git-send-email-firoz.khan@linaro.org> <CAK8P3a0cfk6MG2SBRhJZ41suHw4D-dyCYGhqV9YeD_1rSMrGqQ@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Tue, 18 Sep 2018 17:07:16 +0530
Message-ID: <CALxhOnhRFEenKmC2MuudFU4NMdR3v9jGOXWfbxE96eZj+YetfQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] sparc: Add system call table generation support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Miller <davem@davemloft.net>,
        sparclinux <sparclinux@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 September 2018 at 21:02, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Sep 4, 2018 at 6:42 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
>> The system call table generation script is added in
>> syscalls directory which contain the script to generate
>> both uapi header file system call table generation file
>> and syscall_32/64.tbl file which'll be the input for the
>> scripts.
>
> I would argue that for sparc we only want a single input
> table, since the 32/64 versions are similar enough that the
> differences can be addressed with 'abi' flag, rather than
> having everything marked as 'common'. Isn't that the
> purpose of the abi flag in the first place?
>
>           Arnd

Yes, we can do that way also. But few concerns I would
like to share with you.

I feel it add the complexity in the scripts. eg:-

108     32    setresuid32                     sys_setresuid
108     64    setresuid                         sys_setresuid
This case the script has to be smart enough to parse the
.tbl file properly. It need more logic in the scripts. This is
not common. So if you keep separate .tbl we can avoid
this.

ABI flag is serving *nothing* in all other architecture including
SPARC.

But as I told in the cover letter, I followed x86/arm/
s390 architecture's system table generation implementation.
They are keeping ABI flag. In our case we can delete this
flag completely from all architectures.

Most of the architecture these 32/64 similarity is absent.
So it would be better keep separate files to maintain a
generic script across all architecture.

One question here is; while invoking the script I'm passing
the abi flag. It is simply keeping in the .tbl file to make the
file similar to x86.  What I can do here?

- Firoz
