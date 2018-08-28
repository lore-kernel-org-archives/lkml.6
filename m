Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD08C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8942086D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uVaytGOB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE8942086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbeH1PLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 11:11:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45728 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbeH1PLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 11:11:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id 20-v6so1197532wrb.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 04:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WiGnQIio0Luh7VvpMPFlsc6HDA3Xz/h3SfFYIeGIEJ0=;
        b=uVaytGOBgaB8g6L7RKbnAY6TqhJpJpLDMboTcruegcwKkkTRF6vLIXJ2C0+se5gUp1
         ZS/xDnP9rwKVMcqXk2NyEMA3RLemK3RkJceUH26+LB/qcX1ILFwgvTe8ArQTFHolASk8
         wRn+A90kCgFvmxdqWCifkALt5bbFwEiSR02vq4iZDHR1XJ2igoKDCn6jn53LQDHTLXlo
         /TiiqxNDlFG/z6RWujG8qw8vvRybLNt67rqHchfp0cjVdvD3C2mPOBVzFY3lcI+Ir0sr
         7JtOCzpFlDeitb93sQjx+hi7pPB7YNc41+y6rLv6XaI453BinF4A4nsJ/7Z54QCJdRX+
         6UCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WiGnQIio0Luh7VvpMPFlsc6HDA3Xz/h3SfFYIeGIEJ0=;
        b=SsMtnZE/KEmR1nQ4MjLKy4TwXuxK2hW5tRLv+zKvq0rmUwbQ1W1h2o7mwfQZDFRkqF
         6IEWjS77RHZMaVS5DoANtYidta9BlvqQmmlpxdxtX1lnVSnH53tkBJlXjmndgbRr5qIP
         rE3Wz6vWga4cOBQOF6qkuxdOcQxZ838OdtZYKrj+LNtSGXg8lawo9BDBdKs+2uSw9nW5
         0RkB9PsN/fDFiOUCSLurfHP8W889R7b0fsDwhHogVEBMNeoSjnnMd6kOENCbIQd96oje
         mJCZsAsPKq+OqPNGC7fB65D3XyYe+P+4QjP4E+5uRPjBvZ8SUamg2XtbvGI8JFryRLFo
         kx7Q==
X-Gm-Message-State: APzg51AQffZVeALYt/dFW6ijsVLOM7lYZhYDHTYqSv9GTM8sgdIQbvan
        ibsrrsIRPsEYEcpM0kLjAMjmrul/hKmYaeEYKqWIlIzs
X-Google-Smtp-Source: ANB0VdY63BOsV/dPDiMR1apnnhwJ5yn6UVNzwKzobGisfLlj5VYkfpsrbLtz755IPNREMEmM9utS+mor1pEZt3BhqOo=
X-Received: by 2002:a5d:4cc8:: with SMTP id c8-v6mr848130wrt.210.1535455232490;
 Tue, 28 Aug 2018 04:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180818155724.GA22569@kroah.com> <20180828103817.GB1397@do-kernel>
In-Reply-To: <20180828103817.GB1397@do-kernel>
From:   Todd Poynor <toddpoynor@google.com>
Date:   Tue, 28 Aug 2018 04:20:20 -0700
Message-ID: <CAAW3YpabUJHRT34=PboTfW-NJBeCinrfrzwf2Jp_nT2thDJoaQ@mail.gmail.com>
Subject: Re: [GIT PULL] Staging/IIO driver patches for 4.19-rc1
To:     darwish.07@gmail.com
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        LKML <linux-kernel@vger.kernel.org>, devel@linuxdriverproject.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 3:38 AM Ahmed S. Darwish <darwish.07@gmail.com> wrote:
>[...]
> On Sat, 18 Aug 2018 17:57:24 +0200, Greg KH wrote:
> [...]
> > addition of some new IIO drivers.  Also added was a "gasket" driver from
> > Google that needs loads of work and the erofs filesystem.
> >
>
> Why are we adding __a whole new in-kernel framework__ for
> developing basic user-space drivers?
>
> We already have a frameowrk for that, and it's UIO. [1] The UIO
> code is a very stable and simple subsystem; it's also heavily used
> in the embedded industry..

Yeah, it's clear all the userspace I/O framework code needs to move to
UIO with some patches to add agreed-upon new pieces.  I think everyone
agrees this code shouldn't move out of staging until that happens.  A
whole lot of work is needed on these drivers, and UIO conversion is on
my list to address soon.

>
> I've looked at the gasket documentation [2], and the first user
> of this new in-kernel API [3], and this is almost replicating UIO
> it's not funny. [4] True, the gasket APIs adds some extra new
> conveniences (PCI BAR re-mapping, MSI, ..), but there's no
> technical reason this cannot be added to the UIO code instead.
>
> More-over, the exposed user-space API is just some ioctls. So if
> google hase some shipped user-space code that is using this,
> hopefully the driver can still be re-implemented through UIO
> without changing these bits..
>
> Thanks,
>
> [1] https://www.kernel.org/doc/html/v4.18/driver-api/uio-howto.html
> [2] drivers/staging/gasket/gasket_core.h :: struct gasket_driver_desc
> [3] drivers/staging/gasket/apex_driver.c
> [4] include/linux/uio_driver.h
>
> --
> Darwi
> http://darwish.chasingpointers.com

Thanks -- Todd
