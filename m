Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E0DECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92332086E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kn+J6OWn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92332086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbeIRCpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 22:45:31 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:37974 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbeIRCpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 22:45:31 -0400
Received: by mail-it0-f68.google.com with SMTP id p129-v6so279294ite.3;
        Mon, 17 Sep 2018 14:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rguy3k0JM+uv8VJy66M2BrBxJFkxQarTpX3kyJJkCvQ=;
        b=Kn+J6OWnWbwSu3wLJnQDZF+HGdz92gTePKnLdZ9LSQgOcHvkvwwlqnEC0XI8/c9FRq
         khAxkAvupUMiufZ3NM7eyzdJPEm+sAYFbSZrEzirdsnyl8s+1mDY/Jq203KqXifIicml
         oRofQURa/PM/d8JJ3TAFYuvOjL3A+oQQg6wCN7NeTaw3061viVqMCWxlr2CjZsQJxRRR
         uEYjW391eSe6+X5sYIPjioMdNC+djFNmEK1funA93v390mOOf0KXOWySrm7Dt15c/Ebv
         wHCaJJS+WmsLSoFysalbaxjQgE7hSK8LjgPsB1t44MxlVskcwRyIvQsTLkXT4gNBE2vU
         mevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rguy3k0JM+uv8VJy66M2BrBxJFkxQarTpX3kyJJkCvQ=;
        b=Wz9LUL5OKOKTdKk2AbsFUCwgE+Lq5wdFt46XRU+49q/i4tRsQ6DylMgB5gFrAKx8Sk
         cL+ksj2PV7gUUuD0LdISp/CQ48nDfgauqdgcdW+UQb+lHAzl/L+zxr5/Q7R9aG0uixlJ
         tzI/YbLuJT/H9522Dx+UylVojnkeppVhNd0Eh4HoPLPKi9D12Uc+8FVY0RiryV8Ydqmz
         dvtWUipkCFXj1lkbWmRHdpbDuNPMzTbm5UkLPTIyegHa4kK/e0aEAuwi2IvMTAcxggyc
         7AIzWSB5g77j/i1jDxuYXOULLN+uSfaSQiDtlMbP0eRuwnmN35Wl8FUobnfYLciiDtwT
         6iVg==
X-Gm-Message-State: APzg51BFErZPX9fWsjJsk4d+bnD2DrWAqFTa+lbxf+FpPbjJN2U2lQo6
        0G/naARlXmwQSq5Thl8yOI0fKt+Sa7YCqVGSfq1MhQ==
X-Google-Smtp-Source: ANB0VdalmFZJbbTSZGQ6IOaRF5Q4AuGSfM+7veq1v+rlzhupyDnI6tLtyO8giLkCGGsxlb6StQXYADOFV9gzsNIq0tU=
X-Received: by 2002:a24:8782:: with SMTP id f124-v6mr11390801ite.87.1537218985308;
 Mon, 17 Sep 2018 14:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180917010458.23159-1-deepa.kernel@gmail.com>
 <20180917010458.23159-5-deepa.kernel@gmail.com> <20180917203438.maary2eo64dbuhw2@sghpc.golosunov.pp.ru>
In-Reply-To: <20180917203438.maary2eo64dbuhw2@sghpc.golosunov.pp.ru>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Mon, 17 Sep 2018 14:16:09 -0700
Message-ID: <CABeXuvrZHRLjiyqs_rGXWCKqjiWXkQPBr=mHntpZ6xdoc3z_Zg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] pselect6: use __kernel_timespec
To:     stepan@golosunov.pp.ru
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 1:34 PM Stepan Golosunov <stepan@golosunov.pp.ru> wrote:
>
> On Sun, Sep 16, 2018 at 06:04:57PM -0700, Deepa Dinamani wrote:
> >  static long do_compat_pselect(int n, compat_ulong_t __user *inp,
> >       compat_ulong_t __user *outp, compat_ulong_t __user *exp,
> > -     struct old_timespec32 __user *tsp, compat_sigset_t __user *sigmask,
> > -     compat_size_t sigsetsize)
> > +     void __user *tsp, compat_sigset_t __user *sigmask,
> > +     compat_size_t sigsetsize, enum poll_time_type type)
> >  {
> >       sigset_t ksigmask, sigsaved;
> >       struct timespec64 ts, end_time, *to = NULL;
> >       int ret;
> >
> >       if (tsp) {
> > -             if (get_old_timespec32(&ts, tsp))
> > -                     return -EFAULT;
> > +             switch (type) {
> > +             case PT_OLD_TIMESPEC:
> > +                     if (get_old_timespec32(&ts, tsp))
> > +                             return -EFAULT;
> > +                     break;
> > +             case PT_TIMESPEC:
> > +                     if (get_old_timespec32(&ts, tsp))
> > +                             return -EFAULT;
> > +                     break;
> > +             default:
> > +                     BUG();
> > +             }
>
> One of the two get_old_timespec32 calls here should be
> get_timespec64.

Right. It is a copy paste bug.

Thanks,
Deepa
