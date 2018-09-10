Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D57C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3B42086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IMWtHTaF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA3B42086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbeIJOz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:55:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44243 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbeIJOz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:55:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id v16-v6so21208576wro.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 03:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lIebOggwhmMubIlNRykvvJf2UmQO7I0eIn7QCn7KIt8=;
        b=IMWtHTaFYvipt/pY3LmOM1fFkTQv4vgxYn0QWcN0RVLstLwt6tovPYuTwwfjIqG9z8
         pZdkjV3n07nUGDB/SAzajbg21EyqRWQd82JIiRBJDXXpyUfQSzJUutc7/aICKv8lyRaa
         7DNz3S137h+w9AhJ3xzfFOIJsqnbegGGIbPBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lIebOggwhmMubIlNRykvvJf2UmQO7I0eIn7QCn7KIt8=;
        b=n8bPahFKq82B7rTMFTN57dr6q0VMlGzVcZlXyhyeawkwDbn4Ru5APt0g2YDAHZY1Em
         j+gOYbuL/LBi9FNhh52VbY52sM9n38bnQs/t0NfSWi1xi1CQqekrWUSJYpO7M9AlE/ZH
         F4tXKJpfHA3jy0dVUQy0QiDL8LiPH9FN+IHdIq9fCoUCkRmBR/HPgGggbDXTyBmwOb5p
         DFe9ERpyr8VXxCOPPDEs/irMYjF0KIzmO/a91pknycMP5C/GjWk7CktLLzT99wwin6T6
         GVT2ydNIjW88Hs7U02gVyMpYBkTh9siKCThAfg6/yrfEWU3PB4s6jdsxgzhz+sOt7IZR
         MphQ==
X-Gm-Message-State: APzg51B0MathRVpyJq+TUh+bwgQ4DaK5+dvPLE0I6yjoMb0YKrnvY8VU
        qoz6DKM3xokZkeQ4N8R8lUCY6Q==
X-Google-Smtp-Source: ANB0VdbnhNEcKL2Io8wJ0tKn/c5HxHcyEVBTwDKywH0b/LGZuhoqVqaTpvSnjk8j9uwkzYbTQyRERQ==
X-Received: by 2002:a5d:6984:: with SMTP id g4-v6mr14262846wru.232.1536573727239;
        Mon, 10 Sep 2018 03:02:07 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id m68-v6sm30563645wmb.10.2018.09.10.03.02.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 03:02:06 -0700 (PDT)
Subject: Re: [PATCH v2 00/16] nvmem: rework of the subsystem for non-DT users
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180907100750.14564-1-brgl@bgdev.pl>
 <da9556fd-0022-8e6a-12b4-cc3babbae5b0@linaro.org>
 <CAMRc=MeT7UP57x+Q-a1ODRCvcGKKj_NSfkBLVQ9O5dhTC1DAYg@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <dec727cf-486f-8126-34f8-1b1099cec3a1@linaro.org>
Date:   Mon, 10 Sep 2018 11:02:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAMRc=MeT7UP57x+Q-a1ODRCvcGKKj_NSfkBLVQ9O5dhTC1DAYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/09/18 09:24, Bartosz Golaszewski wrote:
> The API changes change so many things, that these series would be
> incompatible. I can send the series separately but they would be
> co-dependent anyway. Does it sound good?

What am asking is to reorder the patches in a such a way that its easy 
to review.
ex: Order can be :
1> kref and update nvmem_unregister followed by the provider changes.
2> Add support to cell tables, cell lookup, notifier
3> general cleanup patches  followed by fixes

Current set seems to jump from one thing to other which makes it hard to 
follow and time consuming while review!


--srini

> 
> Bart
