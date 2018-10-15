Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F01C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F31E20652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F31E20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbeJOUUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:20:16 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42884 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeJOUUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:20:16 -0400
Received: by mail-lf1-f68.google.com with SMTP id s10-v6so13926271lfc.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 05:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xqMmcV840/cNqMlqPiYyrfsdbtEHwFxf8zEG1orL+ns=;
        b=am7DEKuLK36HN4KbMKkMHCkKZWzy4hCeFwsfYA6mwAUYpBeACvKdAcoEMHC6Uyn0kP
         PEzHOn5to/3oV30eRHi4LTJd+ivdo7DwfdtQFvWe2AeGK3k1AF5llVhNiLebfuvNH6T0
         c5uPEsyF1ma4KCB30edz/a8DygFI9T4Ce6FPkCcjFe358KJmnk/7Ah+AWP/VnFhnYc2D
         B6E1VlNRCqud1M3HEbKQ1o/3EtNsqQ/bZFMrMcRFyljkPY/0KzFH7NJPxctOx5LcN7j5
         Uf+o/JrXwBYlDJbdW+ldRsNPfiOOlm7c7p+43qUBV4lF16JMB3fRU9QDQu5xVc2bQRuB
         6lhQ==
X-Gm-Message-State: ABuFfojq68rHmtt/2dy0NSCnS7HzvfUPxx5zWpaG4h15SIYe6GMwqAbw
        5Oorg363P/3G4/959UBrs9i0xTQ/g6fwcJ+CYC137g==
X-Google-Smtp-Source: ACcGV62KxQiKOoV+ESwhjCcV1GIAKxDWIkVjGrX9IagFGBFNZbnMPoPeLncZsjtBQtjuzbaCaqi7utAlrHfJ84ZF+tA=
X-Received: by 2002:a19:9150:: with SMTP id y16-v6mr2685154lfj.98.1539606908295;
 Mon, 15 Oct 2018 05:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180907103450.13890-1-benjamin.tissoires@redhat.com>
In-Reply-To: <20180907103450.13890-1-benjamin.tissoires@redhat.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 15 Oct 2018 14:34:56 +0200
Message-ID: <CAO-hwJJ8D6E3wMCAy4m2AX6AF9C=-S+iNi1uUM=MjQmAY-DQ8A@mail.gmail.com>
Subject: Re: [PATCH 0/7] HID: logitech-hidpp: support non DJ devices
To:     Jiri Kosina <jikos@kernel.org>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        simon@mungewell.org, ogay@logitech.com
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Sep 7, 2018 at 12:34 PM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> Hi Jiri, Nestor,
>
> I have this series in my tree for a while now (first commit was in January).
> I never sent it (as far as I can remember*) because I was requesting
> feedback regarding the G920 wheel. I think I haven't break it, but
> mistakes can happen.
>
> Anyway, I think it's been too long, so I am just sending it now, as
> it will fix the names of the non-dj devices that share the same USB receiver
> (G900 and G403 for instance). Also, rebasing on top of new code is a pain
> I'd rather not do every 3 months.
>

Can anyone review this series?
It's been in my local tree for too long and feels too lonely there :)

Cheers,
Benjamin

>
> * looking into my archives, I actually sent those as a part of the
> battery support in hid-logitech-hidpp. Consider it as a fresh start though :)
>
> Benjamin Tissoires (7):
>   HID: logitech-hidpp: allow non HID++ devices to be handled by this
>     module
>   HID: logitech-hidpp: make .probe usbhid capable
>   HID: logitech-hidpp: support non-DJ receivers
>   HID: logitech-hidpp: get the name and serial of the other non-HID++
>     node
>   HID: logitech-hidpp: create a name based on the type if non available
>   HID: logitech-hidpp: support the G700 over wireless
>   HID: logitech-hidpp: support the G900 over wireless
>
>  drivers/hid/hid-ids.h            |   4 +
>  drivers/hid/hid-logitech-hidpp.c | 470 +++++++++++++++++++++++++++++++++------
>  2 files changed, 407 insertions(+), 67 deletions(-)
>
> --
> 2.14.3
>
