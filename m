Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A6BC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA2CD27496
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jeVARlrl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2CD27496
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966460AbeF1NyU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:54:20 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37573 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966365AbeF1NyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:54:18 -0400
Received: by mail-it0-f66.google.com with SMTP id p17-v6so7702416itc.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 06:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cXOFUcwBtf+Q8h7jPUtDtzhouDPlPenCkja0r9TU+Jo=;
        b=jeVARlrlgYxlZx8CV8T10RZ2jKxcUzoFHcUN7xs5kxxipHuO5XthEGHq18qFmauZLM
         5r0gtFOnDFVPhSQpE3HwLfBlmKSFmIln0j90qlgTiaUkW9mULXEvKmjCXasnpqj4r9lW
         XBecYER1pjedVRIvBKCPIdNS595Mzx1o/qhxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cXOFUcwBtf+Q8h7jPUtDtzhouDPlPenCkja0r9TU+Jo=;
        b=cyVfsa25UUbjL90mOO3vkQ7s46T/+cU3QoZMc4xk3ZMb5pqs2oteBBDlvIHrW6wuw+
         LnUYfe/lk5aUUjYsu/B9qLwaTxz4sTHpCn/u9hVm9Un5VsqdYZKZI0eVEOtXy5D07/eH
         V/hGRcZ9T1NRUh3TwD6kjvnlaYd9wAgUBlXZC+1jwjmlz9RwAuCAMKyPEeUOCwxYAuIa
         B2RDIcLPwrjXZENLTKO8eyOpqo9daP9SorzbeC8hUGcxnWGJwe/Dwm1IYX6q6wREKFoA
         pLNDmmOSKns5C3RlcBY0sifMDilIvgNwZ7Y3M20SZgAMzEQ/N2HyTHgWOPsJo57DF1JQ
         O5bw==
X-Gm-Message-State: APt69E0Ohd3Z311UsZpQX2kLJZpW757TxGlk8irelUOSEWNZJd5LYArB
        BTgYiWuzdI3atUwgQbWdRsAtAJRrbsw5sG9uXshgdw==
X-Google-Smtp-Source: AAOMgpdxQecUt/jjHsIrpbm5lbKl/SaA2eX5IhSCKqdr6Pnr0f1CHGMFuv2dNm+u+bSEGwyq1Bz/Ub8DA60Hgu3Y9Hs=
X-Received: by 2002:a02:c006:: with SMTP id y6-v6mr8870120jai.87.1530194058207;
 Thu, 28 Jun 2018 06:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180619093126.74060-1-tony@atomide.com>
In-Reply-To: <20180619093126.74060-1-tony@atomide.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Jun 2018 15:54:06 +0200
Message-ID: <CACRpkdaV84wai+ie1D-t=j+RiYNvKJUvjA8g-zvGhMZS2dBuEA@mail.gmail.com>
Subject: Re: [PATCHv2 0/5] pinctrl fixes for generic functions and groups
To:     ext Tony Lindgren <tony@atomide.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 11:31 AM Tony Lindgren <tony@atomide.com> wrote:

> Here are fixes to the race issues for generic group and functions
> reported by H. Nikolaus Schaller <hns@goldelico.com>. I have not seen
> the issue here myself, so please test to see if this is sufficient.

It looks sane to me, it'd be great to have some Tested-by: from
H. Nikolaus, can we get that?

Else I guess I just queue them, but if I should queue them for
fixes it'd be great if it actually can be verified to fix something :D

Yours,
Linus Walleij
