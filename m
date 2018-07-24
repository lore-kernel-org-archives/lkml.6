Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4305C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5A020671
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="I/5ZrLKC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D5A020671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388690AbeGXVXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:23:40 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:55395 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388476AbeGXVXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:23:40 -0400
Received: by mail-it0-f67.google.com with SMTP id 16-v6so5544110itl.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 13:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zo7XnMWTxi4YeBD5KPxlewi1K4MoMVrxTyT2Ix1c2Fs=;
        b=I/5ZrLKC007APqKEM3sqFGtRdHTueykvFq4sAPTln5+PXccRmU3f3S/ctbcGctgWCU
         sUrBx3z4F/LeXRaVJtQL5ydSaMDzOnNtW2/+z+nLd36yvNBy2Czd4lrZTY0xbIMa++Fo
         ZFhavEqTZXFt43ERnCPj+hMyHa+DJ0GtZv8A8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zo7XnMWTxi4YeBD5KPxlewi1K4MoMVrxTyT2Ix1c2Fs=;
        b=nKSTPcZAUHfkCzmGAy3wdGPiHs52gg0GjOPWlOjCPcimK7zTGlGJVyqEh4/sf/YQ/d
         BDujwgYp2v/JXyDPI6/MV0qBMyMZabIjt0+VYWkdSLfslMSRlEW/fOzn2ZUpmlj/vLZW
         9FzjR5gcXbY/pFr2gZT/d7HbtUWmTR2UsPqgGZUT/8IkmYZxCMShIV4O2NPNoAqXQy5c
         7tKn3Mm7XN/QAPjKiDCFsXV3e4tsmXM+Mv9vrB9XSL7xtPiaX0iR914zQOHw1qAsWxTU
         zAQiYCtHJNHKDoag4kFg6JS5xrmCKOVYb/RjUDPugBMyrTrsi5C/tuMhXktumnl5TdeO
         pomQ==
X-Gm-Message-State: AOUpUlG7qOHSGBs5qfW2gyNNXLDpfnOGqfDImMw44Ujt1cVs1FKS8YX3
        aOkyt4Gf/qPFxLXX8u7RP6sur3+BpvgfWLqo5mg=
X-Google-Smtp-Source: AAOMgpcOjur6Rgn3KQW5C9+wiM2gsvU6zarL7Vs+2Q+hFb1+aNhTdWjLnhIpI8+x8cLmrxx5qcV/r4kfSqAkvU0JLY0=
X-Received: by 2002:a02:1bdc:: with SMTP id 89-v6mr16622721jas.72.1532463332916;
 Tue, 24 Jul 2018 13:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <87efft5ncd.fsf_-_@xmission.com> <20180724032419.20231-20-ebiederm@xmission.com>
 <CA+55aFxNijeenFd6o7fg3iJFqAjdTZLaFV2=Eaqbg1fDOzx26A@mail.gmail.com>
 <874lgo5xdg.fsf@xmission.com> <CA+55aFw_CTTRTZfUf1e9yg04X_djG3q7HrCG-XqnyQorpKjaTQ@mail.gmail.com>
 <87fu084cxj.fsf@xmission.com>
In-Reply-To: <87fu084cxj.fsf@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Jul 2018 13:15:21 -0700
Message-ID: <CA+55aFxUc3ttEAuRS7GKs9aTjTFw1poE80DASFSXudVQCuWpHg@mail.gmail.com>
Subject: Re: [PATCH 20/20] signal: Don't restart fork when signals come in.
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>, majiang <ma.jiang@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 1:05 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> What I hear you asking is  moving up copy_signal copy_sighand copy_creds
> and alloc_pid, and anything else that signal delivery might depend on.

No, _just_ signal allocation.

It would still just use the special-case list to set the pending bit.
No creds, no "full task", nothing like that.

> I really want something very simple and straight forward because I don't
> see us testing or hitting this code path much in practice.  Moving this
> into the middle of fork and adding more depedencies does not seem like
> it will be that kind of straight forward.

I think your "list on the stack" was anything but straightforward,
considering how utterly broken the error handling of the patch was.

But hey., send a fixed patch and see how it looks. I think you'll end
up adding a lot of "goto signal_cleanup" cases.

          Linus
