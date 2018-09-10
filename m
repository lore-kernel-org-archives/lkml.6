Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979ABC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B742087E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="iV3/kKIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B742087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbeIJRQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:16:15 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55945 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbeIJRQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:16:15 -0400
Received: by mail-it0-f65.google.com with SMTP id d10-v6so29170496itj.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 05:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Mf6DqvmUfKAc7mU/7xtqv8OovyajSHs0clSkHHl6pTM=;
        b=iV3/kKIJN4sRjldn2UpDuW3FJIPmxiIDlfwth8Wr2046YLSK406oLGp525VlmY5kSh
         UpJ/DbnJ4l2WHox2Ioj6R44z5tkXvs2L5XvbShglw7n8s+vmQMMCn1a05pV+ZhjeQyg3
         WuRtMA+64/wIkXCseCf6M1frzFvoyeVTLHExm9jEfxSAuT7oQKtPEiygLKnCk13wzmZ8
         ftnQQZwQpj6jbO6iCYfGtoCiI41qFXD3umsrVWovz/pjq6o/4vHSX47VePtgD+umg1Ij
         knwNerqE+4+uBhJDOQ1RYfTLZ3IvGKmshUlKZFTaAApYwPfwFs1PoegFVsFEoKmEsjRi
         QMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Mf6DqvmUfKAc7mU/7xtqv8OovyajSHs0clSkHHl6pTM=;
        b=lieft/e3zpHGzza6SJuIOg7ZOuGtySeABOxLvxmq6Q8LefksFIEdl1Dqx7MrkQSmAc
         cuM3TXec8GBOm46ntECYX/3DOWpQRm4zFcDgVZIi1gnXPT80bZzuqJ4kTXYsSnNTjvQe
         IVWLxIUa0L7k0S12eQDbXStA3u0dhMTI0n3/J7Zgq0bMSNWBWSQ6OP9fhZw7GWUSq6fH
         H36HZdCGz6iRBWNd1mS5fSyDtF2J8iqlSMf9dQkKS13adb4G3YHAYXaofeouVLuJL7p3
         atTFOXoiGgbMRcbZDkpIM8bhywr6LZUJ+zF/iPhHQJrdnOhcLIsm/+4Zvy7Ns2mLNtb+
         qvoQ==
X-Gm-Message-State: APzg51AADa2JTkGg/yoK37b5VYfH8ViJpeutMvBJ42lY5Gc1HzPZb6js
        VIfoYFhZr15a2RkNYXgY3/OnFo1Csh9LpNAQUClF6g==
X-Google-Smtp-Source: ANB0VdbppQX2y1ZWbRzOIVShsur9ma2dF8Qs8gsur85FXYHhlh05/tA0PeR7DnJ67ISswq8kyo+476I1zM16K21XyiA=
X-Received: by 2002:a24:a20f:: with SMTP id j15-v6mr17675440itf.125.1536582145499;
 Mon, 10 Sep 2018 05:22:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:1905:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 05:22:24
 -0700 (PDT)
In-Reply-To: <20180910141820.6c715895@bbrezillon>
References: <20180907100750.14564-1-brgl@bgdev.pl> <20180907100750.14564-2-brgl@bgdev.pl>
 <c0b0c411-65f6-62f9-6d6d-2884e5a17250@linaro.org> <CAMRc=MfO01EQAfY4Uu3UwzzvhVOMF7_BpCOPVz2yVXqDgpb0AA@mail.gmail.com>
 <7e138142-8161-3646-4daf-619995baf395@linaro.org> <CAMRc=Mduu4CmLX5DFtJd8NSbzs5g65U9AmM=rbscit0JyQKVAQ@mail.gmail.com>
 <3dbd65e5-c948-a784-0362-930fc41b840e@linaro.org> <CAMRc=Mck=rAJ6jbm57ZecJWNvOYR5pjLy0JnyxFzA8kFvoK7Ew@mail.gmail.com>
 <ec2ba4af-46cf-2025-1670-cbed366d0f15@linaro.org> <20180910141820.6c715895@bbrezillon>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 10 Sep 2018 14:22:24 +0200
Message-ID: <CAMRc=Mdew1s35=M+vh=Fxc--0+rYxRXT96KVOJRhAX9f8QwtkA@mail.gmail.com>
Subject: Re: [PATCH v2 01/16] nvmem: remove unused APIs
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-09-10 14:18 GMT+02:00 Boris Brezillon <boris.brezillon@bootlin.com>:
> Hi Srinivas,
>
> On Mon, 10 Sep 2018 12:47:19 +0100
> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:
>
>> On 10/09/18 12:31, Bartosz Golaszewski wrote:
>> > About that: there are no users of nvmem_device_cell_read/write()
>> > currently and with the new API I'm not sure this is still needed. Are
>> > you alright with removing those two?
>>
>> Why do you want to remove them? Other than reason of no users.
>
> I'm just sharing my (and probably other maintainers/developers) PoV
> here, so please don't take this as an attempt to force you to change
> your mind, but rather an attempt at explaining why APIs usually stay
> private when they have no users.
>
> Kernel maintainers tend to reject APIs that have no users because
> adding something that nobody needs yet is hard to get right. I mean,
> you can design an API on what you think will be needed/appropriate, and
> then, when people actually start needing this feature, they realize it
> does not quite match what they need, and they have to adjust/rework
> this API.
>
>>
>> All it boils down to if we support device based apis using cell info or
>> not?
>
> But it looks like nobody is actually using it, and the first potential
> user (Bart) proposed a different approach with the nvmem cell table
> declaration.
>
>> IMO, I see no harm in leaving these apis as it is, unless there is a
>> strong reason to do so.
>
> It's harmless, but it's also unused. If people start using it and you
> realize the API is not working for some use cases, then you'll have to
> patch all existing users.
>
> All this being said, it's your call to make, and if you think it makes
> sense to keep these functions around for any reason, then be it.
>

Also: the general notion in most subsystems is that drivers should be
generalized enough to not have to care about the provider's internals,
which is the case if we allow users to specify cell info. They should
just query the subsystem for a given resource, use it, then put it.
Fortunately this is what all current users do in this case - we don't
even have any users of nvmem_device_get() which is good since it
should be reserved for very special cases.

While one can argue that nvmem_device_cell_read/write() may be needed
in some strange corner case now, once we add the cell lookup API, we
can safely remove it and force users to do the right thing.

Best regards,
Bartosz Golaszewski
