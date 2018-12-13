Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F49C6786C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC44820811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="ng8UcRvb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC44820811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbeLMBKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 20:10:04 -0500
Received: from mail-qt1-f175.google.com ([209.85.160.175]:36914 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbeLMBKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 20:10:03 -0500
Received: by mail-qt1-f175.google.com with SMTP id z16so411989qtq.4;
        Wed, 12 Dec 2018 17:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4NUXph6sewKAF+Apf1FNRprvzsnumssa+ieZdO5X5ig=;
        b=ng8UcRvbK0jA0sVddxz9JoZN5d+fO5P9VO91aj7IV9eXZu1Cp4MhapTcjqFFLORoT1
         DwFNp3Uki8xpvMGTc3iUbh1+EkPvkkyhkIljNF/xC17BCCF1xhqaYHmFGgOJzphul/uL
         bKESJTjQAnULgPKYAtXFStMhf0MxVlQJ099ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4NUXph6sewKAF+Apf1FNRprvzsnumssa+ieZdO5X5ig=;
        b=q80/is+ZqI3xZ0kC4RK+ounosjDtxZCbq5zPh9IaR6Z0PnMA+Bm4UJSRW6MpFQyzkx
         aP6VfZzu0ON8lsyaZE4hjSYdWi8ZSkR+pkvL9mrZUKifnp3TRWodOhzJKAkagQTdfzlJ
         UVBlUODn4AFnSWp5KkzZgYgkwkBucvgk801HVtcav8/SFwPTPpodxzVZvtU8vbXNpCJ2
         OtQaR0D+mAD+CquOuHRxQdNVLHqjfeI+OkQh5ZDbOvloo1ImJqAoifz+8gzt4an1qBuN
         +KyQHIpNMm+vslcVkQRAwHgFgDvA1ihXwY8TPDQn+tTxjlSWyl7ou7SQg5M3EUryaqds
         OxyQ==
X-Gm-Message-State: AA+aEWZheuamU+jMTytSEIO/X9Am0D/ObJxd+AevAW5QaTywdEzJYNLr
        bBXsaZDnpYtIpkhTUOmaA4mEmNBSJDHq0cWS6fg=
X-Google-Smtp-Source: AFSGD/UA2uv6C0lcuruKpIf2RhbZzybNULof2IpPd7ZmIoT47JeDFYvYL9EdwGuPrndoew8T2SukoqpDgcYH9Uj8iVE=
X-Received: by 2002:a0c:c927:: with SMTP id r36mr21779472qvj.51.1544663401828;
 Wed, 12 Dec 2018 17:10:01 -0800 (PST)
MIME-Version: 1.0
References: <20181212215305.3852170-1-taoren@fb.com>
In-Reply-To: <20181212215305.3852170-1-taoren@fb.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 13 Dec 2018 11:39:50 +1030
Message-ID: <CACPK8XcHN07D5vtoAZ2BnaFzc55P+XEhzsTajOm1S2fvcrrm5Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: aspeed: remove duplicated statement
To:     Tao Ren <taoren@fb.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>, linux-gpio@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018 at 08:24, Tao Ren <taoren@fb.com> wrote:
>
> Remove duplicated assignment statement from aspeed_gpio_probe() function.
>
> Signed-off-by: Tao Ren <taoren@fb.com>

Acked-by: Joel Stanley <joel@jms.id.au>

Thanks Tao!
