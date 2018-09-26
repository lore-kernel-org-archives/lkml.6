Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231F0C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 04:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1692086E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 04:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="ANuk40/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF1692086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbeIZK1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 06:27:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41096 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbeIZK1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 06:27:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id j15-v6so21343346wrt.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 21:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oqLycqIGwEmchXvmKuBrd2D6JWsajBs4luqysWC9dxI=;
        b=ANuk40/oKxvEFqgGRefMDb0IClRhoVovhDoQweCJAthTo00OJIrRTJLThwNymQxAcM
         KUYx99f4NP0dMAK7aeDxOKk9B7cOHdR9obi7i8+tgqdZSNHSp1Y5zMBbLi/eIOaoTtGt
         HwI25Ypzurd03kQPB/4mVPY+01170tjsxcDh2lAMjclskYvpIdGAgucXfLxRQItNqy9C
         e+6rQId4qKb3jz1W1h2s2HIu3bcPzYT3YnyAHC91LS2yRcmFSeE+B8rXSq1D1kFkcC5U
         ybP4DVJZyi2KE28wkj75RmFuGJWEFy1dda7aBfLD9bzrGWrBIJivbucmbpSNVHiNufWO
         VKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oqLycqIGwEmchXvmKuBrd2D6JWsajBs4luqysWC9dxI=;
        b=tCWpk3yi9RKwFKc4T1sxoQnWPN/Cq6BF23OMAf8FC3mE3/a/lzluiiDqp2J+BKbhLr
         UCA61TbDLcSJZb01A2kyO0B+tvclrHwqlGlMYjba53rvwnFL420En9IfTCN7L3THJ4ju
         stIdGqiaDKwEET+qE/WMG3Z5vKcDi3m0si4IiYGsZeYvySU/Psy2u+l5XfnyI9Zzc47D
         YxzR9e8zMB4mlnL5SCOHPNKjGdG+gTAepQEuFNYxnB62j1i07IVvQk8Q3cp1vXHtC59v
         8Zq2Emrp5t1fwOtx+1klUVyURMR4q/tQ+uuJPTwDX1iICXgCcrMvOV1qwjaG//+vOnZJ
         kXTQ==
X-Gm-Message-State: ABuFfohdXahtOIo3QBmQHUHLzhpv3R8XmHZ96UBZhcjt9Ehi0wpEC8lY
        J9mqkb933YkZ3i9HA4Z4P5hcAA8WSOK46NjN2h9pSA==
X-Google-Smtp-Source: ACcGV61dMhx+9b1lIz+H5naFgRKnn0NiTqf2K9XnM6FHCfZd+W7Gr8srBA1uIdOALXgPhB0BqEPIhD2RB5Wff1w4734=
X-Received: by 2002:adf:c554:: with SMTP id s20-v6mr3138812wrf.46.1537935411755;
 Tue, 25 Sep 2018 21:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180923133737.22693-1-anup@brainfault.org> <a7c64e1a-405e-6a2c-cb42-211c4f89367d@wdc.com>
In-Reply-To: <a7c64e1a-405e-6a2c-cb42-211c4f89367d@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 26 Sep 2018 09:46:40 +0530
Message-ID: <CAAhSdy2ZOXk3fDt8W_G1=h_OrifFsXP3XwZ2xnXwt9ztzW4GEg@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: Show CPU ID and Hart ID separately in /proc/cpuinfo
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 11:29 PM Atish Patra <atish.patra@wdc.com> wrote:
>
> On 9/23/18 6:37 AM, Anup Patel wrote:
> > Currently, /proc/cpuinfo show logical CPU ID as Hart ID which
> > is in-correct. This patch shows CPU ID and Hart ID separately
> > in /proc/cpuinfo using cpuid_to_hardid_map().
> >
> I noticed it should be cpuid_to_hartid_map instead of
> cpuid_to_hardid_map. It was a typo in my smp cleanup patch series.
> Sorry for the inconvenience here.

Thanks for pointing.

>
> I can include this patch in into my series fixing the typo if you want.

Yes, please.

You can also include "RISC-V: Show IPI stats" patch in your series.
This patch was reviewed by Christoph.

Thanks,
Anup
