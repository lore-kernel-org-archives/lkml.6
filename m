Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE91C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35CAB2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HH5o2fz5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35CAB2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932795AbeGINm1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 09:42:27 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:38391 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754455AbeGINmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 09:42:25 -0400
Received: by mail-it0-f67.google.com with SMTP id v71-v6so15899320itb.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 06:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JbQzOU8Shl1VMyM4ZerDG35+ce1xIi8TFj2DXnhqJRA=;
        b=HH5o2fz51JCmc+U8oh5lcdC+LF9+hZtckxL8Y+rCeK+ITbloP1479OExt4rNh2aVPi
         uhsVWID1fbDVV513tLKI0/ZzGc3LGOd06JHlcHZeOTXDsGvDeFrFX0JiIpCjBgWQVtOx
         UPcoxrI/nIzOTIU2h73vCc0kU9dzhgSllxrKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JbQzOU8Shl1VMyM4ZerDG35+ce1xIi8TFj2DXnhqJRA=;
        b=Fakza9TVhH1ci45xe+sjBA1QM0BLyObaV2EinknO0sF9GcWZNgnQNgGJp0axSb4vEx
         DHomX9pzDYQMT9yXtzSNdD2cshx3c8TKuIm2QZWJq7pnCtjCIi1YDN6jDRimocGCEnQb
         baZ2E1KdR4dtLlzbM+md3ZvUEHDB3F+MvkNA9/8F8GSou1leW68/Ie6qWaYf279cYwEV
         NZxj/nEpuItW0FXBParUiImx32sYJR/o1cyCez/SdZwy0Y59KSmHztWPNuU4p/+Pl3Ql
         /t3cg6HffdG6ckemZRPpPkeZDZz/BJZ3/pp7pfOqbrC3baUtM+vc/5VEv7zTu1bAPwkv
         Y0Ow==
X-Gm-Message-State: APt69E2Fj3XaAyyWUM0veb1+1w0cLVwfh+46NIjDFPyvdfJH+iHLbsRh
        VcNNt0kTCMt7Ynr+oRPXu4iS7UU69rnBN57NSn0Zwg==
X-Google-Smtp-Source: AAOMgpeNx+03TTgDOSVGu725De6g4GsGIV2HT+pUKyY2Ku+1jebxenYhLrOmZ8r/R52z9Dfmasl3zFTmcyQuxUP9xho=
X-Received: by 2002:a02:597:: with SMTP id 23-v6mr16983979jal.112.1531143744881;
 Mon, 09 Jul 2018 06:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180705155127.GA1458@embeddedor.com>
In-Reply-To: <20180705155127.GA1458@embeddedor.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 9 Jul 2018 15:42:13 +0200
Message-ID: <CACRpkdYODi2oNxqCmHtfev=NZ7S_T62B91S58kt=T84FCnnceA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: baytrail: Mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 5, 2018 at 5:51 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>
> Addresses-Coverity-ID: 1292308 ("Missing break in switch")
> Addresses-Coverity-ID: 1292309 ("Missing break in switch")

I hope these special tags are accepted by the community at large.
Has there been discussion?

> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch applied with Mika's ACK.

Yours,
Linus Walleij
