Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A789DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7819520871
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="YEO/c9ep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7819520871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbeKSTVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 14:21:00 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:53248 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbeKSTVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 14:21:00 -0500
Received: by mail-it1-f194.google.com with SMTP id g85so5461005ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 00:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0Yna8x0OVq/IIn51r3gUtMjXLP2Jj2b+iJ6cRs6mwJ8=;
        b=YEO/c9epJjDoet/P2z7O20dZT89DYbc3gx9tUmqMMua2haZBlkqMDfh5hpUy1gYdqC
         qBi52OzQO0173X60G+fDEIxeHCaDU1NchQ9KxYzbjoSNvgydDBlf/h0JDXAvMbDpRMum
         nYs8ZXA53OwnwveSpE+uuJu3iQV9eOwMaIAU80+M7peUp7HeGtkiiIodCNaJ2OaqTMNR
         p73mwKXGaA3T5uo3vr9pXS19F0LcNYVnVoMuNJ/sg4WwQP3ItNagV2fKmYDXn+AFdDsW
         UhHxTuyO3nANPTdrzMQqTFF2NJYBIbyInkZJTvf0o0lkNHANAYJO/VcTvyC5tFi8hbMl
         NYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0Yna8x0OVq/IIn51r3gUtMjXLP2Jj2b+iJ6cRs6mwJ8=;
        b=tNJZBB2dCMcjpNKW49v0lrUjZ/vvo9oqNBOyJrixTaiHCOdCY8fjEh0MuvGLs+ZKkl
         9v3A5Klwo1MdJ8fNsoxQLLzRTrFIctEq1+29NSo2zukZ3WOz4usFc12umwWPCQMTewMd
         POseNQHvzaWxkXd+WXZQXO380JVaGYnNN2g4obtrcMCchu2IH4ol1+vHOty+/u7wrfJc
         te6zK/E7d3XQF6VAHZ7+O+my8CiswPY+HFURB9V03pP7qxqVC0rCWlIVgm43FDed7MrF
         BhjMb8dKqwQehPNva8872cMcZl3VRZvTB05o7wXIga60ncGS3PqPKonwMPZcyZ+j2ifk
         7bRw==
X-Gm-Message-State: AGRZ1gK0o8tiBhkbEu/tKFpp9oN8ezkRG21W7rUehEc3Lz7Y6K4/HZGa
        gi9iGx8PaGerzrAmd3/0G+i3OQ==
X-Google-Smtp-Source: AJdET5cw9diSwrfOoUCP8o9dg15VVkEhQqFOIIjVHD2Cm/erOypBcO0tbo9S5bPlZ7Sqs8RKCTlnwQ==
X-Received: by 2002:a02:1e4c:: with SMTP id m73mr19384376jad.79.1542617881255;
        Mon, 19 Nov 2018 00:58:01 -0800 (PST)
Received: from [192.168.43.100] ([172.58.139.31])
        by smtp.googlemail.com with ESMTPSA id a134-v6sm16506407itc.33.2018.11.19.00.57.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 00:58:00 -0800 (PST)
Subject: Re: [PATCH v3 0/3] sh: system call table generation support
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     firoz.khan@linaro.org, Linux-sh list <linux-sh@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        marcin.juszkiewicz@linaro.org
References: <1542169930-24118-1-git-send-email-firoz.khan@linaro.org>
 <0b9aaa2f-9eda-82f1-8d52-b537a8c0c190@landley.net>
 <CAMuHMdUKPo6Lu0CtWERYkQTKSATqq0QVit-Awcn1O2EsS22iKQ@mail.gmail.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <72faac80-114f-f563-b340-0cdeea2673cd@landley.net>
Date:   Mon, 19 Nov 2018 02:57:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUKPo6Lu0CtWERYkQTKSATqq0QVit-Awcn1O2EsS22iKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/18 2:08 AM, Geert Uytterhoeven wrote:
> On Mon, Nov 19, 2018 at 6:26 AM Rob Landley <rob@landley.net> wrote:
>> WARNING: CPU: 0 PID: 1 at mm/slub.c:2448 ___slab_alloc.constprop.34+0x196/0x288
> 
> https://patchwork.kernel.org/patch/10549883/

Given that Sato-san is co-maintainer of arch/sh and that was posted in July, why
is it not upstream yet?

Rob
