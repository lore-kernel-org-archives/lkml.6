Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B60EC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 02:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D082620666
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 02:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MR68mwh0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D082620666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbeIZIuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 04:50:51 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38513 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbeIZIuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 04:50:51 -0400
Received: by mail-it1-f196.google.com with SMTP id p129-v6so916985ite.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 19:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0fVr6k+0xT4506/HxcrTRvbN4wTmpwhjTq9OkiCSL1A=;
        b=MR68mwh0YUZFkxd8gEPCYFydwQ84b4XObKx95PYrGuG9DQcuBZCGpOmCCig4cvJNls
         0v6J6+ZKMIxDCk0GT859wupnjz/pEaoe5IGBYpwP7+I7l42cQK2cznPNN1tploLku0WY
         ZQ199kp0OATM7sTB9FYxyY+twF2Yet/6g80DyvEIkb3hlPydasnm/EsmfhJhf9lt77KY
         CvT0LhCqXcNDsArsMlOiHMcdFOY/XeS9gKgfRhqSMjbNPKS7X2so+v9NpQhT48OoY1mD
         tkDEuquKMGOOI3dectgJqYMd6vuupqj6jDWuu1900M6273aV/NV6V0TsAIRUkFG54Yjr
         4DbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0fVr6k+0xT4506/HxcrTRvbN4wTmpwhjTq9OkiCSL1A=;
        b=s3bXRdx+xBAJX41wT9lBrAgb1yFVNjvzq/3WYqy1OvA+YkRETAcTKBtmBx8v6pcrEy
         Ub8ujwnmPmXNgRgb9LOq2UypC6lf+nLB7UtKftebZv4t3oiefTOvNRVumEyKFqjpr9ox
         GSHeDqGBahqVQsnbaPSQhQ+Pi3VdVUrPuU+3aC5o3TFiYsLnpb2AFp+fG2NVosLKBpoB
         Kj1fKMho5XmQeQA2QPLhHn1SxubuiD26M/dbkPMTcSHs6zktU7mDu44uFSRm0n0hh/50
         kVTvbAIOeF0CVreLXsO8ttj15kfKBNg0xKv0WJLnZ0EUm0ULimiyJpK3HO8Kv041pkCP
         B9tg==
X-Gm-Message-State: ABuFfoiDysD4HWZlPupTlWFaHr/MnZXFUHb8DSBNiP6Vej2piOdEkR9M
        UdhTCkvV4gpp48jvGyPwRHAOPP1+PxVPQZQYm3Q=
X-Google-Smtp-Source: ACcGV63RlvSg9tuAOK6103JJ2h8Ii1hvG+YsRQj/Kzwz/lyCm4v5ZJO7uwgoqCgaULwDYCMVbQqneWo+Az0FOj6Z0xc=
X-Received: by 2002:a24:5214:: with SMTP id d20-v6mr1193105itb.24.1537929614143;
 Tue, 25 Sep 2018 19:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1537260207.git.zongbox@gmail.com> <2ccc6c0758624dbb22f6fe451a3e476a000108ef.1537260207.git.zongbox@gmail.com>
 <20180921070006.GC8401@infradead.org> <CA+ZOyaiJv-NZWk3ec_3zhRTSn7G-NGgyaiPTXOmuWfTWD7KSJw@mail.gmail.com>
 <20180925152508.GA24002@infradead.org>
In-Reply-To: <20180925152508.GA24002@infradead.org>
From:   Zong Li <zongbox@gmail.com>
Date:   Wed, 26 Sep 2018 10:40:02 +0800
Message-ID: <CA+ZOyaiB+eEWUr7J1s4PRB5tYcKQfbTp--hnL7S6H3BtUraizw@mail.gmail.com>
Subject: Re: [PATCH 3/5] lib: Add umoddi3 and udivmoddi4 of GCC library routines
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

Christoph Hellwig <hch@infradead.org> =E6=96=BC 2018=E5=B9=B49=E6=9C=8825=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8811:25=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On Tue, Sep 25, 2018 at 10:19:55AM +0800, Zong Li wrote:
> > The RV32 need the umoddi3 to do modulo when the operands are long long
> > type, like other libraries implementation such as ucmpdi2, lshrdi3 and
> > so on. I encounter the undefined reference 'umoddi3' when I use the in
> > house dma driver, although it is in house driver, but I think that
> > umoddi3 is a common function for RV32. The udivmoddi4 and umoddi3 are
> > copies from libgcc in gcc. There are other functions use the
> > udivmoddi4 in libgcc, so I separate the umoddi3 and udivmoddi4 for
> > flexible extension in the future.
>
> I don't think libgcc is GPLv2 licensed, is it?  Also please retain
> the copyright notices from libgcc.

I will give next version patch. Thanks.
