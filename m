Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13891C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A012084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="nOlliuJ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A012084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729520AbeLKAQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:16:40 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41657 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729416AbeLKAQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 19:16:39 -0500
Received: by mail-qt1-f193.google.com with SMTP id d18so14511893qto.8;
        Mon, 10 Dec 2018 16:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lUA5hrXlIPzcqsAb57iWBPxcQU9q1UY/9t3+Q87F8rI=;
        b=nOlliuJ+36iQuU8OyLbis31HPU/sb2nLYzZ9hHzDOEO+u3XNUw8OTtydijAS91iocK
         NVK9TbvC7l5Bv7TvIES2Udpka9zWj4NDapUkl6cyR/D4Q36JHN8icbA3+sibTHfhzp4+
         38gZ9A/Q/SQ/V2iEIKhUYb7cbPOmfyJpEjdMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lUA5hrXlIPzcqsAb57iWBPxcQU9q1UY/9t3+Q87F8rI=;
        b=N8Hki/SDprAvprth4OAr+KZ4wOVM1CY7Sj/NUFcET4G7nIFP9e6yquvFp3u9glNfRZ
         ht/54xKCzVRXERtzynd+0xwDxdPAa4Qq75pedyurF8HdWKe3gaG26fVCZycVXfmsJmF5
         7lvkTJJUuBjsVUU1CbOwh5L3HG0+mvcsIxpLoXDNnzEC3oOFZrPMmEwRC+f0bkCyg71J
         MFmt8cC6FeYGXaID+qzDs7xSmYuisptrcp++jamchzgBepUcsGzoUGctXMKpVznAjlpE
         dYshXnu6sivBhdzKj3SeqUirinIt39bef4CwSSkEteX58OMae2XU/4mMzYzb1e74aU65
         13Rw==
X-Gm-Message-State: AA+aEWbO9rQuYVBSF+GehfDpM/XqVazRWL2tk77VLnGYDhC0eWDeg86W
        JIMheql9JQ/COHp656CYvpP9hNf9qHHODk2a9mA=
X-Google-Smtp-Source: AFSGD/W2IxTQZWkg3O2ArVt75llI5ya9ZbFYqNdFskY03Mlejkj1bvvwc4EyOowziXdz34nBySd29IrMvlnrpvG583s=
X-Received: by 2002:ac8:29b7:: with SMTP id 52mr13878203qts.266.1544487397841;
 Mon, 10 Dec 2018 16:16:37 -0800 (PST)
MIME-Version: 1.0
References: <20181211000506.7559-1-natechancellor@gmail.com> <1544487006.3301683.1605247720.567E9685@webmail.messagingengine.com>
In-Reply-To: <1544487006.3301683.1605247720.567E9685@webmail.messagingengine.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 11 Dec 2018 10:46:26 +1030
Message-ID: <CACPK8XfxQxMqLo10FSRPHdUVt4vr5K32xB2C_SXLAPEza--v0w@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: aspeed: Wrap -Woverride-init with cc-option
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018 at 10:40, Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Tue, 11 Dec 2018, at 10:35, Nathan Chancellor wrote:
> > Clang does not support this option:
> >
> > warning: unknown warning option '-Woverride-init'; did you mean
> > '-Woverride-module'? [-Wunknown-warning-option]
> > 1 warning generated.
> >
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>
> Acked-by: Andrew Jeffery <andrew@aj.id.au>

Thanks Nathan.

Andrew explained to me that this warning helps find bugs when
developing the complicated (some would say crazy) set of macros that
this pinctrl driver uses. It would be good to have this warning
available in clang. Do we have a clang issue opened for that?

Acked-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel
