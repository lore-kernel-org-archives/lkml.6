Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B5BC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D882082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D882082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbeLDO5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:57:45 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37744 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbeLDO5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:57:44 -0500
Received: by mail-vs1-f66.google.com with SMTP id h18so9968271vsj.4;
        Tue, 04 Dec 2018 06:57:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AIcr61O0Nb6BVaATDrV4fKb6Paoy35Rp4VMoCXfkEFQ=;
        b=JNrmExTSPXFPnDHWgvRiHNw3+at8CGckVKgm+LGawNYVwhv8CLzbg49zPVcUkqIe7Q
         AD501eTgdsaJUPX0SmgiU90q99rqTs0cMbqEDaLLVw8jq3KnIFnQJqPcOARjpRiAy07P
         8buOhkELe0wfOE5zExjkyBdypdIa1GkL1z7DMty4S+UzArmSZjvIaQ2lcdfGyjVzel5z
         bovKOE27Ks8MIhW0bA7Dz9QtkQkmjYu7w9MAx/qcTnyw+P03TfVaP+f6sw7EvpBPreyM
         qNYG/u80/kOdm10ATTTTfGsLPQFbjjp1HqBpJQQ9lv/0cXommj8b1M0jOO0eGiIw1eEa
         jbCQ==
X-Gm-Message-State: AA+aEWYSvGCkFSEb00QZS+eB4OPTO/odvAW0fWnsyubxUqItCYhJO8cx
        uqVUA7i/zYAmRGOmb4riArIbXuiEFV26C2Hk0dw=
X-Google-Smtp-Source: AFSGD/WOv2tdd5tGICH0vrauIUxfXhNRXEiPJ/feJt/qFI5J0CV2mHMh4MIoyBMKmDQwp3vVwzNp3v4HPU6unQOFZNQ=
X-Received: by 2002:a67:f43:: with SMTP id 64mr9062834vsp.166.1543935462650;
 Tue, 04 Dec 2018 06:57:42 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org> <20181203213223.16986-27-robh@kernel.org>
 <20181204144822.uqonsto45u7ysdu5@verge.net.au>
In-Reply-To: <20181204144822.uqonsto45u7ysdu5@verge.net.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Dec 2018 15:57:31 +0100
Message-ID: <CAMuHMdV5brJyAmP0Bj7Bp7wruLNM1tSWkj_AyN5HCx4vdg-nrg@mail.gmail.com>
Subject: Re: [PATCH v2 26/34] dt-bindings: arm: Convert Renesas board/soc
 bindings to json-schema
To:     Simon Horman <horms@verge.net.au>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Kumar Gala <kumar.gala@linaro.org>,
        arm@kernel.org, darknighte@darknighte.com,
        Frank Rowand <frowand.list@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Grant Likely <grant.likely@arm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On Tue, Dec 4, 2018 at 3:48 PM Simon Horman <horms@verge.net.au> wrote:
> On Mon, Dec 03, 2018 at 03:32:15PM -0600, Rob Herring wrote:
> > Convert Renesas SoC bindings to DT schema format using json-schema.
> >
> > Cc: Simon Horman <horms@verge.net.au>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: linux-renesas-soc@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/arm/shmobile.txt      | 151 ------------
> >  .../devicetree/bindings/arm/shmobile.yaml     | 218 ++++++++++++++++++
> >  2 files changed, 218 insertions(+), 151 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/shmobile.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/shmobile.yaml
>
> Hi Rob,
>
> what is this based on? I get a conflict when applying the .txt change
> and if I knew the base for this patch it would be rather easy to work
> out what has changed.
>
> Also, should we do an s/shmobile.txt/shmobile.yaml/ in MAINTAINERS?

Probably even s/shmobile.yaml/renesas.yaml/, while at it?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
