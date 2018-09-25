Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A761C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B0220867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="rCkL9xyI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30B0220867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbeIZBzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:55:25 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37882 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbeIZBzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:55:24 -0400
Received: by mail-lj1-f194.google.com with SMTP id v9-v6so22943348ljk.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 12:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2MKpZTQbQtPMjDkxZ8j019ksxj6VPDzn9400A/bKfso=;
        b=rCkL9xyIm2aCZt2XNXiVJIX6709Ud103Qyn6iuAcKzPiATlgPkIGPkiFxbNblwpXPH
         7xF3U40+vjWjVQ0qkQxqetMmOq4A8eSTVLlGVEWHHr5EYQgChx7c9+7qV4T5X9G4pRtg
         hV7ATSbNNkwkn8VrE/RnMiaUMv7fUv83gToc6xznjvwQgVmTGTgd/7YzA5PtB0bF6ywo
         1N9q56dAtrVU/JhCgWm5AFpE7r1A7dFQG8JkQCATIxYIFyKMPB1VUy44lx8I3FZBv27z
         Ut0S1zAKYo3KsCbLgCW/TfGTGKdgO2C8npKWYPoSIfir96lNnEgxVWRMaR6MzBzQ+sf8
         zp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2MKpZTQbQtPMjDkxZ8j019ksxj6VPDzn9400A/bKfso=;
        b=lblIrnKVqbraxS9yWI6NKOIZzcXKEN2ds2U+/yfNw211Eqp+dRFsLXRs9cCdjWv0QZ
         wzWe25feDy68+YXZ5ITd3APs2Mb/c89vjls9bYSVKsmx40DKu2ZZkMVIDteCyifA/nZ2
         SWkloLaDkxhj2bnIZhmB2mIbdnLLQH+hTXkhvs48MpNOrGP+E7kOoFszadmv/pTmvZAm
         ODUDokAD1ws21cnMKm/C7xg7ggNhHr7gQjVsnHYadtOmgUaMPDl5BIX+NYnZYuTdW+FG
         ysEXMLFSrsOuRBf11Bs/DUhM026K57hCAVbffdeKhsj9XsO3nn2s6ECtE5MzkcaqzlVa
         XizQ==
X-Gm-Message-State: ABuFfoiiTgUAF6sAq3dNSztCDIyHjizfmMbeiHhbxVFKkjY1X5Ml4TDe
        Yin+gIO/TRVNiB29mbLWCXK++t7BfOKtlMRXxuxBMvdsYDtGSw==
X-Google-Smtp-Source: ACcGV63fKKDEqqlN8gmHD/uKSdshOUfP/nDqNmVfaRtmMe1K05QGW6W5xIBI3Cv7Egt0bNj4zlwXYFycXBvY5QfZmzM=
X-Received: by 2002:a2e:2c10:: with SMTP id s16-v6mr1978341ljs.88.1537904775401;
 Tue, 25 Sep 2018 12:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180823213600.23426-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20180823213600.23426-1-alexandre.belloni@bootlin.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Tue, 25 Sep 2018 21:45:56 +0200
Message-ID: <CAOesGMjDKKSNVccu4D579SiwL9zEU7ha7HQCHncvh2r4kpO6fQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: fsl: qbman: qman_portal: defer probing when qman
 is not available
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Roy Pledge <roy.pledge@nxp.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Thu, Aug 23, 2018 at 11:36 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> If the qman driver (qman_ccsr) doesn't probe or fail to probe before
> qman_portal, qm_ccsr_start will be either NULL or a stale pointer to an
> unmapped page.
>
> This leads to a crash when probing  qman_portal as the init_pcfg function
> calls qman_liodn_fixup that tries to read qman registers.
>
> Assume that qman didn't probe when the pool mask is 0.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/soc/fsl/qbman/qman_portal.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
> index a120002b630e..4fc80d2c8feb 100644
> --- a/drivers/soc/fsl/qbman/qman_portal.c
> +++ b/drivers/soc/fsl/qbman/qman_portal.c
> @@ -277,6 +277,8 @@ static int qman_portal_probe(struct platform_device *pdev)
>         }
>
>         pcfg->pools = qm_get_pools_sdqcr();
> +       if (pcfg->pools == 0)
> +               return -EPROBE_DEFER;

This is quite late in the probe, after a bunch of resources have been claimed.

Note that the ioremaps above this are doing unwinds, and you'll end up
doing duplicate ioremaps if you come in and probe again.

You should probably unwind those allocations, or move them to devm_*
or do this check earlier in the function.


-Olof
