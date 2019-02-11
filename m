Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D95C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6507E21479
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="saW8/hGe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfBKIKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:10:16 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44256 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfBKIKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:10:16 -0500
Received: by mail-lj1-f196.google.com with SMTP id a16so3830377ljb.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 00:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HTufqxdwVyd5xvnixmRcXTj5wWcKWgsmg6B4AXxL778=;
        b=saW8/hGeXOlXC4KQdSwD/ePjV+PWNSwUhaQU/ZZt0zElqGSuzdyV2JQ4OzQGUNxlrZ
         puxkNe1wC9LfRIzqJHT/YIh6oHJTOQ+ipH4cCcapEB+ARt68rnP/bifs9Qr6MNpNny8k
         mB7UIEtz8/8udtzfKshYqHiPqSA/74wEiS7nNoFIcClqRgxjlUwsXYGeOJU1U34J3+gN
         U+MVXgdwe/xHWXXBESQWGWN5csIkt4eg7MK5EguKxMaYNV9GFvDFwfPxR5Ym6iqr8LcK
         A8zIRGmvKt4CU1+bqpyg2xZHTwaRD6aSqhT8T0aLHFkcYzf641kywbP/p5jpvA2PEutK
         9ckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HTufqxdwVyd5xvnixmRcXTj5wWcKWgsmg6B4AXxL778=;
        b=FxT0cgoRViqMak2sXQP5VNCTLsKHkEM1DxW50EHuNfa9VTP0WwoUFhzqWIvGvstGIG
         +oaI3KCSJt+9tMUqQBM+6OZvLlAsd3hK0OuOCJSOliajJq0IsJ2jRY6N3jbO3BzQkBRJ
         disTTZ6nLMCQcXNZ/DyeQfWXjV4naZw9XucPL7KFcCU+bbmb3VouSH8ZdQy9/o3K97E3
         Npfzkn/wrqoiEtg4r6XVTcDs7SDNGKKlX45blS94Uq3yqLhalzvLxRNxpOzQMjt3nLks
         a+OVIupPqZtBrfajeeG9O7LcbgwoL13I3RJG6bw9w7Pa/JbRp9Av+BUqdpctcpTVU8Wj
         DWiQ==
X-Gm-Message-State: AHQUAuZYl6htvDRgLUqok1lC3k5yodLR8CJvzZJ1mrPfN7/kz01Eq2jd
        DBkeDTcoc0+Iqzd304e6e0xWpdpxDii+7EKAIMlgCQ==
X-Google-Smtp-Source: AHgI3IYtAGtrQysea3hu7s2wg7C8AGK93eOXhuR30JYV0qZQ1Bl8JmGH6irtUBqh9d1hB6s+UJv+Xks3vAV140PumUQ=
X-Received: by 2002:a2e:874b:: with SMTP id q11-v6mr941391ljj.97.1549872614339;
 Mon, 11 Feb 2019 00:10:14 -0800 (PST)
MIME-Version: 1.0
References: <13290065-5568-c0d0-9e7b-7a02ad71dbb0@infradead.org>
In-Reply-To: <13290065-5568-c0d0-9e7b-7a02ad71dbb0@infradead.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Feb 2019 09:10:03 +0100
Message-ID: <CACRpkdb+YefEc4nWifPm1pjOuDLg=DiAPOM9gaftJAc4xmDODA@mail.gmail.com>
Subject: Re: [PATCH] Documenation: driver-api: fix gpio/board.rst warning
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 7:28 AM Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix markup warning: insert a blank line before the list.
>
> Documentation/driver-api/gpio/board.rst:209: WARNING: Unexpected indentation.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Cc: linux-gpio@vger.kernel.org

Patch applied.

Yours,
Linus Walleij
