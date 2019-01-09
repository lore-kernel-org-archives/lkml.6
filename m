Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634A3C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F09A206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P71xmQrQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfAIXOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 18:14:23 -0500
Received: from mail-ua1-f53.google.com ([209.85.222.53]:36841 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfAIXOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 18:14:23 -0500
Received: by mail-ua1-f53.google.com with SMTP id j3so3013045uap.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 15:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=YqTj150WVWbc1Kqk5/WdUNaGGsjx/tFfOa0OTI6vo9U=;
        b=P71xmQrQgG3+V0XcgYs7WIc/8K7Ja8pnIYkdz5uhG7/VsvCmH1DJO4lKKWP+Zer4KI
         TCwR2f9GIvxnixispSluvftah2CLSOAzhlcJfzRkr42VEkgX045Fkynvx8IiENcUtdKI
         XeyU5+0THEC3ZEZ0Dy3439usoZt28RqJNUi/barl4g1bIZmkDRPXtPIM7nIl4wHZ1vhj
         32ulQLD3kzxP57i147f/mRkeOSap0uywNwK2P4ki9zMrnhxyorQHi7wAthtUGTr5FYxc
         8POqIpDVEAYYR442ZpsgrfUOnihEuKi2uXO73NeVipr2puorZsIeWZAUdjAZ1Prr9fWu
         BbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=YqTj150WVWbc1Kqk5/WdUNaGGsjx/tFfOa0OTI6vo9U=;
        b=dMiuXdsgShc+rIVLe0+MzzaapJS9vVqxSZS133J29C1S86aTt0IRuiI4iHWduxThAG
         9T4wOJr8WVO2o6BTHytRFQQIDGxTGUfirbY/AVVTLvDiewuYkoVlO8OU7VvKn0zZoTub
         Djsk/V5C5xtRHTK6boKB+W9eI215OYflgyWyKDGH6Gru4Bj4f2xua2n3vVqYcaOhK0DY
         tnmps3uayhyfBQIsIxqrj7XYF/qQptPDJ++VY2oSah1+jutQ+frPGDylrmXkP5YDrN/F
         YOYXgbC2sqzAcnXILsjNAnqOoQxBWZC7H5SAgMds9p8rHqay/3FIf5QqosrcE6iQ06I/
         YEog==
X-Gm-Message-State: AJcUukc1z6d526QNuUzvDiX/oXOS4OV2dsoikN5+yyghTLK9sYJbxMZ6
        lUSOB5+kT7HRtuy4bYE7i8ejxFphpQB2X8J4V5r5t5w0
X-Google-Smtp-Source: ALg8bN5/hcCAzTk5tgDPmIKVNlDQK+JUReaCw4pCdsZ8Be0bdWyYKCcZTn9CjUDEAhgug5n/yNX1TPJ5+kz/SH8eHIQ=
X-Received: by 2002:a9f:3250:: with SMTP id y16mr2835369uad.98.1547075661603;
 Wed, 09 Jan 2019 15:14:21 -0800 (PST)
MIME-Version: 1.0
From:   Machiry Aravind Kumar <makrvcs@gmail.com>
Date:   Wed, 9 Jan 2019 15:14:10 -0800
Message-ID: <CAAwk1nJOxG-2tCfTCUSgVMP2SXeNnWheT_4K6+WUMCxYVph7nA@mail.gmail.com>
Subject: Incorrect usage of kobject_init_and_add?
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I see some discrepancy in how the function: kobject_init_and_add is
used in various places of the kernel.

According to the docs, when kobject_init_and_add fails, the caller is
supposed to call kobject_put on the corresponding kobj.

We found several instances where this is indeed true:
https://elixir.bootlin.com/linux/latest/source/drivers/block/pktcdvd.c#L131

However, there are again several places where this is not the case.
For instance: https://github.com/torvalds/linux/blob/master/kernel/sched/cpufreq_schedutil.c#L754

Why is this discrepancy? Should these be fixed to add kobject_put in
their error path?

-Best,
Aravind
