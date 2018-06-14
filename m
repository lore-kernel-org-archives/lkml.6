Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DBE36C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE78208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/jSyG9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE78208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755044AbeFNKgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:36:01 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36407 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754901AbeFNKgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:36:00 -0400
Received: by mail-lf0-f65.google.com with SMTP id u4-v6so8644001lff.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 03:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=s0ayo8rMxOtMSw5pOYBFiLv/NYDg6iA0FWNq0qGYqcM=;
        b=d/jSyG9VqU5G8Wnyf9lgSusKottw+W3s+nB3v6S1DsBXSYQjMpP8bhOEDASMcE4fpV
         lWmvM9zH5kFX3Z/rygg4GdL468an04jdUzf9HNFg4tRBis4m9Hqp/d43evkAsUfsl8hd
         OwZXjwtFNZOKQcr2WTt/6drwTvsi367hWj7quzXqjr4uZ1nJvYsSzK65cSxCk+2FolZl
         4+mGLGrvAS+3Ehw9+quIYoA30oDLPYm79TzO3/QxeaL5Qknc/6trb2lVvSCpyqDzWmSe
         poJaQTq9uvY3fHh6PhiInEX7zF2ykPDQpsRs3j9M5tBaG1QZvn5R35EXVBzHfwyAqTH/
         oq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=s0ayo8rMxOtMSw5pOYBFiLv/NYDg6iA0FWNq0qGYqcM=;
        b=eCmREc5HrnlMq4qe6mRWka/njO/VsA9IzOhOT5Y8ipN4Hx//kiD2eNpeEjeM+TxpBQ
         kVGf9yHbuS6ZlVI1v1P5u4BdsydWTvJJLqfGsv6IaWbuAvzQjgNXBCSX1kSzL0D0ccwa
         Dlb3ZWVO/zN4EnNJ0HWofxGGb6EvbKfIgZsn/evbGWK2XCZOskBE1w/YFbgGtKc8ZHAu
         ulYQFQhtfXyIzPiqimKA03m6pc0sLXYaMa3cc2WQ1IZe24gV27WO3z4HDFuXWPvw8Dpm
         3/SN6mGIhHdR0AgqNSh3Cnoc9+Q27PgD76r/2k5ABu2lJsi+wAj9mKlEJ7fJzVzaatuo
         kcsw==
X-Gm-Message-State: APt69E0muu2/jzX9cokrwVZS3oYW5/z861hexcbAPSeLtwe/nntXKPbU
        5a07UI1OjAZ05x6Phmoc++PGjC5AbZaKai/2d48=
X-Google-Smtp-Source: ADUXVKK66n2fSWiOdr41yIe2Im7X866euV1BoWV8enpNjeyyQyiA3zoWV7dBPk9VT3etP67MA16ayEpbK6StAZJx7D8=
X-Received: by 2002:a19:9358:: with SMTP id v85-v6mr5538246lfd.83.1528972558747;
 Thu, 14 Jun 2018 03:35:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 03:35:58
 -0700 (PDT)
In-Reply-To: <CAMHSBOU-f4oxR9kBkgYXOunRSUKx+cP3mJzmVKHnYJXfAzgHKQ@mail.gmail.com>
References: <20180608144834.3003465-1-arnd@arndb.de> <20180608181956.GA110395@decatoncale.mtv.corp.google.com>
 <20180611060819.GD5278@dell> <CAMHSBOU-f4oxR9kBkgYXOunRSUKx+cP3mJzmVKHnYJXfAzgHKQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 Jun 2018 12:35:58 +0200
X-Google-Sender-Auth: g393Q8QHW8FmElfsnmZqhs7RieI
Message-ID: <CAK8P3a1fv8c5fBOcs_x3F3MzjMJeJOWDGG0ay3RzBWwDoMGxCg@mail.gmail.com>
Subject: Re: [PATCH] mfd: cros_ec: remove unused __remove function
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 9:53 PM, Gwendal Grignou <gwendal@chromium.org> wrote:
> On Sun, Jun 10, 2018 at 11:08 PM Lee Jones <lee.jones@linaro.org> wrote:
>>
>> On Fri, 08 Jun 2018, Benson Leung wrote:
>>
>> >
>> > On Fri, Jun 08, 2018 at 04:48:06PM +0200, Arnd Bergmann wrote:
>> > > This function is no longer called, so we get a harmless
>> > > warning until it is removed as well:
>> > >
>> > > drivers/mfd/cros_ec_dev.c:265:13: error: '__remove' defined but not used [-Werror=unused-function]
>> > >
>> > > Fixes: 3aa2177e4787 ("mfd: cros_ec: Use devm_kzalloc for private data")
>> >
>> > Gwendal, in PATCH v2 of https://patchwork.kernel.org/patch/10439449/
>> > you mentioned that you readded the __remove to avoid a warning when built
>> > as a module. Can you explain what's going on?
>>
>> Yes please, and quickly.  I'm going to sent the patch-set today.  If I
>> don't hear from you promptly, I'll probably pull the patch!
> I readded it because when cros_ec_dev is loaded as module, I get a
> warning on dmesg when unloading:
>
> """Device 'cros_pd' [or 'cros_ec'] does not have a release() function,
> it is broken and must be fixed."""
>
> The warning comes from device_release(). Given I get a warning when I
> remove the release function or when I leave it empty. Let's pull the
> patch.

I had not realized that this function was supposed to be the .release
callback for a device, only that it was not being called at all.

The runtime warning you get is obviously correct and you do need a
.release function in the device that will free the memory for the
cros_ec_dev structure when the last reference to the device goes away.

Please send a fix for this, replacing the incorrect devm_kzalloc with
a working allocation/deallocation.

     Arnd
