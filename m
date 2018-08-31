Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E940FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04852077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B04852077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbeHaWia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 18:38:30 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43711 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbeHaWi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 18:38:29 -0400
Received: by mail-qk1-f196.google.com with SMTP id 130-v6so2006507qkd.10;
        Fri, 31 Aug 2018 11:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/9/IhKKUyj4WXbJH15/JfXWKtZghPbWpuI4ZumXr1NU=;
        b=GgR3hk5gfhnpatAoqiQaHfbDv8hIPXi2jiF0j/kNhCOqClsJytSSViEcWQJ64v1R6q
         IprGhXqzhFz1LvqpOH2qU04oo9cGcRtUyVoQS9DX0BNUeOfibYk5tKKS8LGu2pwd9Gds
         lMxtVDAj5Mc9T5wp7ZA2MYNtKXuH7eoo/f+tcckih8FDGozxEc6y21CZkmP+prRJVLy4
         Zre6Byw085S4FsgwAMvayyQnzOW1O+I6sW4LypIiCQnFIDaj0lPsmGBittMzW+cYc7Ya
         B7v7ZNhsIAOdUp1mFy9r5EdUdK0Afiispr6GoIIAeJhU7qQRjiSzPLkjDG96IeWaZxWF
         arOw==
X-Gm-Message-State: APzg51BQ0+wuoqHFMmXmoOFishPAvhNRCFwQZ+APaLVGbSiAWkKAaY1F
        NeEhYB6gGvec+52gXKGvK13hGF0kSe6nBePOfUg=
X-Google-Smtp-Source: ANB0VdbS8ch85K2B3Da8r0pjcRe4+uE6h4ae6MCXOQXWXCxgohs63sDhuNRjU51dKJXxrTICie3Xe4ze75/HgwZeN5I=
X-Received: by 2002:a37:7347:: with SMTP id o68-v6mr16679739qkc.291.1535740186108;
 Fri, 31 Aug 2018 11:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <1535453838-12154-12-git-send-email-sunil.kovvuri@gmail.com>
 <CAK8P3a0q0P-FuG6cTgMNkeZbtXE4pMk1iJq36_x20WRddtwaDg@mail.gmail.com>
 <CA+sq2Cc1CSKmuEjKt8psR7Zyv9PzLkN10hzy8mrai136SF4-qA@mail.gmail.com>
 <CAK8P3a2CMcYg6vMmRAc4N80BpFwczGiPnaLNCDZYXCsRydtPQw@mail.gmail.com>
 <CA+sq2Ce3ew0X+RMm7fQ+iUZF0HKptzBr1dBk3NuRL8o82wBTjg@mail.gmail.com>
 <CAK8P3a1oeOFVYc2xH+KO1gV0m9utHziGpNtQLAEv-RBxKkB7Og@mail.gmail.com>
 <CA+sq2CfAvasZoNmnNQadhdsEz-eyXQPBtXbDmvt1nM0DQsm+8g@mail.gmail.com>
 <CAK8P3a0wdXRmZOw+yyws00GU=xYAFkGm81xKTF3-DjNmjjZH5g@mail.gmail.com> <CA+sq2CfL-eBWPcu1H9UkvKuL4kPeKnL1qkiG0tLZa_GW8LEqXA@mail.gmail.com>
In-Reply-To: <CA+sq2CfL-eBWPcu1H9UkvKuL4kPeKnL1qkiG0tLZa_GW8LEqXA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 31 Aug 2018 20:29:29 +0200
Message-ID: <CAK8P3a0p2PdjVS+QVMtiYK+5=ToeLSfjvf5X85S0HK2Om4fZ1Q@mail.gmail.com>
Subject: Re: [PATCH 11/15] soc: octeontx2: Add Marvell OcteonTX2 CGX driver
To:     Sunil Kovvuri <sunil.kovvuri@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-soc@vger.kernel.org, sgoutham@marvell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 6:01 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
> On Fri, Aug 31, 2018 at 7:50 PM Arnd Bergmann <arnd@arndb.de> wrote:

>
> Thanks for the suggestion, that does makes sense.
> Actually i did thought about it, but i was skeptical if it would be
> acceptable to make
> a single module out of drivers registering for two different PCI devices.

I don't think it matters much whether there is one module or two
(others might have a strong opinion one way or the other).

What is important though are these two points:

- How to represent the two PCI devices to user space: You should only
  have one interface to user space I think, and this should be similar
  to how other drivers manage similar cases (I don't actually know what they
  do, but I assume you've done some research here)

- How you connect find the pair of devices: Generally speaking while
  the SoC might only have one of each, you shouldn't make that assumption
  in the code, but instead have a reliable way of having one driver wait
  for the other driver to finish probing so you can match the pair.

> Will wait for few more days for more feedback from anyone and port v2 series.

Ok.

      Arnd
