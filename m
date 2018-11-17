Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB211C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 768E2206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 768E2206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbeKRCuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 21:50:08 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34247 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbeKRCuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 21:50:08 -0500
Received: by mail-ot1-f68.google.com with SMTP id t5so24177248otk.1;
        Sat, 17 Nov 2018 08:32:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gMTz2EOiWaaOWYD5m3C66XRZowoKjupcKf4X9kojdWo=;
        b=L1PX7y4fMA2aCaoM5m1/RnDhM+xk32xzct0JIPkwBebNRyRL9+hQK8wJmuruZHZdGU
         NU6t3OwZp0VdnHt/nNLaDQJvftiJBnfP/Izf6hM4dVcoJ6w4EhaGv52LbI+HKvjqGc8B
         DK6IMjlFUkvEDwSrX8pWSH9dHSY/AyTVJmftM8Np2j2qG4LV1PssZIayf6JeDhHb7ox2
         67uK194dw11i42IPGaT3UHJkSeEk5bQfnf3QyhplgS8CZVkjc7ygInLNC59msJBNI6Dd
         ao4z3cqyRhGx3WdTP9GdYd9pbYxUobTxes2w4f6vlSw7hzUzCMMLt5MYA+xTuCKlsDYh
         lvVw==
X-Gm-Message-State: AGRZ1gJK1eiZOe+V/MloJMZFHEOuXzvUlHKTvty0NhQ0eKFRrWhWL+7R
        u8l+YuhEjE8s5lcMFLT3lA==
X-Google-Smtp-Source: AJdET5f50tIWITJCu9CME4nt+6IW49ZLepvBIXL2dKXkmvIkoLagQ71IUNZumYBa7aoXHP4B5PoYFQ==
X-Received: by 2002:a9d:192a:: with SMTP id j42mr8709218ota.36.1542472376119;
        Sat, 17 Nov 2018 08:32:56 -0800 (PST)
Received: from localhost ([166.137.105.180])
        by smtp.gmail.com with ESMTPSA id c58sm29202087otd.34.2018.11.17.08.32.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 08:32:55 -0800 (PST)
Date:   Sat, 17 Nov 2018 10:32:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        anup@brainfault.org, Damien.LeMoal@wdc.com,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        sudeep.holla@arm.com, palmer@sifive.com,
        devicetree@vger.kernel.org, juri.lelli@arm.com, mick@ics.forth.gr,
        jeremy.linton@arm.com
Subject: Re: [RFC 1/3] dt-binding: cpu-topology: Move cpu-map to a common
 binding.
Message-ID: <20181117163253.GA6713@bogus>
References: <1541728209-3224-1-git-send-email-atish.patra@wdc.com>
 <1541728209-3224-2-git-send-email-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541728209-3224-2-git-send-email-atish.patra@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 05:50:07PM -0800, Atish Patra wrote:
> cpu-map binding can be used to described cpu topology for both
> RISC-V & ARM. It makes more sense to move the binding to document
> to a common place.
> 
> The relevant discussion can be found here.
> https://lkml.org/lkml/2018/11/6/19
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  Documentation/devicetree/bindings/arm/topology.txt | 475 -------------------
>  .../devicetree/bindings/cpu/cpu-topology.txt       | 526 +++++++++++++++++++++
>  2 files changed, 526 insertions(+), 475 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/topology.txt
>  create mode 100644 Documentation/devicetree/bindings/cpu/cpu-topology.txt

Please send this with '-M' option so we just get the real changes.

Rob
