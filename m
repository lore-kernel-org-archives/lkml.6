Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A84C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7919120658
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="BxyfLfi8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7919120658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbeJSEtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:49:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43565 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbeJSEtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:49:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id n1-v6so35137397wrt.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 13:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fsywY2shMK+YeIYkXYOdsDpsrAZ04Rgim2baIRDzy8Q=;
        b=BxyfLfi8WEwk3JStF78kqj1lFJxgQTqQw4mtOUV2dA0dsQZ5yXKoGrPFjdnnIZd7XE
         9Q/tme8NRk6KkioWB/+MOq3N7Wpj07UGHrERDkzAx5fevAgJTZ5xLAa+7RfqflR2NP76
         bfXITeN/w/jjDTFMUbfjRhRNtkfa6OZBxCJsZEL1LZg6ypKas8WHAaPvW/k0JoenSQbg
         rQYV9zd46iqEpTMv2EWPDzhT2VBoRMa/hwimspCDX8/hdjo/HLE4bKBgUhDkoV+F8R5G
         WEGbi/ghxet7UFugdd47FYFr45Zo/TLZsZxRfd1HhFuL+a3pRLlN33NUQ38TPLxVGTPn
         qzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fsywY2shMK+YeIYkXYOdsDpsrAZ04Rgim2baIRDzy8Q=;
        b=darsyXSlIBclhnNynniyTcifz1MnRRT5gqqFvYemY39lQKhhnmibOLSN83t2yMiydq
         N8aN6tDbR8HWtLAFTGQBL2JFEI3l7G6CgzqlD5VHB8qlT2oGXqdnDBivyzVSV25+I0Ay
         LiN53aybGCgLUIVYOAqnSK7OOADoGT1EJWcJNupCujzkpI+vUIqMMXHqPZ2EgaRV/sle
         2s9qRd3JbxxtSepoP+FdfpWgLe0BJxxMAYrzVh1IMycG4fBLu7ueRbCqPV2bfpNg+BzJ
         jdx7vbyIGs9EYZor5DRRC3d8mDl+BMu98rOzOv5u727LA40ykDRCz6yXa8Z7G56y7KTM
         EhoA==
X-Gm-Message-State: ABuFfoh05uaDzteNmdlPCXzHvMZ1jcXY4qDqmq4MnIWo0HhFmNxV2o6s
        HU2hxfIg8qM0LTT5WWcyhKW5zqMG+fqzLfs8KBl3hw==
X-Google-Smtp-Source: ACcGV61o89jFTbBtogU4nTAN3IM8vqNPgbfXelbPfZKFcZOl0nog42P/2pJqgZ1O8gYMFNJup9lCv/Z6hAAJxpmQ4rM=
X-Received: by 2002:adf:97db:: with SMTP id t27-v6mr6873631wrb.283.1539895593889;
 Thu, 18 Oct 2018 13:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20181004140547.13014-1-bigeasy@linutronix.de> <20181004140547.13014-6-bigeasy@linutronix.de>
 <39e0a55f-4920-cfde-9bef-09c51109d211@linux.intel.com> <CALCETrUdxsFA5g0M9uRFktfdi=mxK_g3kBfs-VxwDZ0xWqjFAQ@mail.gmail.com>
 <20181018162644.qqjkzoqn2fleyi2b@linutronix.de> <CC7B46F7-7A6E-4CAF-A1EB-91271CC7B092@amacapital.net>
 <20181018182538.vgotfpsdy7qxl2tg@linutronix.de>
In-Reply-To: <20181018182538.vgotfpsdy7qxl2tg@linutronix.de>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Thu, 18 Oct 2018 13:46:22 -0700
Message-ID: <CALCETrVjEOkNhdyAF10PaYi_rnFUWKRqPhLRCq3ZV=gxQFETxg@mail.gmail.com>
Subject: Re: [PATCH 05/11] x86/fpu: set PKRU state for kernel threads
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 11:25 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2018-10-18 09:48:24 [-0700], Andy Lutomirski wrote:
> > > On Oct 18, 2018, at 9:26 AM, Sebastian Andrzej Siewior <bigeasy@linut=
ronix.de> wrote:
> > >> On 2018-10-12 11:02:18 [-0700], Andy Lutomirski wrote:
> > >> On Fri, Oct 12, 2018 at 10:54 AM Dave Hansen
> > >>> So I'm kinda missing the point of the patch.
> > >>
> > >> use_mm().
> > >
> > > So. I would drop that patch from queue. Anyone feels different about =
it?
> > >
> >
> > I think we *do* want the patch. It=E2=80=99s a bugfix for use_mm users,=
 right?
>
> This is the loophole that has been pointed out. I am not convinced what
> the correct behaviour should be here (and we have five users of that
> interface). For instance f_fs[0].  It reads data from the USB EP and
> then writes it to userland task. Due to $circumstances it happens in a
> workqueue instead of the task's context.  So it borrows the mm with
> use_mm().  The current behaviour random because the PKRU value can not
> be predicted. It may or may not work.
>
> Setting it to allow-all/none would let the operation always fail or
> succeed which might be an improvement in terms of debugging. However it
> is hard to judge what the correct behaviour should be. Should fail or
> succeed.
> But this is not the only loophole: There is ptrace interface which is
> used by gdb (just checked) and also bypasses PKRU. So=E2=80=A6
>
> [0] drivers/usb/gadget/function/f_fs.c::ffs_user_copy_worker()
>
> Sebastian

I think we need an entirely new API:

user_mm_ctx_t ctx =3D user_mm_ctx_get();

...

use_user_mm_ctx(ctx);
unuse_user_mm_ctx(ctx);

...

user_mm_ctx_put(ctx);

and ctx will store a copy of mm and PKRU.
