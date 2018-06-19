Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA45C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86282075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="p7xRANft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D86282075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937875AbeFSPSw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:18:52 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:44111 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937547AbeFSPSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:18:51 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 4a2b1dae
        for <linux-kernel@vger.kernel.org>;
        Tue, 19 Jun 2018 15:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=5APhmAkGtfDau38ojwhDyNxyy7s=; b=p7xRAN
        ftb7tmQO91Ujmy9IAmfsW1OAH7R4HdIqrb+HW4dfzi1Qayd82yW+85TIAiioNNQK
        lF0lRlwVvJX4wY9T51zP3io3ANQ9HkWBh6hVnDlg89OYVAv1RDjszLRnbZBTZ6Vx
        3eEzbrbGziI4u8ErIhIDvNlrH4rmdL8FVBnk6oMpq4wNR5L015SRrz7MgoOj2tx3
        ATNmZMQTkbI1kEzB9f+tDOxiojyCxgiiU7olsUusW5KKOw5OwUV6UrJyWGrBiYMk
        KL2Ac2Cle0X3Gl4p6LzhqJbCPklScMGpdBC2ZDOmMiGTYYs1LoXrMTCXRqRun0aF
        Ovy47Dqtk/PYFwjw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 04c37c80 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 19 Jun 2018 15:12:56 +0000 (UTC)
Received: by mail-ot0-f175.google.com with SMTP id r18-v6so96942otk.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 08:18:49 -0700 (PDT)
X-Gm-Message-State: APt69E14r4B7kR9cGqMfFA5dY2YJRtnF/9JABpDwOiIWpVFAbM1cQmRF
        rkZTD5siaIKdSR2RF6a44gM3FUp+nONlSBdqim0=
X-Google-Smtp-Source: ADUXVKIL3wENGJmnCH7cbw0NM5ozKtRaPyD01ehaMghOQKob6aegx7OVIVUCt1CMKRv8lDVniliplf+arUx6ar9LKiA=
X-Received: by 2002:a9d:542e:: with SMTP id j46-v6mr11917168oth.41.1529421528130;
 Tue, 19 Jun 2018 08:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9rtoPwxUSnktxzKso14iuVCWT7BE_-_8PAC=pGw1iJnQg@mail.gmail.com>
 <CALvZod6Dxx79ztxzHsDVe6pj7Fa7ydJAjMf_EHV9H15+AsVwdA@mail.gmail.com>
 <CAHmME9qvRDQOJYdSPaAf-hg5raacu4TBgStLy7NzFL+j+dXheQ@mail.gmail.com>
 <CACT4Y+YLySJMfG4kCJ2FiPpPtN6sgU6k2FoZUYMFrJGLj+vDjw@mail.gmail.com>
 <CAHmME9oeoSbRZyf6qJTg+q-zZanYGu4q=YOZNqCCbRAFu15R9w@mail.gmail.com> <CALvZod7MfTTwbfG3zC1kGrZB1Cf0UAnbvdbqhC5Dm=uy6=DtOg@mail.gmail.com>
In-Reply-To: <CALvZod7MfTTwbfG3zC1kGrZB1Cf0UAnbvdbqhC5Dm=uy6=DtOg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 19 Jun 2018 17:18:36 +0200
X-Gmail-Original-Message-ID: <CAHmME9q7aKGNiYauCjyy6Fu+bryPphEoLEMbAObTJgTrTfS2uw@mail.gmail.com>
Message-ID: <CAHmME9q7aKGNiYauCjyy6Fu+bryPphEoLEMbAObTJgTrTfS2uw@mail.gmail.com>
Subject: Re: Possible regression in "slab, slub: skip unnecessary kasan_cache_shutdown()"
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>, aryabinin@virtuozzo.com,
        Alexander Potapenko <glider@google.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 5:08 PM Shakeel Butt <shakeelb@google.com> wrote:
> > > Are you using SLAB or SLUB? We stress kernel pretty heavily, but with
> > > SLAB, and I suspect Shakeel may also be using SLAB. So if you are
> > > using SLUB, there is significant chance that it's a bug in the SLUB
> > > part of the change.
> >
> > Nice intuition; I am indeed using SLUB rather than SLAB...
> >
>
> Can you try once with SLAB? Just to make sure that it is SLUB specific.

Sorry, I meant to mention that earlier. I tried with SLAB; the crash
does not occur. This appears to be SLUB-specific.
