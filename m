Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746E8C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31EE720866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCts0Ioz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31EE720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbeIJXkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 19:40:16 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40743 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbeIJXkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 19:40:16 -0400
Received: by mail-lf1-f65.google.com with SMTP id x26-v6so18293681lfi.7;
        Mon, 10 Sep 2018 11:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VGXlS7amxfyaK0Pa3/QnEC5MQP00XcTaEO8+YmipTcM=;
        b=PCts0Ioz34yibd15ny5gIQzTM3wnpO6unqYTNpj0jaqbY1cRw8aN5qi6Zeh+bYdDZ4
         MnESiCCtysg4wrcfVOjVnUSbPuOCUkWT0VQPSIxU2whWDYnlf0wTyJnUPlVmWZrJQGfC
         Bcmi7t7ptDHp+yu6Mslk4O4bwWRvgm3Gq339zWebAsXHQmMXvQJP+XfATnDNp0Gv/Z0r
         aIrcK5Hvh1WXGFaidyx65j5zCgiOdU97B1Ag5KN7XW0xMb0+E0HgLWXuByN4k0IC4IrO
         YWpLGhGE57oMMF5Kln+nxUrpDoSN90uGAGyZEfQaUVU9jO/NRp8mHRM9Usglwg3bIOwQ
         H0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VGXlS7amxfyaK0Pa3/QnEC5MQP00XcTaEO8+YmipTcM=;
        b=CO0puO3XbL2zzPPoL/ZayEnKGdaSjXutRBtNTHy30+Hcy8YEBpdtdqQqAt9R69QNeB
         ijL/iLZgBeFumJcYfKG0qJzoz3+kCvgacXcCtR/3mfySjLxyITYOAdvyknQk2ODm6CQ4
         m8qtM0c5/RlViA+tnUYj2Lr9WKFLbkgxCcWzLpi1q4p/wG4HS6ZWUCExazF6Ay7bBB04
         cfyccNUZtTdBDn3HEdIbxEocuPRaYZd3oAFx/s2dROIHK4FZE3JRZV/9LAwfoGDR04v0
         oGEDsv1UaoIc4T6InWIetegQDo6zaabrUOXc93oRvCTO2YeXE0UFPcO9FDATnXsQ9CC0
         2K6Q==
X-Gm-Message-State: APzg51ALAJ82qjXKLit1HHTpnKanAp+mzIeHB7ZGruYjzqA1zmAB/ljw
        dmk1sk7PYXANJGXWIa67wUgykmyoW3tHzS4l45tTTw==
X-Google-Smtp-Source: ANB0Vdbpj/y+xOYHnH+stspyOVESavFrSP52WK+PrRd68AigpKPtYppk/lyqMbXxwVgUUZv8QPV/cWjAowqvhU1GsIw=
X-Received: by 2002:a19:5a17:: with SMTP id o23-v6mr12887643lfb.51.1536605088439;
 Mon, 10 Sep 2018 11:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180910182143.GW5662@atomide.com>
In-Reply-To: <20180910182143.GW5662@atomide.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 11 Sep 2018 00:17:45 +0530
Message-ID: <CAFqt6zaRFW+bwVmWbMQ9ni9VJzsa1QMPRLFDCE6X0yQbvbPukw@mail.gmail.com>
Subject: Re: Regression in next with apps hanging with vm_fault_t
To:     Tony Lindgren <tony@atomide.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Eric Biggers <ebiggers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>, kemi.wang@intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 11:51 PM Tony Lindgren <tony@atomide.com> wrote:
>
> Hi,
>
> I'm seeing a regression with Linux next with commit 7b6ec2ae877a
> ("fs: convert return type int to vm_fault_t") where apps can just
> hang.
>
> The reproducable test case I have is to remove a distro package
> and then add it back where adding the package back just hangs and
> the package file seems corrupted.
>
> This is with ext4 rootfs on MMC, NFSroot does not have this
> issue. Any ideas?

This is a bad commit and there is a plan to remove it from all the tree.
Not sure why it is still showing in linux-next tree.
