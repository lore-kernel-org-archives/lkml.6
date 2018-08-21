Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAC7C04E83
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 05:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44C521735
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 05:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbD6F7at"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E44C521735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbeHUIaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 04:30:19 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:37101 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeHUIaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 04:30:19 -0400
Received: by mail-yb0-f195.google.com with SMTP id f145-v6so3354773ybg.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 22:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=u0nxW5SDhuR0cvWLvp9dYb5Hfu9HpYKt5PL/ZEZtZfA=;
        b=rbD6F7atGDmxMdCk2jaAHJPTfxPhtNeEBlP06bFLTIcEUjnRvJJsZUZrBoUN/4T2WQ
         wY9OaR0SfPtETJrdjblzyKy3sVv6fTzTWzl3K+3letCz3QPn81b12t81d4mxUE6PhPKm
         puOQSmPoOFiZqLky3GTNN/OxC6ki3EcNIPXywlh3MEf6JWL+5Ki4TUW9iGI3oHJs58xL
         WoGgug4SFY4buul5YJzN8kCi483lZqPYOmRM4kW+tGFSv/86eAePkUh1rH5zDyCSVJvE
         wZsKh7qVhmsJFH/y3Ce+PvBhtQCJigLf3Fu47OWiDOi1r0OgPDQN36OJeJiHEE2bA5Bl
         fsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=u0nxW5SDhuR0cvWLvp9dYb5Hfu9HpYKt5PL/ZEZtZfA=;
        b=IDzoZIhMe6h+SA1RRHIX5vhN71Ru+FMM0s8Rv8WYgNMHaplz/7PA9EdTyI4uEYHDIq
         AMsmdS65hvvzdML2Bo/T9YYDPY39hXF2FrfoVZUtk8xtg38ojBdc6Cf34TffOvaB1mP4
         mFJHVPYWxhk+DOzrLCOchZHPGL6r96DGJIsXdh/FuBd1TMVtsz6y43jAUA21M/0zbxT6
         Pz6D6fpxHqKDV24hI6niIQlqvlWykuw28YiX9hPHNvQisiMl7tDPNkpOcgId/HlNEoWQ
         cC6SujCKhNPtkbDRH6LM6Phd6qtZUK47+gVc5xicD5OCXIFYjOUFuPV7BvW0gmXmkiNp
         T4EA==
X-Gm-Message-State: AOUpUlFx5mGzOL7Wrc0kIWQe0L6JYdEPtkoRCDW5QAyZsRA1QUiyZNG5
        15GTdHE9IX3PiZby+AwER3sRokDAiwxH6WJZUIk=
X-Google-Smtp-Source: AA+uWPwoWSMfSEqn3KWfdb6Q5JGYvTX33bvSXrTS8q8VVcigwyVhi8yP9kFHRm47Li98o9sY4lDznsQiPKD+0ox1wUg=
X-Received: by 2002:a25:bdcf:: with SMTP id g15-v6mr3711493ybk.494.1534828305596;
 Mon, 20 Aug 2018 22:11:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0d:c142:0:0:0:0:0 with HTTP; Mon, 20 Aug 2018 22:11:44
 -0700 (PDT)
In-Reply-To: <20180818012213.GA14115@bombadil.infradead.org>
References: <20180817231834.15959-1-guro@fb.com> <20180818012213.GA14115@bombadil.infradead.org>
From:   Konstantin Khlebnikov <koct9i@gmail.com>
Date:   Tue, 21 Aug 2018 08:11:44 +0300
Message-ID: <CALYGNiOf_0fR4R747J11JNROO7_FW_9u16Bg09f+CdWPiFwGvw@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: don't miss the last page because of round-off error
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com, Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2018 at 4:22 AM, Matthew Wilcox <willy@infradead.org> wrote:
> On Fri, Aug 17, 2018 at 04:18:34PM -0700, Roman Gushchin wrote:
>> -                     scan = div64_u64(scan * fraction[file],
>> -                                      denominator);
>> +                     if (scan > 1)
>> +                             scan = div64_u64(scan * fraction[file],
>> +                                              denominator);
>
> Wouldn't we be better off doing a div_round_up?  ie:
>
>         scan = div64_u64(scan * fraction[file] + denominator - 1, denominator);
>
> although i'd rather hide that in a new macro in math64.h than opencode it
> here.

All numbers here should be up to nr_pages * 200 and fit into unsigned long.
I see no reason for u64. If they overflow then u64 wouldn't help either.

There is macro DIV_ROUND_UP in kernel.h
