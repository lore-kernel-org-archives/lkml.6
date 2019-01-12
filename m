Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEADC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693C12084E
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BX15Vu/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfALCH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 21:07:26 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33249 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfALCH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 21:07:26 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so7786888pfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 18:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=WUYxqEBLAWdKwx9jSHSlJcfQJizx3bVbCo6NWuPJtIc=;
        b=BX15Vu/eL431OimxTdscWvbRzBpeUyRidoSWXdjfntlf89/WhYjH5ASZSqYKC6MsoO
         whWD8pdAZdEM/SHpb1QgWGOV3FvqGs1XvE3c2h/vIWMDw8hGKoD6kpSSkvkY8xYk4lkf
         KXXVl5d/k1g+T5akL5YplWSmDXavJ/c+6hD2xC32KoBUxWCFH2HUpuZQXu5N4u+EkzhQ
         8ukxuqvQOjE4apEYbb7gwrTp5MJ50xGmB/ZBtAsfqg3knUORz49mvH9M5f6CEcOeGYMd
         eczQ3gXN1UazJs7IU6aMDNh0Acmout+hd2iqBZjwvRTSRAzETIBUwIbxknkil9LKbTfG
         gAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=WUYxqEBLAWdKwx9jSHSlJcfQJizx3bVbCo6NWuPJtIc=;
        b=iRnzQP3/pD388iPfdV9NHFBs5ag/ysu8tjJNqXUuf3RmzJO8Z+g3oN6PTNr3Hx1zOg
         niVq4fESRKllRwS4qSVhHauB/PPYgHESoW3iBJ9GDjMa7rZJmRh3j790ONF3e87pn7WX
         eX4NmfRvZN4uklO5T7fQho8NzkzcEDkrkaF0PujG4fg8p+ttivCro+3K6atWaM8qNaL3
         4+ub/cGcNSCFpuRQ2WY7i2uyflkoiby1kazluUOA1IVDTwrM9j6bAELAvyhNblakiXkX
         oPyO2V2CZPd0xYFlO2NbXYB0h9JBYqgnj09Ho34kibg/fDPX+AZZhj9Uj3/syoqlQ3U+
         ewQQ==
X-Gm-Message-State: AJcUukexCND4C2eIq5inooh660vFw5kGFsxseRmNdSIzUg6JAS64y3g5
        hFQxF2TWv6F+XmGc8LHoBovmJQ==
X-Google-Smtp-Source: ALg8bN66h1ixfV8Ud5dcJ3dL884rN/RW0/4Dp5V7rGFYFFDbTjSzDDXn/LUVcSK/miT8nagJ8kd9ow==
X-Received: by 2002:a63:66c6:: with SMTP id a189mr15494643pgc.167.1547258845208;
        Fri, 11 Jan 2019 18:07:25 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id c13sm160617376pfe.93.2019.01.11.18.07.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 18:07:24 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-Google-Original-From: Paul Walmsley <paulw@sifive.com>
Date:   Fri, 11 Jan 2019 18:07:23 -0800 (PST)
To:     Alistair Francis <Alistair.Francis@wdc.com>
cc:     "palmer@sifive.com" <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] RISC-V: defconfig: Enable Generic PCIE by default
In-Reply-To: <20190112004117.28265-1-alistair.francis@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1901111806590.3094@viisi.sifive.com>
References: <20190112004117.28265-1-alistair.francis@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jan 2019, Alistair Francis wrote:

> Enable generic PCIe by default in the RISC-V defconfig, this allows us
> to use QEMU's PCIe support out of the box.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>


- Paul
