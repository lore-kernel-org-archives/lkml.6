Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F71C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 23:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CB0206C2
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 23:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="WdTdzif/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731162AbeLPX0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 18:26:13 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:55513 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731012AbeLPX0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 18:26:13 -0500
Received: by mail-it1-f193.google.com with SMTP id o19so16395611itg.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 15:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EavIckkG0CsdZ2qkKlOGygOr08ukf3mcJXqDqLICEd4=;
        b=WdTdzif/YexPRKiaKDnPlS4T4i3EluuXHZFPCe2j9u1tQkqdu10uiA6jPMZX/hGMfP
         MfW9zQvRVOcMGFPZoD5WVInFOdO7swQJz1wy/zc99saqDe6I61PrvywZKsTpsXMwCz+w
         q5NXv5sLljdfMG01bo8NL6MpKnAVSMNtSGM9DZ7l1B2R+cfjS/AEtugL6poytNS2lf44
         drMTK/sYpXyE3emmuUPDwujX4698sVGzGFp96/as/HPdvqpeXirTUk8CS5V6r7mZbPQS
         74eap8VfuRcwZYTrsevzGAV9e00ZQaYAS+8gEQ6mqhsEWlZV75zkj8Kw/5lDU5SELs4Z
         cVvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EavIckkG0CsdZ2qkKlOGygOr08ukf3mcJXqDqLICEd4=;
        b=NTDq2+3owZ4HLFJgLUkEbSkmfr8wTAFQEA28F3REJofTfxAYU7CxFcyobMz+NO7x//
         N0hXnkEb5D/W/Uf/R9/LPKpW5vYsFx1xSRKmkOgCpgmwCscCdFVKmGOsV2EWRcr/BMXu
         64Vho+PH/Cd+WTCAbK53m8k/hu4wMlf+NM4N4OjZNq6YYqHPBysid+WuPNVF5hs1aKKl
         9UY2Me++a6xtaiBRaqMfQ7ayiLTkKGBj6tpFU3hhgdNwh/NqI8yTwa8bTcsc3WqNd23w
         l8sOF5Up+3o+TLuwOcJ4/XiMXlDNuRa0HYnPlDZjHMpHLja3ejcsk/edUQ3j4djbyBh0
         P+ZA==
X-Gm-Message-State: AA+aEWZ+ufos0eE/BRhOW0+yP29pkc2bDSxkrIBHdtu14fI9v5CAlqN6
        ScoFPG3vwjb1DuKcVTEfi3DxRryFwZp1ApGa3axSwQ==
X-Google-Smtp-Source: AFSGD/UuyntCCCLhhZ0Q/o4kOf6pEK5gGUo1uRrUP70J/W2Wn/ox2CFs9pr2l63fPZHAJhPVGHt0V9k0XeKM1+y4OuQ=
X-Received: by 2002:a02:5ec9:: with SMTP id h192mr10118712jab.112.1545002772089;
 Sun, 16 Dec 2018 15:26:12 -0800 (PST)
MIME-Version: 1.0
References: <1544533009-12425-1-git-send-email-mw@semihalf.com> <20181216.124120.731491122771817496.davem@davemloft.net>
In-Reply-To: <20181216.124120.731491122771817496.davem@davemloft.net>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Mon, 17 Dec 2018 00:25:58 +0100
Message-ID: <CAPv3WKfz4AkODzJ+gsV=u6ve5YnZEdUhZF5+VmFPQa4mp9okUw@mail.gmail.com>
Subject: Re: [PATCH net] net: mvneta: fix operation for 64K PAGE_SIZE
To:     David Miller <davem@davemloft.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        netdev <netdev@vger.kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Stefan Chulski <stefanc@marvell.com>, nadavh@marvell.com,
        Grzegorz Jaszczyk <jaz@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

niedz., 16 gru 2018 o 21:41 David Miller <davem@davemloft.net> napisa=C5=82=
(a):
>
> From: Marcin Wojtas <mw@semihalf.com>
> Date: Tue, 11 Dec 2018 13:56:49 +0100
>
> > Recent changes in the mvneta driver reworked allocation
> > and handling of the ingress buffers to use entire pages.
> > Apart from that in SW BM scenario the HW must be informed
> > via PRXDQS about the biggest possible incoming buffer
> > that can be propagated by RX descriptors.
> >
> > The BufferSize field was filled according to the MTU-dependent
> > pkt_size value. Later change to PAGE_SIZE broke RX operation
> > when usin 64K pages, as the field is simply too small.
> >
> > This patch conditionally limits the value passed to the BufferSize
> > of the PRXDQS register, depending on the PAGE_SIZE used.
> > On the occasion remove now unused frag_size field of the mvneta_port
> > structure.
> >
> > Fixes: 562e2f467e71 ("net: mvneta: Improve the buffer allocation method=
 for SWBM")
> > Signed-off-by: Marcin Wojtas <mw@semihalf.com>
>
> The discussion died on this, but the bug should be fixed.
>
> So in the short term I am applying this and queueing it up for v4.19
> -stable.
>
> Thanks.

Thanks. Indeed, the patch is valid as a fix for current version of SW
BM. However, because this concept is broken, I will rework it and
submit patch/patches some time early 2019.

Best regards,
Marcin
