Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B29C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07374206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JyyuS17z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07374206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbeISB0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 21:26:52 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:52418 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbeISB0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 21:26:52 -0400
Received: by mail-it0-f65.google.com with SMTP id h3-v6so5067409ita.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 12:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R7jnvBy8cnTm7W0veOHNACdJsxUaYd972WmYVZvWrE4=;
        b=JyyuS17zedHi7Ep5M74cv4M7MNXzkKsv7Y/glkzuvjpgEHTjYvyDdFsvT+RwUB4C/S
         9m468UE8eaUMOZEyhGMTN+DedZjE0ZKmlDnIjax3ymrC4t5ZB2kELwILwe0dQ941cbAW
         FUEPO9WV1qW0lHCL+RqZ8by0lPGpBh8ohW8zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R7jnvBy8cnTm7W0veOHNACdJsxUaYd972WmYVZvWrE4=;
        b=VIMI5ZJPPAsXHuAiR9IJRPLHH/pL05+DWnbtX1O4aU5gA9PX/HJlD0ekxghgN4q6cN
         X44S72B8D4mGm+TIZrfCS5Uemjfmb10x9QqP23zO4dXmDN3n1jUNoM8hsI9kSc4cKD4p
         OqPOZYGfRBNNgiatQWHik37Xudy9PN+Pc23bSMjhRutkDXR9ZY2dNa8UJYxhKxGksfJp
         gxnKnr7+tXi0noFZkPyLXNRjrdkX6y4R4MwM1p4QTKKRIIUEU92eLLQv+SjljlSU+yan
         OpS8tEbfuTvU2i/JHJevDFMbSmWSm+y7elT13olWUuGIE6gEjWMMcZzKOITwVmfehc2j
         eT4w==
X-Gm-Message-State: APzg51D5dP766fkO+2ZNE50a3RAyCu2KKe8V96JV9vFzhVJdXfN5b3go
        nXlYF7hCQIxKd/6Gl1DsyXEGVkbb6cO8gIA2qhuh5A==
X-Google-Smtp-Source: ANB0VdbMxIBZslkEyZeyoXQ4U01gq9xK4HOAqbBhH1DeWbU33IKtrRww47YHaxxfbf5All7Jrs4pymqtPyj9a2h+86I=
X-Received: by 2002:a24:9d84:: with SMTP id f126-v6mr18605187itd.130.1537300364472;
 Tue, 18 Sep 2018 12:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536404280.git.sean.wang@mediatek.com> <fe864a4557632eed07cad3727b1b180504d86aac.1536404280.git.sean.wang@mediatek.com>
In-Reply-To: <fe864a4557632eed07cad3727b1b180504d86aac.1536404280.git.sean.wang@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 Sep 2018 12:52:30 -0700
Message-ID: <CACRpkdbi7jgCnmuG3k-suWiH3=NjkT=2xECEcS1uOMtuXsJ93w@mail.gmail.com>
Subject: Re: [PATCH v2 12/22] pinctrl: mediatek: add MT7623 pinctrl driver
 based on generic pinctrl binding
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 8, 2018 at 4:07 AM <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> Adding MT7623 pinctrl driver based on generic pinctrl binding, that is
> good example and demonstrates how to port any other MediaTek SoCs
> pinctrl-moore core when people really would like to use the generic
> pinctrl binding to support these MediaTek SoCs.
>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied.

Yours,
Linus Walleij
