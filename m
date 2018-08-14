Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECCCC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89BD220B6F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uilOEDL2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89BD220B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732515AbeHNPdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:33:08 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35881 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732092AbeHNPdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:33:07 -0400
Received: by mail-qk0-f196.google.com with SMTP id x192-v6so13241384qkb.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 05:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2Ly3z6zYWRMnVJAMzbSgmGnV1h7BCRViWVJPf0raK5w=;
        b=uilOEDL2t/YC40xvCB/Ejor90BirvnkWW0fNJx8Ftfow5CEM+v5/XdAzmQXh+/ohZv
         C/i2fpv4zkvXkdi4UGNnI199UdLzpnCGxWgr6TskQvoxv6kiV33fjJwz1S+G0maeLLhd
         vf3Qpqvgo97cjZjkhgivTfmetksoB41C9olp4EpbfL25fFXAt50HvOTCrYRp0ez3/kSM
         QQFHN6Kl3uJUDOHIBmGl+GFH+pa4voPQ5p8hx107t0ZX8p5e4BvlW6fZctsgVHINyldP
         xAyUCZf8Zzd8iw/GlsGtpJd9ZfE/3rM1//qtwhFuPMDXY++D+3V2VLeE2qKAqFdU2TLp
         ocig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2Ly3z6zYWRMnVJAMzbSgmGnV1h7BCRViWVJPf0raK5w=;
        b=Sf2Uy2Z1FJx5UzXLwrd8HO6lqJCUaPkXHtySCi18Q35vXBgQzOjQIjVwk8bEYyhzmQ
         DcI/HHO0E8wncvB3R9w3LUUzpK7RzsUDoZjUANe7zenXdITJ8zfhmmQtDPAlHoG8Xwrq
         24m1zzlM5eZqQFQC6eVCbh3OdNvECEHt2RKnUVSVAHI1yMsJ1GWsCk7Zf4NlByjTrkTO
         UWzuhDkfTxUsqi6QTbHoNrtQQZGuGSBsPPP+XBb20HzySGumC5jngFhncXIgd0ajwvr4
         g8sGMKFyAUP+zkplgmldOWY99mSrCE2YDAV8jZBvqzMxexE6CcuMTG0eNF7U6x/KLyiI
         VNbg==
X-Gm-Message-State: AOUpUlHJYytrIFVoVbDah3JzZtZs7mudJsOV2mD+QRaJ9lahjEZprU5K
        62JnsHuHd8yMliNxIGr5gpwnWYNEXyyk8Ys+QekL5cIc
X-Google-Smtp-Source: AA+uWPwSJwsttYqfObJ2Wc0aUAIv8cHgWM2cHWRhkI530pdzJJ2hXIEZg1NTAoWkUS4c2KSUsSjopav+BuQY12fmFS4=
X-Received: by 2002:a37:2bc5:: with SMTP id r66-v6mr19623038qkr.3.1534250764836;
 Tue, 14 Aug 2018 05:46:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:9c4a:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 05:46:04
 -0700 (PDT)
In-Reply-To: <5B698106.5080806@intel.com>
References: <1532592471-21177-1-git-send-email-wei.w.wang@intel.com>
 <20180726093728.GA9069@yury-thinkpad> <5B599F5F.2070705@intel.com>
 <08410774-8b10-d620-064c-fdf4399d7336@rasmusvillemoes.dk> <5B69445D.1000107@intel.com>
 <CAHp75VeQaHGaRgN8o1t7bA2BTjshZqO1GUO+D9BBqp1cVVrV2A@mail.gmail.com> <5B698106.5080806@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Aug 2018 15:46:04 +0300
Message-ID: <CAHp75VegLeoKgSOEhny9fj0VHeJTRiA3DVanztuL5QOgWTZCpQ@mail.gmail.com>
Subject: Re: [PATCH] linux/bitmap.h: fix BITMAP_LAST_WORD_MASK
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, dgilbert@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 2:22 PM, Wei Wang <wei.w.wang@intel.com> wrote:
> On 08/07/2018 06:26 PM, Andy Shevchenko wrote:

> "there", I meant that user-space port, not in the kernel.
> e.g.
> Line 225 at https://github.com/qemu/qemu/blob/master/include/qemu/bitmap.h
> (there are a couple of other places)

So, means no problems in Linux kernel project.
Thus -> NAK.

>>> nbits=64, means all the 64 bits need to mask
>>>
>>> The two are different cases, I'm not sure why we let the macro to return
>>> the
>>> same value.
>>
>> The point is macro mustn't be called when nbits==0.

> Yes, I fully agree with that point, but it seems Rasmus NAK-ed that point.

No, we are talking about different things. Rasmus pretty much right
that the caller should have already known nbits and avoid calling this
macro if it's zero.

-- 
With Best Regards,
Andy Shevchenko
