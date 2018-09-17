Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B18FECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455A02088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aIeBRTSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455A02088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbeIQVVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 17:21:10 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:35157 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbeIQVVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 17:21:10 -0400
Received: by mail-io1-f52.google.com with SMTP id w11-v6so11925474iob.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 08:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Tsr7gJFmk83jWI6fRjp3my7jqo1it9S8wvEhdrgGOw=;
        b=aIeBRTSmM9sItnkno9UsR4GnH0LvykJsU4YF++nLObpFf6XLPkGhMmm5begF6Dv0cT
         V8kEZh50CH6i6uapKh+/IEOQ41+LDrKC3Hi1gpaYc7vEzeas26KqOlZykKneD1n5+X3t
         6CGG5DI9VQP5lWkBAnExPfMruaMYmN+dhJtIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Tsr7gJFmk83jWI6fRjp3my7jqo1it9S8wvEhdrgGOw=;
        b=qBphPLZLVIG3zu0dxP6fJwVKYHuO+yNbMI44BkbLJiW8wKDqArGjiHB2I09lunhEMe
         acIv5Hd53RX4aWTYsUF8ifyFz1MscJW0khKu98szJFOw5Vam7Kk6mn1qGztnQtSQfo68
         EZKzgN36sDulf4KD7hj8afNVLEtrQ8RO112rPI5GgpiCUvz5aJsiRVqoPlO/0Yr0VjnF
         j9BY4V/4J3/wT68cznlYoudbNOYXyLzxcQdIf35JMCFxbevlMzLmlLDajJUIQpaDQY5D
         CNwRDUTej9w+DOaW1y5Ck1hqXzId/fJb/wqbClFavGwR0ndhJRW3yj6ArubRZKHpVByb
         oFzQ==
X-Gm-Message-State: APzg51DzWi7I5AEpodLuC9zhouYXEJZXdjdz2ZWjb+/u5mawFznN5vgQ
        J1r4vZx9HQ0z4hliDvZDraAV5+3tp697DCd/L6gGsQ==
X-Google-Smtp-Source: ANB0VdaqNKt/tlNftjthLtZQtY8FihyyqYRiCMcQEgzzSODvoZ7PfvimNKryml/ki8CasiHhvs2tFZ11fHhnSBmPL2w=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr9815995ioa.277.1537199593257;
 Mon, 17 Sep 2018 08:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180917124935.GA26204@kuha.fi.intel.com>
In-Reply-To: <20180917124935.GA26204@kuha.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 17 Sep 2018 08:53:00 -0700
Message-ID: <CACRpkdbCwwNmhHHL8cY8zC9+Huyif+z44rpgcHrZF_9NG68xgg@mail.gmail.com>
Subject: Re: gpio regression in linux-next
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 5:49 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:

> I hit a BUG while attempting to unload fusb302 driver module on my
> Intel CHT board (GPDWin). I bisected it to commit:
>
>         461c1a7d4733 ("gpiolib: override irq_enable/disable")

Sorry for not getting the fix out to next in time, and also thanks
for the Tested-by!

I pushed the fix to for-next now.

Yours,
Linus Walleij
