Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B03C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6E520881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCYikHRL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D6E520881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933366AbeGIVfS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 17:35:18 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34944 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933060AbeGIVfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 17:35:16 -0400
Received: by mail-oi0-f67.google.com with SMTP id i12-v6so38718509oik.2;
        Mon, 09 Jul 2018 14:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=9Nfs72WMH3kVKxZWJLdnyeTUwGypm2E9KNiKX32WxTw=;
        b=RCYikHRL/5E/TDebrjEw61ruxiY84KSx5dg/fNpVamFGqssDcWHpAMhVhRdUG7MufO
         ORvI5oUujnHod3SKBNumU6DwFzsb/dA6fGQQs524W5ynKer31eb/vKJw5eu33waouhnZ
         YUVeKOLl9HYYiYyJHfxM18b7he/iqvDoZHdm2Sra05vQ5oFc0ZfXgBUrsfnF4BhHIzTK
         2yBn22Sz0gucyv7eZ1jh0BzDszKc12g+ba78Ey55d4M65eRWW6DtYsmAJlK8rPhyGmNg
         hHcvDMA+tKtQ4S6mDlZ+3WVv1weM71s0BqRZMOXFr3N/6hF5BofP9idw5+bqtzhEMP4T
         Myow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=9Nfs72WMH3kVKxZWJLdnyeTUwGypm2E9KNiKX32WxTw=;
        b=OTJrk5C2qt1IvQPpZ/VFE/fh2wzl/VQqqzSGcQRgJCxqS31BKybFm4ZC527pVHaedP
         U/qaIORuHdu0houp5CN20835dJ7kV+kARVBeNDU2zKaX4Phw6UOh/P2SHinezVD3YvFX
         Ne+FGR7+WBsZeGLYDk+K8/SDJFtvmfHiA3E1V7TyxnKXiZFSzCuLO/zQGRdaIgZAlpAT
         6jOdlw+R9gFxk+2UI5T4Q0UwBIyVAdeOQp5PVMuHlQO/6WJy4gyzEpGNIdix3zRKSINM
         2+Pa23bP10T2m7r3SubGNIbX9gbcO7L3VXtBQ4UIgx2/yHy7aUnWarFAT09iIx8/ib26
         XBXg==
X-Gm-Message-State: APt69E1SwSnwSHPEDts4ySLPTZ10sbdvEN8DUAGrpPlEDEZfn4g4ZSrg
        e71TDEPp2tl6vIjJqabpJsmd4i+LWfsqrzAtWt4=
X-Google-Smtp-Source: AAOMgpf1QpFBNBxCYobCPOBw8XUSfwiv3wguadM+yrGBJP5IZoJg/eh3oXU4AUZw2kQfDYdR4+GEefc3OYoHN6wLPiM=
X-Received: by 2002:aca:6910:: with SMTP id e16-v6mr23699456oic.358.1531172115321;
 Mon, 09 Jul 2018 14:35:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 14:35:14 -0700 (PDT)
In-Reply-To: <CAErSpo4eaaieQiZjAejXAoCv82wddPOcRQXpiqD6X=fFW5XAHQ@mail.gmail.com>
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <2108146.dv4EAOf6IP@aspire.rjw.lan> <CAFgQCTsGC8NH+5kXYD7vykJeUsaAzCAjgxSP-R0EqA3YvgsY0w@mail.gmail.com>
 <8816662.k3KXbdkA2e@aspire.rjw.lan> <CAErSpo4eaaieQiZjAejXAoCv82wddPOcRQXpiqD6X=fFW5XAHQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 9 Jul 2018 23:35:14 +0200
X-Google-Sender-Auth: _dMpI-_HOTCOZYXlT8LfMztqqIQ
Message-ID: <CAJZ5v0hVDo-Y2gPTxd6yHVY=vr093hai1VhLzNzzhFkKe0LoKA@mail.gmail.com>
Subject: Re: [PATCH] driver core: Drop devices_kset_move_last() call from really_probe()
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 3:57 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Fri, Jul 6, 2018 at 5:01 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> The devices_kset_move_last() call in really_probe() is a mistake
>> as it may cause parents to follow children in the devices_kset list
>> which then causes system shutdown to fail.  Namely, if a device has
>> children before really_probe() is called for it (which is not
>> uncommon), that call will cause it to be reordered after the children
>> in the devices_kset list and the ordering of that list will not
>> reflect the correct device shutdown order.
>>
>> Also it causes the devices_kset list to be constantly reordered
>> until all drivers have been probed which is totally pointless
>> overhead in the majority of cases.
>>
>> For that reason, revert the really_probe() modifications made by
>> commit 52cdbdd49853.
>
> I'm sure you've considered this, but I can't figure out whether this
> patch will reintroduce the problem that was solved by 52cdbdd49853.
> That patch updated two places: (1) really_probe(), the change you're
> reverting here, and (2) device_move().
>
> device_move() is only called from 4-5 places, none of which look
> related to the problem fixed by 52cdbdd49853, so it seems like that
> problem was probably resolved by the hunk you're reverting.

That's right, but I don't want to revert all of it.  The other parts
of it are kind of useful as they make the handling of the devices_kset
list be consistent with the handling of dpm_list.

The hunk I'm reverting, however, is completely off.  It not only is
incorrect (as per the above), but it also causes the devices_kset list
and dpm_list to be handled differently.

It had attempted to fix something, but it failed miserably at that.

>> Fixes: 52cdbdd49853 (driver core: correct device's shutdown order)
>> Link: https://lore.kernel.org/lkml/CAFgQCTt7VfqM=UyCnvNFxrSw8Z6cUtAi3HUwR4_xPAc03SgHjQ@mail.gmail.com/
>> Reported-by: Pingfan Liu <kernelfans@gmail.com>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>  drivers/base/dd.c |    8 --------
>>  1 file changed, 8 deletions(-)
>>
>> Index: linux-pm/drivers/base/dd.c
>> ===================================================================
>> --- linux-pm.orig/drivers/base/dd.c
>> +++ linux-pm/drivers/base/dd.c
>> @@ -434,14 +434,6 @@ re_probe:
>>                         goto probe_failed;
>>         }
>>
>> -       /*
>> -        * Ensure devices are listed in devices_kset in correct order
>> -        * It's important to move Dev to the end of devices_kset before
>> -        * calling .probe, because it could be recursive and parent Dev
>> -        * should always go first
>> -        */
>> -       devices_kset_move_last(dev);
>> -
>>         if (dev->bus->probe) {
>>                 ret = dev->bus->probe(dev);
>>                 if (ret)
>>
