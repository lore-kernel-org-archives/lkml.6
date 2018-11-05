Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3427CC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F008320819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F008320819
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbeKFFmF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:42:05 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37700 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeKFFmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:42:05 -0500
Received: by mail-ot1-f66.google.com with SMTP id 40so9059300oth.4;
        Mon, 05 Nov 2018 12:20:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Lr7j6JCfZ8/pb8QeQCYXx0UHO1h5yDWxL+Q6SAgDgWs=;
        b=XlgbGHdiTtSp2kozj/mS/u6Tzt8usak2sKovnaHs7/EbrEjkaKt9/UZuITpd2mJUG7
         Mz3YYCFGVrkoJ0VH7i8oPzOS1LA+21gDX5/S5wLPXygnLASJPNAF9OUtdnO6osajYGaK
         faCl2emDYNXExeKVEg/T6hutr4Iti8aTmcP1vBm60sgjG+D9bndKSlJqWxDDepbqZjR0
         hhlFT2Z4oOeJ8hCbRBk5c92UfBYQ+//MbRM4y5D4aERz6s5lH75pQGX9p7PXZpjErOCC
         RTRooy8TaHb6o5D9yVgswdeM0UsoxRgSEvMEhu4FyQDBvtyNp62FcIedNz82ldoUEYq0
         7WTw==
X-Gm-Message-State: AGRZ1gIqm9aS75DGTjAPm+bfrJSsOhja8QbobZbWyVUv2vKk+faw02ht
        JYOhTGElTMB9KGm6iMHxKXT8z5WOdU6qV5+g9JyTh/9y
X-Google-Smtp-Source: AJdET5cG5TjVWfP6VLzl/qrB2rkJZBmZtXj3MGXzWHF2ANKgxs1T4ULSZLCIvahuhut9tIOnBxXKKt8EDcc0gOx/6tA=
X-Received: by 2002:a9d:348:: with SMTP id 66mr9466973otv.300.1541449242258;
 Mon, 05 Nov 2018 12:20:42 -0800 (PST)
MIME-Version: 1.0
References: <20181031113500.3763-1-malat@debian.org> <20181102.233357.1129560140046922258.davem@davemloft.net>
In-Reply-To: <20181102.233357.1129560140046922258.davem@davemloft.net>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Mon, 5 Nov 2018 21:20:30 +0100
Message-ID: <CA+7wUsw7Qv=Zxeey-C0BSw=C3Zu_u=CZOU60TTJkk1ebROmUfg@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gbmV0OiBtb3ZlIOKAmF9femVyb2NvcHlfc2dfZnJvbV9pdGVy4oCZIA==?=
        =?UTF-8?B?cHJvdG90eXBlIHRvIGhlYWRlciBmaWxlIDxsaW51eC9za2J1ZmYuaD4=?=
To:     "David S. Miller" <davem@davemloft.net>
Cc:     LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 3, 2018 at 7:34 AM David Miller <davem@davemloft.net> wrote:
>
> From: Mathieu Malaterre <malat@debian.org>
> Date: Wed, 31 Oct 2018 12:34:59 +0100
>
> > This makes it clear the function is part of the API. Also this will
> > remove a warning triggered at W=1:
> >
> >   net/core/datagram.c:581:5: warning: no previous prototype for ‘__zerocopy_sg_from_iter’ [-Wmissing-prototypes]
> >
> > Signed-off-by: Mathieu Malaterre <malat@debian.org>
>
> It's not part of the "API", and it shouldn't even be exported to
> modules.
>
> Only net/core/skbuff.c calls it, and that is never modular.

OK. I got confused with the EXPORT_SYMBOL(). I'll re-send moving
__zerocopy_sg_from_iter to skbuff.c.

Thanks
