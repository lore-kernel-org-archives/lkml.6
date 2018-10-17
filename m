Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD6CECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DFA521523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fd7ze2hh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DFA521523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbeJQVft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:35:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45964 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeJQVft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:35:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id u12-v6so13203780pfn.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 06:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ixx4Ybmjxu91RY2LQlr7ikt9bJh+H2INS/VFi5gpdt0=;
        b=Fd7ze2hhu4vkQt7tG5VVBtDxtAOrNS+MlsVd9qtezb9aBb5e+iiNJ7WjTAx5XjOz86
         9cyz7DbirTzqvgEzYR2RxShoocnWFLRLNHNzmSdri43fbIDOTySS7VKnPtgBxusU6+ZI
         1d2vH43dUE0a4D0xeP2O1iwfi/jUd80+FQj6f4SXtOvEOdx6lNQvkX9pjuXeEW8g8EIE
         H73QgCwJRIaU7YsDx32c5qFXmvpvWc/w+7WhGLUYTutJb/fWA11Qe4LlbWjwvL6wV3Ch
         VGICmJw/+qk/KVgz0l5rhD2iPOBnmhG3zTPQi6ouJlcpSpluZaJhNvB7AyAVr/bEEoZr
         Ck/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ixx4Ybmjxu91RY2LQlr7ikt9bJh+H2INS/VFi5gpdt0=;
        b=LQ5K8Kq9RM9Y16UNByhxwB/JBWBu8fVPCkTL/WuRPwcL2bUqpofnpx7sLnSmUFHABo
         Y0fX5lcy6C85kNMLjOC2FogMlqTgCZuHxaDcEAcKAAjohjOq638V8BGWqND0Knas3Rxn
         3IQ218qT3/cyaYHIKXggkpXRt43K4KNRtZlQitvIFzFkGjId3OXyA1pB4SSo/FdODkgA
         9/WHA7fhSBNvIQECti1z3dA2RpuXPy6Xp6KJGQGWQEmPL9fMRphukIPnz6DqerTmQUEK
         FP/vrd9YBESTlUuG1vaoWL238Go9Fbj5U9G8O5/KJ4IEVkNcR2OSTi2P/xgvSs39zzI3
         DzhA==
X-Gm-Message-State: ABuFfoiiFKB1zp/haj0njTmF8jNXnNTkMya03LxadBdnbFlRy41USwo8
        VWBt8Dbmt8gWGuk8dzoA+3nwTasQmhc0EGuzlpdRQqoBgOM=
X-Google-Smtp-Source: ACcGV60rODJLuXIeF9U3xQuURAzHOePQ4dhEF1l67YIr+a4W8Mc/0+bWiRk2BR0N8r+73r6pFWPe7kj4bCZ3TsaBNIE=
X-Received: by 2002:a62:8a91:: with SMTP id o17-v6mr26740404pfk.184.1539783604001;
 Wed, 17 Oct 2018 06:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <20181017023652.6867-1-changbin.du@gmail.com> <62b6aff8-8ca2-7d6c-d810-64d10a25f2d4@siemens.com>
In-Reply-To: <62b6aff8-8ca2-7d6c-d810-64d10a25f2d4@siemens.com>
From:   Changbin Du <changbin.du@gmail.com>
Date:   Wed, 17 Oct 2018 21:39:52 +0800
Message-ID: <CABgQ-Tgfa-dX2v0LF95wTef36bKGwTkdB9AQrzCozOx_7kgMBQ@mail.gmail.com>
Subject: Re: [PATCH] scripts/gdb: fix lx-version for gdb 7.3-
To:     "J. Kiszka" <jan.kiszka@siemens.com>
Cc:     Du Changbin <changbin.du@gmail.com>, kbingham@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 08:56:44AM +0200, Jan Kiszka wrote:
> On 17.10.18 04:36, Du Changbin wrote:
> > For gdb version less than 7.3, lx-version only one character.
>
>                                           ^^^ prints?
>
I will update it, thanks!

> > (gdb) lx-version
> > L(gdb)
> >
> > This can be fixed by casting 'linux_banner' as (char *).
> > (gdb) lx-version
> > Linux version 4.19.0-rc1+ (changbin@acer) (gcc version 7.3.0 (Ubuntu 7.3.0-16ubuntu3)) #21 SMP Sat Sep 1 21:43:30 CST 2018
> >
> > gdb 7.4 seems to be no such issue.
> >
> > Signed-off-by: Du Changbin <changbin.du@gmail.com>
> > ---
> >   scripts/gdb/linux/proc.py | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/gdb/linux/proc.py b/scripts/gdb/linux/proc.py
> > index 086d27223c0c..0aebd7565b03 100644
> > --- a/scripts/gdb/linux/proc.py
> > +++ b/scripts/gdb/linux/proc.py
> > @@ -41,7 +41,7 @@ class LxVersion(gdb.Command):
> >       def invoke(self, arg, from_tty):
> >           # linux_banner should contain a newline
> > -        gdb.write(gdb.parse_and_eval("linux_banner").string())
> > +        gdb.write(gdb.parse_and_eval("(char *)linux_banner").string())
> >   LxVersion()
> >
>
> Looks good to me otherwise.
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux

--
Thanks,
Du Changbin
