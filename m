Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C04C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 02:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B0B82145D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 02:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6xiOw9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B0B82145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbeIYIjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 04:39:20 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:38744 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbeIYIjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 04:39:19 -0400
Received: by mail-it1-f195.google.com with SMTP id p129-v6so13300934ite.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 19:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dVmfr63hrnP4U38TbLg1c0GMQyb98je9tIJ7oyY1q+c=;
        b=M6xiOw9nv2H1sEPveZKoB6Qob7hjg/vLl7bE62qxvked+Jm0Nt6Xpl6ftjsmwsoQsa
         TxnjPkY5XrSoe5bYFcek+2Vu78xiUw4amETINDnHNCh4BAROAkAIhCmAziC1DXY20tps
         ULWf1AWAuidVM3H3MAkfSly+LMC6zxbMtPioAKVbu8qqEhWRCH/odQrY0xWg8SGMQqpx
         Pttp21R5Xi12Q5buNFEqFnVpulmwKPCgpdTStpL/eJZw49dRjxmh9SoTxUth5NN+8JAa
         npIuY9fUfWYbXYdWkNASS3Ir0mQpNFOyfmgU5elcKws96srVDsz3zCxJRHxk+TCPQ2XF
         l3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dVmfr63hrnP4U38TbLg1c0GMQyb98je9tIJ7oyY1q+c=;
        b=oRsziiUl57bdyL+NCyaV7dFG8nsS2r1uDY4kfCOMIvliHkI/QTXTjD8ma1MRWdc2M2
         XXh6eNYd41T6fFHkQLU/ye08jwd4REqQDJUwkRXAiIdEoRH2DNi32NH1pGBzlgCDPNqa
         5oLwi9PptCkQFM8QFtzT8JwXwymfzH7L4i1ybGMeQkb3QCFJ4lzEU9rOiGGVEf1p/bNs
         ZKH9sM2QMnntBQAZgFxCcA51znsXUWLCfajrN33Lt45VSk8faXdsUvbdLKOPrwbmtktc
         Xr83cy1p4KZNdCoRh3MBWnrsgM3Bf9cAkGEC+81MX+8L94IJSha6fyGHarcXHq+nFYra
         72Ww==
X-Gm-Message-State: ABuFfojIoR9ZE0TV5nflDYxzZP7hc/fYdqEnJWUYaPl6d3D933/EgPu8
        gxNNCRornB3LycKIvwtB2RR/JbRjIkKHr1zTVjU=
X-Google-Smtp-Source: ACcGV61sz7wbYZ75HAF6Jry/tPsvlQsGl7XtzT8+NVsyH9C5lpLoJTG/ko0JH/aiKdEXP3kJ/1GQSUn4jBOIGwRHwwI=
X-Received: by 2002:a24:ee0c:: with SMTP id b12-v6mr1016681iti.33.1537842844025;
 Mon, 24 Sep 2018 19:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1537260207.git.zongbox@gmail.com> <40c77db9ee2d23479ff90f2658539d29d7a30896.1537260207.git.zongbox@gmail.com>
 <20180921065806.GA8401@infradead.org>
In-Reply-To: <20180921065806.GA8401@infradead.org>
From:   Zong Li <zongbox@gmail.com>
Date:   Tue, 25 Sep 2018 10:33:52 +0800
Message-ID: <CA+ZOyaj2Ed3GCK0icaRNcttM7set=V1ffravCZefwmykD8=eMg@mail.gmail.com>
Subject: Re: [PATCH 1/5] RISC-V: Build tishift only on 64-bit
To:     hch@infradead.org
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        Vincent Chen <vincentc@andestech.com>,
        Zong Li <zong@andestech.com>, linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> =E6=96=BC 2018=E5=B9=B49=E6=9C=8821=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=882:58=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Tue, Sep 18, 2018 at 05:19:13PM +0800, Zong Li wrote:
> > Only RV64 supports 128 integer size.
> >
> > Signed-off-by: Zong Li <zong@andestech.com>
>
> This looks fine.  Just curious, what do we even need 128-bit integers
> for on riscv64?  Did you see any issues if you drop it entirely?

You can refer to this issue, but I didn't try it.
https://github.com/riscv/riscv-linux/issues/136
