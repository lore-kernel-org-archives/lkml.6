Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048F0C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 12:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B605C20825
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 12:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iO0ylXDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B605C20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbeKQWmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 17:42:22 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35983 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbeKQWmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 17:42:22 -0500
Received: by mail-lf1-f67.google.com with SMTP id h192so18295825lfg.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 04:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Jj3foZTWOCTNIjxGEAxqGPTyZF/kyaPvnHcUB6q+YSQ=;
        b=iO0ylXDATNdBJQMXTcYdoQqIwCXAP9tYoJ4OxwMjrUPE8cofvO19zt26iMd8U3fKS2
         OZBBoNhA0vJxPk8vMPYX0nqGWzH+K+KhjF/PK+VLVOlrs/1ZLB7956QohU21UplP0YmR
         wKUMVeAKty7lo2RNFkmRIAVtQ0pk32ax1KWTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Jj3foZTWOCTNIjxGEAxqGPTyZF/kyaPvnHcUB6q+YSQ=;
        b=eidH6E12jjD98WAJtapvtag6n68YJWPx3V3pZ1TEocgEwfy9VV/t5GZyIjM1E7bpr8
         Le+3KQl5SzBqoJPgh9wSlISAG7OFys6436bTOoLIahffpXb+fzDTMFlLIp65ehEL/aBQ
         loCT6doQvnB95w138Ow8c9N/z0OPkskgGuFxjoLfmlnFK9swx7xEZVmrVSgnJ8sf0A5J
         XUwa6lkMKRGQLJ4SGidMSVfzTwnAfnETfLNCXJAakmgCdWKciJ+FUIWxyTr8r/FYsBdN
         HsaAfXwDeNyrFf0ce27Up5QRaXKZZmmzvieMT3imqjFDoVUxkr6wyOPmvhR2tPX2FFQ+
         2/WQ==
X-Gm-Message-State: AGRZ1gKjDgVBb9CtIHBZ4SxxJ1mLqMFxT2FuR0WoKpGs5UxtjcQlUW5w
        NnbFAt4c3+dGRPDCDMs6d1PP8BZXDHDvjjzVIWmxDQ==
X-Google-Smtp-Source: AJdET5c2hxJXh8scL8iU8LMQzZiSSUqtFmXpjsBWjqA4TduyoSqfP4rgsUmNGVnZBXvKMs0vdOZ0pC6XU+UVFnUJrP4=
X-Received: by 2002:a19:5154:: with SMTP id f81mr7767243lfb.96.1542457548834;
 Sat, 17 Nov 2018 04:25:48 -0800 (PST)
MIME-Version: 1.0
References: <20181112202553.1410-1-ctatlor97@gmail.com>
In-Reply-To: <20181112202553.1410-1-ctatlor97@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 17 Nov 2018 13:25:37 +0100
Message-ID: <CACRpkdZMnjuJocK0VjXD7WsP2VtnF3-0=Mu_4ENiVAx9nZ+F3g@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: sdm660: Set tile property for pingroups
To:     Craig Tatlor <ctatlor97@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 9:26 PM Craig Tatlor <ctatlor97@gmail.com> wrote:

> This was missed when tiles support was added in a revison and
> causes the driver to fail to load.
>
> Fixes: 9cf0c526bc58 ("pinctrl: qcom: Add sdm660 pinctrl driver")
> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>

Patch applied for fixes with Bj=C3=B6rn's tag!

Yours,
Linus Walleij
