Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C239AC282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 13:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8298B2147A
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 13:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuJRRYka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfA0N5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 08:57:51 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39122 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfA0N5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 08:57:50 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so15027085wra.6;
        Sun, 27 Jan 2019 05:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TnrAuBDWXcgSYTj7AO9+1nKX+KN2wk+ZlZFTkcq9kWM=;
        b=GuJRRYkawFddO8QaThutkCd8aIq7vH3hGH8Z9PMYxQwcbZ7voIuUhVqH1ByelzbkWV
         wAqrHhKSkcYQR0WTgWu8/mdxnQz7W1rznpCT07giJ3AfLCGOxNkRe4ZUDLazs95zB3FH
         B7NqBNAkc+0nXj4a7h9nKGWyLAA6JcoofdmmqHh/bEm8FBbVXaQk5jPbYO2SfpzTIjKV
         vkxlIEn9vTj+7Igd2OAWDIx+ssxwCtyDobHb9QyTE1HBgbKPCvCmmgCanxv0jP2yePso
         3Uj3EHKMo3G49UvbXi8tGPF8p2VHWxzTit3XbnW/cjZPJAXsaHQ0iZBw9t0i+QBT+8EK
         +0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TnrAuBDWXcgSYTj7AO9+1nKX+KN2wk+ZlZFTkcq9kWM=;
        b=AQLAkYyvfkSd8Ogu1jce4hMITLAoIi38Rl/vsfVJs6f2tMoYDjZFES4kU8zCguOaZu
         y9AyEs3blqM6Qb4QCAbT5qGciZXttYqEToikVQHz9yxp7b5v3k5CMIbgTTSBHlPkBrxm
         GvvELcVgH1ERDVanTMePddPbQrfs8vP+NTBAWGgQQ6QKQt2thaIDddmUaVJLiZypr3l8
         gppFC2Rr/j2tv/nHwwrVnaVNKoNcGq4VYoTHqXqZ09uzCXPDRiouowbMlKqvSpERlaen
         +0EQIKj7kXTLLnbvF1DT8GsHN9CL2T+RmUIJuPI7rfkXPH7PlJ9ke5n983ldVh16c1Up
         gwAg==
X-Gm-Message-State: AJcUukdR+WJ2OCMW6+xGVmba31FDbidOqURdo9THMLCukUxNj+Kkw8x7
        upJqFeVeiXAAaXj4PdS1D+YQq0w7xUl2uMkVDUbiy8aq
X-Google-Smtp-Source: ALg8bN7O73HvA5MpdxYf8vk/kHFX9x7duEBa1fEbWJpqeHaklCTLTbHGzvLntZ5c5hEU0ytASveZAs6mJkoIYIW/1lg=
X-Received: by 2002:adf:fac6:: with SMTP id a6mr19441129wrs.53.1548597468708;
 Sun, 27 Jan 2019 05:57:48 -0800 (PST)
MIME-Version: 1.0
References: <20190125130701.GA855@vmlxhi-102.adit-jv.com> <20190125150906.27614-1-sudeep.holla@arm.com>
In-Reply-To: <20190125150906.27614-1-sudeep.holla@arm.com>
From:   Eugeniu Rosca <roscaeugeniu@gmail.com>
Date:   Sun, 27 Jan 2019 14:57:37 +0100
Message-ID: <CAH3KO=0kUewNu20G82RxVFmZXJ2amuxFwXjkrHMCGJix75LuCw@mail.gmail.com>
Subject: Re: [RFC PATCH] drivers core: cpu: add hotplug callback to update
 cpu_dev state to resumed
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jisheng Zhang <jszhang@marvell.com>,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        Joshua Frkuska <joshua_frkuska@mentor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <rosca.eugeniu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FWIW the "cache: parent cpuN should not be sleeping" warnings no longer
appear during s2ram procedure on R-Car H3-ES20 Salvator-X with this patch.
The kernel version is v5.0-rc3-241-g7c2614bf7a1f.
The test procedure is:

root@salvator-x:~# modprobe i2c-dev
root@salvator-x:~# i2cset -f -y 7 0x30 0x20 0x0F
root@salvator-x:~# echo deep > /sys/power/mem_sleep
root@salvator-x:~# echo mem > /sys/power/state

Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>
