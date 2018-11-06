Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5CDC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2684820685
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fn2XVbW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2684820685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388704AbeKFXhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 18:37:32 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]:37940 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388477AbeKFXhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 18:37:32 -0500
Received: by mail-qt1-f179.google.com with SMTP id p17so2693227qtl.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 06:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u8YeZjL9QrbUMItsTM4z0v7b/i6G6iNYAzJikPQpqSQ=;
        b=Fn2XVbW49f2xKrS6dmPG2qBoA9TOkQ/64GWqzDKAC6lG701Y1OFin+DiX6XTi7FZif
         AbVc6cktfgnB6hhDwdwGLpBJ0gwfOedsz5/Pou3LM2svAVDYlEHKsDR6KKELS7QiujBO
         WaDNrT0W0bnsHkJTDa0x+9aa8g+UvelpkSaJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u8YeZjL9QrbUMItsTM4z0v7b/i6G6iNYAzJikPQpqSQ=;
        b=gIVgSxLKkDdR+RhROkRlXWjE3qgLf11yJcyB7rQUXScORvu1zeO6X0CVE23RpPRDfh
         4hqYp1ZAxSLo4fSTipscasy2tXILk9+Eb7Ut/T35gVQc66CPKRrB5txNAPXY2S+lpG5I
         WS50h2l/bZOa1WqQUS0te/exXwPH2r5S37hOA3X2b+QcupkSfEGBrFuPQZ2QIqhmS2Ap
         rxIO0X9e/qnVa8tlPj3q/rG4G5+XPDkq44Xzv/eecvfxYbUF37h2B0sZT5hgejT2+O4Q
         qF6E4F7e4meM2eHuyeHUU06OFeEaKfJOeNYprWaHdIC0MyvGx1BhZ0zzqU8ZF6l5zGy/
         FCWQ==
X-Gm-Message-State: AGRZ1gKumFa6VcNXEqnKn1YrcQSSK/ExM5ecbo1l9pY6QW7XgMXKb3Q9
        YeAvDwhJ5QjfxPVLBpU4IgMNLYpXcONZO2HZ6OQsizoAugA=
X-Google-Smtp-Source: AJdET5fgFqh0Shi5xrWnLdsmFfRI8g0Fdxd/HLNvxovM6TcSsOvmvWwKN/Mq5MZC9lezGgpU80hNBhpyaHEG+Wq7P6g=
X-Received: by 2002:aed:32c1:: with SMTP id z59mr1235794qtd.123.1541513526350;
 Tue, 06 Nov 2018 06:12:06 -0800 (PST)
MIME-Version: 1.0
References: <20181101.115119.343759554267818330.davem@davemloft.net> <CAH+k93Fyj_wo5sTmd3Vb=V57w11PUGuq9X6pM35Ph_oYqcROLQ@mail.gmail.com>
In-Reply-To: <CAH+k93Fyj_wo5sTmd3Vb=V57w11PUGuq9X6pM35Ph_oYqcROLQ@mail.gmail.com>
From:   Matt Hart <matthew.hart@linaro.org>
Date:   Tue, 6 Nov 2018 14:11:54 +0000
Message-ID: <CAH+k93FCQZ3GX_g4yDodyz30Udg9ZGu7bk+oDvBrDXKYJ6xbPw@mail.gmail.com>
Subject: Re: PLEASE READ: kernelci.org bot email problems
To:     davem@davemloft.net
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Nov 2018 at 13:55, Matt Hart <matthew.hart@linaro.org> wrote:
>
> On Thu, 1 Nov 2018 at 18:51, David Miller <davem@davemloft.net> wrote:
> >
> >
> > The bot@kernelci.org emails are being bounced by vger.kernel.org
> >
> > The reason is that there are always syntax errors in the SMTP
> > headers.
> >
> > Specifical, the From address is:
> >
> > From:   kernelci.orgbot <bot@kernelci.org>
> >
> > By SMTP rules, when special characters such a '.' appear in
> > headers, the string must be surrounded by double quotes.

We believe this is now fixed, could you confirm?

>
> We mostly just rely on gmail to deal with this, so it's pretty
> disappointing to see a malformed header.
>
> >
> > Can someone please contact whoever maintains the bot so
> > they can fix this?
>
> Many thanks for the info! We'll get on this asap.
>
> >
> > Thank you.
