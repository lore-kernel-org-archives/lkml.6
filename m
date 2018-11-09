Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2B7C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C9820827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvUr5ANp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C9820827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbeKJH3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 02:29:36 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44189 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeKJH3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 02:29:35 -0500
Received: by mail-oi1-f195.google.com with SMTP id p82-v6so2703011oih.11;
        Fri, 09 Nov 2018 13:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2IGN/I+TlmCein6bw4Ys33AF/IgEGt4cIR5yI/8ZJOI=;
        b=SvUr5ANpIlYrs3dxRjC6VQEKp8L6g99qY64tlIAvHi/4d4/KgnEXbJJkJhgixlMO86
         iaJuBdy+lDR+45g+k/12t0DhIxpuew64SFnT3DhNHNFKB616YoxD6Qb4gouRypGyQjvg
         khVyTMvyjRC4J6k9gsCAFqWpWW3oGmFJ3rA+K0laIev+A5Rn64yhdNynngP6afI6V+Ec
         0tkRd2zRI0OOvk0S3ESAOQLl06vM01sa9yqwZCjYh65rwkx7j0fPsjVqdISXkdDtg8ye
         sl2+h81fvTXBOCFrXxhjTi9FlQemmcFx5uCTvCDsG0Z6Bjcr401pc+EzCYX4dJbxQrb9
         Y3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2IGN/I+TlmCein6bw4Ys33AF/IgEGt4cIR5yI/8ZJOI=;
        b=WpwFxDHdUELb05wR+3DZh2jYfrmaeoFdUF+dOyeSV6PpI9WATJcDcD4hDm1giagGMZ
         MoZvRZqSJzS3pryTNZrE+naVhc/ZpMEaP2dRFDVJZy9ABaBG/uH+4LUGR8UHaBG61zDE
         TPy3YO1JkPDLG/1axnkJli8DhgzmLSsZXebZ6ItDYvWFJrotne45lUBkBmD6MQEffzet
         zigswbkOQPV+LAcKkUXpZ+o0Zj07ivo2dTvfpPkJ/J28Ln3DydSJs87vniCe/jDS98wv
         +fxnC1domSRqy2JYk32kWel7ux1pH00/eCfskRS6h7H9yPMT6ayKn0TR5IBM6qqr5iFj
         oRxw==
X-Gm-Message-State: AGRZ1gIkHXtCcxVeuAiC5Y8AEoQvOdxEsDJhYOXnwt/WPTFmKHFN2b30
        /ZgeVxyaI3rf391i9R5hYK2eic9IayP1KWG6jhJq2g==
X-Google-Smtp-Source: AJdET5caTjSlEh9coNcZLwGi9fNG52GQAmtnuRysoX14gMY5JHaAKSpCXmI8ag6RLqQtc4B8BSKYgIjEufZSQbMtDmk=
X-Received: by 2002:a54:458c:: with SMTP id z12-v6mr6073835oib.297.1541800028237;
 Fri, 09 Nov 2018 13:47:08 -0800 (PST)
MIME-Version: 1.0
References: <20181104155501.14767-1-TheSven73@googlemail.com>
 <CAGngYiU+8k4ZHYhFVQGKXW8mATEDi64Mi9PsVkX-5vn2PCY3ew@mail.gmail.com> <CAK8P3a1STE+vN_yF0Zyu8gGX_KCWZEV=muPxVE6M1EUqdhO4Pg@mail.gmail.com>
In-Reply-To: <CAK8P3a1STE+vN_yF0Zyu8gGX_KCWZEV=muPxVE6M1EUqdhO4Pg@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Fri, 9 Nov 2018 16:46:57 -0500
Message-ID: <CAGngYiWtmHPShpbLOj4qYJCe6PvNT7ZUDd-0jRsRyxD+HWbByQ@mail.gmail.com>
Subject: Re: [PATCH anybus v3 0/6] Support HMS Profinet Card over Anybus
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sven Van Asbroeck <svendev@arcx.com>,
        Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 4:22 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
>
> As usual, it comes down to the user space interfaces I think. Designing
> a user interface is hard, most importantly because you cannot change it
> once anyone starts relying on it, as opposed to implementation details
> that you are free to change at any point.

Thanks for the feedback !
I will rework v4 so it uses a userspace interface shared with other
fieldbus drivers - uio.
Let's see how it goes.
