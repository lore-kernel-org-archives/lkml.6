Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66210C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1408420881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vq/9j6Ta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1408420881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbeGJGdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 02:33:43 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53380 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751129AbeGJGdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 02:33:37 -0400
Received: by mail-it0-f66.google.com with SMTP id a195-v6so28885797itd.3;
        Mon, 09 Jul 2018 23:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RXvCm2b1RxOO65ySOZT2fw2NttHpGPva4cEEbYYtFSI=;
        b=Vq/9j6TaJJIcN728vFTw2hmRVE9EYTxjYto5KTj50L0EKxBvL4mts73rP07ZbUuSz+
         hGNJ+3ViFaK/uqlvmr7gV9ny/lJvP6S/LBV4yGc0uaHJXOreYLfNxdNdQqOTpPVNHnCp
         TsV/1GhZikou5EB/E89cmamcw55F8Wyo9JRIdaHdgi4najZByo57lby7IIxHIK1L6r1t
         TnuZKz89YBP0vsdlmyD4xCUApJH9SRh1pRGNtx0V+/NdKuiExnVHNaoi2/XBThP4siAv
         8jJ1O1wzEp/pks6FdJN7flUq0UW7SqFOvCx6DPCH7UFHcRzP1lefszfKPjKIGX6LvqSn
         U2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RXvCm2b1RxOO65ySOZT2fw2NttHpGPva4cEEbYYtFSI=;
        b=rLN/0vNbLAZs4/2hfkABFk0oiifQJ7qcjy51z4QmRjRpeYWNqFGqFpFBjYAtK8k0LW
         BjyRVHW5jJyJr2/z3TwH2FqEsdRxIq1XtiCJExuYNKmnEbFPmAFMAgxlzC9RFLgriRWc
         pqk8zV4zRk/TLZ08OZ2eEWDjbJ0LXo7yRrdd0CZpa8xJQRPhpvHbscsEnNjebr8CFwGo
         Qt/ZOiM/z9yo10RlaS8CMIh4EVZ/rZytDG9SNv40UBJBZDr5SRTzeUVbLa3C/1LFMnVz
         PeJbCFrPfM44tLfW1K5y1WG8MBJqYAvmFXkmrDpfv1ru05P4Nk9KYYCM5TNMmkR0fF4T
         YDBg==
X-Gm-Message-State: APt69E2VNlo9jTn0HUF+4d9JVHaAdEEn53TRE1bHY5FCA472goG5YPMY
        2iUYbmyQ2FQxB3/IJOIWTAPcD2/GxYLPRA0IIw==
X-Google-Smtp-Source: AAOMgpew48GwZS2CP1N8koZweFZcYgBJ0vjxMDHKye6dpLjmCnoZtRGIVDVR6T+kiZyCsSZ2X/Z8D3DKYzm1DeK0wnU=
X-Received: by 2002:a02:8c94:: with SMTP id f20-v6mr19276348jak.98.1531204417257;
 Mon, 09 Jul 2018 23:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <2108146.dv4EAOf6IP@aspire.rjw.lan> <CAFgQCTsGC8NH+5kXYD7vykJeUsaAzCAjgxSP-R0EqA3YvgsY0w@mail.gmail.com>
 <8816662.k3KXbdkA2e@aspire.rjw.lan>
In-Reply-To: <8816662.k3KXbdkA2e@aspire.rjw.lan>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 10 Jul 2018 14:33:25 +0800
Message-ID: <CAFgQCTvyPY5KiaSR0P0z+K_CTOA45kvjm=w7tWnTbvH_yy858w@mail.gmail.com>
Subject: Re: [PATCH] driver core: Drop devices_kset_move_last() call from really_probe()
To:     rjw@rjwysocki.net
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
        lukas@wunner.de, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 6:01 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The devices_kset_move_last() call in really_probe() is a mistake
> as it may cause parents to follow children in the devices_kset list
> which then causes system shutdown to fail.  Namely, if a device has
> children before really_probe() is called for it (which is not
> uncommon), that call will cause it to be reordered after the children
> in the devices_kset list and the ordering of that list will not
> reflect the correct device shutdown order.
>
> Also it causes the devices_kset list to be constantly reordered
> until all drivers have been probed which is totally pointless
> overhead in the majority of cases.
>
> For that reason, revert the really_probe() modifications made by
> commit 52cdbdd49853.
>
> Fixes: 52cdbdd49853 (driver core: correct device's shutdown order)
> Link: https://lore.kernel.org/lkml/CAFgQCTt7VfqM=UyCnvNFxrSw8Z6cUtAi3HUwR4_xPAc03SgHjQ@mail.gmail.com/
> Reported-by: Pingfan Liu <kernelfans@gmail.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/dd.c |    8 --------
>  1 file changed, 8 deletions(-)
>
> Index: linux-pm/drivers/base/dd.c
> ===================================================================
> --- linux-pm.orig/drivers/base/dd.c
> +++ linux-pm/drivers/base/dd.c
> @@ -434,14 +434,6 @@ re_probe:
>                         goto probe_failed;
>         }
>
> -       /*
> -        * Ensure devices are listed in devices_kset in correct order
> -        * It's important to move Dev to the end of devices_kset before
> -        * calling .probe, because it could be recursive and parent Dev
> -        * should always go first
> -        */
> -       devices_kset_move_last(dev);
> -
>         if (dev->bus->probe) {
>                 ret = dev->bus->probe(dev);
>                 if (ret)
>
Tested-by: Pingfan Liu <kernelfans@gmail.com>
