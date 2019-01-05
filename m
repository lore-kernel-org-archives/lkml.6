Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E9FC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 09:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EBA82087F
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 09:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tFV+8U+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfAEJoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 04:44:09 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37402 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfAEJoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 04:44:08 -0500
Received: by mail-lj1-f194.google.com with SMTP id t18-v6so34341580ljd.4
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 01:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kx201FxbZ0by8OaLw6gk/K+zWDVBwQBNze14d/saNoY=;
        b=tFV+8U+LSIZEl9gfcSdKqOGrFg7T+BZqcdMXxc95kGCTyjd6VPLvWJH1uu+jvwdQ7j
         nIZ1Rea/ey0FK5M7PIP4fPqGkTop7TxrDbvkc8jzBtLKSpd3e+uVAAorZBcTyuhe0+sp
         zkadg71yNhjxLWQXWTXF4j6BFrN1Go6xyHYMJkRV/zJ2T/+YCtS1c5u3HQwYTNvb/hQh
         lD/Ruvn2PgNkCKP6QgWRmFv34UrUcc6hpUfXTKpBI541F1fbvu1zjSagjmmr8ftZXu2P
         yYxc48MATsdHTIltCUTkcRP8yEinHhlMVzxAkdcLKsNMdpJrzd4A9Wznb8m5ERUNOIo3
         hhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kx201FxbZ0by8OaLw6gk/K+zWDVBwQBNze14d/saNoY=;
        b=BUKC9AYd4Pw42XieGjiMemyoPd5ry0HHJccGnUr0T+2WqBCxQCVjVLR/sxe5KhyK0Z
         g6038htcuGBkZVUa0ZXwxYncVFSeARW1w3n5a7oTsZxtYJTgylJ6kzjrt9RZpyiWxBuE
         psC74pVNgRHBFYzBbUmXD82nq/tyy0uxZU/ZQR/I6ziaSYKultXfFTyudbgmPBIljdvm
         CwedmTlyahQ2GY8xO7fq8OorHiNsse1yQujK5fGDgS/XTZXulNaNXeoQqcMulWcBiMDx
         ESgA4YlzwRgK1ARgv2t5Zm2L02JZtsyqIGQtwl73Rd04BcY1nvl/IBngE0T64Ct+TQls
         vNug==
X-Gm-Message-State: AJcUukdV7J7YPQ/9AgGM5tuFndqQHHktVtubd4wIpRyas4WaRXXaS06F
        /8qjqYhs+IWjPjI5dj7zRm2vNOXBQJrPdIPLDNlHcHONl7Y=
X-Google-Smtp-Source: ALg8bN7knzsDAyOXgfU46QeWqR13RcWPqaaDfrs90j5l9Bpco+cGUMdGd5xnz5jAMBtrH8CS3dX5u23bKGYNaCAVRco=
X-Received: by 2002:a2e:5b1d:: with SMTP id p29-v6mr30384998ljb.176.1546681446546;
 Sat, 05 Jan 2019 01:44:06 -0800 (PST)
MIME-Version: 1.0
References: <20190104021311.38194-1-rkir@google.com> <20190105085429.GB13941@kroah.com>
In-Reply-To: <20190105085429.GB13941@kroah.com>
From:   Roman Kiryanov <rkir@google.com>
Date:   Sat, 5 Jan 2019 01:43:55 -0800
Message-ID: <CAOGAQeoOTVMzufOvXf+f6SDJYfCWj7unU8oWExfq3WSj55o7CQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: misc: goldfish_address_space: add a driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Why isn't this in drivers/platform/goldfish/ ?

I was not sure where to put, but this driver is not a platform one, it
is a pci one.
