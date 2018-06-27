Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45345C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC4226091
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC4226091
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753477AbeF0IrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 04:47:15 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:37711 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752642AbeF0IrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 04:47:10 -0400
Received: by mail-ua0-f194.google.com with SMTP id c2-v6so764158uae.4;
        Wed, 27 Jun 2018 01:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E3mAUNDm5OQkqoa8fA7K1JaLqPW7To/+nJxHr15xBE0=;
        b=b3UBgkl0oq6Qc+wJZuTNr5s59ya/J6xihLun6kPYuK205HTBqMKT97NOTuZ2lg43Ln
         fx+hHJr/LRC/dzSVe3oCvKsA4Wq/M68k+IutYHK/A7a8xGICSJ6PXFzbqevE52QHicrt
         VwxCyyg35PEAQJ807LoSLpBARRg9DM2jUaSP+LFNjEajMfg+U0gRGYhdfC4c5mlrcNDc
         AEUhcQmLSoGF9CDeLqlKXwmrkiCBD+VxfOvmUc7rJD9i/uorvgfIDzmSARiV3GruGE/B
         bF4ZfqHmc2MxQGTOHj/7osQexglRRmjQZjjeRpLEOj8E9nTeDJ4uMN+qCGOPwIXxBkXK
         pvYw==
X-Gm-Message-State: APt69E012PvalvV3m7o3OLqGnMTsEjBoKV9ELRjFrCC4U82hzAS8ORbK
        knMtk8XN3cCzipGGmv6rV/NVPmn0CLvgiS7EUBA=
X-Google-Smtp-Source: AAOMgpfgbabHfVVER2VMbZHd7RtyS8/xg/ug/sQNCnoN4omuc2H6Hop+tDPCzhyiJg1M98n3wCtKtfv1JW+bVczHHY0=
X-Received: by 2002:ab0:1446:: with SMTP id c6-v6mr3165947uae.12.1530089229285;
 Wed, 27 Jun 2018 01:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180619194421.3432-1-nm@ti.com> <20180619194421.3432-2-nm@ti.com>
In-Reply-To: <20180619194421.3432-2-nm@ti.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Jun 2018 10:46:58 +0200
Message-ID: <CAMuHMdVLLir_U7cu-p=hVv_A1hOuTGhHJRBnad2BYSQdV+rJHQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Documentation: dt: keystone: ti-sci: Add optional
 host-id parameter
To:     Nishanth Menon <nm@ti.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On Tue, Jun 19, 2018 at 9:45 PM Nishanth Menon <nm@ti.com> wrote:
> Texas Instrument's System Control Interface (TISCI) permits
> the ability for OSs running in virtual machines to be able to
> independently communicate with the firmware without the need going
> through an hypervisor.
>
> The "host-id" in effect is the hardware representation of the
> host (example: VMs locked to a core) as identified to the System
> Controller. Hypervisors can either fill in appropriate host-ids in dt
> used for each VM instance OR may use prebuilt blobs where the host-ids
> are pre-populated, as appropriate for the OS running in the VMs.
>
> This is introduced as an optional parameter to maintain consistency
> with legacy device tree blobs.
>
> We call this with a vendor prefix to prevent any possible confusion
> with SCSI ID (m68k) kernel option.

I'd omit the above paragraph. There's no "host-id" literal involved in the
m68k kernel option, and it is not related to DT at all.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
