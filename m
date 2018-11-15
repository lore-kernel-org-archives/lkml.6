Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731C0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB7D208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N25TH/eM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB7D208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388643AbeKPEFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 23:05:04 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38429 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeKPEFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 23:05:04 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so2055388pfi.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 09:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6G2KpmpfCtmqQlw0KlLFcSMUcNS3EWFTLTfjH5tvPWA=;
        b=N25TH/eMZ1eCRPoRQyH7sADMQ3XHsVyGl2bp2bJISV5mhZVqNr03ivatjocEmFIEt1
         gdH9/oeuBBJzCv+EdtZBPdhxHFxW9aM7c0Vu3GmGX57ZThpxrwGsCujJ6S+xmX1YJNnH
         8BJetUAtSL3ksa7GBY7T7l06bf5of9FOSRz0zYKGwAEw5SYhcPN2DktovulmYB0lF9Yx
         CI2QpSNkl1+ECtmWYyGuKUBM33VXeOJkoyA6aLdl1deZIeJaenQFy7djxwTNCZ4JMzgs
         sDmPnuIzHEXdjfEbZ3eoIS3uVESJ8DLhI98nR8CeUxXBXPOwfiPVw8H87eAIXw5eO/3I
         FdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6G2KpmpfCtmqQlw0KlLFcSMUcNS3EWFTLTfjH5tvPWA=;
        b=bSxXmFIje2m+lwBYOlFJ2KjAJqy5cX8qLMBifWBMOC+Ac2aYMrs/TKbmo0TjcFFiCV
         Vpc8H6ayIfhehpLbzD57rDLu2Nx5y5brElWaxtHpHCg5OF+UDTTTsrQKb8qxRngI6zWg
         74GSdXZu8FL3xPiukxWFwKn0doBWKvKYA9SL8Fufr0/bRJ7u+mg2INOgc66R1Jeyk70q
         wV0FyEMdhh83olzV3YN2j1aelfY4p2HUjy+0QFvj1P9x3ldSmfCshOK8IVkVzjf53XUc
         KCLTOZGbyeowG1XfxBGkEU3BurjUrrGBr1P8wJfHAcsbTxmOmqK0Z5n/VpqyLkSPbEXa
         incQ==
X-Gm-Message-State: AGRZ1gKlRuu6mygMreT3xTzyOJwMnP6hW5y6mAJJAWwcSu0sH8Vz5Ur4
        Zo6MpaydIOoqy8pC3CXDsepksrEKT1ov1QgKuo8=
X-Google-Smtp-Source: AJdET5c3T/+W2EqPp6pC7PirZgkFA+xZ0xnD5veblIlBPyIzSFRxFTqCtAOqKJmdIzIk4ulEc0p27ZQFQah63F3SMVM=
X-Received: by 2002:a63:bf0b:: with SMTP id v11mr6874893pgf.302.1542304574924;
 Thu, 15 Nov 2018 09:56:14 -0800 (PST)
MIME-Version: 1.0
References: <5bdfa97d.1c69fb81.4aef7.c9f7@mx.google.com>
In-Reply-To: <5bdfa97d.1c69fb81.4aef7.c9f7@mx.google.com>
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date:   Thu, 15 Nov 2018 23:26:03 +0530
Message-ID: <CAJr6mf0HfJNdsHG2H6VnRMYW1WGqBr1gvwMQoWk3mSdDhO3EmQ@mail.gmail.com>
Subject: Re: [PATCH] arch/powerpc: Use dma_zalloc_coherent
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 7:52 AM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> Replaced dma_alloc_coherent + memset with dma_zalloc_coherent
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>

Any comment on this patch?

> ---
>  arch/powerpc/sysdev/fsl_rmu.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/fsl_rmu.c b/arch/powerpc/sysdev/fsl_rmu.c
> index 88b35a3d..8b0ebf3 100644
> --- a/arch/powerpc/sysdev/fsl_rmu.c
> +++ b/arch/powerpc/sysdev/fsl_rmu.c
> @@ -756,15 +756,13 @@ fsl_open_outb_mbox(struct rio_mport *mport, void *dev_id, int mbox, int entries)
>         }
>
>         /* Initialize outbound message descriptor ring */
> -       rmu->msg_tx_ring.virt = dma_alloc_coherent(priv->dev,
> +       rmu->msg_tx_ring.virt = dma_zalloc_coherent(priv->dev,
>                                 rmu->msg_tx_ring.size * RIO_MSG_DESC_SIZE,
>                                 &rmu->msg_tx_ring.phys, GFP_KERNEL);
>         if (!rmu->msg_tx_ring.virt) {
>                 rc = -ENOMEM;
>                 goto out_dma;
>         }
> -       memset(rmu->msg_tx_ring.virt, 0,
> -                       rmu->msg_tx_ring.size * RIO_MSG_DESC_SIZE);
>         rmu->msg_tx_ring.tx_slot = 0;
>
>         /* Point dequeue/enqueue pointers at first entry in ring */
> --
> 2.7.4
>
