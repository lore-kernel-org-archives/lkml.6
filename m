Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6CAC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2A42087C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QklHNlPl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2A42087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932866AbeGIN5v (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 09:57:51 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:43112 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932436AbeGIN5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 09:57:48 -0400
Received: by mail-yb0-f194.google.com with SMTP id x10-v6so7205470ybl.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 06:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e5IG2t5Mzhwos36ff7qsPwYHJMWObFoEvgBP/1DlqnM=;
        b=QklHNlPl7VgGYZ+cZybld4uAQloIk1Dmw3W3/aDk52r/W/mKCTsQoi9ZuNsbHPvA9N
         4MR/tPisQwaUW+i7l/md8y1z5QQUCvGsYzPTnMIGFSs/GnhVowRykhmVVMcyxYfnp47+
         dDHUvKDg7M5QpR0Ezls5rvUpRYYQxwu5Xynxea9wDRX9YJS4ZnpWE0t/1yYHNpC6MMIm
         OcWCq9sqiAkoM7Xqprv53VmKbunFdsfra+XfCjXbtpa8/yXHHc6ZRAVg50Mii4crr1YY
         OnYf5scl4wf6RtvoPycqYaDgzWmSoE/bSczhHGQFHmKZhyUAy6NKKG3oFa1cUMpmMVaO
         lf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e5IG2t5Mzhwos36ff7qsPwYHJMWObFoEvgBP/1DlqnM=;
        b=g4dugX+GZsfswyOsYo7u9O1c5Mbsdc2W3j+9nuBc+b7R2Ak3Qb20qksf0enri3Ow0L
         59aRRvfmoNtXT7VbM2UZibtxkr/YN5kssUYzyrUgi25fBTl1restxl9AGKmzHTsfYuTe
         mKk2zUh94p+GHSrXupUpZJZ+xMsS+9GvFktij7Etu8HQpgfiuSs+gGRrGugEUYCKeQZa
         DHs7+/i+msQGXCz3WJ2mad8txBZxXldjn6A+fefGS3QiAjDuXDb/DBk07pTUmrkENp0g
         WF+OFoJ624f45ErlhPO/YuavKzkRGJ5Ci0iq2BQI6VD6yXa9xfBGHqWXIScW4tz+nGoP
         9ozg==
X-Gm-Message-State: APt69E2TbNiScz0DLBYRP5tY3s06bHK8D+HIPd/Tdvhyuc3ct+r+HWoi
        HZXVMxZU+0Lf5MtwUzJsd0lyFePhPyQv78JCIE0N
X-Google-Smtp-Source: AAOMgpeIajQJE7+Dl4E2j3KhIwObF2Rgbc+3JKhh+mxVWoFfWo4ADzYNDQXA5b4o47I+CAnUWahCz9iaFg6biIDpxus=
X-Received: by 2002:a25:adcb:: with SMTP id d11-v6mr11392413ybe.73.1531144667595;
 Mon, 09 Jul 2018 06:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <2108146.dv4EAOf6IP@aspire.rjw.lan> <CAFgQCTsGC8NH+5kXYD7vykJeUsaAzCAjgxSP-R0EqA3YvgsY0w@mail.gmail.com>
 <8816662.k3KXbdkA2e@aspire.rjw.lan>
In-Reply-To: <8816662.k3KXbdkA2e@aspire.rjw.lan>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon, 9 Jul 2018 08:57:36 -0500
Message-ID: <CAErSpo4eaaieQiZjAejXAoCv82wddPOcRQXpiqD6X=fFW5XAHQ@mail.gmail.com>
Subject: Re: [PATCH] driver core: Drop devices_kset_move_last() call from really_probe()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernelfans@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>, dyoung@redhat.com,
        linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 5:01 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
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

I'm sure you've considered this, but I can't figure out whether this
patch will reintroduce the problem that was solved by 52cdbdd49853.
That patch updated two places: (1) really_probe(), the change you're
reverting here, and (2) device_move().

device_move() is only called from 4-5 places, none of which look
related to the problem fixed by 52cdbdd49853, so it seems like that
problem was probably resolved by the hunk you're reverting.

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
