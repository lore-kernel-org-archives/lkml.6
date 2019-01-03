Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8024C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9964D2073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OJ5GPDpw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731686AbfACRZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 12:25:22 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39165 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbfACRZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 12:25:22 -0500
Received: by mail-pg1-f194.google.com with SMTP id w6so16269456pgl.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 09:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:cc:to:in-reply-to
         :from:user-agent:references:message-id:date;
        bh=/3f/8UT7w199nKPlhdUgU5QbN336qKDqa4dp0VAFn3o=;
        b=OJ5GPDpwIT5BUlrsmJcISqgZwLCriISgVDu9pY/mzNmYddwyBAZ87M7N/YfZV3IDKk
         4me6+5u77HMyi9RneH3J8W1HfTfx7hvGlyyeMp2gTP42ixyJtiAHhNeJqyqU+Qh/Mas8
         RuTe5IEVEkutHgWJKU1aqYYS1M/glQzmF1A7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :cc:to:in-reply-to:from:user-agent:references:message-id:date;
        bh=/3f/8UT7w199nKPlhdUgU5QbN336qKDqa4dp0VAFn3o=;
        b=GsXPb+6dVh1Uc9+Xn799TYly3OdkUGmYFWAZAcNxuGJTEUKDOwOrbcHxb0IHqtkHVW
         0wrCc9qBUxwByJdsBsUJZxGo04uhJwLvfblHpyTwk8ohZWAPGBBpjaC9rvq79lQ1KXqj
         3X9kEheQrHCv3ycPuruhu0NJF/XQEf9cX/D16c2fh8z96ZvqS09Uzx2k37Whdf4VuyxT
         kTcQBWL/LeMhkutsL1OwJ5F94490ljbyrCJIUiHHBdURcVnAJRtTq8uPfeZk4lMGXbFK
         99xFgoUHvJJh8Ug6PBYZ8JwQ7Q3ywP6a4pd3/JMnIKvVxANaFa0pfrF48+GBqojdR6V6
         PdrQ==
X-Gm-Message-State: AA+aEWbhapexcKAHKztsN7xg6Ofz16WfJcmej9KADkyaqKoEppuRUNEG
        Lt5mu1NFeV2nnisUsaa0J+JXKg==
X-Google-Smtp-Source: AFSGD/UzT6muXz6Bru5yQRk20DRxN1niAZ9rGNBJ+HZdRIZhgPvmxrkm1qYWbbr+wkxnAGQgn4fjNg==
X-Received: by 2002:a62:16d6:: with SMTP id 205mr48856414pfw.256.1546536321419;
        Thu, 03 Jan 2019 09:25:21 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 78sm104626790pft.184.2019.01.03.09.25.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 09:25:20 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] driver core: platform: Add an error message to platform_get_irq*()
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        javierm@redhat.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
In-Reply-To: <CAJZ5v0hwhuerPoizdYjqNkdymxubOweZ3JhPiXRUcrNtByz_=Q@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8
References: <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com> <20190102185106.56913-1-swboyd@chromium.org> <CAJZ5v0iL_Fq0RUbLjMj9WBitDw2amNV_ybirkiPbuYb0zroGAg@mail.gmail.com> <154653191998.15366.14229484132412159772@swboyd.mtv.corp.google.com> <CAJZ5v0hwhuerPoizdYjqNkdymxubOweZ3JhPiXRUcrNtByz_=Q@mail.gmail.com>
Message-ID: <154653631992.15366.980047163353936345@swboyd.mtv.corp.google.com>
Date:   Thu, 03 Jan 2019 09:25:19 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rafael J. Wysocki (2019-01-03 09:22:56)
> On Thu, Jan 3, 2019 at 5:12 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > I don't see much benefit to seeing -ENXIO or -EINVAL printed here, so I
> > left out the error code.
>=20
> OK, so the value of the message is to tell the user that some driver
> asked for an invalid IRQ, right?

Yes.

