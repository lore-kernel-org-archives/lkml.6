Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC041ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B7820652
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lt0CQyrV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B7820652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbeGRQtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:49:07 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46362 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731361AbeGRQtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:49:07 -0400
Received: by mail-lj1-f195.google.com with SMTP id 203-v6so4566838ljj.13;
        Wed, 18 Jul 2018 09:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=IF9bR0+4/6n4RL0exynGUupnYhn/Qsfmu1qFrjhvzrU=;
        b=Lt0CQyrVhnePEzOMXZbY1/GgUPKTepGeyn/KIHHpCZbC1whS+0u5o4FKND+k+YyxMv
         UqyOSK+5xOnhdkqJqbI7C4q2/2JF2BZnYsQHuPqv+LMtsNvsULv2B3TTV2d91PatbaFc
         tmpYURkKwPJTaygBdbdPdjhQuEIUSEW1PPKOSn6umlRSuOBDdG8pxTf8qLQHcXr9YZCc
         nVHmw46Wgzz1UaZ4Sp73dtZXDxqsvTrWOjqWWwdp8HgDh/IbScwJAsbzPpu4qRPZAddU
         /pZlzLnzVfon0pgVfoWJc5gliIT/51hp1UFu+rjpmf+vD/OSvZdQZNKbdkG5NSie+nHO
         ChkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=IF9bR0+4/6n4RL0exynGUupnYhn/Qsfmu1qFrjhvzrU=;
        b=hLpmUBjD/8B3lxx2HoNbwA0Y6GnCkdxRAnqVI3ddHcNzxY8guJ8rIzNR5SB5u9GXW5
         35RxKO5+vIsKkiV/aSVoxUewYQ+xUnQMCCfLun/HFz0cSvNL+IXu22jA1zzPisAnd2Y/
         T9CPo+d0ZgbHSUfdSdCRPqz+U67F8BL+l2SEI1HxNfFB2qfmP96hcn7JeQdZBEAfE0oR
         Ai110lex6+3OoMUnu6L+aJAjVmRB3o7Anm3YJiyO4IDVC64DNP0erPRzSkPWLm/q9Za/
         L3eba7DRR7zawwr1+wPnANq4KhWTi+2ZiOqASCGJC25TqlN+dDRb+9WbS0z7ag1oK+8G
         BnFw==
X-Gm-Message-State: AOUpUlEXBiIfRpNk/jMUURwVeGAjMuS7Bl+/qCnZeU22akF7afMEbbyw
        0766IRXUnuzAIfbrCALoP0HOpRemRTwRva6I63s=
X-Google-Smtp-Source: AAOMgpctPg6cMlPjPVlPAQF9jHVDQt8YlW1nShLv1+DrkcLtbnL+T87Rj3LzXv+Wze4ej0QiXFW4B4inU9oHE6THU/4=
X-Received: by 2002:a2e:998e:: with SMTP id w14-v6mr3800658lji.7.1531930230033;
 Wed, 18 Jul 2018 09:10:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 09:10:29
 -0700 (PDT)
In-Reply-To: <20180718155006.lkoktldllafrfqbf@cs.cmu.edu>
References: <20180718114645.591551-1-arnd@arndb.de> <20180718155006.lkoktldllafrfqbf@cs.cmu.edu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 18 Jul 2018 18:10:29 +0200
X-Google-Sender-Auth: t3SjPtl-EgfxMOvnScb4k_2eP1A
Message-ID: <CAK8P3a3HYBar1yVCEjxR2VNpPOOx23qM5fCyO-TMmeF780rBiQ@mail.gmail.com>
Subject: Re: [PATCH] [RESEND] coda: stop using 'struct timespec' in user API
To:     Jan Harkes <jaharkes@cs.cmu.edu>
Cc:     "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 5:50 PM, Jan Harkes <jaharkes@cs.cmu.edu> wrote:
> On Wed, Jul 18, 2018 at 01:46:25PM +0200, Arnd Bergmann wrote:
>> Unfortunately, this breaks the layout of the coda_vattr structure, so
>> we need to redefine that in terms of something that does not change.
>> I'm introducing a new 'struct vtimespec' structure here that keeps
>> the existing layout, and the same change has to be done in the coda
>> user space copy of linux/coda.h before anyone can use that on a 32-bit
>> architecture with 64-bit time_t.
>
> I think the userbase is small enough that we can handle a much simpler
> transition to 64-bit timespecs everywhere. In that case the
> CODA_KERNEL_VERSION should be updated, which is currently defined in
> include/uapi/linux/coda.h as 3. As moving to 64-bit timespecs only
> breaks 32-bit systems this allows userspace to catch that case and
> refuse to run userspace with a mismatched layout (or handle
> translation).

Ok, so to make sure I get this right, you say we can do an
incompatible ABI change for coda without causing any problems
for existing users?

That would definitely be the easiest approach here. I guess
we also just have to be incompatible for 32-bit user space,
since it would make 32-bit users have the same ABI as 64-bit
ones, right?

I'll have another look at the ABI side then, to see how it can
be transitioned.

> It also would make how to handle questions about truncation moot, or at
> least moves the problem out of the kernel into userspace.  We actually
> were already using unsigned integers for timestamps in the client <->
> server protocol, so as you noted, that does give us a little breather
> until 2106.

ok.

>> Originally sent on June 19, which lead to a short discussion
>> and an Ack, but the patch did not get picked up for 4.19 yet.
>
> I'm sorry, somehow I missed the follow up questions in that discussion.
>
>> > If we only have one code base, it should be fairly straightforward to
>> > make it deal with 'unsigned' timestamps consistently, which would
>> > let the code work fine until 2106 rather than wrapping around from
>> > 2038 to 1902.
>
> At some point there was a webdav filesystem that used the Coda kernel
> apis, but I think they may have moved to FUSE since then so I would not
> be surprised if there is only a single code base at this point.

Ok, I found davfs2 at http://dav.sourceforge.net/index.shtml

Ah, so the coda kernel implementation is similar to both fuse and 9pfs
in that it can connect to arbitrary user space implementations, but with
no known users other than your coda user space and some versions of
davfs2?

      Arnd
