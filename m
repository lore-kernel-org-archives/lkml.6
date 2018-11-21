Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A4BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1702080F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UZIs/Dwy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1702080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389902AbeKVIUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 03:20:36 -0500
Received: from mail-io1-f45.google.com ([209.85.166.45]:45765 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729727AbeKVIUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 03:20:36 -0500
Received: by mail-io1-f45.google.com with SMTP id w7so5151522iom.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 13:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=zvQfOE74+PILfenmuxRflVw0EMeCHeMf/eXJisDTHgs=;
        b=UZIs/Dwy/GlvrrwJXzHXUb7yVHghrabcwxJZrc/48CCwGQlmMKu9K/1J2HMXDTWsUH
         lz+8XYn1T+loJGDEMpKFgywEwvGWyqmbjMOPb7qAcStM7vOzbIXWCloECCMQ0g3b7MMs
         zE1CTy/7wQK7QpSxwgJphIewEicHhDwRlI0L4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=zvQfOE74+PILfenmuxRflVw0EMeCHeMf/eXJisDTHgs=;
        b=WVn1nEbhehnpnBW53KEFV2r4dnT0xde8/Ya9wh9eR/n8x4dVp9eXds8fjqmEl83Bou
         gkI6jpw1qClTt89JDTql6T3x47/43ewSfugRXRNOwq8LjgL63owhC5QTncEdgk1ZU5sw
         mYQ37PbYKAoHNzOIZl0M+IN6uab9/MOdzlQbYSb357feWRUGGVS6WQ35qlDGex2VuKhr
         e80oh6bkt6wQOQFT9r8LYwaHxTkc9YR4U0PCbd3z811VwWdf06ouTMclUeCHbPOju3X8
         Xlbiz+Al+ZjLGVhe7C3qrBBssYHi4ATSxlNG17hCUF7VRzswhPOyhbdKtL1utSAvWMJ8
         PnBQ==
X-Gm-Message-State: AA+aEWY2ccYYWENLc4DnGitUPWYieeQryHXzao0iqfXcygNytO0VUKUw
        lBenxXCkDtWqhUR92M4uP25TJsP4iiYx35CdKfHXEg==
X-Google-Smtp-Source: AFSGD/XCppLfdA9hanOWu8KpFTHzgB3rzChYpmL8f4rjDkys0UBgxylePO2f38NUwMyD1+EDCvRcqohZupZYguWxkAs=
X-Received: by 2002:a6b:5d01:: with SMTP id r1mr5927472iob.170.1542836667412;
 Wed, 21 Nov 2018 13:44:27 -0800 (PST)
MIME-Version: 1.0
References: <20181121205633.oxksehwjg5a2q6rt@oracle.com> <5A24CA1A-3059-44BE-A0D5-4E29FC6E5BE9@vmware.com>
 <20181121211447.weqjjk2fwbc27er6@oracle.com>
In-Reply-To: <20181121211447.weqjjk2fwbc27er6@oracle.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 21 Nov 2018 22:44:16 +0100
Message-ID: <CAKv+Gu-jnppk-zJnqij-J6CwW0Vf4xZw+uESGWBCHoyk3ZEgDA@mail.gmail.com>
Subject: Re: Out of tree module build errors since v4.20-rc1
To:     namit@vmware.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018 at 22:15, Liam R. Howlett <Liam.Howlett@oracle.com> wro=
te:
>
> * Nadav Amit <namit@vmware.com> [181121 16:12]:
> > > On Nov 21, 2018, at 12:56 PM, Liam R. Howlett <Liam.Howlett@Oracle.co=
m> wrote:
> > >
> > >
> > > My out of tree driver build is now reporting issues with the jump tab=
le:
> > >
> > > ./include/linux/jump_label.h: In function =E2=80=98jump_entry_code=E2=
=80=99:
> > > ./include/linux/jump_label.h:153:14: error: dereferencing pointer to =
incomplete type =E2=80=98const struct jump_entry=E2=80=99
> > >  return entry->code;
> > >              ^~
> > > ./include/linux/jump_label.h: In function =E2=80=98jump_entry_set_ini=
t=E2=80=99:
> > > ./include/linux/jump_label.h:180:7: error: dereferencing pointer to i=
ncomplete type =E2=80=98struct jump_entry=E2=80=99
> > >  entry->key |=3D 2;
> > >       ^~
> > > ./include/linux/jump_label.h: At top level:
> > > ./include/linux/jump_label.h:212:26: error: array type has incomplete=
 element type =E2=80=98struct jump_entry=E2=80=99
> > > extern struct jump_entry __start___jump_table[];
> > >                          ^~~~~~~~~~~~~~~~~~~~
> > > ./include/linux/jump_label.h:213:26: error: array type has incomplete=
 element type =E2=80=98struct jump_entry=E2=80=99
> > > extern struct jump_entry __stop___jump_table[];
> > >                          ^~~~~~~~~~~~~~~~~~~
> > >
> > >
> > > This happens in v4.20-rc3 as well, so I bisected between v4.19 to
> > > v4.20-rc1 which resulted in the following commit:
> > >
> > > b34006c4258c9c86597b6b7123d6a9a3513d6cd7 is the first bad commit
> > > commit b34006c4258c9c86597b6b7123d6a9a3513d6cd7
> > > Author: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > Date:   Tue Sep 18 23:51:41 2018 -0700
> > >
> > >    x86/jump_table: Use relative references
> > >
> > >
> > >
> > >
> > > Initially I assumed this was my own fault, but my module does not hav=
e
> > > these issues when using v4.19.  Is there anything I should try/change=
 in
> > > my module makefile, includes, etc to support this relative reference
> > > code?
> >
> > Do you see HAVE_ARCH_JUMP_LABEL_RELATIVE set in your kernel config?
> >
>
> Yes:
>  $ grep HAVE_ARCH_JUMP_LABEL_RELATIVE .config
>  CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=3Dy
>
>
> I should have mentioned I ran 'make defoldconfig' between each bisect.

That is puzzling. linux/jump_label.h defines a type struct
jump_label_entry if CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE is #define'd,
and so the error suggests that it is not.

Can you share the command line (with V=3D1) and the preprocessed result?
(Re-execute the failing GCC command but replace -c with -E)
