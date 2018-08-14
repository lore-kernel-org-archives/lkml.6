Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59145C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1154221741
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQH9Bvko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1154221741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732531AbeHNPmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:42:50 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:46382 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729536AbeHNPmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:42:50 -0400
Received: by mail-ed1-f44.google.com with SMTP id o8-v6so10027565edt.13;
        Tue, 14 Aug 2018 05:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DVUkFXLyqFs6NTqoVOA4CUwW8RCJUL9vA3bbdGScnXI=;
        b=WQH9BvkomWxoQh7PY84OqJQJh0D3RAX/cf35qdcQCxBSTzKouYyR09auIROIFL2ZkS
         H2IMgWNuoBnobQ7lK8r+haFpllIXEcXc9CyeMwmy6PbI1FliqnN5nAYiHiRD62PxZuk2
         Hh8YBfqRAlrIq6IyHrCSxcDRMOF8cAqlJKTHxt6kxPiDXCsKE5R1mIuz/xoCDVuk5tmw
         6LSYQGVXmC2mqNFlIgLuOogoWHiPNX9qgXhe2PzeoNE6+1BYTJLP/TzefQKB4hMWUtlk
         0pQKwblOHxfojLEyrT87h8TlIB9N1jGqnO24OLZfIjCIlEkZ2xy7zmaADn5if5mI+apN
         ejrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DVUkFXLyqFs6NTqoVOA4CUwW8RCJUL9vA3bbdGScnXI=;
        b=hQpvhEHXmvGh/ywMDgPaN2Z4bkHBehV7nOdpif152L8ypQq0lz58NjY2lV49pPD5Pf
         Oxk4T17SyxkOxFDeE5v3KRpr92LPmNUUKsFUi+01HnB30uczb9dOo6+sMV1ISHemJjNP
         RIg0StuSuog/GJb2Qt6IKZKt1IJ0bBn5Jph8a+jeeyNwp9e3IfR7y9Z3tDB64s/n3K9d
         C0jnmEQ/EDtfuCxsvH5OIioXusMpTLyNgHDTptPt6uY+4wQYECIfYYuRiuEi2IUsXLgq
         ijbXu0rSmMp8dQKWRZ6eD38tghyVvmDinzI1CNO6gOXzsr2xR9RpE/baHJPEUfepO9DR
         5eEA==
X-Gm-Message-State: AOUpUlFuW1IHkpd7+F9cEyLAcHbA96gLLnhUysnxd7iuaCMy0wPFtCUu
        wXgllHLAKDQeMm+ABHsAM4fKRT+2hb61wqE7bhs=
X-Google-Smtp-Source: AA+uWPxIjo7VNtiLXy2NU1Q57F3hEIe5sttbvI7xCxG3iXLLW2Q6NPelKEBpQqp+oe67A262nMHFSrSW//Gd2PrA1uc=
X-Received: by 2002:a50:dd4b:: with SMTP id u11-v6mr27896639edk.298.1534251345343;
 Tue, 14 Aug 2018 05:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <CA+Kvs9kZKt0tvsB-YqomM7grvRyDr=B-HPWUNv1ZcKi8w9ms-A@mail.gmail.com>
 <cdc09cf9-27dd-7838-34e7-12d63571e770@ti.com>
In-Reply-To: <cdc09cf9-27dd-7838-34e7-12d63571e770@ti.com>
From:   Ramon Fried <ramon.fried@gmail.com>
Date:   Tue, 14 Aug 2018 13:55:32 +0100
Message-ID: <CA+Kvs9mV3u045acfBa2pEiUcVDyYroVrobtsKKBpDAfX+Os5iQ@mail.gmail.com>
Subject: Re: PCI Endpoint - Missing inbound mapping ops ?
To:     kishon@ti.com
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 1:53 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi,
>
> On Tuesday 14 August 2018 06:19 PM, Ramon Fried wrote:
> > Hi.
> > I recently saw that the PCI endpoint API only supports outbound memory
> > mapping: (AXI -> PCI) through the map_addr op.
> > Why inbound mapping is missing (PCI->AXI) is missing ?
> > In almost all of the PCI EP controllers I've worked with there was a
> > need to map complete BARS or part of BARS to mmio/aperature regions on
> > the device.
>
> pci_epc_set_bar() is used for mapping BAR.
Thanks Kishon.
what about address mapping ? Synopsys has this functionality if I
recall correctly.

>
> Thanks
> Kishon
