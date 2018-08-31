Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067C6C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952DA2083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9m/VkB2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 952DA2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbeHaWoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 18:44:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34858 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbeHaWoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 18:44:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id j26-v6so12050660wre.2;
        Fri, 31 Aug 2018 11:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pu4d3RVUUdPlCH9xGqZIyoOubOEpKWlkGfWbiKMjGPU=;
        b=C9m/VkB20rzVwxuflt1rhnTGoF83CU+VzsRcBYFVnS7Fz18IAbY+CDOtKwjqVDTxsl
         yBNuwRt5FV7nuvvcFMauO73gA7mnWlBjSvu+uKLp4SDA+nzywHBUKvvcx0Tc2XA+ck/T
         eIALmL/1E3Czr+vR5FZn8NkPRY9BzX49D5VR1ecG4pI/Qwf41aDplAkMFKT4Gdi9IdZj
         RdbVN4tdCts3immTOXgAVeuUPoW4njFFDUHPCXD8fcg9djRS//E7MoRCrMPsfxrZcK6b
         dQ6RRiIfL/6iVF0FHOYtKN6ImyyIQC60SkYdR8chmbAujM30qOqDgKeow9oF5taPzuRF
         Drqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pu4d3RVUUdPlCH9xGqZIyoOubOEpKWlkGfWbiKMjGPU=;
        b=jRw1QT6iIM9TV6EJoXjtMl2RmEmsmJciOjPbIb65nnXF6EQDDUhVqEq9/vEE1Ggr50
         lWj/wtEzgoxfQsWe8frUqK3xIPvMZQs9koZI4uMtkDk2waL0ePHOPBVq7AsCVvo4bk11
         0XYhvPrqUTHABHhvefNsPWQI7Bz/OyhC64bxkc/HaXdVAz1p5UAxs0YqwXr0bqZWX/Sq
         VP8GGVWhEZ/eAkC3fbzvtF70L4Nkm6nV2/1Td49Wf4rQ/85AlIkAXO+9kAt0CbcGv76m
         9U4jTKM4ag1CUelqcf0iNcRybjd2hNpFSAizgRU0uzTFhTAwq31+akcjzsTix9ez6OGZ
         /yRg==
X-Gm-Message-State: APzg51C0mgFmTa9xa9UeIfJbxr1Ps1cLDRy/02/s82WJxcMCJFEfbvQV
        bm2Onffj2zINCJkw+6kyay0xaIsGtClLzQjtZmc=
X-Google-Smtp-Source: ANB0VdZ9WMLFVsgMY9bJ/9g/mCqOEO/MX1mlPtiuRP3s82nqeDYy1asG1SvYFDv2wl1/mMFQ82YEfl9bn9zfi0yubU0=
X-Received: by 2002:adf:9051:: with SMTP id h75-v6mr12545497wrh.65.1535740522478;
 Fri, 31 Aug 2018 11:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <1535453838-12154-12-git-send-email-sunil.kovvuri@gmail.com>
 <CAK8P3a0q0P-FuG6cTgMNkeZbtXE4pMk1iJq36_x20WRddtwaDg@mail.gmail.com>
 <CA+sq2Cc1CSKmuEjKt8psR7Zyv9PzLkN10hzy8mrai136SF4-qA@mail.gmail.com>
 <CAK8P3a2CMcYg6vMmRAc4N80BpFwczGiPnaLNCDZYXCsRydtPQw@mail.gmail.com>
 <CA+sq2Ce3ew0X+RMm7fQ+iUZF0HKptzBr1dBk3NuRL8o82wBTjg@mail.gmail.com>
 <CAK8P3a1oeOFVYc2xH+KO1gV0m9utHziGpNtQLAEv-RBxKkB7Og@mail.gmail.com>
 <CA+sq2CfAvasZoNmnNQadhdsEz-eyXQPBtXbDmvt1nM0DQsm+8g@mail.gmail.com>
 <CAK8P3a0wdXRmZOw+yyws00GU=xYAFkGm81xKTF3-DjNmjjZH5g@mail.gmail.com>
 <CA+sq2CfL-eBWPcu1H9UkvKuL4kPeKnL1qkiG0tLZa_GW8LEqXA@mail.gmail.com> <CAK8P3a0p2PdjVS+QVMtiYK+5=ToeLSfjvf5X85S0HK2Om4fZ1Q@mail.gmail.com>
In-Reply-To: <CAK8P3a0p2PdjVS+QVMtiYK+5=ToeLSfjvf5X85S0HK2Om4fZ1Q@mail.gmail.com>
From:   Sunil Kovvuri <sunil.kovvuri@gmail.com>
Date:   Sat, 1 Sep 2018 00:05:10 +0530
Message-ID: <CA+sq2Cc_fdTjSJx1BdietRThfK=gn3Sy__=K4iQNQDCBTa+JyA@mail.gmail.com>
Subject: Re: [PATCH 11/15] soc: octeontx2: Add Marvell OcteonTX2 CGX driver
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, olof@lixom.net,
        LAKML <linux-arm-kernel@lists.infradead.org>,
        linux-soc@vger.kernel.org, Sunil Goutham <sgoutham@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 11:59 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Aug 31, 2018 at 6:01 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
> > On Fri, Aug 31, 2018 at 7:50 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> >
> > Thanks for the suggestion, that does makes sense.
> > Actually i did thought about it, but i was skeptical if it would be
> > acceptable to make
> > a single module out of drivers registering for two different PCI devices.
>
> I don't think it matters much whether there is one module or two
> (others might have a strong opinion one way or the other).
>
> What is important though are these two points:
>
> - How to represent the two PCI devices to user space: You should only
>   have one interface to user space I think, and this should be similar
>   to how other drivers manage similar cases (I don't actually know what they
>   do, but I assume you've done some research here)
>
> - How you connect find the pair of devices: Generally speaking while
>   the SoC might only have one of each, you shouldn't make that assumption
>   in the code, but instead have a reliable way of having one driver wait
>   for the other driver to finish probing so you can match the pair.
>

Agreed.
I do have a patch in works for that, i.e to defer AF driver probe till
CGX driver is loaded.
https://github.com/sunilkovvuri/rvu_drivers/commit/27b449087c16224a9e93dd91d6d9f734b5210bed

> > Will wait for few more days for more feedback from anyone and port v2 series.
>
> Ok.
>
>       Arnd
