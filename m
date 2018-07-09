Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD59C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9B52087C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qh1I+qwz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9B52087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754658AbeGISa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 14:30:59 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35279 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754641AbeGISaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 14:30:55 -0400
Received: by mail-pf0-f193.google.com with SMTP id q7-v6so13144260pff.2;
        Mon, 09 Jul 2018 11:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w3R+dxmtGQJass5v+U1H+BlweUmN820sgEAalhi1Hbw=;
        b=Qh1I+qwzUiP5OJij84Icg5DEo+qlo6CbvXhIFTbbuNIiI4oNX8t2ahJcTTa/o8OI4v
         Np25vD28WbBL9u2EIT3CVSGI6gyit4EkJu2y4WmaKSeaAdTIkYTDBdDv+ylohYBaYVv3
         pt57khsjU4dsG1nvMoe8rVBXIIhxB0j2Eoxm1guqw+4wUEv9Trkjb8PWjw/C3Bo/u6T1
         NiBX3MKY0Lb5wz/AVIY9tpiwfGQ/7bMAhkmODMcCsBoMANar5kDLh4nGk5d/xRjnDin6
         HivH3JVKWwsOGHLk0HiE8I6+avVTuQ5uinzRnj2aiCxcQJCzjhiMINWC9yVuwCsKvS+b
         kKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=w3R+dxmtGQJass5v+U1H+BlweUmN820sgEAalhi1Hbw=;
        b=GXH0DsSjFGhK7UNHQbA8/toJRhrDZoheNJY0QO3Ez94F0OZ+Z7KLsnlWMqWOjgJvtD
         VZ58jGtwkwNw4qtn5k3xXBwQGjp4QN9728IumsIMXMU4vnhzOofutSfqR0lKP4wFthrO
         RdDLham7CcZ0ZQ5NVfc4/ZIVaWua4w6fwjKOE+PnKUdnmvZbromXhHy0ZwhZW4oWH83D
         68BufiAsxdP8So4EAN0CB0NUy36ltnKEWI6oKAWF5Njx7vobfz2/EGnF/0CEKZ8okTfx
         0tr3rhIWU2m9CXNHVq+XdNfGOs1Zb95EblEQkh56ABsXoduJjmvoQLUPEHNv5/Brjy2Z
         hXBA==
X-Gm-Message-State: APt69E0gYrQPltLN2AgG8ot+Rbhrea3hAgmxsxX1cru5urTPsAR0ljwI
        K2jF7ws1eDnRkB9jdwKpCEGyvg==
X-Google-Smtp-Source: AAOMgpfsJZt0EReUQkXXqIT1VT+S1n/jwQKB8cJJ4aZJDW8R6xx4xz6EFmnGrVTyLYDt8d0s5mZdsQ==
X-Received: by 2002:a63:7847:: with SMTP id t68-v6mr13663440pgc.329.1531161055125;
        Mon, 09 Jul 2018 11:30:55 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id z4-v6sm26839669pfb.108.2018.07.09.11.30.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 11:30:54 -0700 (PDT)
Date:   Mon, 9 Jul 2018 11:30:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: Build/qemu test results for v4.18-rc4
Message-ID: <20180709183053.GB31159@roeck-us.net>
References: <20180709175550.GA7469@roeck-us.net>
 <CAGXu5j+rn+69QiLR=Rbd6ys7atL8Z8THyazW_T3Z=CAw0n8xzg@mail.gmail.com>
 <3207f3de-0a10-f575-f24f-210a2a926c4c@de.ibm.com>
 <CAGXu5jKyESyPD1MyM7BrVFPKDY9+HqRCpXcKG5ikCZwdGZLaSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKyESyPD1MyM7BrVFPKDY9+HqRCpXcKG5ikCZwdGZLaSw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 11:19:17AM -0700, Kees Cook wrote:
> On Mon, Jul 9, 2018 at 11:16 AM, Christian Borntraeger
> <borntraeger@de.ibm.com> wrote:
> >
> >
> > On 07/09/2018 08:06 PM, Kees Cook wrote:
> >> On Mon, Jul 9, 2018 at 10:55 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> >>> s390:allmodconfig:
> >>>
> >>> arch/s390/kernel/als.o: In function `verify_facilities':
> >>> als.c:(.init.text+0x24): undefined reference to `latent_entropy'
> >>> als.c:(.init.text+0xae): undefined reference to `latent_entropy'
> >>> make[3]: *** [arch/s390/boot/compressed/vmlinux] Error 1
> >>> make[2]: *** [arch/s390/boot/compressed/vmlinux] Error 2
> >>> make[1]: *** [bzImage] Error 2
> >>>
> >>> This problem is only seen when using a compiler which has the relevant
> >>> plugins enabled. Bisect points to commit 1658dcee3d43ed ("gcc-plugins:
> >>> allow to enable GCC_PLUGINS for COMPILE_TEST") as the culprit. I don't
> >>> know if a fix for v4.18 has been submitted. The s390 boot code in -next
> >>> has been rearranged and the problem is no longer seen there.
> >>
> >> Hm, that would imply that mm/page_alloc.o wasn't visible during the
> >> als.o linking? But ... if the problem is gone, I guess... good?
> >
> > als.o is used to detect if the kernel was compiled for a newer generation
> > than the hardware that we are running on (very early). So it is compiled
> > without gcov, kcov,ubsan and with a different march -in other words special.
> > In linux-next we moved the als part to the decompressor which avoids all
> > these kind of special handling. As this is part of a bigger patch set it
> > would be  non-trivial to backport that for 4.18.
> > So unless we want to have it fixed for 4.18 I think we are fine.
> 
> Okay, cool. If you want to fix it for 4.18, it should just be
> something like this in the Makefile:
> 
> CFLAGS_als.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
> 

Yes, I confirmed that this fixes the problem.

Thanks,
Guenter
