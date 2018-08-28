Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A6AC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAAE720893
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKwdtc8i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAAE720893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbeH1M1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:27:14 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39144 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbeH1M1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:27:14 -0400
Received: by mail-ed1-f68.google.com with SMTP id h4-v6so749576edi.6;
        Tue, 28 Aug 2018 01:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C4f9zh3G5vgWUScu39+v/Z2lcjFf08RYj5aso8z9poQ=;
        b=BKwdtc8iQZe9g7kFvSYrlpXta5jqkV5PxWkuPZND6627f4EQvlKy/TbHQHBwin9qVJ
         I2bHuWapjz9fQD7gvDvtKIGJYQSzS81DiA2TzNAywgq0tprfny1zoN/+ZrUmkJDo1tE9
         QB6tPJZEOux1lgpYEor3D8OPkHm5izvuwaphPCcWqlPnsPwNKohCRDHM5zp5zD4bCd2H
         qmLtASqinFDNlWKk2SMZv52p6NyVmlP1Co1CTW3prhMr73uYLlXn/SMnQEzE6jzMZ1O9
         zKRo/i+N0tF2UJM38zZt8YoOiALR2UQmcW9ixbosiWmon5TWPP9jlxQ58fwvFfhrFYTb
         +AMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C4f9zh3G5vgWUScu39+v/Z2lcjFf08RYj5aso8z9poQ=;
        b=OpfEvBD9IlGBEGz6qlKb9jE1g8S17I1jcxiSfsabjz0ssUl+BEAI40SbKZPS6/YZzu
         dsSKGYGcE0V3h6zzGKS1CCiGLqwuM8mAmhO9/rGCEAUnZ8amayxoPMY0hKpyqARqk/Wi
         T7NibxO/dzymlHVIBK4vaXAAy+JpHENBWLIr5GSA5A+6lo4dvT83kcawYqRj6yZFr6Yw
         /bUH4kOrvmgu0SVBeC7O7IiXzPZ6jlt/5L1OceTIEUzdSaJI3sih810vl/uX5In6dgvu
         CQ5mHtyiKN95iJHbE47jAx8iepUNINIl9YUL2njBuzgibDOl20GsC+a/vceU4rpGAw+W
         YOZA==
X-Gm-Message-State: APzg51DyhLCo/EqG9P7Rv2+2NI7wPHxOxgBmVnVyvxHtBgw05aUm6JTJ
        hpHnFl0VZIQw6c+lpNGDp65J9XSE2UaZB3A6QvhuJA==
X-Google-Smtp-Source: ANB0VdaWjxMQbTTQBuSzINbXcvlKFSg6PJwdv8nHUidtB5zBNuYO2hxXTh/8Ah+4eGo1z0F2cpGRhJiCD2ifB/Bqmi4=
X-Received: by 2002:a50:8843:: with SMTP id c3-v6mr1278427edc.146.1535445399160;
 Tue, 28 Aug 2018 01:36:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:d301:0:0:0:0:0 with HTTP; Tue, 28 Aug 2018 01:36:38
 -0700 (PDT)
In-Reply-To: <20180827144904.17226-1-hangdianqj@163.com>
References: <20180827144904.17226-1-hangdianqj@163.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 28 Aug 2018 16:36:38 +0800
Message-ID: <CAGsJ_4yLruLKnKc6kpr1JZ8BSSS4wAyvxeGm6A+S7-rLAZAVmg@mail.gmail.com>
Subject: Re: [PATCH] tty:serial:imx: use spin_lock instead of
 spin_lock_irqsave in isr
To:     hangdianqj@163.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jslaby@suse.com,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

jun qian <hangdianqj@163.com> =E4=BA=8E2018=E5=B9=B48=E6=9C=8827=E6=97=A5=
=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8810:49=E5=86=99=E9=81=93=EF=BC=9A
>
> Before the program enters the uart ISR, the local interrupt has been
> disabled by the system, so it's not appropriate to use spin_lock_irqsave
> interface in the ISR.
>
> Signed-off-by: jun qian <hangdianqj@163.com>

many discussions have been done with jun in wechat regarding this patch. an=
d

Reviewed-by: Barry Song <21cnbao@gmail.com>

> ---
> =C2=A0drivers/tty/serial/imx.c | 21 ++++++++-------------
> =C2=A01 file changed, 8 insertions(+), 13 deletions(-)
>
