Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD30C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 03:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E902082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 03:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZ+A4Cmo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E902082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbeJCKNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 06:13:23 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55201 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeJCKNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 06:13:23 -0400
Received: by mail-it1-f194.google.com with SMTP id l191-v6so6486203ita.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 20:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uQao3xGFEFn8Y07K52ssW3bIqYUjRZ72xPIgvT77Ym4=;
        b=GZ+A4CmoXyGrbbVW3uT0V+18mzHQHBQzDHvK19anHICNRGZ4k8fx1247KVm3oXUqvk
         hfxD2U7j4YCRZYF+KONDkPtuU0VDLXZjkjFOdkVj2Ui9CAD71cLd7+52NB+TKIhy+rRO
         ITh5H5IUV1E0f67o/pxErBPB0qdv/kD8ZCpiLWWD7Vs7SRZ/gdYLR3K3W9m5xYYbFHUm
         XxvigGqkNb+Ip3yTCZ2uAhndIYTLubgVm18VoO57ayUwlRrinZ8GoR/MxoxZBZ5EV/6Y
         UNuHdkGoSKpL4gW9EusNYYJWyDytSCcyaZA2pEibTMKhlDzqvrrg9zY8AYmz3zXm+c6j
         /o9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uQao3xGFEFn8Y07K52ssW3bIqYUjRZ72xPIgvT77Ym4=;
        b=AfX6bKpvd6UILOiHirAcuGDMZMnxKybsZ48B1pAb7Y+JJjbJl/x/5QuHoA52A1odi5
         fsaTZGDLC8coE2rJgDsS9rkPb7lDRcRFBSORglYM8IIWl0t35r2HbO/I0oCQ8KxjnyPI
         vtLrnICnMis7Z7Wz2zt18wT7seC73w9L6qbtj30XfBS3xhmlkXqxjhs/zvbbM2FcVaU9
         U6vcpVlObgUtnvRdTu3qvyJ31NwV64MWl/r4EgIr9rv0TVGib/wx2yu+9NH9/ytKB1fY
         73gzBDt0C3B47y7+vakBbT6mE8BnrA2MYq47MpHLjfeFkX2BN6fgWe4xRfoSNfP7huI+
         yHdg==
X-Gm-Message-State: ABuFfoi6NM3ICEhUCfp3ulRBBo5ykTk6psHiF+96FRLAMxXJyjaiUIDV
        4uBKJqljRRLfAfsbXeeUAkORWlXoLixg0G5ngEo=
X-Google-Smtp-Source: ACcGV60UH3Tc3qrk2vBvlkhP7HdVxRn3MMNJthy9WqLiWK3RZJHb32Z9GWd1mHq/f4badBV1GUohh9Rk/JPMGefJQhA=
X-Received: by 2002:a24:ee0c:: with SMTP id b12-v6mr3984139iti.33.1538537213819;
 Tue, 02 Oct 2018 20:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1538470103.git.zongbox@gmail.com> <54849b9d9a709525640011814872155eafa7a9d7.1538470103.git.zongbox@gmail.com>
 <20181002145116.GE3889@infradead.org>
In-Reply-To: <20181002145116.GE3889@infradead.org>
From:   Zong Li <zongbox@gmail.com>
Date:   Wed, 3 Oct 2018 11:26:43 +0800
Message-ID: <CA+ZOyahwAA3v+9XeJ4eLkhiNgDacHtLHfrqG3ifhdV-shwnAaA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] RISC-V: Avoid corrupting the upper 32-bit of
 phys_addr_t in ioremap
To:     hch@infradead.org
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        Zong Li <zong@andestech.com>, linux-riscv@lists.infradead.org,
        Vincent Chen <vincentc@andestech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> =E6=96=BC 2018=E5=B9=B410=E6=9C=882=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8810:51=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On Tue, Oct 02, 2018 at 04:52:31PM +0800, Zong Li wrote:
> > From: Vincent Chen <vincentc@andestech.com>
> >
> > For 32bit, the upper 32-bit of phys_addr_t will be flushed to zero
> > after AND with PAGE_MASK because the data type of PAGE_MASK is
> > unsigned long. To fix this problem, the page alignment is done by
> > subtracting the page offset instead of AND with PAGE_MASK.
> >
> > Signed-off-by: Vincent Chen <vincentc@andestech.com>
>
> Looks good,
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> (and I'm pretty sure I reviewed this before..)

Hi Christoph,

Very sorry about that. I didn't notice I lose these review tags. Could
you please help to review again in version 4 patches? Thank you.

Regards,
Zong
