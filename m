Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8CFC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C3E20671
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fH99T33i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C3E20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbeKTTxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:53:43 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:50745 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbeKTTxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:53:43 -0500
Received: by mail-it1-f196.google.com with SMTP id a185so2375225itc.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 01:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=npEkZFzgj8KvYAKvqAa29jWAAVO/xwwjupaVMmPsmz4=;
        b=fH99T33i5OkZAqj8Gw+P1b5vLolB5v8N6eshavdEUCpYkAhgcK2Qb0IwORr5YUxDwY
         nts6+4bV0nVuzLlLF4bAJWPqmyaE+q4dFLLLPtXD+0bfua69Q9Ns3g8hxAxufAE/fy3W
         85q8Tk3c2SdJv7//Tvw1Z8HNuxiTEOwH/N8rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=npEkZFzgj8KvYAKvqAa29jWAAVO/xwwjupaVMmPsmz4=;
        b=hpgurukE3jRCGR+oQ59Tfxj8wIKS9l8R0QCRaJcz1eAtWP/H8JbeiEm9J8ILhrqIeF
         YczV2ogpMCwS9PtgTZXF+/aMOGsxxzHLaURPeuMkfh7xiLnt/zZB/LdsFq79YDsI6uxa
         hJVnHCE9CbtuwijiFFxENHEdSJbdPJhLyjYRVlCXOyknJ6TNcuUFSWOM2CtycwggA+Qt
         gwdvVb4zFJZo1+Mm8Ycn+0wGw02I4Ih5POWofvPzVOGnExwnTA8LbAeT/+iY8RoQrmNN
         E5NM9pQq1Q+GAdsKiKXPZlevL/rd7YyMJx/y3cIuZJNW6mc8aep775EqYAtDXhpC66Uk
         FhiQ==
X-Gm-Message-State: AA+aEWZGUqi5oxXvF96FpxwuPlMUTgR8oHqqbckWgRmE7eRt0U2kU/Wi
        gVhojTmncUkqX1Kg4DPcQtIxt19oPZUQTls9l6BGcQ==
X-Google-Smtp-Source: AJdET5cCI+KvWIIqnLYB1ZOVML/QIEOys6PbY6unnxdqqcVoA+JxctMYzTchlIj5rmMKdvcUQwxIJPXIzqblR0VU/+I=
X-Received: by 2002:a02:c909:: with SMTP id t9-v6mr1094083jao.95.1542705934401;
 Tue, 20 Nov 2018 01:25:34 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:70c8:0:0:0:0:0 with HTTP; Tue, 20 Nov 2018 01:24:53
 -0800 (PST)
In-Reply-To: <20181107084741.GA31092@kunai>
References: <20181106133007.12318-1-sjoerd.simons@collabora.co.uk>
 <9051c212-6e2a-bc39-3686-693e6cd87f1d@ti.com> <303b49cbb5b687d6b6a7ad4048eda459586c0806.camel@collabora.co.uk>
 <20181107084741.GA31092@kunai>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 20 Nov 2018 10:24:53 +0100
Message-ID: <CAPDyKFpedP1f4XZYvebFCuooYrBa2ux9F9mYRNi1Q=M-5eJ0Rg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Remove timeout when enabling cache
To:     Wolfram Sang <wsa@the-dreams.de>, Faiz Abbas <faiz_abbas@ti.com>,
        Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        kernel@collabora.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hongjie Fang <hongjiefang@asrmicro.com>,
        Bastian Stender <bst@pengutronix.de>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Harish Jenny K N <harish_kandiga@mentor.com>,
        Simon Horman <horms+renesas@verge.net.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 November 2018 at 09:47, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> That also happens to be one of the cards we deploy; However i did
>> wonder about adding a quirk but decided against it as it was not clear
>> to me from the specification that CACHE ON really is meant to complete
>> within GENERIC_CMD6_TIMEOUT. That and i fret about ending up in hit-a-
>> mole games as the failure is really quite tedious (boot failure).
>
> I agree that we should use the more defensive variant as a default. I
> mean there should be no performance regression since most cards will
> respond just faster, or? The only downside I could see is that we might
> miss a real timeout with no bounds set and might get stuck?

Well, you have a point, but still it's kind of nice to know which
cards are behaving well and which ones that doesn't. Hence I think I
prefer to stick using a quirk, unless you have a strong opinion.

Note that, in this case we can use CMD13 to poll for busy, which then
means it also works for those hosts that doesn't support HW busy
detection, without getting additional delays. If this hasn't been the
case, we must be using a quirk, but now we are more free to choose.

> Maybe it is
> worth contacting eMMC spec people to at least know what is the expected
> behaviour?

According to the spec, the GENERIC_CMD6_TIMEOUT should be sufficient.
So this card is not conforming to the spec, I think it's as simple as
that.

Kind regards
Uffe
