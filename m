Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E3F16256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA2120857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3pt5Ca2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA2120857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732080AbeG3Tb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:31:28 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35779 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731958AbeG3Tb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:31:27 -0400
Received: by mail-pl0-f68.google.com with SMTP id w3-v6so5890206plq.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 10:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b7d67Tes5ANTchJAKNecVThmz21zo9dp8quKByoKjpk=;
        b=i3pt5Ca2jTh6wPdKnGNBRX+H1G+ZsYRhoDGCQowT2cH1h4CqunKwm+m8HgfHe+H+ww
         JuXKIcgz5uwCFVCCBN0I3k1K9x8xVxNK0DwhCPOcwVlqycZZ25i41il+706HYegjJ5Y2
         jEJNCYUGwS+xeqbmgo4FsEt2x5IEUWz7k3WygG/8p2zQLToFrKnUzd90DiGZ1uph5jvZ
         GPaNrD5zfBEBGcmiykjQwx+HPhTE5lOZR5PveaKp8kksjaqWqFjSsPqoG2kWnlKZCZRW
         uSExOdrbM4J5thC5SXaB8KbjBXts8Wgo2b7Yoknv5GJK2a8cNMiM7dTD/aSJacUEIxbn
         ZEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b7d67Tes5ANTchJAKNecVThmz21zo9dp8quKByoKjpk=;
        b=TPLMSEQDTDRQVuEsGgx6xZbOtJP2aXCwkMAuzYmAfGk4kAIFPtp0x0LEjgA4Ne9x9m
         Ig2vdM6YxuN2MALbegFSva7DPiewxphbsFhoYEyoW4zl6T7WFU57OSg3K6fQ+2egIdYc
         QPiR4LVCzVgo2iQ0lCbUFCO1P4DadwpbdhS72F3yqRs/Esq2rffSTSPWLgWsp7BafGLN
         QjvGfblOAOb9EHxPLf0WvIHA6RdigRpnx/+0RKw2ozFDpn/vWJFyzaxKrKJyHCF2KkBW
         stottQ8UMD5SEOU68s5SbCrSh1fhWbMyy0iPOZoOFmUp7OjSD3TrTyQMn301PiyZsM9w
         FsHw==
X-Gm-Message-State: AOUpUlEQC9KUr1AkNdzGOr3aLlaas13mKKj24WDGdJ76xHBENm0WW9HP
        7Vjt/YeVMc5c1ozPKhKP+6uxMAG+/DsEy/XqBrU=
X-Google-Smtp-Source: AAOMgpdBNQynYAcZJbWX3M/aGohp7b5zdNfMsPogYDNaWgivwDajIZmCCJztSFhBvUzm0D/XOj1VZ2zPPCrADl1Ef1U=
X-Received: by 2002:a17:902:1001:: with SMTP id b1-v6mr9012514pla.155.1532973320733;
 Mon, 30 Jul 2018 10:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180728002409.5781-1-xiyou.wangcong@gmail.com> <ef0e1185-51d6-0707-cda4-6f2ea987b651@linux.alibaba.com>
In-Reply-To: <ef0e1185-51d6-0707-cda4-6f2ea987b651@linux.alibaba.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Mon, 30 Jul 2018 10:55:09 -0700
Message-ID: <CAM_iQpVeK2VQDuahreZC2-L4eEzx0WtD8Bz=oHH68VSAiMqLGQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: sync expires_seq in distribute_cfs_runtime()
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ben Segall <bsegall@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 29, 2018 at 10:29 PM Xunlei Pang <xlpang@linux.alibaba.com> wrote:
>
> Hi Cong,
>
> On 7/28/18 8:24 AM, Cong Wang wrote:
> > Each time we sync cfs_rq->runtime_expires with cfs_b->runtime_expires,
> > we should sync its ->expires_seq too. However it is missing
> > for distribute_cfs_runtime(), especially the slack timer call path.
>
> I don't think it's a problem, as expires_seq will get synced in
> assign_cfs_rq_runtime().

Sure, but there is a small window during which they are not synced.
Why do you want to wait until the next assign_cfs_rq_runtime() when
you already know runtime_expires is synced?

Also, expire_cfs_rq_runtime() is called before assign_cfs_rq_runtime()
inside __account_cfs_rq_runtime(), which means the check of
cfs_rq->expires_seq is not accurate for unthrottling case if the clock
drift happens soon enough?
