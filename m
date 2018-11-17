Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF237C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 15:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA0520825
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 15:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDk8iqkR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA0520825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbeKRCPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 21:15:30 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:34733 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbeKRCP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 21:15:29 -0500
Received: by mail-ot1-f41.google.com with SMTP id t5so24126659otk.1;
        Sat, 17 Nov 2018 07:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oqZmzwyxa+dYFxZqc4HuRpcAd4w+HN1YSsHqzEYaTNg=;
        b=kDk8iqkR+5hLMkz6q+9x+zsUawjEhjqKnBEctsrmiuNR6AiGBrNRO6yK3LqLPFEYgd
         9tj991xbGP9Le1zEWVZdq8HbANLHEJCS8MxP/gmcLLMS1PI0I/0hrt7HTT6W0aMbp1UE
         sQFjQhVq+5HB3sRVibWeFHtesR15Zv+eJUOHyg0W7rQ0D/oEw2Rps3Zpt7iahK22KjW/
         LFr9t09FMc6/diHoiJSZ9AbHkLuONuE0eD9naZLFBx0YEOgoPbNsQb5Zf3MmPAcYq5YH
         zmDtn0MTY9rIFuhuxbWMDpCCVj1/WpiMZg6c/qEbyKrGD7lpCFkA5SkBv5mkvVpkDnyQ
         qX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oqZmzwyxa+dYFxZqc4HuRpcAd4w+HN1YSsHqzEYaTNg=;
        b=nBPXCvoxZ7jjMYRQATTJC9wX5uHtVQY8tQ28iiqlFGfEYnAOWdLiBSnlm1/wIEh+rf
         1GYFc209WxC0WHXcg1kilmIH0W0NOIh4F9WAc4ixlgdK4/BLdcvCpduvlz4id2bX3XDh
         I4gcobHyDTOvTLioxyUcmwoIJUlY0V0WAu1INVyII7SVBQ3nk5OQ3v9s7xvpgxVMJuvj
         kC4U4XmRlRnSLjD06TtV5xxJJMWWBI/qB/C5ZQ6Jnmx2eJwcWQlM+d4lLAOzS12hzdjw
         N9t4gXyYegTBnFXws0O6Aj+tWgJVeOEETscZ2BkI5yzuXadweMWhsdm/Yp/4xYgR5lrt
         Benw==
X-Gm-Message-State: AGRZ1gLvboSdx7ypIETyhjUotgNL9o1xrsXROSbNq+5/H1kkqqn81VDO
        F7FubHJBMaWkq7vi0rYQnujpOZVB2h4+J5FhW/M7+DWg
X-Google-Smtp-Source: AJdET5fTYm0NjunO8Mf1KXKt73nkmsIijDJaTlWEKr0gbTSfpCGSpRj/30I6D37myFvMMfPSuGMv+dCps/gOYXMzHJc=
X-Received: by 2002:a9d:b8e:: with SMTP id 14mr8576348oth.279.1542470304096;
 Sat, 17 Nov 2018 07:58:24 -0800 (PST)
MIME-Version: 1.0
References: <20181114135202.27104-1-TheSven73@googlemail.com> <20181115200018.GC32274@lunn.ch>
In-Reply-To: <20181115200018.GC32274@lunn.ch>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Sat, 17 Nov 2018 10:58:12 -0500
Message-ID: <CAGngYiVLw6sGGTijReKR2zcfZcAXnuY9KJaVm1Lm19_hgzh49g@mail.gmail.com>
Subject: Re: [PATCH v2] tg3: optionally get mac address from devicetree
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Sven Van Asbroeck <svendev@arcx.com>, siva.kallam@broadcom.com,
        prashant@broadcom.com, mchan@broadcom.com,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please this cancel this patch. As suggested by Dave Miller, it has
been replaced by:

[PATCH v1] tg3: optionally use eth_platform_get_mac_address() to get mac address
