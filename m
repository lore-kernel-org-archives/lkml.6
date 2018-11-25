Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30AAC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 03:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B788D2082E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 03:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+1CXdko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B788D2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbeKYOty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 09:49:54 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37151 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbeKYOtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 09:49:53 -0500
Received: by mail-ed1-f68.google.com with SMTP id h15so13110877edb.4;
        Sat, 24 Nov 2018 19:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U+1/tgMRj/JOTQJucvUDHnPuwS6ae3Le7j3qMw3/BNY=;
        b=e+1CXdkoqv0T+/liB0x++UlCLBh/5ehF2Dom3e0FXTuIStU/zSmjEoAcQtifr/d8ZA
         Odu23hvDquesan35YVNfgWvHdRX0uDSsMbpBdn4g2R8oyki+92E+EF4CzvjgVZZwP0Pu
         O4RWQMEFIKMl8OXqcLQxkBW2/S39le7RlIfc6Wxm2BSn99NqmkrIqZwKlatxAeSPPvP5
         hGuVSt6avd6onG/+AijqSsRuKnYlLulMf3PZdK7M/WgpkHQg8CbUZdhWJPD3o+jYCP4X
         KbKWK0WPfj1j9fYvf9+eIO9ZyS7UTKLNiatJ3PdK0azWBfAWmRrUReUcVMM6rIpjjnhd
         Tk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U+1/tgMRj/JOTQJucvUDHnPuwS6ae3Le7j3qMw3/BNY=;
        b=Bz94KB3NS/R83gxqOsReQ0sLbKM1NOUo26NUuJiucQp5lfXpOcMQaUr4eD2qAm4SmH
         ahe4wLX91dUhDMjYfaamh95Xrl3eDE/S8ImBcQXBqgt/Lqv92ix9r03qDAQxqCJ6UpFg
         ZR5TbgH6+N2ga1Vnczc9IvDBc78xRZAXcwoZRRtvUlwNtegoAAdfgviwuv2L02BdKiA1
         gqUyyiIc7ChFglU/VIFi+3FFloAuqQq+fBrtZU9kUg11CyU1xF4nPfXCdFJvUcQoAEa3
         5xYT+AjeZGUwO6xJ8Cx5MROHtcVqnjjWGLZlIAWMyXzBdSEnpgMev9DAu1gd3ubJ7wCQ
         saWg==
X-Gm-Message-State: AA+aEWY0QwspIO4mIgQZ3FBUxVPsSO3gHVlNyDTDRumbmzwhCIm76A0K
        pu0+zC/KMb+avTFfBPo/NdzP1LQU8i9sLPvCGAM=
X-Google-Smtp-Source: AFSGD/Uo+PFO0An0PYuSLkZsAmQgP+qZKrbnPJvykiTPwAAACJqIxg+aILVpVdhVnYfQ7CCdGoXqaHEebYN70hABOeM=
X-Received: by 2002:a50:bdc8:: with SMTP id z8mr11875509edh.46.1543118385909;
 Sat, 24 Nov 2018 19:59:45 -0800 (PST)
MIME-Version: 1.0
References: <20181124022035.17519-1-deepa.kernel@gmail.com> <20181124022035.17519-4-deepa.kernel@gmail.com>
In-Reply-To: <20181124022035.17519-4-deepa.kernel@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sat, 24 Nov 2018 22:59:08 -0500
Message-ID: <CAF=yD-JGh23sA_6eUtBq8=wSZ5g=nipmhdr1WwjP5th51qEtiQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] socket: Disentangle SOCK_RCVTSTAMPNS from SOCK_RCVTSTAMP
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 3:59 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> SOCK_RCVTSTAMPNS is never set alone. SOCK_RCVTSTAMP
> is always set along with SOCK_RCVTSTAMPNS. This leads to
> checking for two flag states whenever we need to check for
> SOCK_RCVTSTAMPS.
>
> Also SOCK_RCVTSTAMPS was the only flag that needed to be
> checked in order to verify if either of the two flags are
> set. But, the two features are not actually dependent on
> each other. This artificial dependency creates more
> confusion.

This is done so that the hot path only has to check one flag
in the common case where no timestamp is requested.
