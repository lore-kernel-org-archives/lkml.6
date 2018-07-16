Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E22CECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AAE520850
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N8BM6qn9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AAE520850
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbeGPUtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 16:49:52 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:41375 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbeGPUtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 16:49:51 -0400
Received: by mail-oi0-f68.google.com with SMTP id k12-v6so77255201oiw.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 13:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WCmPxVK3qYnR6RrgRdSfGNbiY0q4whf6n33vgOL84UY=;
        b=N8BM6qn9D0cG1ga2Pc2yQH4+5Q7cpcjCE05dCYQa6SXUVaIPJ+oMH2zY1TVk/ZoDH2
         6nI9UgWaqEOVvIaQcH2gFbbKSXk8sFA+kioSg3RBLCrDbcsJ/EnERT+zUij5GuwFUMx1
         xD38GEMQahn5+qDtAImCb4spGY9hXLSxnLBmmFfVD3VM5l8DL/WCXTk3BUsC5FesxkxB
         9I1tCDoavhWwonxQN54l4K5+8utJVjj7ru3Y7Aq1qTdfzcZbWYlEVJgtU7rCH58Lk+ql
         PVPrd7iZ5jF1PKYLETcMnGmZ4+LhCqbivO8vLqvefFJAy24ZFJt24peZqGx/VIhEwr+4
         s3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WCmPxVK3qYnR6RrgRdSfGNbiY0q4whf6n33vgOL84UY=;
        b=CdB113UyfWvB4yoZpyll/y9uEG6ykZpjYj+ZmprTXF6dvMqdfzjLCymd08iEFtObXK
         3tER13BaMhapmT2A4aROENsLLck9mKgyW5byvO1PuDSR7LZpiu9C3hP2xoBsQ2mywDDG
         V2WEKCwWmV9Rhkysijh0tgKTdUo6zOu6owbTeB1P5cRejekmnej0uJSOG9x4X1TsNtVC
         SVwD2To0rw4t2awmJou1G+e2uhDfuu/jl/hHrv8V/iAVCoa/ftEdKt+km0D1TdNBE2oq
         yhe5w2Z81E6dcpAGKqmqbujDmVZeaT4b8v45tSjmq4ulf4Y3iEYaM/ePi5o/+LYDJjT9
         QmIw==
X-Gm-Message-State: AOUpUlEfDYHGmVDet6MEM116hnophgAesJx/2ziVCytnsDZFRSkzztBv
        uOcGO97GbkmadjVIICCQXdMOBiHio9toXz6ZavFAkw==
X-Google-Smtp-Source: AAOMgpdH9kIE4FIL9OshrrqVqY2pOIftECS1AO49kxv4rc5x15FF7Njdwm8QmYBIko58WcjOHbRiM7oozQCOZbgNMO8=
X-Received: by 2002:aca:e089:: with SMTP id x131-v6mr789552oig.221.1531772450691;
 Mon, 16 Jul 2018 13:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180716194843.252772-1-jannh@google.com> <20180716195657.GO30522@ZenIV.linux.org.uk>
In-Reply-To: <20180716195657.GO30522@ZenIV.linux.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 16 Jul 2018 22:20:24 +0200
Message-ID: <CAG48ez1=rW2fBmx0pwu+yQCGpq2Bu7XnMYRkYJt2Dnj5y1USFw@mail.gmail.com>
Subject: Re: [PATCH] fs: don't let getdents return bogus names
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru,
        Matt Turner <mattst88@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-alpha@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 9:57 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Jul 16, 2018 at 09:48:43PM +0200, Jann Horn wrote:
> > When you e.g. run `find` on a directory for which getdents returns
> > "filenames" that contain slashes, `find` passes those "filenames" back to
> > the kernel, which then interprets them as paths. That could conceivably
> > cause userspace to do something bad when accessing something like an
> > untrusted USB stick, but I'm not aware of any specific example.
> >
> > Instead of returning bogus filenames to userspace, return -EUCLEAN.
>
> Because there's such a lot of userland code that expect and handles that
> error value...

Empirically, for example, "find" seems to handle it (by printing an
error message to its caller).

> I'm not sure if this mitigation is actually better than "just return it
> as-is", TBH.

Turning it into something that behaves approximately like an I/O error
seems way better to me than letting userspace run around wildly and
potentially (depending on the filename and what userspace is trying to
do) mess with unrelated files belonging to entirely different mounts.
For accidental corruption, that's probably not an issue; but when
dealing with something like a malicious vfat filesystem on a USB
stick, I imagine it could be problematic.
