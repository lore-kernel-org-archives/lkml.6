Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A95C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269402147C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zDQT/cTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfBTJvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:51:31 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41961 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfBTJva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:51:30 -0500
Received: by mail-lf1-f67.google.com with SMTP id e27so17082218lfj.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 01:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gA4PtPu29VMduZLWI8wAkpnW9tpbGCSN+/USs3P4Dh8=;
        b=zDQT/cTs7le4pbjb7ndRvAHcsEhDOE9yaMqAeGVVidbzJVagMZIhxp+hhF24YiC5yy
         n/o2/VAS9qfW6SswaXB+oQD/xetX+piu3KoTFv9sh8vOJ86y3M9p5JbO2Rjs6yT/2bEa
         dq0lhdW3irnau0SGgKJBttQvW8bHSvbDDcLfS0vFYPPdif98vHsVP1kkq6nAfV8pIdKI
         R36FtP0HZoH9aHiRiD+WQA5Uiu9i4bjPigk3f4mF092+l7b27cqHsxiOn+A1p5z0Qddz
         ggTjHhDFKJd+YstblCdFnBFRYosvpDQkUt24ybSdALi1NZDuwNB3W0widnr84O2oTYjj
         yVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gA4PtPu29VMduZLWI8wAkpnW9tpbGCSN+/USs3P4Dh8=;
        b=Mcow3rdYs/gk2RGidU+ZKbWwHn0b5p8CEND7bFa9I9/a0FrAE76vFKBSSIJpNT3JrS
         8FZeaaclnBf5ZipJwVWz0uPK5mjFUdCt/ln5Z1M0WY+e2VebAfLs+vxcDw6GWv3xiJGi
         XUFKj96ejCgDtd/kw3u7tGAp0a6IpGEmkuLtDhyMpSruH9hJaCBIsiEtivnfy6E8ywj7
         3QlsnKP+s9RwuCdhqHOkHds2ZvV9ZAmWrBJF1m7xIf9BWRX6jGYAZcxMpQE4btWLfz7o
         PfpaT5WNS6AlF1itQGEw4eb379UyIZhjwdM20bIhkZZf3IJzA/P3LSZJGj8wZ8JXP26w
         x3pA==
X-Gm-Message-State: AHQUAuYY1EYrzo1WtIUDsZTP1m4cz9MIckvl5aGiZh7es5QeLQHzCyUS
        doOGZcMIKVgrO3svauGZO4eW8ufhZRHGpfIVzwAHpw==
X-Google-Smtp-Source: AHgI3IYzm2thzCybr9YbN7FY1LAUp7eSZ9GMsdfWH99Z1tMmDbwZ2iOpO6o9CoZrNHGUBjSb64M27FQ8nkaLfuaQF4s=
X-Received: by 2002:a19:ec0c:: with SMTP id b12mr20906063lfa.27.1550656288596;
 Wed, 20 Feb 2019 01:51:28 -0800 (PST)
MIME-Version: 1.0
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-2-git-send-email-rogerq@ti.com> <CACRpkdamWQUW_O+gageB4Q6XuBg+t-h+eW1gpor7_DHvx41j=A@mail.gmail.com>
 <9c58bc48-90bf-8ac5-7fbd-0f6443e3fc5e@ti.com> <CACRpkdb4Q0efW5MaDmPTmewq-RFwXOTp15DCE1VpPf6g216iBw@mail.gmail.com>
 <5C65490E.6000800@ti.com> <86ef8asfap.wl-marc.zyngier@arm.com>
 <5C658CE4.5030307@ti.com> <5C658DD6.8080309@ti.com> <61cf956c-77d7-2316-65a4-de5896e5c082@ti.com>
In-Reply-To: <61cf956c-77d7-2316-65a4-de5896e5c082@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 20 Feb 2019 10:51:16 +0100
Message-ID: <CACRpkdYiLDbb=D2biBtr1aWJc6ottUONWm5qPE6g6_Pbpg94QQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] dt-bindings: remoteproc: Add TI PRUSS bindings
To:     Suman Anna <s-anna@ti.com>
Cc:     Roger Quadros <rogerq@ti.com>, Marc Zyngier <marc.zyngier@arm.com>,
        "Davis, Andrew" <afd@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
        ext Tony Lindgren <tony@atomide.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Lechner <david@lechnology.com>,
        "Nori, Sekhar" <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>,
        nsaulnier@ti.com, jreeder@ti.com,
        Murali Karicheri <m-karicheri2@ti.com>,
        woods.technical@gmail.com, Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 2:00 AM Suman Anna <s-anna@ti.com> wrote:

> Mark, Linus,
>
> So, I hope it is clear from Roger's responses that above assertions do
> not hold true to this INTC, and so want to confirm that we are good with
> the current non-hierarchical design.

IIUC the 64 lines are latched onto 8 lines, but all 64 lines have
individual masking and ACKing bits and can all be used at the same
time, so yes that is cascading and then you should indeed use
the chained (or nested) IRQ handler.

Yours,
Linus Walleij
