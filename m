Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F88EC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048DB21EFC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MdysfpBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 048DB21EFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeHJXtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 19:49:00 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:33546 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbeHJXtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 19:49:00 -0400
Received: by mail-io0-f194.google.com with SMTP id z20-v6so8883818iol.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 14:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DbM9WqC4kvi4aAJhNHHLmADtedLlgSw6EFEDqNfzQIg=;
        b=MdysfpBs96DAKNnvZCC0gA8wzRYI7rGx4HTVdDcV/iWRpH5lenPbTNlJhpPMjH6Gto
         NDkaF1cvJ5Juca6qH8OYAyrPzab+Z4BJf5uE/8Yvl5X2t5SHpqzmz8vz8D/HmiibtXV3
         OYPLuap/hhp1fm54AHSWS+XYpzNnCVCGWOvXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DbM9WqC4kvi4aAJhNHHLmADtedLlgSw6EFEDqNfzQIg=;
        b=VcnvaQ2+euqOMr1zsoRBfst8CsvKteqBmxlseDV4FYf2ret6+SJ12YsOvn8KrR8W9H
         lYXAwC0plDAy3c0mzc0Y+jjJScYoPekYFzKiJsYQVl6qQz5rZ2NCtrqY8lJt73455h+6
         NUgEn0Qg3ZEcjO89VYtBOWhIqffijxVBqyJ9YBziYZPZali8IK+oEEweztGuj1gLmyq7
         7+OWHHozNBawpN+2U7D5gepCr4NXOn1kiXi96ZI/w9h5kQ9/U/iHSIpgG4Qjjj5X0X2D
         KeQFMGJJXdeBFJLP0lf4sxidN4F6DPK67iQSUUFo1OCqMoTch0D+fWBINMvStw54chGp
         qyMQ==
X-Gm-Message-State: AOUpUlHXhdjZAQJMlosbrHtQj+CO0UsFB83w3Rwr+2xJybePq6u14O2R
        ruqnYciR0EkGd4BmoAHObxFQOpMFNnZw+Jm52fBEZZRg
X-Google-Smtp-Source: AA+uWPxPWN9ddBKOGnzjKt0PFc9L4ayMCb3v5jNnqayPAR5Xf2DG6HcGAZA6bg7+e+v79ebHNVX4ROIDrR/dMZrc8uE=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr6769472iof.304.1533935846355;
 Fri, 10 Aug 2018 14:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180808222636.6381-1-lbloch@janustech.com>
In-Reply-To: <20180808222636.6381-1-lbloch@janustech.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Aug 2018 23:17:14 +0200
Message-ID: <CACRpkdZC3Do8kq7dHHyARJs4hdTw4+ai76r4Kn45+vJ4HGduTA@mail.gmail.com>
Subject: Re: [PATCH] gpio: it87: Add support for IT8613
To:     lbloch@janustech.com
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 9, 2018 at 12:27 AM Leonid Bloch <lbloch@janustech.com> wrote:

> This was tested on actual hardware and found to work fine, but currently
> the official specifications of this chip could not be obtained to
> confirm the numbers.
>
> Signed-off-by: Leonid Bloch <lbloch@janustech.com>

Patch applied.

Yours,
Linus Walleij
