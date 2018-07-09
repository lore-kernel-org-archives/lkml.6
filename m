Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F559C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9D42084C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="au1iS4Ce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE9D42084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754613AbeGINi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 09:38:56 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:55312 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754437AbeGINix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 09:38:53 -0400
Received: by mail-it0-f67.google.com with SMTP id 16-v6so25364206itl.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 06:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n+ldMrCF9lYm6TEPVJcGCBuIAXyPzRv1+euDsS8qDuE=;
        b=au1iS4Ce6KWI1fwZWHwRrOQyXcfyt6w9mHnYAZLyTy+mwBj6ItaBsV68ycb3Qi5jfB
         eA89ILftP7AzGI2WoL6eApyC08sFYuqxIx5B7sEGXEIvIJJNPsV1Licpt1WNFdV5zRdO
         VCAgWPXMdeA1M8rJine1J4GuZVJsXvE7mE73Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n+ldMrCF9lYm6TEPVJcGCBuIAXyPzRv1+euDsS8qDuE=;
        b=OrWtDRtBB2sAsnc6TdL4zScH51eQuDrqr5pIvO4Y2NeAN8cMtoF0mZgOHcgH/HMgsM
         ESSVLr+1lwIhF7nHRuArSPnpxKk+HojfLmlBDYKvZJ040zx1cDbluSOe36dtSa2TD6M4
         4+rSr5AN7Mp9qgmQ55E3lJHmIeXmiIIXZJQ/u5p1xe+hskza5VuSGi+7LaaIulA3reu+
         czcNCDYHBFlKor2zAFPkuV7E9C5AE69veCUmAfBv1PosBb0z4rwBeEmcrWCoBxVKn27X
         nqPbBTBOQOZYlM83gsZjBAvGfX2kIDktbB6UcdCwGP/Q6Kp3rlbBtYPzUwxYDi+tDv8U
         jjEg==
X-Gm-Message-State: AOUpUlGjAPWL4cOk3o21286H7+QNu/NiBgYym8cWqWRai7V+bGhPVfZr
        cOEQQ6R+87BC+h91Jh4lWa39H3CaPR+gD8gyDrY8pQ==
X-Google-Smtp-Source: AAOMgpdRav9gV4wB9xwt8xjZ2ibNB4iOQZQp/26ldJDDCyx9tcBKzAszueN9dR7CcX8NIhxE+Eyje3hZcqJwaPMPec0=
X-Received: by 2002:a24:2c49:: with SMTP id i70-v6mr716529iti.135.1531143532821;
 Mon, 09 Jul 2018 06:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180705154452.GA32564@embeddedor.com>
In-Reply-To: <20180705154452.GA32564@embeddedor.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 9 Jul 2018 15:38:41 +0200
Message-ID: <CACRpkdZmv+_4B--J-RXfEu44bvQbq2yS0zei9uPYrtr+cBTxwg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mt7622: mark expected switch fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 5, 2018 at 5:45 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>
> Warning level 2 was used: -Wimplicit-fallthrough=2
>
> Addresses-Coverity-ID: 1463284 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch applied.

Yours,
Linus Walleij
