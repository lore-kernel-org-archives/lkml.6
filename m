Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938B8ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F12620837
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="R+d6ewmR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F12620837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbeGPOJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:09:31 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53567 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbeGPOJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:09:31 -0400
Received: by mail-it0-f66.google.com with SMTP id 72-v6so4712050itw.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 06:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JYoD/hoxsc1KAqwbTrIGs7eHSbZ0A3cKnQ5LTZhEG7Q=;
        b=R+d6ewmRDv7OdL/Rn/LqQj8GgKiVfnW3I1BnwSzyy1eSZOBJJht7vUIwFV0ymIWCs1
         B2D1zCu1dubVRTMnQqFQIbQoRS/UIyIcPyrFBslBEPw747s8jga/kDv5X3VLBh7ZZ54J
         8Ox4RqAoxMpQKO1UqwWCZ932leUPbT9Fu4Tag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JYoD/hoxsc1KAqwbTrIGs7eHSbZ0A3cKnQ5LTZhEG7Q=;
        b=IuNT7uteS5bAjMv9r5lp0+YLmkPOmi9KHzNaSW9Jf35UmV9VC8Z8GruYeY8jz3asaw
         zP3TZvRdy/l2pGwIAuL2vd2tPalJ6m8mn6M4+TuXyWf0HweBs+IviFK1LvFjJxzqD+ex
         OdVV/7Wy9CL7sofohJyg+CJRaGEOfTKknR2hH+Pel365ciKuSzJ2NQMjC+bKXh+ZNyqV
         umDtF2G/kYDgrk/eaZU5nH+WquEVC4iFB7F6ezysm8/+zbgyoZiWfYvj9EOMwMIQ5pQW
         P97YTJPpFg5HAJzKqSMChlPl7fhRUZKL6E6dINjPXjxDE3Ka2T1PVMa5lGuDZM2BKBni
         vwjQ==
X-Gm-Message-State: AOUpUlEQpcF/K4VB93RkTiQV3NBcTkbFlN/F2lHWoU6w3SSgrkfevwWf
        UbfWTBLJPDkO6rbqd+vaEYAj6huqaoiInDk3v7mo5A==
X-Google-Smtp-Source: AAOMgpeImoShK6rUMHnU2p4zOTbR992PeVyoYNL/IsgaE3T4nM4DQuYL0WZOmVWuMV6KC6Js9nHgeKLFuEGTTjBhrHs=
X-Received: by 2002:a24:ad01:: with SMTP id c1-v6mr12579474itf.70.1531748520900;
 Mon, 16 Jul 2018 06:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180716083424.11157-1-brgl@bgdev.pl> <20180716083424.11157-3-brgl@bgdev.pl>
In-Reply-To: <20180716083424.11157-3-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Jul 2018 15:41:48 +0200
Message-ID: <CACRpkdaNCwn5cWvopcyDONLccfMpO5znc=q+pyr=F6frNvuaGA@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpiolib: remove an unnecessary TODO
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 10:34 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> It's actually fine to read values of output lines. This was also
> allowed by the legacy sysfs interface.
>
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>

Patch applied.

Yours,
Linus Walleij
