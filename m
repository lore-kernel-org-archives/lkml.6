Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6B2C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C8C214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eS7N9+Cm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C8C214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbeHVNM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 09:12:29 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:36329 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728694AbeHVNM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 09:12:28 -0400
Received: by mail-io0-f194.google.com with SMTP id m4-v6so978225iop.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 02:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KD2TeYt5cC0F7Orpqc9GrrxbnjvuoALlrGf/ITJNjH4=;
        b=eS7N9+CmUbJv26171z04bS7PGin5bPMdu5VyqVG5OqcSEFzf63EqBWj4NgDUEMo+l1
         HfKpSgW4TpetgVc+bsJbUthZmRRv5Md2PeeF/vamXgFdwsXd24e+KyC1BjuoaD7NbgG/
         zEdwGCIs9OEHJ7woYo7o/csSRNmtffb/CFK/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KD2TeYt5cC0F7Orpqc9GrrxbnjvuoALlrGf/ITJNjH4=;
        b=YdyzjuMgVKmKb8CoI6mskuys0H2t7NBOQuuSxPDQahiuKOK7i47JvPScWkNBH+443x
         9P1eFhQIXZB0oicSjHjAsxIECQYHQGYLFnpG8LSfI5k2yi5hyZymOl0TXjOIbUB5bUQw
         OgP2l1PZ/CHmrRjt7occSH24IazX8+7rjaY/cfGpmSH4UaCdjJSkybktcf/kRpkhZdHE
         faxgQ02N6wBtdoOaAXSSW7rI8o3vAc4Kvf7jCNgt2bFHIQNn/edjU+4FoXr5UocK6obQ
         mUAVh5W4kMLVkNRVZc+/fbdDeBfqcKv6oHeKhE+IORrJhwX+tsh5Z8kvKTg18jygShgI
         R8pA==
X-Gm-Message-State: APzg51CV3g0PZg68A1F+kOZxqqpbXilj7mbvd4EkwruRDPR4qB9xFvOv
        Da4EnfsmMfDrMo3f4UShHPma6CQWJC/+ISHgJB60AQ==
X-Google-Smtp-Source: ANB0Vdardk+879/A8hsICDsrSErI2pzCfpZlbPKEgx2nu25jmxspJFLFK3lPoJ1VFOoDBygGDtEN7b/KMMEUoPMmbsY=
X-Received: by 2002:a6b:c995:: with SMTP id z143-v6mr17339266iof.266.1534931299317;
 Wed, 22 Aug 2018 02:48:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Wed, 22 Aug 2018 02:48:18
 -0700 (PDT)
In-Reply-To: <1534250074-15890-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1534250074-15890-1-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 22 Aug 2018 11:48:18 +0200
Message-ID: <CAPDyKFq3=gF941BZ9DCcjkg95mDEMMV8k+6856k6t2P=KObaNw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add SDHI support to r8a774a1
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 August 2018 at 14:34, Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Dear All,
>
> this series aims at documenting SDHI support for RZ/G2M (a.k.a. R8A774A1).
>
> Cheers,
> Fab
>
> Fabrizio Castro (2):
>   mmc: renesas_sdhi_internal_dmac: Whitelist r8a774a1
>   mmc: renesas_sdhi: Add r8a774a1 support
>
>  Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 4 +++-
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c      | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> --
> 2.7.4
>

Thanks, queued for v4.20!

Kind regards
Uffe
