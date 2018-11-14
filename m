Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDC7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 12:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9755208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 12:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fWBw7N2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9755208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732083AbeKNWtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 17:49:16 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:47074 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbeKNWtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 17:49:16 -0500
Received: by mail-lf1-f67.google.com with SMTP id f23so11389161lfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 04:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oXfRuHcKXCX7JywOVhWIYFJXJIMnYp8paUndEfIwwao=;
        b=fWBw7N2I7CFhiGVsGY5dTUW1pDbLhzuWIaAlf8sjYxHHFE6/j1uWyCVhG5X2S/06zP
         OGrz4KI2Bg2xaavW95pAIcLkRTrt80heqzEoT2wkbfZ88xzDdwTm84gyfTa3ibG2z+Nk
         By10FHfSJo4QE5lj003pbcau+v7Obfa6Qvz8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oXfRuHcKXCX7JywOVhWIYFJXJIMnYp8paUndEfIwwao=;
        b=iAE0QnQc+7/3juN0nPDebQYO4BWi7RUyP1593oehgTmkKwSzd6lqKquJ/vAs90Hlgg
         WUlA+pUPKYjZ3FEJ9T2hJVSOjbklePFPl8Op88K8pGfvYVZOAoLq4r75GXyncXVYR3kR
         QJEXmDxFmoRJ+b+Cm2MTF9V4O9Yvo8h/kv05D5Vr8TQc3JBLiMsQ62ea1L1/R9Mo+Qpi
         DGxOS6jolb7dtZb6Y0ZtaGZDIPRwhm7o+rVhxvJHMuy7iCVNvfBFsMIZb5RxF4x1KRdi
         IkNwcbOjjf5+QoxZgu1J+ZZ/0gX3a2wGtVxw+9Z6w8b/wFbvp9MaG25pF1uGBmpuu+H8
         B7pA==
X-Gm-Message-State: AGRZ1gJykwOpN2oGjyEYDgl2Z/z3ymCw6zsZa5ME9yG74thfHkzBjX5y
        ctFrrnL8D8JUgMF/ztFAypCDIeQn8DDWgVgwZMOX7w==
X-Google-Smtp-Source: AJdET5cHpJ8tUFp/98/xgpirF4NrPC+wN4XBjgElJQ7W8EUKio7jT79nUsF2cEyt15JnyMNuSXd4DP0kcgnmbFaLCn4=
X-Received: by 2002:a19:8d01:: with SMTP id p1mr892157lfd.149.1542199568188;
 Wed, 14 Nov 2018 04:46:08 -0800 (PST)
MIME-Version: 1.0
References: <20181109142138.54770-1-heikki.krogerus@linux.intel.com>
In-Reply-To: <20181109142138.54770-1-heikki.krogerus@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 14 Nov 2018 13:45:56 +0100
Message-ID: <CACRpkda+wiiCN+B1FM8Lb8_zR25ehnbY718GYKNuZGePsB+fUg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] device property: Introducing software nodes
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 3:21 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:

> This is the second version of my proposal for "software nodes". There
> was a "dereferencing freed memory" bug in patch 3/5 which is now
> fixed. device_add_properties() and device_remove_properties() no
> longer change places in the code as requested by Andy.

The series:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
