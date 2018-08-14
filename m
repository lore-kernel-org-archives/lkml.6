Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9301BC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C5321742
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCyZBE/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C5321742
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732685AbeHNPx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:53:28 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:46103 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729955AbeHNPx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:53:28 -0400
Received: by mail-ed1-f44.google.com with SMTP id o8-v6so10045846edt.13;
        Tue, 14 Aug 2018 06:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lcKKzJYfk1bV2qkGOl58nif+rUHIuAONTvTYHT+Bsfk=;
        b=QCyZBE/npxQCY89R+1mcgIi0RCue6UgZ8t87sCCUy7M7gSwiis4QJbbfSiEW0cqXRo
         DEX40lvVA2HbH4IWG0f2LUUYe80DsVbOb9/9ibLMDuigkpRXMjepfMftPRHnEv4M1Ogk
         9ueiK5pozsa7oKNd2wRuH/wDNLZGwy1pAvFqDfEJxWMZQCeFMoDhZ33HeYI/E5bM13Bu
         HPhtMKcush+vNzau8iJvONeRhUL+xM+t8uk0gGhIc8cavFeks2N5/Pp6Z+iSEkcuooaT
         aC3zFRbw3oKITM9YIVANBvvIwc+avrxNZXPEb4tInKMon7JRlhEyteWhWUKIsROZ/3sZ
         1Igg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lcKKzJYfk1bV2qkGOl58nif+rUHIuAONTvTYHT+Bsfk=;
        b=sKJDNN3+Rwd1wX0UFDfcAoZKC32Sf00vazAFRXU1Hj62m7Q1NwyeJbXZtyZzArUT56
         ni0DWlgvJrW5g5I5HQnsAq4EGfbCNv0KipNceILXXSaGjsLkjumQElRtooNWVvuYj7i1
         /y7vuj3eQcvDUBBqn80Oyk0Jll0KrI2QCV0wy9tJHTHugJtcOzVvZyH+ThW0yOa8ImrH
         oHfEZEdxADE70A75xTivvTgC7XILfq1OiR+4KsXGtUs5M8tSZ7dprZOjTm98jpdfWqNS
         0pUVsXq1+LQfomWLc9bpVlRshk22tglQoq3v8eTCOTDXI5jThJXE2ynuGoIYAr7Vy7zg
         CZ8w==
X-Gm-Message-State: AOUpUlH7kfOGnFqqaEefRUzvxKdDEiKQ9001duU3WybVlWDOQkIhIdv0
        BhJUldzbRAyip6SxI7yixh26oRyki4zzYD404Sa0AtwldCc=
X-Google-Smtp-Source: AA+uWPx/6haduEY0x/0Ekccj2UkzZUbRHbahMGqS/j/8GtQuY/4oYwQmD3jKzLs8nrqpbYghOFAs3DaRuxZaTmCg/zw=
X-Received: by 2002:a50:b941:: with SMTP id m59-v6mr27208626ede.20.1534251981131;
 Tue, 14 Aug 2018 06:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <CA+Kvs9kZKt0tvsB-YqomM7grvRyDr=B-HPWUNv1ZcKi8w9ms-A@mail.gmail.com>
 <cdc09cf9-27dd-7838-34e7-12d63571e770@ti.com> <CA+Kvs9mV3u045acfBa2pEiUcVDyYroVrobtsKKBpDAfX+Os5iQ@mail.gmail.com>
 <3ffbd957-a62f-b1ec-63b9-4ab3e03c8873@ti.com>
In-Reply-To: <3ffbd957-a62f-b1ec-63b9-4ab3e03c8873@ti.com>
From:   Ramon Fried <ramon.fried@gmail.com>
Date:   Tue, 14 Aug 2018 14:06:09 +0100
Message-ID: <CA+Kvs9nSyB0t8DKnf3AQrke5rh1N7O8E8mFKOkOOoHCYbHC+=A@mail.gmail.com>
Subject: Re: PCI Endpoint - Missing inbound mapping ops ?
To:     kishon@ti.com
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 2:04 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi,
>
> On Tuesday 14 August 2018 06:25 PM, Ramon Fried wrote:
> > On Tue, Aug 14, 2018 at 1:53 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> >>
> >> Hi,
> >>
> >> On Tuesday 14 August 2018 06:19 PM, Ramon Fried wrote:
> >>> Hi.
> >>> I recently saw that the PCI endpoint API only supports outbound memory
> >>> mapping: (AXI -> PCI) through the map_addr op.
> >>> Why inbound mapping is missing (PCI->AXI) is missing ?
> >>> In almost all of the PCI EP controllers I've worked with there was a
> >>> need to map complete BARS or part of BARS to mmio/aperature regions on
> >>> the device.
> >>
> >> pci_epc_set_bar() is used for mapping BAR.
> > Thanks Kishon.
> > what about address mapping ? Synopsys has this functionality if I
> > recall correctly.
>
> The addresses that the RC will put in BAR's is not known while we initialize
> the endpoint. So we really can't map BAR's PCI address to an inbound address
> while EP initialization.
>
> I think some older version of Synopsys had this (and didn't have BAR mapping).
> Actually TI's K2G had this IP. However the ATU registers here are mapped to
> BAR0. So the host side PCI driver can program the PCI address (that the RC has
> allocated for BARs) in ATU.
Yes. you're right.
Thanks for the clarification.
>
> Thanks
> Kishon
