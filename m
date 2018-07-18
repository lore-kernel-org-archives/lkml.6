Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD3CECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A5D2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dSEjnFTq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A5D2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbeGRXrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 19:47:08 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:44554 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbeGRXrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 19:47:08 -0400
Received: by mail-io0-f179.google.com with SMTP id q19-v6so5513692ioh.11;
        Wed, 18 Jul 2018 16:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9w1WJpYXI4VAmyxO6WdugBnxuEJ4RE/RdYB+2vcoc3I=;
        b=dSEjnFTqYsmf5eDN0FHK+JQzZm7Dfw0SpkCQDcJzVwq4ZIE2Ch+HMVJFG0xhvs4hj8
         PC8Ah7UbKE+XK71QBq3RmxAEYWwzYCOFD2NbtObRWsPCI16YI8lNZOecWk3bpGkU+AxY
         WWu2Gazml0VIYYPlpubSbvuV5U+jwgUiZRHgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9w1WJpYXI4VAmyxO6WdugBnxuEJ4RE/RdYB+2vcoc3I=;
        b=au+H+M9h1PUTeQyJDjcdQTrBZEDsZGCM4PxP7iu7CK1fJFy9upqfgzWwltQlrtVgU0
         DsrpI94qiMdDH/P5adhOn+koiM9UcHM90gBa5FoJZfKsbfbDUIpATWec2N6gBfPjFdRu
         ROlyg6HIN2PFyxMi4wPFitQben/JWUoLgZIXRosdijezHK5aHITRisDnnFeJ2xzmLPhI
         CV9Zet/GEdID5G7ounWJ0X3A/2EO9RijoEJMIJnooEtbgdVsqbti5tRn98TtLg7XziJH
         QVR94CRgG0cBNZ0jM1Rdqth8lm1DS9fWyLFtPLT30Md3ZRD8TN0xUaqaCkTovr7MpR3v
         Fc1Q==
X-Gm-Message-State: AOUpUlEh3KqDLrrstQVcTAhnLIdJfBKLGJV15vnm/MhgQYmH2G6yh9+Y
        h7H3kHlc1EufC1bscF/TgKDR38/KbVW0J7qBTgaKlw==
X-Google-Smtp-Source: AAOMgpfUpCk0zouLBvLr11GVCMGjMu/7Qbrdj7giQyJ1RnW4O43obwXuy/4sTtSou8JW415gyR+Yd6fEdzpZzExAn60=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr7057830iov.203.1531955219221;
 Wed, 18 Jul 2018 16:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAOssrKf60FHqgG6pB5zOP7iV-qdHdDUODdG7SVpoNh3Pipo=6w@mail.gmail.com>
 <CAOssrKdqnsPSipweUCers6d2AgJX2aVGQUs1pd7cB79GoSJH1Q@mail.gmail.com>
 <20180718124340.GS30522@ZenIV.linux.org.uk> <CAOssrKcS+kwK+S1aojhbW_4p8FJLPaafBDqDu89d=F14wT-0rw@mail.gmail.com>
 <20180718181252.GU30522@ZenIV.linux.org.uk> <CA+55aFxh62Yttq-W2Cr_YQQ5tAL1xjijjnaz1-zdZNqZPQFM0g@mail.gmail.com>
 <20180718194637.GV30522@ZenIV.linux.org.uk> <CA+55aFydd9ji2eJSNVK7Fjpziehvm6fO3b1eTeUAn0L1tk3GmQ@mail.gmail.com>
 <20180718200411.GW30522@ZenIV.linux.org.uk> <CA+55aFwhnOPO26ubjJ9WhK6YT8JqD5_UTGmNLFWbPdv-On99=w@mail.gmail.com>
 <20180718212205.GY30522@ZenIV.linux.org.uk>
In-Reply-To: <20180718212205.GY30522@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Jul 2018 16:06:48 -0700
Message-ID: <CA+55aFyJJSf0M8ij+Mzea7sFWOuDNcC4eA5KyVYeiKv8HY6LvA@mail.gmail.com>
Subject: Re: [RFC] call_with_creds()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 2:22 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Why is counter any better than LSB of a pointer?

Easier nesting, but if you do it with the "surround by a macro" model
I guess you can just save/restore instead (like you did in
call_with_creds).

           Linus
