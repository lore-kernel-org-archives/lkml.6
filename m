Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 01460C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9071208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QtwvpP+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9071208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755216AbeFNLhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:37:08 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:37151 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755171AbeFNLg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:36:57 -0400
Received: by mail-io0-f193.google.com with SMTP id s26-v6so6806514ioj.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 04:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QJE2WKaMiy8XGYH1BEOdK+wvmjesl2QZDcHAaHB/9NQ=;
        b=QtwvpP+kh+/RsrtbfOESyrVWpOY9anc6276VJ/MwTGxV7cfuuHLKke58dZzP74lWFy
         82CvnvwJcg9asSBc1ZUmpIPOpfxXhaJSNoRp42JP5ZtDVGmNdCKLVvO/pNh6wTAaz0hV
         wlvGz8hQQieZbncS8wkaEPz9LpKBSA5A57YRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QJE2WKaMiy8XGYH1BEOdK+wvmjesl2QZDcHAaHB/9NQ=;
        b=HsBHscqq0OklYdQLs9VyyhuHflXSH7axavnEJsYEH0y1iAqmlpoOKWzFguFpxzb1Db
         z3NpoaoBkTIamsbu2a8gA6e1CTDyEFngCKUqo1f2BcAOy/z1n0ts1222/NnzRX4AzRp4
         38JdiY45lA8F629fTYk8FjPtSh4MO+MmSYowp+/S2eaq6tMxaZZ3begBfwGhC+erDBjQ
         N9fcqCBhACcKunRWXNJMBqxtFYKWetdzeBYGHVeyYc09qZmeDSs0n/zMa+QU0gU7RZkq
         zq2joEIySgeVja6X2qZSqMspI6UkJ+FXUmmsYpfehYvmQ6m37XXIPSef2Koxzk1iygsL
         bWFw==
X-Gm-Message-State: APt69E0+QEEflDI9LezO8oMpmzRlvSCeC44tr1AyBiL1u1B0FSpkgTMP
        /5AaxnxdgQhAoWmDMK74dtZyCJbBv3e8ei5uE0CXRw==
X-Google-Smtp-Source: ADUXVKLg4/mMxgmgiQNEIW8R51ou7hoCvUBM2H9U6ICGiGu9icCyXTwBYWNF5fNfh7I8jR+IYMBDod+knx2SGzKoJ/Y=
X-Received: by 2002:a6b:1902:: with SMTP id 2-v6mr1921132ioz.304.1528976217005;
 Thu, 14 Jun 2018 04:36:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:78c9:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 04:36:55
 -0700 (PDT)
In-Reply-To: <1528861237-24254-1-git-send-email-j-keerthy@ti.com>
References: <1528861237-24254-1-git-send-email-j-keerthy@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Jun 2018 13:36:55 +0200
Message-ID: <CACRpkdbLj7SjrWjCXYVbr8sh6XWwrv_yYA5ViOe-LxQib-dLeA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] gpio: davinci: Shuffle IRQ resource fetching from
 DT to beginning of probe
To:     Keerthy <j-keerthy@ti.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Tero Kristo <t-kristo@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 5:40 AM, Keerthy <j-keerthy@ti.com> wrote:

> This is needed in case of PROBE_DEFER if IRQ resource is not yet ready.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>

Took out the previous version and applied this v4 instead.

Yours,
Linus Walleij
