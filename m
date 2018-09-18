Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F174ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BEB206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BZNwD8Nl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8BEB206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbeISB1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 21:27:51 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40020 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728657AbeISB1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 21:27:51 -0400
Received: by mail-io1-f68.google.com with SMTP id l14-v6so2590955iob.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 12:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VjYnkbmR1Z9NYRQCtEbaSJVib+5z4bPly2Q7QOe/Hgg=;
        b=BZNwD8NlNpxwXZGiR5347+NQwWZL607iJ0I+JLD/66e/do0A7jop3hl4+OvteU62BK
         mFOEe9sNPVOjTNdQs4P8yJ2q9RPx8z7rfj7WwhwhsrN0IITOEaF7p7v5i1fE1misUnQJ
         mo90h0Sjq6s8v2bwIPGGr0M6Cp0SI2U1Wzn3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VjYnkbmR1Z9NYRQCtEbaSJVib+5z4bPly2Q7QOe/Hgg=;
        b=Q+F8aVvDIApBAPXwGJdJ48werYN1MFyaHFmoaPB7TtAP8HmIoU2PVkq2SvjsnQZVUh
         oNzNCOKima7lAZ+kRypXT5tt8JgSowiWuTE6xphjXjf5b3062H37krDkuF8sco+xOSLs
         OKjNDR8qmA0kXQBwZNAUanLaoAKUBqpnKx0h+9uWHEkTHl5ewsh18vAHB+8Jp1sjpoOs
         8rOm75Dv3fewBWNCrYYQ9AlRU87kCiH6gXWvTHDuWJc2TW9hRgMnoYiCEa1LYY9iUf1V
         jLH1YSfnS8YqDd10+P1WzpXfq2KyP8Sq18nPY8VvJHJTxIqjTaalc3iN9udCcEngIM3F
         OfwQ==
X-Gm-Message-State: APzg51AJbd3xk9sqLfXRecnNZdMoX9J6mT7UXjyjApZCBzsnwWxiT07K
        /jaE7Ebx6I6BCci/X0toYtEbgo4aauEBdhWQ2oGpcw==
X-Google-Smtp-Source: ANB0VdYwGal6rjz2AA2y2fKEx967ARiiMOkU/bi8NJ6VbfQr7wWrFd6V8apFvVkDIq6lD30AMBb3MxQV1cELcL0yIV4=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr26036977iof.304.1537300423661;
 Tue, 18 Sep 2018 12:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536404280.git.sean.wang@mediatek.com> <f7d9fa1721c8d75509682a20c014ceb461495f1c.1536404280.git.sean.wang@mediatek.com>
In-Reply-To: <f7d9fa1721c8d75509682a20c014ceb461495f1c.1536404280.git.sean.wang@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 Sep 2018 12:53:30 -0700
Message-ID: <CACRpkdaRy9xmqX9F=fijFoa19UkUG9xd0=uZhawmz-e2jhhTfg@mail.gmail.com>
Subject: Re: [PATCH v2 13/22] pinctrl: mediatek: use pin descriptor all in pinctrl-mtk-common-v2.c
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 8, 2018 at 4:07 AM <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> all use pin descriptor instead in pinctrl-mtk-common-v2.c for the
> consistency and extensibility.
>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied.

Yours,
Linus Walleij
