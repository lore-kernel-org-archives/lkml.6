Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73BAECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D75208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0uHdyuF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D75208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbeIXOV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 10:21:56 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37045 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbeIXOV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 10:21:56 -0400
Received: by mail-qk1-f193.google.com with SMTP id c13-v6so10698752qkm.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 01:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C1gJRhX9kcXYo+qobOGEZNI2c+EQHg1Y8CnwRzwKVVM=;
        b=B0uHdyuFyqcpqN1uozzGtANtWhdGVuqgSb4G36FRhv+RseAJyeRzpTt55lpReKE6Lz
         JsJ92+RNjC/ikkI31a56pLvPApRmAIre2UtHJcIL5jqkqPoARw7AkvSZaVQKK2FfO5rO
         ZfEJWe6KaBIsAW19wQIDM5Au7jUzHTFNDT8D4BkDMpoK/zfrOpx24x3oMThIZTxcrGe6
         da06u4zXjp7i/M1fKG8DMEvhs2RacEu0fPyCXuPH2FabSvplboSMNaAAWAIT1TbMfB/N
         014au0PnPlEiAknSIdeEiJLx63R3Es0IJZm00WHtziHOiGJEk85nur8EQp96um3LXTs4
         Y/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C1gJRhX9kcXYo+qobOGEZNI2c+EQHg1Y8CnwRzwKVVM=;
        b=JCQo1jpe5t0lMys8KDq9xSnGTD03TJqSHScIaxfai6MXYkqQneOnWDvG68+AchJicQ
         dCHqF9cRNTiWr/sI7CuiG2zvFxIZOYay9OebjI4tub3wDJl4kHDde6dkWbxEtxCFlAA8
         GJCfz75/g+Uf6GKJu5cwzwfmB1dtu4wNZC4MxANdLWya5wp2mf0Sg5N/oRcMxlKIdFrj
         9F6QcS7mANcf5pU+JlCUUf0ZZsgsQgq3C6baYoFvEE5MqBqPM9GG0iyHkPTTO5cu0e01
         K8khLuX413ecFRh5Jwu8uMQWkj9KDKOlwMLiRQBJQYxhONTkDnsZ8dukLrNHrlIMcPn7
         MSBQ==
X-Gm-Message-State: ABuFfoixkooCXG/r1ZwyZ1sMpr3rcRDx3DXMHoarEDnyI4a75Txpix5u
        Oi1aBcvalULLqbjOwdNlIgcrCWX9jSdSCpqMgNyBRA==
X-Google-Smtp-Source: ACcGV634+VvDqp/ujEPvvOANCkQFprEuz1g0xV5mX9nTDT1WVL8Bsh0LGfDZ0oyVSoyGzTrf1opnx3cFZHGeSAuxLvU=
X-Received: by 2002:a37:dc41:: with SMTP id v62-v6mr4020262qki.109.1537777261484;
 Mon, 24 Sep 2018 01:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180920144904.24911-1-romain.izard.pro@gmail.com> <1537535934.15252.3.camel@suse.com>
In-Reply-To: <1537535934.15252.3.camel@suse.com>
From:   Romain Izard <romain.izard.pro@gmail.com>
Date:   Mon, 24 Sep 2018 10:20:50 +0200
Message-ID: <CAGkQfmNfYCObGG+zYmokRDqqKbcjVoaAxrYfnz70moZiyE6qCg@mail.gmail.com>
Subject: Re: [PATCH] usb: cdc_acm: Do not leak URB buffers
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-09-21 15:27 +0200, Oliver Neukum <oneukum@suse.com>:
>
> On Do, 2018-09-20 at 16:49 +0200, Romain Izard wrote:
> > When the ACM TTY port is disconnected, the URBs it uses must be killed,
> > and then the buffers must be freed. Unfortunately a previous refactor
> > removed the code freeing the buffers because it looked extremely similar
> > to the code killing the URBs.
> >
> > As a result, there were many new leaks for each plug/unplug cycle of a
> > CDC-ACM device, that were detected by kmemleak.
> >
> > Restore the missing code, and the memory leak is removed.
>
> Try as i may, I don't see the difference. Could you put a comment exactly
> describing the issue into the code itself, lest this problem reappear?
>

The critical point is that on shutdown, the URBs need to be killed with
usb_kill_urb, and then released with usb_free_urb.

As the code for iterating on all allocated URBs and the parameters are the
same for both functions, which also have the same length, the difference is
visually subtle. But conceptually, it is not subtle at all.

I believe that this does not need a comment.

Best regards,
--
Romain Izard
