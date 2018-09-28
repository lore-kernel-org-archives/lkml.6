Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD119C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BDEB2172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BX3D7Nnh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDEB2172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbeI1N5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:57:20 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44859 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbeI1N5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:57:20 -0400
Received: by mail-qt1-f193.google.com with SMTP id c56-v6so720864qtd.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 00:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pv8jQq9DK1jeavZj2c2CYezWp1mf/cIj5KNTPPCBBDs=;
        b=BX3D7Nnhn0ZVthGyzdhS7NZvZvCScI6fQ578jLwGz2c6h6I+tY204qxjUTGBfpPc/6
         OMJqUb56uNZujd7+H7vQjK0Ie5AW6XvLLptmwv9275JMtp/cROjMCIDa2vx+2nZNrJRw
         D7aFDvI8rHxUZnaHxuuPSDlVzSWq6UamdzT8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pv8jQq9DK1jeavZj2c2CYezWp1mf/cIj5KNTPPCBBDs=;
        b=OhG3sAdzfibaOoWcRCgu6Oq5mOcjoVNo4Br5wlxY3pgPBm6TunbTYohW3O6NW6QMzX
         ZinWak/Kx1AJ2eP4I1GlDg5D/FU8UOSOTX1idMMC1/0aYkdpmeiZa6FH8Z+kEzXOlFza
         DCX3H/SZJuyWAhWPDUjAWXUHkIjb91kVdr7Y5y9vAWWn8LFdYx23f01Kx5Gawh7duGm2
         J534J0jddYRTAC1zNU4m9NMofkF0WCLggT6vxu+u+LHN/03tvd4kvNgXf4jkM09Wdz0m
         FcWIMYiHC8GfQYzU/5JctXAgPqPRtDdb7o1jHoFNCIcoCu5WR4QCgEM7VsYWJfCuahcH
         al7g==
X-Gm-Message-State: ABuFfogIlCr0AUv+p4fCfUQR9R3zTlrvN5BY7m5qHtHT2O7Z7+od1Gmx
        QWR4e+yor0oL/yS/lQj42lwACw6rgqDN+dMJNmDDWQ==
X-Google-Smtp-Source: ACcGV62p0j34RFlSPYMXE8sc2cmhVt+oj5lJmLCzNXK9LMyGr3ZPb4qYNyUB9nDYw5ktoim0KdqjxxM0N0Raws+3eT4=
X-Received: by 2002:ac8:1793:: with SMTP id o19-v6mr11408630qtj.98.1538120095000;
 Fri, 28 Sep 2018 00:34:55 -0700 (PDT)
MIME-Version: 1.0
References: <07c454a686966823161ebfe1ed7c08f29032fb2c.1538039535.git.baolin.wang@linaro.org>
In-Reply-To: <07c454a686966823161ebfe1ed7c08f29032fb2c.1538039535.git.baolin.wang@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Sep 2018 09:34:43 +0200
Message-ID: <CACRpkdYAGjBRiy2n=7g_62ysb7aO0V9OZDZ0rLEfcevfmG9Uyw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: sprd: Move DT parsing before registering pinctrl device
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        Mark Brown <broonie@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 11:15 AM Baolin Wang <baolin.wang@linaro.org> wrote:

> It will be failed to select default or sleep state for pins hogged
> by the pin controller device, since we hadn't parsed pins configuration
> in device tree before registering the pin controller device. Thus
> we should move the device tree parsing function before registering
> the pin controller device.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Patch applied.

Yours,
Linus Walleij
