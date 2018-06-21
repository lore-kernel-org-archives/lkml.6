Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE74C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD6620846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JYRbYaa1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD6620846
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933195AbeFUMva (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:51:30 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:46812 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932858AbeFUMv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:51:28 -0400
Received: by mail-ot0-f193.google.com with SMTP id v24-v6so3397824otk.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 05:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X+GPHMAnpM/xgWRIhEXLrvOaD2W+kdG11ZYMntJQvLI=;
        b=JYRbYaa1ZiwaSOYCm5rA5twDoYNckHJhaLRXMx20ZCeu4+C0DbH57f6D+MsfRNa2XV
         IjgJp6EVyQAKi/1gcAfJF5oiOuWA3X8QC+S3caIHYKR/IPhtwHGYqeC3AEX3DEtKWNxp
         NYmRP8ijhoBqU3TLyIutJ+mvQwEkSM5CkIdHo+G3pHis1Lz18tKU+F5mNZsVivFQ0zOh
         CblvzT86mXk8U0VLiO7/EP99k070m+B5X4dcVYAWKKqH3goDJOkhMrH5H5m9u4LDNw7T
         BHv+vYIHClCSSCIPuT2J1G/wYy2c4BDjFM+o0c/WObjONZTjfM3SBtGF8SokWorviOk0
         J6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X+GPHMAnpM/xgWRIhEXLrvOaD2W+kdG11ZYMntJQvLI=;
        b=B0lf+InrLMTFZwbu1SNazykzzA9lBy+UMjMw4DCmf0Az3UMxAmak4ezLbZHER/Cw/T
         VwIqHUs1RJXB98Dw4DOFqh2PR3gpRZWr7WHBe6mDTJB7qDgEUwrEhB1SI40Wf4a3coUG
         hoBoD7cfAGRae7DGX9dTdxzdbznmbAEw7JYB9cRwwFo0/OtU7fgZmpaoCK2ZecBRGj+/
         wPIhP7Y4F0Enfnpsf2DhfFZTtOnGf71qlvUSXZdTkQ/iAk3n+Uhl2nNwsEZ7oCGZHctn
         gfli71azKGMsJ0tLjaqTMFSKwNQi80Sn7sfzffgc5RWUjdfAE+76Lq5bMUw6soIUTV/L
         JG8A==
X-Gm-Message-State: APt69E1iUFlPz+AbUg2eZcxCthkNfkBb3RyC39LoqEdGh334Zuwu1Txz
        cmIKUqtDFZdFuz8D1NN3kfcIVr8+EWsHLDtmR4/vCA==
X-Google-Smtp-Source: ADUXVKIi8b0J+AoIZlE5TE7ptlwQTEQjTI/TR6D2YYYbPLzmI2WmlaV3UznAbBT4Ye9DU6lXOnXHqxdBiTe0/73M+QU=
X-Received: by 2002:a9d:59c8:: with SMTP id u8-v6mr16203133otg.216.1529585487860;
 Thu, 21 Jun 2018 05:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180615152335.208202-1-jannh@google.com> <20180615164009.GD30522@ZenIV.linux.org.uk>
 <90063ef3-68fa-e983-9b47-838e6076b0f4@interlog.com> <813e817b-bb2f-4a47-6225-9e39f19be278@kernel.dk>
 <20180621123431.GA558@infradead.org>
In-Reply-To: <20180621123431.GA558@infradead.org>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 21 Jun 2018 14:51:16 +0200
Message-ID: <CAG48ez3BWeZkW5XG814K4o7p0KWXVm9Gpzh2rTthNei=4fhH-A@mail.gmail.com>
Subject: Re: [PATCH] sg, bsg: mitigate read/write abuse, block uaccess in release
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, dgilbert@interlog.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        fujita.tomonori@lab.ntt.co.jp, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 2:34 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Jun 18, 2018 at 09:37:01AM -0600, Jens Axboe wrote:
> > It was born with that mode, but I don't think anyone ever really used it.
> > So it might feasible to simply yank it. That said, just doing a prune
> > mode at ->release() time doesn't seem like such a hard task.
>
> Let's try to kill it.  It is a significant amount of code, which does
> fishy things and is probably entirely unused:
>
> ---
> From baec733be1b400d73d0fa2bfc07684598c4172e7 Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Thu, 21 Jun 2018 14:31:32 +0200
> Subject: bsg: remove read/write support
>
> The code poses a security risk due to user memory access in ->release
> and had an API that can't be used reliably.  As far as we know it was
> never used for real, but if that turns out wrong we'll have to revert
> this commit and come up with a band aid.

FWIW, I just had a look through Debian's codesearch (which AFAIK scans
through the source code of all software that Debian packages) for uses
of struct sg_io_v4: https://codesearch.debian.net/search?q=sg_io_v4

Hits that seem to be using read() or write() with struct sg_io_v4 on
bsg devices:

In the package https://packages.debian.org/stretch/tgt:
  https://sources.debian.org/src/tgt/1:1.0.73-1/usr/bs_sg.c/?hl=131#L131
  https://sources.debian.org/src/tgt/1:1.0.73-1/usr/bs_sg.c/?hl=236#L236
In the package https://packages.debian.org/stretch/sg3-utils:
  https://sources.debian.org/src/sg3-utils/1.42-2/examples/bsg_queue_tst.c/?hl=60#L60
