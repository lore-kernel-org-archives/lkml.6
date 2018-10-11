Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D38C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D704D2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DltcYvgs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D704D2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbeJKVjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:39:05 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36460 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeJKVjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 17:39:05 -0400
Received: by mail-qt1-f196.google.com with SMTP id u34-v6so9954530qth.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 07:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=bMrhvhQG5l6P5OBNLqmHXyVFNugrzPHDUyoEC5+s8QY=;
        b=DltcYvgsr8uOEbLtDzR/T2rJMGIYZmpFJu06DDSwlFdpLuNaUFdkOOvL1+WVSqFA1E
         PnwByHPDMw24A26zMKHfrd/FLA63meFPQDYVoCuSq9040y14ug0j/L8MAWfQgC1nOZno
         aXQLnP+RchC85LYdR6LWGD/6yNRKgsxpV3SY6Ajqmq2+Nzdj6RKaYSH1e+HspH5U4NPe
         qA8MKNQIRy/tC+96sX0iynif91P1wEjYD2WG+SaHqTFglfBVsx72TCaiLU+jWYpiiR3d
         w3lQWg8/gRAB4nacn98/iHvX7p/8FZX/WyXC2eukij291EBqAf+XM/i7BKLOuz1TRqQF
         5HuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=bMrhvhQG5l6P5OBNLqmHXyVFNugrzPHDUyoEC5+s8QY=;
        b=n2gSJa8zhQuuN6dzgdmRKipzMs9NGgA2BikSnXl7Ap8wiMnY24zkLdiYKGqWwp9xeI
         asa0Yt3G9BpXKMosJjwx0eHOLF8mXHmnmp3C5IXhDcpX058pwHUIo0z2/ACcVE3kbXnM
         gdWNEyQjK4sX3jdgL8lqiUsm1KBtsUklxtv5Pg4qjdiIjIFen3smnOzNbKe3gaqyFUuv
         whYc2jUBSuVEAVCsog2IG4RM7SI59I3qp2HOMC9s6UhVvGTVcLNW32XQZIjmi3AdmCpH
         RPSLTu9LuBleUukT8YlKsJx2Z1G7EleUc80osWe3sIO9+OYnYM1aSA2HS3bxXaX1l1GI
         6cZA==
X-Gm-Message-State: ABuFfohhPM9a9Blt5rOoRv6hNzdr29F9I2HqAMnkdEpT3kQRqeOMSKZo
        Spi1jNwzNKKbGqsEbVaiNiwRRqEc2Nme1OZrxLQ=
X-Google-Smtp-Source: ACcGV60bWC2x3Y9HpmKNWl0rLYHA06vWR5KMgBRuHxmUB/xBFY12dQrJpfqSGMwMQAHgyfqGmxOYDbqk89x6AlJFn8k=
X-Received: by 2002:ac8:1d11:: with SMTP id d17-v6mr1647025qtl.343.1539267102764;
 Thu, 11 Oct 2018 07:11:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:fd8b:0:0:0:0:0 with HTTP; Thu, 11 Oct 2018 07:11:42
 -0700 (PDT)
In-Reply-To: <20181011123116.24885-1-vz@mleia.com>
References: <20181011123116.24885-1-vz@mleia.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 11 Oct 2018 16:11:42 +0200
X-Google-Sender-Auth: 5Bcwqz8HlGzsSiFRYB4gKGoCch8
Message-ID: <CAK8P3a3pbpEX1BjKvn179pTYtYEtiQnd=SmD5NYkAtpdZAonkA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Assign myself as a maintainer of ARM/LPC18XX architecture
To:     Vladimir Zapolskiy <vz@mleia.com>
Cc:     arm@kernel.org, Joachim Eastwood <manabian@gmail.com>,
        Olof Johansson <olof@lixom.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/18, Vladimir Zapolskiy <vz@mleia.com> wrote:
> To all appearance Joachim Eastwood abandoned the maintenance of NXP
> LPC18xx/LPC43xx archtecture about two years ago, and for me it would be
> possible to continue the support, fortunately the quality of platform
> drivers written by Joachim is exceptionally high.
>
> The change is based on https://lkml.org/lkml/2018/9/24/1398 discussion.
>
> At the same time two redundant explicit driver file paths are dropped
> from the list, clk-lpc18xx* drivers are covered by "lpc18xx" search
> pattern and timer-lpc32xx driver is covered by "lpc32xx" pattern and it
> goes into ARM/LPC32XX entry, which is also under my wing, in other words
> LPC18xx/LPC43xx clocksource and CCF drivers will remain maintained.
>
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Joachim Eastwood <manabian@gmail.com>
> ---

I could not automatically apply this with 'git am', not sure what the
problem was, but I managed to apply it by patching the file manually.

Thanks for taking over the platform!

      Arnd
