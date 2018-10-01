Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DC1C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D05A2082A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D05A2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbeJBFKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 01:10:12 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42336 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeJBFKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 01:10:12 -0400
Received: by mail-oi1-f194.google.com with SMTP id w81-v6so10937873oiw.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 15:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EBMuyxcw3gTNEnsYJL9HAsaFTeTTjjUiMjGbPctuLCE=;
        b=FeTb04O3lhkx6c/nLEBq9gm/fm2RFyF3tBr9Cr6aOz9954g7eHnC8xj0twJcYvPWAU
         VbOSLoy4ZZSjvg3+dpcrTCuDitLBTGqVHgefbYc6epaRkdx3sZ+VeD5Vl7fV4AS5pMYO
         qnlP6SThHx/DRwbE28fn5SNiDFkOq2kp/c7xJw4dp5wmPTGGVmAaN+ceTPMWUkVxJrqZ
         8M7Iokc59/Foy/8hcqVvUCCT7VdNBgla7a2ftOu3AL47qH88Y5m3BDr0yW5s5ps3E8vB
         ithjnd8RMpU7qZ95dpjTfmANICXxjNO13lgjz7Ba0lPnFfbBpI0Nqymnt3/CnUfWsy8n
         EzgA==
X-Gm-Message-State: ABuFfoj7GkxL69+IA3jE83d9Q8RI9va+MIyPMBNuMnaHfqBmnQjB58pE
        zPcXVzary27SW076uOJBR31/395eiL0=
X-Google-Smtp-Source: ACcGV62nQbfD3wg4azCEHz2+lLoDDxB+WvLTjcvISF9GGUyMPzY/rqdl6rtGhZhsSkl9ah88LdSZzw==
X-Received: by 2002:aca:5107:: with SMTP id f7-v6mr6520884oib.223.1538433011547;
        Mon, 01 Oct 2018 15:30:11 -0700 (PDT)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com. [209.85.167.177])
        by smtp.gmail.com with ESMTPSA id j79-v6sm2307698oiy.13.2018.10.01.15.30.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 15:30:11 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id l197-v6so12626785oib.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 15:30:10 -0700 (PDT)
X-Received: by 2002:aca:e310:: with SMTP id a16-v6mr1108411oih.79.1538433010858;
 Mon, 01 Oct 2018 15:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <1538124204-31406-1-git-send-email-madalin.bucur@nxp.com>
In-Reply-To: <1538124204-31406-1-git-send-email-madalin.bucur@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Mon, 1 Oct 2018 17:29:59 -0500
X-Gmail-Original-Message-ID: <CADRPPNTn99q=6fungYr-xcwY6vFiw9KTUp8UCEQ2u0+sv7vd4Q@mail.gmail.com>
Message-ID: <CADRPPNTn99q=6fungYr-xcwY6vFiw9KTUp8UCEQ2u0+sv7vd4Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] soc/fsl/qbman: DPAA QBMan fixes and additions
To:     madalin.bucur@nxp.com
Cc:     Roy Pledge <roy.pledge@nxp.com>, claudiu.manoil@nxp.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Scott Wood <oss@buserror.net>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 3:44 AM Madalin Bucur <madalin.bucur@nxp.com> wrote:
>

Applied 1-4 to for-next while waiting for clarification on 5/5.   And
updated the prefix to "soc: fsl:" style to be aligned with arm-soc
convention.  Please try to use that style in the future for soc/fsl
patches.

> This patch set brings a number of fixes and the option to control
> the QMan portal interrupt coalescing.
>
> Changes from v1:
>  - change CPU 0 with any online CPU to allow CPU 0 to be taken offline
>  - move common code in a function
>  - address all places in the code where the portal interrupt was affined
>    to CPU 0
>  - remove unrelated change from patch adding 64 bit DMA addressing
>    requirement
>
> Madalin Bucur (2):
>   soc/fsl/qbman: replace CPU 0 with any online CPU in hotplug handlers
>   soc/fsl_qbman: export coalesce change API
>
> Roy Pledge (3):
>   soc/fsl/qbman: Check if CPU is offline when initializing portals
>   soc/fsl/qbman: Add 64 bit DMA addressing requirement to QBMan
>   soc/fsl/qbman: Use last response to determine valid bit
>
>  drivers/soc/fsl/qbman/Kconfig       |  2 +-
>  drivers/soc/fsl/qbman/bman.c        |  6 ++---
>  drivers/soc/fsl/qbman/bman_portal.c |  4 ++-
>  drivers/soc/fsl/qbman/dpaa_sys.h    | 20 ++++++++++++++
>  drivers/soc/fsl/qbman/qman.c        | 53 ++++++++++++++++++++++++++++++++-----
>  drivers/soc/fsl/qbman/qman_portal.c |  6 +++--
>  include/soc/fsl/qman.h              | 27 +++++++++++++++++++
>  7 files changed, 104 insertions(+), 14 deletions(-)
>
> --
> 2.1.0
>
