Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADFBC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713F821571
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="q+brhI/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 713F821571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbeI1UEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:04:43 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:38735 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbeI1UEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:04:42 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id a6ed30d8;
        Fri, 28 Sep 2018 13:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=bhkR2+qUE0HYLY0/R3S5lpT5obs=; b=q+brhI
        /XHA/kOJP9iUfKcDGW301a5rT5RT8OMME75GrsiUI5bL+BzPIBoayY9gIfVs01/y
        qJ2//M7sLLxain2Wml0KqWqVVS4Y4e12V/zq8ValbZrLS66U0/A3yvZDBNXsCrv+
        Wde5DGs0/bk/yg85Y918VLRl91z5Fm3mxdqIDfg8bQTE8NmN079UQEcdfHem42eA
        SkPwEdKGQIUbrDdhSPz8EexsLr5/Av8ZbIlOAs5RN/YQoqG91bEzUGXJI5iAyUVn
        OZq6ydjt48Dk9oluR/LSOgU6ZUT4tybpTPRRHpgQlUJX756o0uzXXLKUedngQjas
        NhqAIUzOTD5hmpkw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 040c8708 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Fri, 28 Sep 2018 13:22:02 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id e21-v6so6030382otk.10;
        Fri, 28 Sep 2018 06:40:50 -0700 (PDT)
X-Gm-Message-State: ABuFfojQ365jLL8YBn5PKfG11lN3WsHHPj1eNzj1OuQ2C+KL4lnAZSAT
        HJ+kbctqHhIIXdDfUUgNWySL6jrVKmWCVdMYxXI=
X-Google-Smtp-Source: ACcGV63WtHgjq2itbrvidRUZYQ8ZodINWorSvPsJw/LRfC+BH62G6P9mVM+ws6u314FeLKXhsMOuwWNYLhvQ2nAOEKY=
X-Received: by 2002:a9d:42c3:: with SMTP id c3-v6mr9488783otj.54.1538142049115;
 Fri, 28 Sep 2018 06:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180927182944.GA22921@gmail.com>
 <20180927213537.GA27576@zx2c4.com> <20180928011726.GA98113@gmail.com>
 <20180928023546.GA20765@zx2c4.com> <20180928045542.GA545@zzz.localdomain>
 <CAHmME9rJ4CewfDEqWh00ZowjWg9TaYpksVSzKSSxoKya-M8_LA@mail.gmail.com> <CAKv+Gu-ZMR7zEAKv6_2tyD3OqnjVugOzKHzBEXW3pQs5W-SvLw@mail.gmail.com>
In-Reply-To: <CAKv+Gu-ZMR7zEAKv6_2tyD3OqnjVugOzKHzBEXW3pQs5W-SvLw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 28 Sep 2018 15:40:37 +0200
X-Gmail-Original-Message-ID: <CAHmME9oEq4xSVTzDAiPkuZ=ix=TMLYLjLDv9x+EQeLi7HTbYqw@mail.gmail.com>
Message-ID: <CAHmME9oEq4xSVTzDAiPkuZ=ix=TMLYLjLDv9x+EQeLi7HTbYqw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 00/23] WireGuard: Secure Network Tunnel
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 9:52 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> As I understood from someone who was at your Kernel Recipes talk, you
> mentioned that it actually stands for 'zinc is not crypto/' (note the
> slash)

I mentioned this was in v1 but it wasn't taken as lightly as planned
and was removed, so if it needs a recursive acronym it can be "zinc is
nice crypto", "zinc is neat crypto", or as the commit message
mentions, "zinc as in crypto." Alternatively, it can just not stand
for anything at all. Zinc -> Zinc. That's what the thing is called.
