Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B583C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B1D20652
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="X2mnoTPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B1D20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeICHKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 03:10:18 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35393 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbeICHKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 03:10:17 -0400
Received: by mail-it0-f68.google.com with SMTP id 139-v6so13794364itf.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Sep 2018 19:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rGIrP+Fnpuguc6WBPAyS3SpvYHUE6B5TLpMlC2xrLz8=;
        b=X2mnoTPMuc8WdmDwuP2oPKKzkEo2dYD0jX0NOLbh81chKAWInoExgvRjNwkqvbZcIn
         uYKnKVacK8FKSOGKQQjs5vJo2uxYhsR51XtzrwyrHIIisGpeg3ozZ4d06Squm9mBTrSt
         2sczHuTHR/p8W+X4I3CeU39Wojnk5w3HrOKNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rGIrP+Fnpuguc6WBPAyS3SpvYHUE6B5TLpMlC2xrLz8=;
        b=H5j6GrQWvSuBq/pP3QnUN9HeiwrQ4+1xJK44lzkNULanx+lCfriRNhgv9aT3eT7ApJ
         Zspi5edskWhoz9mdd5uwIENPRVFWjcqWDcQUE0yeINEcZUTSsvhP6MyW85IQeKWd+2du
         8hRX2xMV1D+pxyPsL58qxwJSkvNjfmzXV8E5DBTa7y9i2kDtOCHDzAicXOU0qiGvikkg
         kP4AS2EF3J5qkYQCNIKFTyoC/FZH4WpYvCo14LCV6RdawRZM/9ccNbB82spqb85ZbvV7
         BN86NwkzVvKvTT7FDCavvncy6MLd18GOvu+98ylMmxFVw65bUkIjXPK6RiMSHH8W8s5V
         +eEQ==
X-Gm-Message-State: APzg51DsGWV6KZr66747qpEVNnwv7Wfnt5O4V+75PbdkbOkCPSS+RQ0Y
        E8o4wmTph/wMNT468XACWXn1ozU72MXIKyiLfXE=
X-Google-Smtp-Source: ANB0VdYsHbBtjYTZlFuXSt860rMn3QV/h0frWqIPdF2+jwecCUh92OxJNIkPgP2s9MQt1u16acXzW5jSiDTg6/YTS2M=
X-Received: by 2002:a24:61d2:: with SMTP id s201-v6mr4237511itc.22.1535943133208;
 Sun, 02 Sep 2018 19:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <3009b28a-971c-920a-9184-900f1f3b2203@suse.com>
 <alpine.LRH.2.00.1808312312480.14475@gjva.wvxbf.pm> <CA+55aFyqpg_e8dXZWhdyVLa0xSYcK6iuRTKDXxnFLaFEcqZHkQ@mail.gmail.com>
 <CA+55aFyOSLEbiNvPoHkHe8WXae_aJiS+jsnubG8Xk0CYw8U4uw@mail.gmail.com>
 <a1980256cf3d2ea8e91707fcda7cf141b27a212d.camel@kernel.crashing.org>
 <fd389fc96692e38c318f14f0da840cdecda8fbe5.camel@kernel.crashing.org>
 <CA+55aFz_Kbu2PDjqvmgqCFcFSsoRPD=a8vAtPY=--t61X454Jg@mail.gmail.com>
 <CA+55aFwSfXu1LXjLZe4gddY2VybEGLbPpx-PWinF19LjbevEgQ@mail.gmail.com>
 <a2b20fc447e0b2cd208dc82081cb24e38bf71f68.camel@kernel.crashing.org>
 <CA+55aFyhq23ce94Vq_XdCJSOKvo8oYnb2UOdjf-KVaaOFngr+g@mail.gmail.com>
 <ca2ffedd94f7ca2a53c4417c801efbdd7c40eaef.camel@kernel.crashing.org> <CA+55aFx0b8ATmeO8KRaHrgsZnhT_0TqotsPUkxN4gbCsvrZuyA@mail.gmail.com>
In-Reply-To: <CA+55aFx0b8ATmeO8KRaHrgsZnhT_0TqotsPUkxN4gbCsvrZuyA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 2 Sep 2018 19:52:02 -0700
Message-ID: <CA+55aFwu8K5=DfVrLBgoDP33m-izCMqZoQ6UogCmYC8kN_XKtg@mail.gmail.com>
Subject: Re: Access to non-RAM pages
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 2, 2018 at 7:47 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The comment actually does talk about it, although the comment also
> claims that the cs read would use load_unaligned_zeropad(), which it
> no longer does (now it only does the read_word_at_a_time).

IOW, look at commit 12f8ad4b0533 ("vfs: clean up __d_lookup_rcu() and
dentry_cmp() interfaces") for why the zeropad went away for the cs
access (but the comment wasn't updated).

And then bfe7aa6c39b1 ("fs/dcache: Use read_word_at_a_time() in
dentry_string_cmp()") did the "let's make KASAN happy thing.

And yes, the word-at-a-time code actually matters a lot for certain
loads. The "copy-and-hash" thing for path components ends up being
pretty critical in all the pathname handling.

            Linus
