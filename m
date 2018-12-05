Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47372C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA002081B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UNd0vZvQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA002081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbeLEAXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 19:23:35 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38232 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbeLEAXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 19:23:35 -0500
Received: by mail-pg1-f196.google.com with SMTP id g189so8142166pgc.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 16:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=rXz3U3BB2qLVL7pDyi7g6ArLmKgfu6RB2C9y2sIyQss=;
        b=UNd0vZvQx46EpcicD+JD3WZrqKRZgMmW0+NfSxRx6ZOsPWgr93gbFJHwv86Co7x1Jn
         p9NN8tpcSLd1aV8vfa6kwFuxTjfRwyBuVnUfwdhwKOkpWCyVYeAt3Id8LhZ+QZ2aK7jF
         17JXlnclsppDUhQozJ7gPyQ5Jlb+diavl0oMF0539qPEROjmnTBVWC24wQYqX6jDSomF
         D0CXkgaOo/ocrB/pNYEylbPzKMnkW1fs/WFNGYR2xSsNAqWZqiGWAa8QtPdk6oyv/kxK
         TEnihlIbZbkKsfGOhd0xPSp0wD0cn00cKyIqyDetuqb2CjKHUxpBTSr3+HUeCpVG2Wlw
         94LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=rXz3U3BB2qLVL7pDyi7g6ArLmKgfu6RB2C9y2sIyQss=;
        b=WySOTlThnOpqqzYPqk0OaRpvknGsDogi1+ohX/29HVBQFDt3/WXjGvUzXgz2q45fng
         Htlk01LjhopGLEeiPjxW/UzxkMFZpW3bU9sQ0WL/lpigRPncXdPZmSqUX8Cc5MPg5DYQ
         wyexdJtpVxkYnrD6h3OxkrhpkHqufpqboTcaGuzyf8tvOreXl08QBkCGphDNUVavYD18
         tm392L17lb36mqIFX73XyCEwsHRc9XaZHLe/nT9d5dQb+IEH7rTi5LHlsrbyBLWdYm3t
         3mLMHgViCida8xKzyVYruOOqKXaJlXhFEuFklaS5fEDN6PCJtvmyYq5IOhKZEt+SFhgN
         w2NA==
X-Gm-Message-State: AA+aEWbdPhsEBbCdgOygg5vyf54NlsoMKpZqdD7ePa3EXgTbQ9xkLEwu
        DoEJ7MGnwr1bgP1CgwIpBZ5JeQ==
X-Google-Smtp-Source: AFSGD/XGJhD03HWOsr+Ai1mk71eWDszLqTXBQnA1uSfWhbIxF4GaeH+M9b0XYGvsM2ojZLlr9yKLDA==
X-Received: by 2002:a63:f34b:: with SMTP id t11mr18681172pgj.341.1543969414116;
        Tue, 04 Dec 2018 16:23:34 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id k129sm32765272pgk.29.2018.12.04.16.23.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 16:23:33 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Carlo Caione <ccaione@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH] MAINTAINERS: Remove myself from the list
In-Reply-To: <eaf25e588c5ab78c607e7168e22871464e7ec8d7.camel@baylibre.com>
References: <20181201151749.10932-1-ccaione@baylibre.com> <928e27de-cb7b-cf40-b8b6-2aa43a69ee39@baylibre.com> <eaf25e588c5ab78c607e7168e22871464e7ec8d7.camel@baylibre.com>
Date:   Tue, 04 Dec 2018 16:23:32 -0800
Message-ID: <7h1s6wddob.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carlo Caione <ccaione@baylibre.com> writes:

> On Mon, 2018-12-03 at 11:21 +0100, Neil Armstrong wrote:
>> On 01/12/2018 16:17, Carlo Caione wrote:
>> > Kevin is basically doing all the work. Remove my name as co-
>> > maintainer.
>> 
>> Sure, but couldn't we move you as reviewer and add Martin as reviewer
>> aswell since he is dedicated to the Meson8X support ?
>> 
>> Or maybe add a separate entry with Kevin as maintainer and Martin as
>> reviewer for Meson8X ?
>
> This. At this point I don't think I will be going to work on the
> Meson8X for a while and Martin proved to be the right guy for this job.
>
> So, let's remove my name from here first and then Martin can add a new
> entry for Meson8X.

Queued for v4.21 (branch: v4.21/soc)

Kevin
