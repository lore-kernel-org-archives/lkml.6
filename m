Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C00FFC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8E2208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mf0JvZYg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8E2208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933691AbeFLNJO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 09:09:14 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53848 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754266AbeFLNJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 09:09:12 -0400
Received: by mail-it0-f68.google.com with SMTP id a195-v6so14463053itd.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 06:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2S81F5wjpMg7XU13M4EAXiQPxug5hYVZCRjgOkh/VTM=;
        b=Mf0JvZYgaSE7/KxS9S44AJN/ASFlK6FxqxXjzpu71qro2qu21g8wKbGmOL0jUl8W37
         mJV+1zdPSc9vbpq5+2IP77f7ODyY17+/7JnO1oIdNXTq8P196bnZjZ5Y5jkJEF09jKid
         ylaUL7ZKWqHnlz7FCMGYFSvq6f4KacOO2J9N0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2S81F5wjpMg7XU13M4EAXiQPxug5hYVZCRjgOkh/VTM=;
        b=NXm8XJBGe/IDY+DT962KINiW8xAPhIwj/eVD+MO2aQx8iYFhJaeFajL0DYgTOpUesE
         5jomrCKwBa+v+4+KdeX4JSpIl5sMhyvmJwVmlo+NSwCuavy2YnX8fdo4zAP9fKYTRhZK
         95T0mOa8A3ssWzF/yH/jOqXKZJTZhQWGaTckrAcoe9xj5SICvcXBbTSopUFAcUZqeFCB
         Tqchp0mP547ikqZ3XpStlUd0IZi4q9U72e5E39CETGWRxkF4qFvYQOCfk+STI18/6D7x
         laqoSqGylSNXtjB5qZPTfq4d8az8zC+Lk2dRz47uot+TbX0sxkly9/OyHP9USpZ6XAm7
         xJBg==
X-Gm-Message-State: APt69E0wub+CCKhuiwiX0i+yJ7IeTJdffxrZ3/aLAh10Nt4u4xWl2A6J
        X6Vty0TwWKMZpUvldlQOq3BnNxW8hGsRxkk1eKsESGQI
X-Google-Smtp-Source: ADUXVKLe2hudYJS+VNliM1DUfESisoXJA4wJvC8Z8B73SQFlz8M8tiaCCnaH5Zf/58AC9JoPEj+LMSmEONCLjqYaQPc=
X-Received: by 2002:a24:690f:: with SMTP id e15-v6mr340706itc.70.1528808952071;
 Tue, 12 Jun 2018 06:09:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:78c9:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 06:09:11
 -0700 (PDT)
In-Reply-To: <1528276734-1483-1-git-send-email-j-keerthy@ti.com>
References: <1528276734-1483-1-git-send-email-j-keerthy@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 Jun 2018 15:09:11 +0200
Message-ID: <CACRpkdbsww1m5GMJ9A8dhn5vXfjaozzb2QaZOkWATdOGg83qMQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: davinci: Move fetching IRQ to beginning of probe
To:     Keerthy <j-keerthy@ti.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 11:18 AM, Keerthy <j-keerthy@ti.com> wrote:

> Currently IRQ resource fetching is done at the very end of probe.
> In case the of IRQ resource not being ready, we defer probe
> and need to revert prior changes. Hence move it to the beginning of
> the probe so as to avoid reverting.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>

Patch applied for v4.19.

Yours,
Linus Walleij
