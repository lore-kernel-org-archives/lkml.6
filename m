Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14103C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999C321546
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OXuZA9bV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 999C321546
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733253AbeITU6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:58:25 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:36098 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730758AbeITU6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:58:24 -0400
Received: by mail-io1-f41.google.com with SMTP id q5-v6so7699787iop.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 08:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YC5B+caAMUGA8fAoGgUCkO+nCqrO+KmoBZ/hNjHe5vc=;
        b=OXuZA9bV4trrLHDOK+sX6dmKdIY8E8iooDk/mXjHv3+FmqBqE2yCIBb28vXu2cLKMG
         Xm6ogQ0laYrXHFXNQwsKhqrL+5YRkC6wh3izTEr34KNS+FYoofeNA5zFUipana45oJ85
         QTOXHrH66dBKQ89nIIRNKsvuhLVEz951PpC40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YC5B+caAMUGA8fAoGgUCkO+nCqrO+KmoBZ/hNjHe5vc=;
        b=hHi+S06HNic9g2clSa7Yf30OvnBhXQJkGSP/oZPhQNwKWxWgip7RPqs1okKXDYKgS4
         vfWw9QSErVoFIZIwK9LUx/w1HHdYpq/lU7ayY8dTNRJ8CdwxBBIxm+FyDlV71W3dlq54
         ur6jWjaUBJRUSbmjWr5LcqSle4wSNCcUSv+XJuTMPy/FqEcGyXEb85ZAjq7lycn9Pm7K
         pJo/zr/oLotvELm/ASIQ/ObjHtEDW13ladNdJhQ3CEwzjFCQ+rsawnJOfG61cS9bN0Ce
         sjDXnpnyilVpTLsMJ1cjpXG0Mwr4sw4fexpKMaVSG1xyt6RHJFrgDe2HY0jRBSrarRgi
         loVw==
X-Gm-Message-State: APzg51BdqHXOudSEyWE4oYMp0kHF3WPRSmVsdLEZRjmIKehLSk9/vuRS
        OE1V2AUVPLGwEm2qN4Era4XiezkXET1T3PXMSP4kuw==
X-Google-Smtp-Source: ANB0VdZJXgtHRKN59Em8EDcqa4P4w85R02coIMe1lpVO0+ETqtOVmjLUV0nDdpWJ8vksWeUW5j8TfZf2YnnFZPhFWOg=
X-Received: by 2002:a6b:630a:: with SMTP id p10-v6mr33207423iog.175.1537456468039;
 Thu, 20 Sep 2018 08:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <CACK8Z6ECjwWqDnaXKrmEbEXzmiX41Sbzys=FSCqMwh8eYLPH9A@mail.gmail.com>
In-Reply-To: <CACK8Z6ECjwWqDnaXKrmEbEXzmiX41Sbzys=FSCqMwh8eYLPH9A@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 Sep 2018 08:14:14 -0700
Message-ID: <CACRpkdbq91Uc8cvo-VbszzfGsthRg-CL45A2DLAXYRX-Bi+Y7Q@mail.gmail.com>
Subject: Re: pinctrl-icelake: driver writes to wrong offsets?
To:     rajatja@google.com
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        casey.g.bowman@intel.com, matthew.s.atwood@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good bug hunting in this thread!

Please see if you can use libgpiod or the tools from the kernel
tools/gpio directory to test GPIO lines, I usually use that since
the global GPIO numberspace only constantly confuse me.

Especially when there is a really many many GPIOs the local
numberspace and the global GPIO numberspace approach the
same values and I get totally lost sometimes.

Yours,
Linus Walleij
