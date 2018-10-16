Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99607C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D4C20881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GGExXRWK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D4C20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbeJPPtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 11:49:43 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45562 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbeJPPtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 11:49:43 -0400
Received: by mail-qt1-f195.google.com with SMTP id e10-v6so24604572qtq.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 01:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z6fa3MH7oMec2hDGhqIsewHQTweOGEE8myYBqzG5zJg=;
        b=GGExXRWKDrlErvxQaEz1ngwI8xVKHEOC27+Qn3M9dgZHJCIUvktJ0cPHXBcEO5HRoZ
         4NQEAfxNijZtsSd08wwMzg6tcUtEq0ROvzUjzAo+jHqAlHwQOlu0LdVEDu0cBfjaGlIl
         MU3bsOhLTDuhpP3DolJRGV8RR6XtbUI0F4JuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z6fa3MH7oMec2hDGhqIsewHQTweOGEE8myYBqzG5zJg=;
        b=hpXqRNGrLqsU5UBG4pZ93kW1CV98B8braZTO9lBRPINtLzdyp+54zUvKNet5O0zG49
         1glv1tt1cgxlJ2E6Jk+REMXQmdbNPS4HOEqadRtgl4n8BCQVJpt2RJP2DQ1/P0IE04/6
         hbkUDSir2/035zmAH+LnX6BXjULc+64oW1mLTkR23Htvjj4Xltvibz2HGgbgQAF2rCkx
         zpgVr4WaqzdRK3rqAt1f0x6RR+7CJu5XWt+kAoZ17/yjKHwUZ6G5OJ/Sl8SGUV8egTwB
         Gofe+mKybeyhkvAO5TcYdChfE8jhPXTgoQeFErnxA3Qw/qnTSKA/KsG9wLw+pfVadD1l
         X9Qw==
X-Gm-Message-State: ABuFfogb5My+OsyZJEdUxVDYmueNNSanOpnd6niIKX1uhqeQP6t5a0qu
        3eUKgUZ5Gt4I+qyhQsyp8w6bj3PKJAwTH35o5uqJHg==
X-Google-Smtp-Source: ACcGV61pCgRUq6qiOhpr3r6KcjO3I1hJ/Y4VYLWEgqROf3BA0xvMVbLj9JOgjDnrbhdWP3S452dmSQrsVdrdtFCBQhs=
X-Received: by 2002:ac8:74cc:: with SMTP id j12-v6mr19144814qtr.358.1539676831302;
 Tue, 16 Oct 2018 01:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20181015221629.13924-1-stefan@agner.ch>
In-Reply-To: <20181015221629.13924-1-stefan@agner.ch>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 Oct 2018 10:00:19 +0200
Message-ID: <CACRpkdaVGKLtE-whhK3oFgY+4xoy1JqWkcBW4UO0-hJs2B-QGg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: copypage-fa: add kto and kfrom to input operands list
To:     Stefan Agner <stefan@agner.ch>
Cc:     Russell King <linux@armlinux.org.uk>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Joel Stanley <joel@jms.id.au>, Nicolas Pitre <nico@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Roman Yeryomin <roman@advem.lv>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 12:16 AM Stefan Agner <stefan@agner.ch> wrote:

> When functions incoming parameters are not in input operands list gcc
> 4.5 does not load the parameters into registers before calling this
> function but the inline assembly assumes valid addresses inside this
> function. This breaks the code because r0 and r1 are invalid when
> execution enters v4wb_copy_user_page ()
>
> Also the constant needs to be used as third input operand so account
> for that as well.
>
> This fixes copypage-fa.c what has previously done before for the other
> copypage implementations in commit 9a40ac86152c ("ARM: 6164/1: Add kto
> and kfrom to input operands list.").
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Please add:
Cc: stable@vger.kernel.org

I am on deep waters with ARM assembly, admittedly. So I wanted to
ask: OpenWRT has this cache patch:
https://github.com/openwrt/openwrt/blob/master/target/linux/gemini/patches-4.14/0001-cache-patch-from-OpenWRT.patch
I do not know why (sorry).

Do you think that patch is actually a hack to hide the problem
fixed with this patch? (OK maybe stupid question but...)
it appeared anonymously in OpenWRT with the commit message
"add v3.18 support" at one point.

Yours,
Linus Walleij
