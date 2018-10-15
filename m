Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB63C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32FD120881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrzrL2KR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32FD120881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbeJPE00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 00:26:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbeJPE00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 00:26:26 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 350ED21471;
        Mon, 15 Oct 2018 20:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539635973;
        bh=THHYoNaTLkRDFJWkRyI5CLYM20a/EMclstlhzFjHCII=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZrzrL2KRNf9fpmah+RJsf9MDm2VneExGuGDF2dj/TvbBFvvxYNkaFpRcEr4eFPilB
         gLKVRzSD3wH2QsPpVgU91+UlNbEllbuPlA8YOhx8MfbDe4odPdqr273atNcauxrX/n
         0MaJAXSVerpO093dIA0t4lylXW09tX+p90Hj/PCE=
Received: by mail-ed1-f44.google.com with SMTP id b7-v6so19132797edd.9;
        Mon, 15 Oct 2018 13:39:33 -0700 (PDT)
X-Gm-Message-State: ABuFfoj/kGCpujdY/WZ9BAIvUT4U6jLpW8Xwq13TPRGn+J5p7b+h91v1
        L1Ep8DGd8f4EoUXGtLycR+jQKQg8LxmQXZVjiVM=
X-Google-Smtp-Source: ACcGV62djEsD7Oq+4HA/ftkBjCTNNu002ZO9IJg6kl64uvSOIsO+LHHiiX0shBRA9Jsv9ZBbFeTzTN3LSyNVepKbaZo=
X-Received: by 2002:a50:fc06:: with SMTP id i6-v6mr22757977edr.153.1539635971545;
 Mon, 15 Oct 2018 13:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <1539567282-1326-1-git-send-email-frowand.list@gmail.com>
 <CAMuHMdXad2g5zEZ8=XzzVgfijcatKYj5AjwVQg=W-by_rHfcAQ@mail.gmail.com> <e69685d5-e09f-5f7d-2ff0-7ead12500371@gmail.com>
In-Reply-To: <e69685d5-e09f-5f7d-2ff0-7ead12500371@gmail.com>
From:   Alan Tull <atull@kernel.org>
Date:   Mon, 15 Oct 2018 15:38:55 -0500
X-Gmail-Original-Message-ID: <CANk1AXQU=3Ap=wbO5b8c2pMq61hzuRkeWYNv2Esq+c9d+0e_BA@mail.gmail.com>
Message-ID: <CANk1AXQU=3Ap=wbO5b8c2pMq61hzuRkeWYNv2Esq+c9d+0e_BA@mail.gmail.com>
Subject: Re: [PATCH] of: overlay: user space synchronization
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 1:09 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 10/15/18 01:24, Geert Uytterhoeven wrote:
> >
> > Please say explicitly that tree_version contains a 32-bit unsigned
> > decimal number, which is incremented before and after every change.
> > I had to deduce that from the code.
>
> Good point.  I'll add that.

Looking at the code, tree_version being odd or even means something.
tree_version is incremented every time the of_mutex is locked or
unlocked, such that:
 * tree_version is odd  == of_mutex is locked and the tree is
currently be in the process of being changed
 * tree_version is even == of_version is unlocked again and the
changes are finished.

How about making this explicit in the interface by breaking it up into
two attributes:

/sys/firmware/devicetree/tree_lock == "locked" or "unlocked".  If the
tree is locked, you know that the tree may still be changing and the
sysfs can't be trusted to be stable yet.  Or maybe even more
specifically tree_overlay_lock?

/sys/firmware/devicetree/tree_version = a u32 that is incremented once
for every overlay added or removed.

Alan


>
>
> >
> > IMHO that is more important than having the sample script here.
> >
> > Gr{oetje,eeting}s,
> >
> >                         Geert
> >
>
