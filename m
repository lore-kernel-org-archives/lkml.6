Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066C9C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0ACD21775
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JI4JOqpB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0ACD21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeHCSFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 14:05:10 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39175 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbeHCSFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 14:05:10 -0400
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so5363232lji.6;
        Fri, 03 Aug 2018 09:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N18bI2nmDyWcQj5+h1ZZhviQEe4qJLvQBNTvDUS3NlM=;
        b=JI4JOqpBSdUpUenQlktG0HINXHpA5W8aijs9L7zwLRmFo/hrBxUSPiAoSu8/UCUzJs
         z6+ZhGbghateMGe5Hye+5heg+XPWQXxcaRC6Xlhyvd+W5RtqSTOVLLx/766QSSHgHCa0
         vvYVxISA72NQmPX6aVdprDgrs9F6+re/K9FdRGt+I06XgmPEL5tK0jRo9db4QDJk3sW6
         Lst0/BJPQjQbYsO1Yb1nLUxBaFC3QU/8/mHU4BG1r6WGhZmOGSkBxAyy/e0lbs2i95q5
         dq0aqbT0ZUaYsWwf7QKe7eyshEUWUay1n0zCwE5GVU/fKOpAkjGAFAYOIsoN74lPSWss
         jYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N18bI2nmDyWcQj5+h1ZZhviQEe4qJLvQBNTvDUS3NlM=;
        b=PAKP4OE5qAnUMmY0v8DiUrvYelG8XZeItQQcecUYHpYsfrjZOTYibYxlG/AmarydC3
         PcpnMvQMEB8fZSM1sDEPSCOR+RYFfmoMDKreXXn6uf7SE/eN/MnYXuJ2jnS230MbJaJq
         Y2/mEG648Q3esZlDvOA0pZXCtZXstmWqXZfsCPStcXaQxs1C8JiQ50++DB9LVkUzyFAr
         msATsC1i27F+HjLACgvJK+2VX/PbepmB/gHV2n0hgAmcPZJchU5L0ifNWHhIa81eVyZM
         QSdAbPyF86DoC9JeKkePJr7mjjIs5lokOSyYDgmIUjQXFG6r7Hz7i+y8lmiRvYDsZzvm
         TERA==
X-Gm-Message-State: AOUpUlEOhpU7NBeFjOQOvg+7pICO2L0ohyl/Eqd23p6NsJrUzhrInvjD
        vihnt/aXY1amdplic6FmDd+t/yzwR418gAz2YLY=
X-Google-Smtp-Source: AAOMgpdncaYo/m4ONL6jSd6vg12ilBqxPy1VOoxD1VIHtFHTelVhH/kyZspSzYlHXyYw9RlMbJA7cUi54/dTRuXOyEg=
X-Received: by 2002:a2e:8950:: with SMTP id b16-v6mr6371400ljk.111.1533312491926;
 Fri, 03 Aug 2018 09:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20180803072628eucas1p26abe0cb121b974401759502f8807bb96@eucas1p2.samsung.com>
 <20180605224458.62692-1-ravisadineni@chromium.org> <20180803072628eucas1p26abe0cb121b974401759502f8807bb96~HTx4BGQjl1119311193eucas1p2U@eucas1p2.samsung.com>
 <CAEZbON7qLheHFuU6zwArCz=CG03JvnFjcehBGjE4RqROYrMLhQ@mail.gmail.com>
In-Reply-To: <CAEZbON7qLheHFuU6zwArCz=CG03JvnFjcehBGjE4RqROYrMLhQ@mail.gmail.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Fri, 3 Aug 2018 09:07:59 -0700
Message-ID: <CAKdAkRQG08d_duPiKFi_=xUNO93c0Rcw9kpaYFFJahjJM-NdGw@mail.gmail.com>
Subject: Re: [PATCH] Input: cros_ec_keyb: Remove check before calling pm_wakeup_event.
To:     Ravi Chandra Sadineni <ravisadineni@chromium.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Ravi Chandra Sadineni <ravisadineni@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Todd Broch <tbroch@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 8:51 AM Ravi Chandra Sadineni
<ravisadineni@chromium.org> wrote:
>
> Hi Marek,
>
> Can you please give me little more context ? Snow is still on 3.8.11. This patch is not backported to 3.8.11. Are you trying to flash a different kernel  on snow?
>

Ravi, from upstream perspective what kernel Google uses when shipping
Snow is completely immaterial. Mainline is supposed to work equally
well on all devices.

Thanks.

-- 
Dmitry
