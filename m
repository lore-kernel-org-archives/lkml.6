Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D15C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CA92170A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtOCEVZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46CA92170A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732713AbeHNPz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:55:28 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:33130 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729955AbeHNPz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:55:28 -0400
Received: by mail-qt0-f177.google.com with SMTP id c15-v6so21024644qtp.0;
        Tue, 14 Aug 2018 06:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jBHh7yt66FMCdIT/kEjoDs6pL9+AowhtP91Cq7f4ff0=;
        b=ZtOCEVZPx8HO+T4iacSd9gFiZcJ8Gjg98GNWQ3xf84XUQK6GtsWgLH98KNJea3LMcz
         fLgBDK3wvuGItICMxYvUhvI2vkvzG8nWHNp9OHq8k/if0ms3fZ7YirD4LOuR65syhsQ2
         ughQd5IYpv3weUeIbyz1JMXsLzw3Mq0PVhVnfjPnd01O+Ok/0mw0vFwohBu1DpJVAKDO
         cVScbSbpBHtskICJha1DZinnINUc+LuUZexHI8n1mS9ZnNd+RUBr2NcZJdI0MZXGl7EB
         MjL//ic6KCQMCwIJWHccdARtPJBIHNhIhdUIdFBmYH3ZNASsijUEojnh4o6RSMfkfet6
         1X+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jBHh7yt66FMCdIT/kEjoDs6pL9+AowhtP91Cq7f4ff0=;
        b=t6UGWLpTbSMd2zDwHOx7rWmoc3+S4QrKeXl7zeVn0tx1NrdwUJzaDE1OoOjc1p5ivm
         2kD6Ei+hYp55ZLO6QuJ8f58Mpd9BOj6gPC/chdF2XFNvB8F/Zru5mS8qIDigHQnsi8+r
         6ZUZgk6BDvN5DVceZW4wryf1FVM4fWs52CPXXA2/jeW0/bljYKGJQbad0lLCiNuCNFjW
         lytCbauaY7QURkAVYu1njmthlJ2iZ8R5SKK0UakWcWjSD5dQB9QWbUzx+9na1Q93iA/W
         PJ0dmB5SSX6YYpjPGSCz2NK4bZYZc/Lrii7H50wzLutsAkxQ82q+4Q0JoTzDBky+hkMi
         T/YA==
X-Gm-Message-State: AOUpUlFW3kRD5r/QH0OWSMrkxnqe8DiNeSpCHQopEc/KeMu2j6EQxMp+
        Ksx3eBQMsEz9IeMmO8WugtAOayNJnSuyLYAI07s=
X-Google-Smtp-Source: AA+uWPw9nv4kuo2xAVs48Ni/uLcWCHM4IEaeGjNRNh9/CZWltx+jOr9ugWGXULP6IBDH4mH+EGewDITBQ7jqlbsD+A8=
X-Received: by 2002:a0c:f791:: with SMTP id s17-v6mr19127080qvn.194.1534252101290;
 Tue, 14 Aug 2018 06:08:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:471a:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 06:08:00
 -0700 (PDT)
In-Reply-To: <cdc09cf9-27dd-7838-34e7-12d63571e770@ti.com>
References: <CA+Kvs9kZKt0tvsB-YqomM7grvRyDr=B-HPWUNv1ZcKi8w9ms-A@mail.gmail.com>
 <cdc09cf9-27dd-7838-34e7-12d63571e770@ti.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 14 Aug 2018 15:08:00 +0200
Message-ID: <CANiq72mfrdTkgUamfTZ7rizfwVP-bzTbPBQ=waz0zKUpxnggiQ@mail.gmail.com>
Subject: Re: PCI Endpoint - Missing inbound mapping ops ?
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Ramon Fried <ramon.fried@gmail.com>, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

On Tue, Aug 14, 2018 at 2:53 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> Hi,
>
> On Tuesday 14 August 2018 06:19 PM, Ramon Fried wrote:
>> Hi.
>> I recently saw that the PCI endpoint API only supports outbound memory
>> mapping: (AXI -> PCI) through the map_addr op.
>> Why inbound mapping is missing (PCI->AXI) is missing ?
>> In almost all of the PCI EP controllers I've worked with there was a
>> need to map complete BARS or part of BARS to mmio/aperature regions on
>> the device.
>
> pci_epc_set_bar() is used for mapping BAR.

Just to let you know, the ARC/DKIM seems wrong according to gmail and
is marked as spam. It seems it happens from time to time. Bjorn
Helgaas (in CC) also had the same problem a couple of years ago.

Cheers,
Miguel

>
> Thanks
> Kishon
