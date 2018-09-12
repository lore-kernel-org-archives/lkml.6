Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B443C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 05:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAEA420866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 05:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sa0FqnGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAEA420866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbeILKPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 06:15:05 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:43954 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbeILKPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 06:15:05 -0400
Received: by mail-yb1-f196.google.com with SMTP id k5-v6so473634ybo.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 22:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6EMkHR4YY8ma6BgsoJ7ulyhcd1nEIJtE8TcjG08puXA=;
        b=Sa0FqnGX0nvsROi64LK2qlcC049ollTgRx3pqp2vHKJy5Xvu+7bzZdohedJWRw6zUp
         OI2Rlfsp5jvAVgt97+Ei7nbZt65znskTr318NHC7gdrojcz90Qsc8xCissK6LV0tEaNu
         NJY/AhZpHynmoCbg1soJwlsknpiX+FrvKTbhfD2U0vrT3xB/eO8v3otCws20zU5b5NGn
         Fp/x1D7QSSvSAzzu/r1VjcxZ7eWS+fAvj0cBkLrFIS6t7KAOjwdNdp6o56Fjgfr5cARJ
         vkXeWuUG0a1bx4hQPBzS+T0KoZdEfld+M19URSrgjJDrIVjtgN0JymTYnMQh6xp5phM9
         QBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6EMkHR4YY8ma6BgsoJ7ulyhcd1nEIJtE8TcjG08puXA=;
        b=gHKuuadiahMzVdpjSmivdkZzlbzLK+oOHDoAfleX27RY8MNHkhJl24BI0VfnMkNC/8
         8Qnl4MH6utGveeFbXwqoj+4g82zk8NPVcj9Vz7/rVLw/TkLsex8a2T+doVuuoUKyqaUa
         IYlf+QTpY3NplvZ0NkOlfsLrwVNlQOou4WjpygqDqg1iY4KtFqeBgNrxUYPh/F3AhGR7
         t/7MvRSgTfpyBcS5XEeK3v68A4g1S8p5to6+Uc4UaVGEMpB7daddgbb0ajV99cj6hetc
         umfITgaitDEg/Fs0dORwXOiCGoSDybQJ5lDIKhERXZpIRNB8EtA1tOUNnULUxsjHEju/
         yMrQ==
X-Gm-Message-State: APzg51BxLp1IExgvp67YPI56a6pxrp7mNfLJTPeJ71hsHxcZtL0vgbNd
        kUkfjCcmesGhHlk0OMkeG1rYuGliidP0dW5Ex/8=
X-Google-Smtp-Source: ANB0VdZEojW1P2CTHkcqxX45fCgAcb4Rm8IuIvkdscFZQJrPQevnULIGqNLBbz1U6A7T1uUqzioAhoJzJxjx9z30mPw=
X-Received: by 2002:a81:6c0a:: with SMTP id h10-v6mr45883ywc.275.1536729139435;
 Tue, 11 Sep 2018 22:12:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:54f:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 22:12:18 -0700 (PDT)
In-Reply-To: <1536726319-9645-1-git-send-email-yamada.masahiro@socionext.com>
References: <1536726319-9645-1-git-send-email-yamada.masahiro@socionext.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 11 Sep 2018 22:12:18 -0700
Message-ID: <CAMo8BfKXd1sHu=04i_FD9aeCxDTL8gBz+aN-s8veENYkDK3=HA@mail.gmail.com>
Subject: Re: [PATCH] xtensa: remove unnecessary KBUILD_SRC ifeq conditional
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 9:25 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> You can always prefix variant/platform header search paths with
> $(srctree)/ because $(srctree) is '.' for in-tree building.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/xtensa/Makefile | 4 ----
>  1 file changed, 4 deletions(-)

Thanks, applied to my xtensa tree.

-- 
Thanks.
-- Max
