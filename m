Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F24C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4476020652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nzlxJZX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4476020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbeIGWgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:36:19 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43198 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbeIGWgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:36:19 -0400
Received: by mail-io1-f66.google.com with SMTP id y10-v6so2187083ioa.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 10:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=56eXda+u3EN/asILw4ni54x7KtNJzcwfosaEbrHtj/4=;
        b=nzlxJZX5o8wOdpKXOKKzfDerHk2dpZ7nSx4rz+iZQ0ArjPjyv/caOBWLZ4NYKGo786
         kgMVPcfNcW41N7N+KD6kQoCNb3yy8AL3qxnMrjXUr7AQCcf8uI05Z+eoLsnJ22NKDDzM
         tSPB7FjlV8tmJJcagPNOfKJdsYiGw9bMbdkCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=56eXda+u3EN/asILw4ni54x7KtNJzcwfosaEbrHtj/4=;
        b=JzmkFUZnXERN59nRnw2h7w9k492KkW+GL7q/uveoCaDsZb+SpG6bGh/NFGh3dnFdQS
         b8QbfENptjauMYXO1HgNZPPSfoaS5I0KHUGJNW3DZ6SnsXrgYTs2IpnWPmPEkwD2antt
         v+nouxX7W9HnR0fLQii9JE0V60XMWCTDQFHDG806ZJI1CLJP4ydkiJ7vWBplM0I73mU4
         WMCPx8rcQNJAxQNv5gsfVzZQGOApE+YDC0V/HLytQpJwWHY5IxWqjDaqlxQeLmjTmw2D
         WisTQaW9isG20LVaq0P14o5tJzb9zajEi1KhvpQI2KV+ou7yTx2nCYSKNBZcjSB1x9vr
         032w==
X-Gm-Message-State: APzg51C0VktWcZ1rDBv1mEgb3RBViFFEPJ406WkEkU7frfubSw28tVi+
        aWiKMiLcaEifvtfWeda2vaDBe9RF84cxmcfIWnDdqw==
X-Google-Smtp-Source: ANB0VdYCAIpBA+i0KXnbzTbt5s/GSzlqK9l3tbm7m/De2ouAxECnzvXFDCV3m1u0HTExi/Yxf3KXzMEssmUsFlpu3q4=
X-Received: by 2002:a6b:9f46:: with SMTP id i67-v6mr6893025ioe.182.1536342856178;
 Fri, 07 Sep 2018 10:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180907002728.112770-1-grundler@chromium.org>
 <20180907121128.GH17459@sirena.org.uk> <CANEJEGv0A8LO1znHToYOkddzr_JmHpogvYewVrMpK+ZB6SJX5w@mail.gmail.com>
In-Reply-To: <CANEJEGv0A8LO1znHToYOkddzr_JmHpogvYewVrMpK+ZB6SJX5w@mail.gmail.com>
From:   Grant Grundler <grundler@chromium.org>
Date:   Fri, 7 Sep 2018 10:54:04 -0700
Message-ID: <CANEJEGtWeBY7TMctUUn6q67FF5A6zMB2y8TbRtXEKsBREYn7CQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: max98373: usleep_range() needs include/delay.h
To:     Grant Grundler <grundler@chromium.org>
Cc:     broonie@kernel.org, ryans.lee@maximintegrated.com,
        lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com,
        alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[resending as plain/text - sorry]
On Fri, Sep 7, 2018 at 10:52 AM Grant Grundler <grundler@chromium.org> wrote:
>
>
>
> On Fri, Sep 7, 2018 at 5:11 AM Mark Brown <broonie@kernel.org> wrote:
>>
>> On Thu, Sep 06, 2018 at 05:27:28PM -0700, Grant Grundler wrote:
>> > Commit ca917f9fe1a0fab added use of usleep_range() but not
>> > the corresponding "include <linux/delay.h>". The result is
>> > with Chrome OS won't build because warnings are forced
>> > to be errors:
>> > mnt/host/source/src/third_party/kernel/v4.4/sound/soc/codecs/max98373.c:734:2: error: implicit declaration of function 'usleep_range' [-Werror,-Wimplicit-function-declaration]
>> >         usleep_range(10000, 11000);
>> >         ^
>>
>> Note that this isn't causing a warning upstream, presumably due to an
>> implicit inclusion that isn't present in the v4.4 kernel that you appear
>> to be using, or gets missed due to config differences.
>
>
> Ok. Is this just an observation or are these reasons to not accept the change?
>
> cheers,
> grant
