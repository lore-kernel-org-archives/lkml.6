Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD44C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A64A20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LozelMFP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A64A20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbeK3WFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 17:05:50 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36169 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeK3WFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 17:05:49 -0500
Received: by mail-lf1-f67.google.com with SMTP id a16so3785569lfg.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 02:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Et1b/qyS83Tt3+WZK9m0GQyvQi7hqAuYI1kow5m6Cw=;
        b=LozelMFPCyOeQdR3Vlq/V3KUuSi9qqLIOnYniybEg0bv1VcpfrH/ZIlg7stZbNg8Hx
         jb86Id1Di6utDZYoqEE806A+ppn1USCY3M81FFPJzDZxxYSE/A9yc79PW9WdMXAwA7FZ
         E9RkPk5NHQizltAzGguPycZsRl2FrVunhKAGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Et1b/qyS83Tt3+WZK9m0GQyvQi7hqAuYI1kow5m6Cw=;
        b=ljlbFazPN1KDms7qW0vibWJaRQFT+lh9tkKB5Zk90LPKGuBIWyCidMRbgAjSBqp4+m
         Yn9vZWMznH9PXHDwP96n79Gz0U2wXG+Uh+cy5fnUAviehuOVKLsqvyen52MP5+BgC5Vf
         gptxjKKkLwxsSbLPTCYt+8FoiHGE8d70S7l0F2dsaXrwGZg3WOu+vx8XAKphhHAvY+m6
         C6VWn29T2+NDEjMVbmic2HCQQS560i9AbkyRb8CQ4uoLabZRfFVXSn3DlwFopNoM9N6V
         ChazciLrbLLUgBtUdjzPgeBhhnTV9CHd1+MdgBrkK9fUaAjmUpKfYDnbVhxCWgdk5xlB
         jDeA==
X-Gm-Message-State: AA+aEWbd9YCa/PdWhgOpUwbiDqguy/Ia2Uc1flVzXJNp0eOjIVF/UBzc
        xwmy5iDxA3zSbCT9C+7DmE+urye5LGTRaipyd2rghg==
X-Google-Smtp-Source: AFSGD/XOkt9VCwlPA7+DM9fNRiz/AlO0mHwWFJaOZykKlEAx9x/tnrkHJXRo4JFta2tukWGLc+5JWIYrMLQ1SIbHuWI=
X-Received: by 2002:a19:f813:: with SMTP id a19mr3232655lff.67.1543575414328;
 Fri, 30 Nov 2018 02:56:54 -0800 (PST)
MIME-Version: 1.0
References: <20181128104350.31902-1-linus.walleij@linaro.org>
 <CAMpxmJUsAccSKELNxn6DEWO6_3aCbzM=hZyaXUCr30S0-Eh0mA@mail.gmail.com>
 <20181129190132.GM2089@sirena.org.uk> <CAMRc=McApz-8qUo9SiqZgYXor4_DkBRY61nMhiFQ2QSSBj6gWg@mail.gmail.com>
In-Reply-To: <CAMRc=McApz-8qUo9SiqZgYXor4_DkBRY61nMhiFQ2QSSBj6gWg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 30 Nov 2018 11:56:41 +0100
Message-ID: <CACRpkdbmruqLOwRLikUq2RiY927W_Evq83zdMtGY9S1A_i4E_Q@mail.gmail.com>
Subject: Re: [PATCH 00/10] Regulator ena_gpiod fixups
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 9:35 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> At least we could document it in the code.

I've put some comments in my patch set, I will check if I can add some
more in the less-than-obvious spots.

Yours,
Linus Walleij
