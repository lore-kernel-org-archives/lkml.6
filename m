Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 06028C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B7420020
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M+XX/JlH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B7420020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965943AbeFNO1a (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:27:30 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:56067 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965633AbeFNO11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:27:27 -0400
Received: by mail-it0-f67.google.com with SMTP id 16-v6so8572711itl.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 07:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6D7FRzcKkf1mtcCgqKoPcGMQEGQXfdycYZdpgoORS1I=;
        b=M+XX/JlHp4XQKH7aGc/DkA3zau8kIaGq2Fv0PEJCVH7obmE+d8nNtvJJUgITe3gO/n
         lWLDoldWkMxWZTxCgVPSidteo34kxkkHlSdj6hbV+NA4yTkjV6RIQb/KQZAE5egBikS4
         6XDQk4VuB5lCK8UCiPj5ZH/Enh+3p8agCIS8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6D7FRzcKkf1mtcCgqKoPcGMQEGQXfdycYZdpgoORS1I=;
        b=gVAA+Xtue/c4D+Q+n9a4anpI6d6Ww+Io4ny4uetylTfk7scHHIDP2ryWny2t2oCGAn
         IzODomHT4OHtEK8nfIznIM8keNtuaLaNbqqNK2aWzTN2wP4vDvS4SmMHUXiE5Ckt0MwL
         4Y7wP07tsgHbNSUzY54z4+HrOP00EMK7VdhIHgnU8WsPtl+R5d3ee+vBlt1g/MNFpJCL
         YrZyf5IhPMkFrxEZ4nzSQITy2LAn3NnCEBYweaNDRnaXOhKrJLg7tywnwZBXZSvkCf/7
         lXCdq2tgbIPBBB1MyvpSpnaNz7oSMfsZ/nDHT/GIfeEnRZYaBGaf8Scasj/iOW/GA8VF
         eNmA==
X-Gm-Message-State: APt69E1zwHezD4ozTJZFTwVN/PipQ1Dyj0TaZV7NXGQphxMtz+N4NiY/
        U+ArATs6Gdjr0ylUr9QJZ//TR8gBK5UAUm5uHE+60g==
X-Google-Smtp-Source: ADUXVKL+m5DDAIfvEIyXi7Z/IJ/9RveYCwK4QeiJSDkAdQ9OZrT+mirWssG3IUDF2pIO/82cforfnLHwDrviZR+q7JI=
X-Received: by 2002:a24:19ca:: with SMTP id b193-v6mr2429963itb.135.1528986446419;
 Thu, 14 Jun 2018 07:27:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:78c9:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 07:27:25
 -0700 (PDT)
In-Reply-To: <1528774132-38287-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528774132-38287-1-git-send-email-jiazhouyang09@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Jun 2018 16:27:25 +0200
Message-ID: <CACRpkdbjMLiJtxUpuSuvOBKD-rbybF8baJUBjvP6Hv5baeWY7w@mail.gmail.com>
Subject: Re: [PATCH] gpio: max732x: add error handling for i2c_new_dummy
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 5:28 AM, Zhouyang Jia <jiazhouyang09@gmail.com> wrote:

> When i2c_new_dummy fails, the lack of error-handling code may
> cause unexpected results.
>
> This patch adds error-handling code after calling i2c_new_dummy.
>
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>

Patch applied for non-critical fixes.

Yours,
Linus Walleij
