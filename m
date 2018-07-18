Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B17AECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3287D20652
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="ADoQBGLj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3287D20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731541AbeGROGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:06:23 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37468 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730622AbeGROGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:06:22 -0400
Received: by mail-it0-f65.google.com with SMTP id p17-v6so4251229itc.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 06:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qkMEU/KWvYEIN2iOOPHhvlKOommLAxNVFWpqeCr4s7c=;
        b=ADoQBGLjw3RWHNgEAeLsG3t0zRCosz2zeyG5uCL/uH734Vi8iGe2vyLoWMAw22zJy3
         JibRCjGYhedTBBroII446XGza900YSH1ZtkmsbREr2Q21JMjm7KCube5JoWcnqGfGwmW
         15shsfPe2bVqi4ixLp933BQ3+YdGY22lbgh12FhZy0g4L/4y/jUnpcWKMd5Y8XKF/77n
         Ipvmc/i+hMiqibhedI74fabzfZQOncb4VuSUnHaI7yZYVOIEsMG9Skh02ACqYG2y5T1L
         ZzvBkTvR7P+ArB67rsI6Ddwev3zYupCUe6flFy3DXPCEXTURbZOKkOAWJWg9totCz5sj
         si7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qkMEU/KWvYEIN2iOOPHhvlKOommLAxNVFWpqeCr4s7c=;
        b=OIuQJ7lY4HMdUQgjZVu6fvOMnXlIlLvmS0XkmyXojnyg3IiWxeU0urKE46KxgJrpU/
         vaFqSolBrpvX/h9spGv4OcH8camtJTzQzMJTr/f6XR/CFDLuwVYunL+adtf1EJX1fRkA
         DcGuUmFq44fFNMyn+BAWDz7PtxgQ0JRNdrxRWgpxN1CdA1NVFK6wdHtehBk09zA2a6/s
         hlzR4FHkj0fiGzUG08oJcRI0R/aHGN2SjRrfQfOiaIrjXTw1eFgsMtCZwDgeLU/H72ww
         WNaA2ft5q7x1gL2neafHTRggNSVuupru1Pg13R3ENFA98ZkxNquhPDHfo6cH8J9RAINU
         So/g==
X-Gm-Message-State: AOUpUlE54ZEZVXypKOBDOfWmgltMHdwMdIjtIkNEQ58G/bbTJpQfEXpy
        MERSsWC7P9AqEt4KRbyMMKKwSRyYxHhSdDtwI45DHYMX
X-Google-Smtp-Source: AAOMgpe0hcaSMm0LO4L1hmebrsl/SLBKLf5Jh1gLtUnvMgCSBwZFI2u6Rs13UDiyhxoZMDWh2wT6ryc3RdZefayQGrU=
X-Received: by 2002:a24:2e88:: with SMTP id i130-v6mr1846748ita.123.1531920506347;
 Wed, 18 Jul 2018 06:28:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:bb58:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 06:28:25
 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1807171100190.1689-100000@iolanthe.rowland.org>
References: <20180716122125.175792-7-maco@android.com> <Pine.LNX.4.44L0.1807171100190.1689-100000@iolanthe.rowland.org>
From:   Martijn Coenen <maco@android.com>
Date:   Wed, 18 Jul 2018 15:28:25 +0200
Message-ID: <CAB0TPYG_UmZK-V2bpFZmY-LExNsv5mxfSnyG3YVALnOM7X0m0g@mail.gmail.com>
Subject: Re: [PATCH 6/6] RFC: USB: storage: move symbols into USB_STORAGE namespace.
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Kernel development list <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        USB list <linux-usb@vger.kernel.org>,
        USB Storage list <usb-storage@lists.one-eyed-alien.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 5:04 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> This patch misses the various EXPORT_SYMBOL_GPL lines in debug.c,
> protocol.c, scsiglue.c, and transport.c.  They should also be
> considered part of the USB_STORAGE namespace.

Thanks! I'd been using the usb.c symbols as my test vehicle forever,
and I forgot to check whether there were others. I'll make sure to
include them in the next series.

Martijn

>
> Alan Stern
>
