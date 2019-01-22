Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6AEC37122
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD8C2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfAVCUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 21:20:44 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44957 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfAVCUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 21:20:44 -0500
Received: by mail-ed1-f65.google.com with SMTP id y56so18012026edd.11;
        Mon, 21 Jan 2019 18:20:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yO2ilgFiLuBnxJIpyJSadHX/mLmEhU4+AIAx+RHbdZE=;
        b=oR86JPYdK8B7E4GD4tCUY+r0WD1kNmLzyshQnx3JHtNd7Th4TvprVOn4+hsajr9RXz
         flhCM7TB0yt4zs+ZVmBiFUXYoiUlYFAmVN5EEX3IrjqMQ85LbnQz8WMg22Xp1RerALKU
         E0KBdV8hpbxCuU1fclBO50ikYoLauU5dgeChxRArW2+dQrKltKeQURmFjuhb+ewXbOhg
         Uim2sMfDgjjvHxNctG1azedMSwOQMAoJHiTpAIBWLA3KiItNl2wg3Nyp2eEm2bRxJV6I
         MV742DUEZ48rC+mOZR3OTwpxdPwIMrrcj0EWUVuyWeUkNvi7itVBh8/KYC1ZS7SyKFLe
         2P9w==
X-Gm-Message-State: AJcUukcCI7okDVEs1kuoHi78DhUzfghhIZHvEHojv5E5kvlrQpNmyJPD
        frLN8WXFvajOzuocHnqBAD2MhdXLIOk=
X-Google-Smtp-Source: ALg8bN64GmT6TZ6L2RQb+7pnoFgx+e1BPaIPWdH/R6YUsJXuFgJdzKLoiBM8Dx5uU/YXRHa++og5NQ==
X-Received: by 2002:a50:a7c4:: with SMTP id i62mr28993928edc.162.1548123642251;
        Mon, 21 Jan 2019 18:20:42 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id b9sm11512476ede.12.2019.01.21.18.20.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 18:20:41 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id p6so12613329wmc.1;
        Mon, 21 Jan 2019 18:20:41 -0800 (PST)
X-Received: by 2002:a1c:f605:: with SMTP id w5mr1621910wmc.116.1548123641509;
 Mon, 21 Jan 2019 18:20:41 -0800 (PST)
MIME-Version: 1.0
References: <20190122094203.54570662@canb.auug.org.au>
In-Reply-To: <20190122094203.54570662@canb.auug.org.au>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 22 Jan 2019 10:20:28 +0800
X-Gmail-Original-Message-ID: <CAGb2v65=fa9aL3+wKhbkbeuAVAuFL_KUqSPuQCXveJXU=DJt+Q@mail.gmail.com>
Message-ID: <CAGb2v65=fa9aL3+wKhbkbeuAVAuFL_KUqSPuQCXveJXU=DJt+Q@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the pinctrl tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 22, 2019 at 6:42 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Linus,
>
> In commit
>
>   15d90c339a7f ("pinctrl: sunxi: Correct number of IRQ banks on H6 main pin controller")
>
> Fixes tag
>
>   Fixes: c8a830904991 ("pinctrl: sunxi: add support for the Allwinner H6
>
> has these problem(s):
>
>   - Subject has leading but no trailing parentheses
>   - Subject has leading but no trailing quotes
>
> Please do not split Fixes: tags over more than 1 line.

Sorry about that. I've been doing for some time now.
Should none of the tags be wrapped?

ChenYu
