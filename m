Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3040EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0988C20874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731588AbfAKLh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 06:37:57 -0500
Received: from ozlabs.org ([203.11.71.1]:44669 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731426AbfAKLh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 06:37:57 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43bgpV0C64z9sBQ;
        Fri, 11 Jan 2019 22:37:53 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Corentin Labbe <clabbe@baylibre.com>, benh@kernel.crashing.org,
        mark.rutland@arm.com, paulus@samba.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Corentin Labbe <clabbe@baylibre.com>
Subject: Re: [PATCH] powerpc: build virtex dtb
In-Reply-To: <1546951970-29079-1-git-send-email-clabbe@baylibre.com>
References: <1546951970-29079-1-git-send-email-clabbe@baylibre.com>
Date:   Fri, 11 Jan 2019 22:37:53 +1100
Message-ID: <87y37re86m.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Corentin Labbe <clabbe@baylibre.com> writes:

> I wanted to test the virtex440-ml507 qemu machine and found that the dtb
> for it was not builded.
> All powerpc DTB are only built when CONFIG_OF_ALL_DTBS is set which depend on
> COMPILE_TEST.
>
> This patchs adds build of virtex dtbs depending on
> CONFIG_XILINX_VIRTEX440_GENERIC_BOARD option.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  arch/powerpc/boot/dts/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/powerpc/boot/dts/Makefile b/arch/powerpc/boot/dts/Makefile
> index fb335d05aae8..cae14fca682e 100644
> --- a/arch/powerpc/boot/dts/Makefile
> +++ b/arch/powerpc/boot/dts/Makefile
> @@ -4,3 +4,5 @@ subdir-y += fsl
>  
>  dtstree		:= $(srctree)/$(src)
>  dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
> +dtb-$(CONFIG_XILINX_VIRTEX440_GENERIC_BOARD) += virtex440-ml507.dtb
> +dtb-$(CONFIG_XILINX_VIRTEX440_GENERIC_BOARD) += virtex440-ml510.dtb

I'll squash these onto one line, eg:

dtb-$(CONFIG_XILINX_VIRTEX440_GENERIC_BOARD) += virtex440-ml507.dtb virtex440-ml510.dtb


cheers
