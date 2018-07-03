Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABBFC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96ED24967
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLsHnZLI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D96ED24967
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934468AbeGCS7m (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 14:59:42 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:45162 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752019AbeGCS7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 14:59:41 -0400
Received: by mail-io0-f196.google.com with SMTP id l25-v6so2670983ioh.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 11:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FOMTFUsZrH2mCjaerXXEqNwHzQvnWrlONhodbvYzud0=;
        b=ZLsHnZLInMLKvdgun1IL8L6zjpRjWfdr3Qo/nnJzjMWb+5qto49/hGjlh1ZcuFoIwO
         Tg/8pBjpBaz4CoSLKfHrF62wrVdXAhJzPKnxv/mXCzQ4kPX4BorlsBnm1LgN26p2a4BW
         c+uj6hbgn++5JU9MzAhPF3NvthX0f5jW9EVfEEXysd4AOxl97SW07XTXxZ03gIZmIqnA
         Cuf8M/8wfaudWD/FRhSNP0UeJT2ZD3w90XorIDNBmzoJgS7lnIJLbiA1RCS7oStIKh2e
         ovFM2Ti7/Vyw7hpKY4UKQKelXGuB63T5Zb/xdC5LMAL/kS65DavKi5V52wBfK0rsoGtN
         pa2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FOMTFUsZrH2mCjaerXXEqNwHzQvnWrlONhodbvYzud0=;
        b=oJcOqZEUX1WoNIBAIylftCvPz5POJeXz5k+lsKfBqc+vpF3FP7HxZ7kR7tdlnESKGw
         j/pTSN1+AYnqjlBzFdHlv/ufxD8i0L1TIMBY4HoifEqqaLEZSvadZiU80ZGRirWIda4j
         b0FWFSKT4ZeOiGomRm6UnxgRHyZ42vGJRSdn/lTS/6Jco+CZmz2K5rIsVMGny1hwJ9wE
         2dq/GUKoXWbx9vGEju5O1OqvlDxmPBXfrSCpK1ihldvYcYVJakFxN/D4xxCMRc6PgslW
         Rr/OIt6Ri4hl7mCAxJvVs7wjas7n4DVa0/O/eOLmLtP3L+4orHs2Jpudv34J0fOmOSCU
         iSrg==
X-Gm-Message-State: APt69E0saYFFvtxd6cxIWPPTOpDj2MSWxrpAi+dktNlcR+3kJCNuurHd
        hQ74DEJim7zGIKL1FW3X9q7j50pg2mEDvYCgcQw=
X-Google-Smtp-Source: AAOMgpdCQcS/owtt7OgdsF48bhYhmcYBuYkuyL+wt7DkWzypiTCrz2A8fRod9A2+8QCVeu1QAWgr/Q7KtKVEx5c7GZw=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr27061053iov.203.1530644380714;
 Tue, 03 Jul 2018 11:59:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:bc4a:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 11:59:20 -0700 (PDT)
In-Reply-To: <20180621180823.805-1-dima@arista.com>
References: <20180621180823.805-1-dima@arista.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Date:   Tue, 3 Jul 2018 19:59:20 +0100
Message-ID: <CAJwJo6Z8jGFdb0ZEUNFt+T7HiLvS69w6_QC9qVs9TqiJ7+sjTw@mail.gmail.com>
Subject: Re: [RFC 0/3] iommu/iova: Unsafe locking in find_iova()
To:     Dmitry Safonov <dima@arista.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Any opinion on that?
It looks to remove a source of possible issues and
has a nice diffstat.

2018-06-21 19:08 GMT+01:00 Dmitry Safonov <dima@arista.com>:
> find_iova() looks to be using a bad locking practice: it locks the
> returned iova only for the search time.
> And looking in code, the element can be removed from the tree and freed
> under rbtree lock. That happens during memory hot-unplug and cleanup on
> module removal.
> Here I cleanup users of the function and delete it.
>
> Dmitry Safonov (3):
>   iommu/iova: Find and split iova under rbtree's lock
>   iommu/iova: Make free_iova() atomic
>   iommu/iova: Remove find_iova()
>
>  drivers/iommu/intel-iommu.c | 14 +++----------
>  drivers/iommu/iova.c        | 48 +++++++++++++++++----------------------------
>  include/linux/iova.h        | 17 ++++------------
>  3 files changed, 25 insertions(+), 54 deletions(-)
>

Thanks,
             Dmitry
