Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 22412C5CFF1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 00:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B1A2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 00:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4ZLoo7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B1A2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935040AbeFMAxA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 20:53:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934717AbeFMAw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 20:52:58 -0400
Received: from mail-it0-f45.google.com (mail-it0-f45.google.com [209.85.214.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BBEB208B1;
        Wed, 13 Jun 2018 00:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528851177;
        bh=DJ47oRLREspzrb52mw0mFNOtP/a6z8C5+y1q4OIY9AU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=N4ZLoo7erWyTlMquXug9hRMhwF+FOgcKYcqJ+84sWF2r4bfDEiwzPFvhLBYWCmrxU
         /iePBgLYI+Xr0tMkBRj0wp3KoPPg1/OgZBpIRM1vWX2SqIHPmYyqWe0ihMf0R9qGl3
         V4/a08lsUhseyOanM6Zk1YOKZsV3nbjQBrFm9uDE=
Received: by mail-it0-f45.google.com with SMTP id 188-v6so1704077ita.5;
        Tue, 12 Jun 2018 17:52:57 -0700 (PDT)
X-Gm-Message-State: APt69E0C3kbZAto2MJVa6LcjGBlYxxjrEQ+t5/A9gPvlhjQ08/CYFQn/
        8eReHaFh0+6lPTX8Zml+rNPXQBDSJUMKNx/s0Q==
X-Google-Smtp-Source: ADUXVKIyiuGQdjq3fBBnYmCMNR9cNjDBBTC4TVc+re4j/vc79hulMEKQTkPK07X0DEa6FJomZPjhSSP46/rfrvJ6FwA=
X-Received: by 2002:a24:798f:: with SMTP id z137-v6mr2585881itc.19.1528851176865;
 Tue, 12 Jun 2018 17:52:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:6403:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 17:52:36
 -0700 (PDT)
In-Reply-To: <20180612230604.137880-1-swboyd@chromium.org>
References: <20180612230604.137880-1-swboyd@chromium.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 12 Jun 2018 18:52:36 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+=JUyc9dzKFDSbQN7_3-M=EMqLoqy44+x9=HHt4VebAA@mail.gmail.com>
Message-ID: <CAL_Jsq+=JUyc9dzKFDSbQN7_3-M=EMqLoqy44+x9=HHt4VebAA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: spmi-gpio: Add pm8998 and pm8005 to binding
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 5:06 PM, Stephen Boyd <swboyd@chromium.org> wrote:
> Update the binding for two more PMICs supported by the same driver.
> While we're here, remove the duplicate pmi8994 lines because that
> support got merged twice.
>
> Cc: Rajendra Nayak <rnayak@codeaurora.org>
> Cc: Vivek Gautam <vivek.gautam@codeaurora.org>
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,pmic-gpio.txt          | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
