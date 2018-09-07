Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDBCC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03682083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="ukDOMQvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03682083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbeIGV41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:56:27 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44775 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbeIGV40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:56:26 -0400
Received: by mail-lf1-f67.google.com with SMTP id g6-v6so12592901lfb.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 10:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=t8/yfktA5mXHEuUkOKvhr+GykXG2xNQPwle0rgEaAOg=;
        b=ukDOMQvVq2rGK7v69hSPyh4931dZYIxv5Xyfq7HmGWbVAAJIGCUmrlDXXnOziGXBI7
         7732h2xuabDQfRY8jn3k1tf5Xh6Trg4a1JIa+IrTdpFI8ni63o2VzHbI5PopZll8k2Xr
         nEsyYrZHFQk8NMEOlhEHAfOrTLLxQ1scbpEgfNPmh9RRT6jBh7ZvBHJMkYSwp3+5bFQ8
         W3dZS+s5Sd4TaxRRfNLqDbtp8dkTtw1SwjoBaccasNuR82qs+IzpjD7KycOH37qQDOCE
         8ptKSjxcziUBoSQXlG6QPdqCYjU4T00H6rmKEtAXNXjr2lCU/Yaqrd+cRQcMIQNSszCn
         WlYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=t8/yfktA5mXHEuUkOKvhr+GykXG2xNQPwle0rgEaAOg=;
        b=roI+cPDyfp/CYW6W2boenG9MKihpLfjNT3enpZIpsFEYq5QopgY1azy0W2Uj+NFTWK
         YN1JxJiO40PAelXoqgqd3gUBHSgo+umExvYBqGa5VW5JRJc8vD2Bon9LZsbx9U0zGV9Q
         Z0lTdWsSIcsj21RvPHE3zNzwhq1u4nz/A2tFuA0bmatxvYymw7RIq7Z+ONEQeslJFOuW
         xfzRX5EktEetPi7/ObBQut+YqqY+Vk2F4yCgnEaa/yM7DYuanufuMGAFEFewIVVJycG/
         deCl1LIjLaown2SsUMSD5RmmjwTacygglSYmylO2tIcBjHO2IAaRY4kTEZ5Lvg7qXniy
         /4gg==
X-Gm-Message-State: APzg51BfAenNinC0GTyTyQReH+seocWVYxn321ZdK76mRwXlnUfA+H5+
        nl3VctjmEvdmSdAUUt7AdFNiVwFzaNFIqr/07378SQ==
X-Google-Smtp-Source: ANB0VdbRY9OV9OkQbZoRBrjO/JRP7uldiPENuHnGiGkm6CS025QSgMijpX5N3pbcIG4e6fn9zXlmFng+JBNTH4Ufcpg=
X-Received: by 2002:a19:d8e8:: with SMTP id r101-v6mr5592656lfi.37.1536340472689;
 Fri, 07 Sep 2018 10:14:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:6413:0:0:0:0:0 with HTTP; Fri, 7 Sep 2018 10:14:31 -0700 (PDT)
X-Originating-IP: [2620:10d:c090:180::1:378e]
In-Reply-To: <1536339135-5431-1-git-send-email-sudeep.holla@arm.com>
References: <1536339135-5431-1-git-send-email-sudeep.holla@arm.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 7 Sep 2018 10:14:31 -0700
Message-ID: <CAOesGMiRYFuMDbs9bogSRz-85d_+JYh39ktvYeY2fuUL4Pmr6w@mail.gmail.com>
Subject: Re: [PATCH] firmware: arm_scmi: use strlcpy to ensure NULL-terminated strings
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Kevin Hilman <khilman@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 7, 2018 at 9:52 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Replace all the memcpy() for copying name strings from the firmware with
> strlcpy() to make sure we are bounded by the source buffer size and we
> also always have NULL-terminated strings.
>
> This is needed to avoid out of bounds accesses if the firmware returns
> a non-terminated string.
>
> Reported-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

In case I don't end up applying it:

Acked-by: Olof Johansson <olof@lixom.net>

> Let me know if this is rc/fix material or need to wait for v4.20 ?

I don't see a reason to merge this as a fix, it's more of a cleanup.


-Olof
