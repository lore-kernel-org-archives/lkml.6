Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C6FC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E2DB20868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUIm12IZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E2DB20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbeJZWRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 18:17:40 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43300 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbeJZWRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 18:17:40 -0400
Received: by mail-ot1-f68.google.com with SMTP id k9so1064504otl.10;
        Fri, 26 Oct 2018 06:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d7F7o3iY5Xq+a1FKbiif3XaIk7dmJ9kYCMFcwmuTabM=;
        b=TUIm12IZ6XVUCN7b5c74N48taIF4GsIsFTXVLzlQWdHETGxY0JRcfMAC4I5M7iBR8G
         5+h7HYhPisUr5csMd7FQfjVV8w+8YGd0Z6aXgOjGtl7WOv3wKxvZDEeA9l+xgk3ciVPe
         Cq7iHHbGQdkgUo3Rz6Z6Q6q3jDpGMRf43gxMT4DM8X8lCGhM7sf5o2k/NRFb/JhCl2SI
         5h3CIyHc5FYOi3b1j1NBJVreMKs/L+icLxaTt8AP4HdBViJfRbiHRGSIW1txHyvM8cnw
         W4D792eZItcr0+aoKmfWX8i1rhcKvltLwYET7/NDLaBgJ5YN6nE5w62APdzr/mWhivG8
         t3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d7F7o3iY5Xq+a1FKbiif3XaIk7dmJ9kYCMFcwmuTabM=;
        b=DQnkoJfBzGP5eq4hvrND+dwhrGA/U2HeUBO8JdYO5FK2GanV+lHP9FJOZurn0t8ioZ
         GxsIemDpb5T7q10wVtsjHvpy0IcA5GcFLo8no2lUdIjq2brQ+xnCSQdgvILKwUhvGuN0
         6Ay+P26uK7n0JnRfaFJpx+XAxtbE+IZAh6cVsOCL9Jq+m3xF6xtjmqk0rzBagbezD96f
         aYgSy1kQ629mihnMWTTREfXQBr1X9a/mxLamMCW3sYImaPVAZ/ahmxmhW9eluw4jxEUB
         I+2+eHROpVJB6PxmtefVPXhiylbo01JUjsAIMoKOWd/y4CUe0tEQUl5i1Moyxn7yV9FP
         bDQQ==
X-Gm-Message-State: AGRZ1gLxPJ8BPidIwic+DFseVI2arsbEVhWH791l6fDCzHlsJtGJDNGJ
        IoXOJW8iMwBnoIopdYgGKyaMC0uA5sm1Snu7kdc=
X-Google-Smtp-Source: AJdET5dONEDDaf95EOplS69XzvUnPdNLhayvxglhujgqQ4Va/YTwZT5uJFmFvqmCJM2YVKfzs+8vOHSa7QXvKSw8y+o=
X-Received: by 2002:a9d:d61:: with SMTP id 88mr2222754oti.245.1540561232916;
 Fri, 26 Oct 2018 06:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20181024142456.10084-1-svendev@arcx.com> <20181024142456.10084-2-svendev@arcx.com>
 <20181026083410.GO4870@dell>
In-Reply-To: <20181026083410.GO4870@dell>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Fri, 26 Oct 2018 09:40:21 -0400
Message-ID: <CAGngYiVZ3y2Y4Wg=CEqoO+C0Mr1CYspON1C=Kmb-vq=kxs5bUg@mail.gmail.com>
Subject: Re: [PATCH anybus v1 1/4] mfd: support the Arcx anybus bridge.
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Sven Van Asbroeck <svendev@arcx.com>, robh+dt@kernel.org,
        mark.rutland@arm.com,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org,
        john.garry@huawei.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        yuanzhichang@hisilicon.com, Stuart Yoder <stuyoder@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        maxime.ripard@bootlin.com, bogdan.purcareata@nxp.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Wow, this driver is going to need a lot of work.

I'm open to reworking this 5 times if need be :)

>
> But before we get going, how many sub-devices does this have?

This is a custom piece of h/w which exposes two anybus-S slots, plus a
power readout in sysfs, I wasn't quite sure if mfd is the right
abstraction for this.
