Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810F4C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 08:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BBC220879
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 08:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="T757LCQS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STXCClVG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BBC220879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeI2Ovk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 10:51:40 -0400
Received: from mail-vk1-f172.google.com ([209.85.221.172]:45255 "EHLO
        mail-vk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbeI2Ovk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 10:51:40 -0400
Received: by mail-vk1-f172.google.com with SMTP id l123-v6so1934842vkl.12
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 01:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=jHvdXPDSKyOJu3fpzAN0JVfKJIMObUKKoft8TuxICio=;
        b=T757LCQSwLYeHIBlFKuIh6tZzxlnDYhfXEsFA5PwYQim2/5E0QndmaPY/TchqQtBMA
         C8Dt9r4ZlC8VURxv9jyHydZabevV+/hM+GMsEwGE7edm2PoXEQ7rxBueUBy8jJ1nqD9k
         vcJqUZcZt0lzvvK5jkD4G9SZ8zaDcY2w1yTcBhWIyG7nJUH6DD4Epx1l5RxZq08PsB95
         n5HVDGdsPRvJtZtlF6gSHSRFMfydE39YCkxr2CZjznCwj237HC7UPQ3vw8MSalRG+Uav
         I093AHOmEz9rPHJe0fvfyQ/nGqmEs0X74irQw1gcO0HThOHa0LMNseI41ERbPnFeJbDi
         XYPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=jHvdXPDSKyOJu3fpzAN0JVfKJIMObUKKoft8TuxICio=;
        b=STXCClVGnTmONwob32LqSCKduL1bjnbh9jbCV+zs6FX5+3eHMeX3f3GiGYjqH/QKY9
         PZIYwPxx/ofZlc5hlR0ltzOLQi2drlUQruXv1HDJ659gRrVkwEP1/wsvrRLGGgZYCNkA
         KnkUtFpaCtcsPRcv3sxbffCdAmbwt0o8DxuNwwa6zlAXi2sbtWZwoxJw5/B1iiO5b8Uk
         AWN6Rh3ptLv92Iv/15b4V/U0z9ABekswirO+j3og8otAi4OIiVcF50qWW6d9ehzyEhTW
         uy91FL0CJ1iQS1nLFdaurhcFLBvs1vvqs9oc5tRUlLODPG7saYgqVhT9QjIrFh4XygzZ
         UOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=jHvdXPDSKyOJu3fpzAN0JVfKJIMObUKKoft8TuxICio=;
        b=JdB33N8GmtxjQUBXvYkhSXSrmvbBii/LTNbFxaAPonWS09xOGcFtZ5hRZVW8iyCxRs
         ict7mx1RSXS5/95a9ibrNU/WS9Hqq/MMZ2GRzeeQuY2xlPcC5Bs78FtDcCrqvuK+qP6Z
         GvM1N8N2P57deQ0gDLOjSb7W71QEJWFUpK+76w/1P+mYezEvsZrmvfxoPf/XoYYc1P9e
         E3qQYDnSR3MhfRJ0nF10+Et/w8dG46x6KR+7PiGgHGD1jtpngxqTqjCCOit+OHYNvktE
         Bt2PBxdQFK50Bq6zPIBBynfDpVn7AsHnmXYOulZTRaDCyGf4Cxbym8ItyWIWMk3wYtB3
         7Gvw==
X-Gm-Message-State: ABuFfojhfU3xrc7ygjQJlguxTjrZxklk+L/tqidJFIeucTO6AHl2CWV3
        nW8ZfFXVNNovPrr2g2ej55kSxhNkomitg1ZlG4QRsQ==
X-Google-Smtp-Source: ACcGV63rqeMYSztOipFk8WrLcs6A83YkG0MGIq5wfeDaLg4AuXG6gtiLFHBLM7i8FNkk5wsMJ7gIoVvPo0Coga/ujbI=
X-Received: by 2002:a1f:8eca:: with SMTP id q193-v6mr836469vkd.50.1538209447503;
 Sat, 29 Sep 2018 01:24:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:12c4:0:0:0:0:0 with HTTP; Sat, 29 Sep 2018 01:24:06
 -0700 (PDT)
In-Reply-To: <20180920202942.208509-1-zenczykowski@gmail.com>
References: <20180920202942.208509-1-zenczykowski@gmail.com>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Date:   Sat, 29 Sep 2018 01:24:06 -0700
X-Google-Sender-Auth: Ggg18yi7aAifk3h4oogMj2tgTQc
Message-ID: <CANP3RGcnLSB0vWKpO+drJvCCbzAQ-3AnsYW3Q1EjjXwCKi0uiA@mail.gmail.com>
Subject: Re: [PATCH] usbip: fix vhci_hcd controller counting
To:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Dieter <jdieter@gmail.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-usb@vger.kernel.org,
        =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not entirely sure who I should be CC'ing on this... but it's such
an obvious fix...

Thanks,
- Maciej
