Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AD6ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66906213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BjfpOkpG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66906213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732568AbeGLUtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:49:16 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:37952 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbeGLUtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:49:16 -0400
Received: by mail-io0-f195.google.com with SMTP id v26-v6so29415011iog.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 13:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/CncoAKal/6ecb8G/QRbiv3nTxWWczK5WM/zDDkstCk=;
        b=BjfpOkpGR8yMEvRgz3KY08LDYTP1nVAtOk9BRY8tMTpO40U2Vvu/enWdL9fF4jn+nw
         kfLlBTJSDse3qoJb5k9uN3QAMI57PS6F8N/yevmEfrNf9hC296hWDM9vgmREut1Ti2j7
         HoAwhb4cYS6zlVKUzvlv4RAOXjb99zaCLlXQbOrLYPhL4e4ftWkihu8HboU68rDiEffZ
         +mk8TIxu6C2TKYbeZprzI4IpZay1rdfEDTuiip0twi0iIYL/EyZQXxm6QePgfucHo37p
         qD4sOyFdQtAHISvZ7w7UVbKcdwI5ucLQ+SmKJxQZBYzfMI9bvV5E6r9VFN4s5upBDa+P
         iKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/CncoAKal/6ecb8G/QRbiv3nTxWWczK5WM/zDDkstCk=;
        b=eR7j07jw5/5wBOeevXiqshGEmIvtTqAZ8MdPOwMabUT66S5srnzmrITatypdOdh6/y
         7to9PIsF5Fi0mSezNXmo2LgOaGi2DzMH2cpebHBm3z9fAkQ2T0jpnOaADwDWrmb280Bv
         uoryVlnfVwjdfC51VMpaAI7zi3BI7bDnbd0Mc6yN047vXpBvEkz2lvhvKb1GZ3b2NVLT
         tvWqWTLU3wmcWFRURK1mj8vNmGpyfvZDE8MEbXaoiUu/oHkVQUbkfNxWSnLIaPNDlV4u
         xdQKtgmmbqOvBhDb5RMSWDBRy7PooTV78N1WT0+YmBCfCWarKISlsnS9U2TZhYJYpVu4
         dogQ==
X-Gm-Message-State: APt69E0kfatrUN27UBnq4CxQuxsz2+1qx/C7EmgOvM+8aK2mDI3zVsu9
        MAUpN1SncAqchjI+hwAxlcsAg8MJ3Rm+q71dUt4FGMPV
X-Google-Smtp-Source: AAOMgpd6MyhXCit4Zt9+7tduTVNGzhquMUEtw0mARcCwaMRoEx97Fju4cecZU4x3C5sKT9phhSQslEyUV9zZ/gTOQ2k=
X-Received: by 2002:a6b:ac03:: with SMTP id v3-v6mr29090699ioe.71.1531427883244;
 Thu, 12 Jul 2018 13:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180712201032.156997-1-astrachan@google.com> <47d4b24e-8c60-fb3b-3377-62d20c5f3dd1@zytor.com>
In-Reply-To: <47d4b24e-8c60-fb3b-3377-62d20c5f3dd1@zytor.com>
From:   Alistair Strachan <astrachan@google.com>
Date:   Thu, 12 Jul 2018 13:37:52 -0700
Message-ID: <CANDihLEz3_fZ4r4g=VcxWps5DWSjMJdbJZKZWsLFKVp_c7FscA@mail.gmail.com>
Subject: Re: [PATCH] x86: vdso: Fix leaky vdso link with CC=clang
To:     hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        x86@kernel.org, kernel-team@android.com, joel@joelfernandes.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 1:25 PM H. Peter Anvin <hpa@zytor.com> wrote:
> On 07/12/18 13:10, Alistair Strachan wrote:
> > The vdso{32,64}.so can fail to link with CC=clang when clang tries to
> > find a suitable GCC toolchain to link these libraries with.
> >
> > /usr/bin/ld: arch/x86/entry/vdso/vclock_gettime.o:
> >   access beyond end of merged section (782)
> >
> > This happens because the host environment leaked into the cross
> > compiler environment due to the way clang searches for suitable GCC
> > toolchains.
> >
>
> Is this another clang bug that you want a workaround for in the kernel?

Clang is a retargetable compiler (specified with --target=<something>)
and so it has a mechanism for searching for suitable binutils (from
another "GCC toolchain") to perform assembly and linkage. This
mechanism relies on both --target and --gcc-toolchain when
cross-compiling, otherwise it will fall back to searching /usr.

The --target and --gcc-toolchain flags are already specified correctly
in the top level Makefile, but the vdso Makefile rolls its own linker
flags and doesn't use KBUILD_CFLAGS. Therefore, these flags get
incorrectly dropped from the vdso $CC link command line, and an
inconsistency is created between the "GCC toolchain" used to generate
the objects for the vdso, and the linker used to link them.
