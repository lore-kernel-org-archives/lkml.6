Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12CFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68665205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ERpkjXHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387465AbfBOJRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:17:39 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39667 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388090AbfBOJRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:17:39 -0500
Received: by mail-qt1-f194.google.com with SMTP id o6so10093849qtk.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 01:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pHeu5JGMOU1EgxdvztFSk/kQgSEyGK8ZIvx2jHvc17g=;
        b=ERpkjXHUOVvbEoaP7Ix7pgMW6Coci96ne1h9iiEQ+IKpGoyN7GqYw4TgO2qdRhDYBy
         jALmTeWdZSGIVCXLP3WJfo0sd7IsqnhNjDWsoWKfLMmXYxIWQjSjNaRLdaGUoe6pgZ0Y
         cpQG3/2yznHn24BoQqsBDF8XA3UsMrn7qCyws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pHeu5JGMOU1EgxdvztFSk/kQgSEyGK8ZIvx2jHvc17g=;
        b=AYotakhp2RL67pYCcVmXOq36oUbdfMEHadbgVziyA5spLIq442lwolkXfoSPmnGpPH
         DTL1rnMlXNWItQAidM3KT7LcjieDmbTjcqRgtcSlOlyYt8mpc/liU2Yc4tbGrZ95WDAW
         +sTAOnAwlvf8Ef8n1/LVCnZZbIeih2hAd9RSJjDzMzLRU/WMafpPZrs+itDqHqNXgvBI
         CshE+NbzVVhRZFzJTsYM71OWuObhiLzs2BShgzy4aYrQA2cgNYi3psZKWtPh3ReXkNhf
         38coHDCXCmgatCijCL5W4aoS9uWItgzUKERkaMRQ+CTTupra1N/hXUw+mrb1cJX3s813
         B8dQ==
X-Gm-Message-State: AHQUAuZfLzu3ZByhwLyK5gIjbq3Iy3OqBs1PQulqbJW+OqklD1w7Eqrk
        Ahg2tRjVvuKUgEGrGNCRI+DS4gRe1Kl9T/XyNUGz+g==
X-Google-Smtp-Source: AHgI3IbiLPsHirD/XHSvcifyp9fuzaRJC7tOry4+XO6LWiBdKdHShOVnzhCPnbR7x8JCU5VczPmcpChvvl2/djjeObs=
X-Received: by 2002:ac8:300a:: with SMTP id f10mr6571381qte.236.1550222257770;
 Fri, 15 Feb 2019 01:17:37 -0800 (PST)
MIME-Version: 1.0
References: <20190215090202.157100-1-hsinyi@chromium.org> <20190215090959.soxkf3ho3or2geme@ninjato>
In-Reply-To: <20190215090959.soxkf3ho3or2geme@ninjato>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 15 Feb 2019 17:17:27 +0800
Message-ID: <CAJMQK-jrpnfzKNYh01Pg6QydSSa-=6x44Pj1wwMdXw7G3x-ybA@mail.gmail.com>
Subject: Re: [PATCH] i2c: mediatek: modify threshold passed to i2c_get_dma_safe_msg_buf()
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jun Gao <jun.gao@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>, linux-i2c@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I can add a check in another patch. Should we return NULL pointer
if msg->len is 0 or print out some warnings? Thanks.

On Fri, Feb 15, 2019 at 5:10 PM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> On Fri, Feb 15, 2019 at 05:02:02PM +0800, Hsin-Yi Wang wrote:
> > i2c_get_dma_safe_msg_buf() allocates space based on msg->len. If threshold is
> > 0 and msg->len is also 0, function makes zero-length allocation, which returns
> > a special ZERO_SIZE_PTR instead of a NULL pointer, and this will cause later
> > code to fail. Modify the threshold to > 0 so the function returns NULL pointer.
> >
> > Fixes: fc66b39fe36a ("i2c: mediatek: Use DMA safe buffers for i2c transactions")
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>
> Right. But we need to fix i2c_get_dma_safe_msg_buf(), so it will be
> handled for all callers. Do you want to add a check if msg->len is 0 or
> shall I? Both fine for me.
>
