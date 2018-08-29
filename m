Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87CDC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5611E2089B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aWc/t1ht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5611E2089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbeH2PnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 11:43:18 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34051 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbeH2PnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 11:43:18 -0400
Received: by mail-io0-f193.google.com with SMTP id c22-v6so4231992iob.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 04:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=63mfh1t7Yzndk1NlN8ep604w94vAu5lXbqp2r0WJJz8=;
        b=aWc/t1htBGUHoD3YqT0+XGyje+bJ33/WXDq1JaDTYg66JsS1Bmx/AJ09oFczCu/kkZ
         7sDpnXnq4dR1BKsPEwuZlqbqMRFmkXNwb8kA8Q7WLt5VW55adU4TFkrar8fvbcialeL6
         S7DOg/Fqg2PRnvbgB7saJLoTOqyd9yD1/RHo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=63mfh1t7Yzndk1NlN8ep604w94vAu5lXbqp2r0WJJz8=;
        b=BbByiEvLzuLsneVdi+SGe6l+3Id4IGweTqFPlFa4O0Xx9IDb4GtfkUB9Tk60KViy90
         L7Tc0Yv7plwzLP9mC6u7c22nZioJ2jGUX4UfxF7rjmqyqFkvlX9mEYxj0gbvS/GwQLyP
         laKIzX+mIDu4i+Gp/3gvgnEMExvGGGfgVecrNvhddRWOOUy4zE7cHorO2W7QK1Quflwp
         eyU/iEyJYxdAjAbcwYi/CCAPALPkqIu4coKjV9YAxZw/3l7n4DJjGuJhkqmNWLDcl9z6
         E7ayux/4YmqHEm4j4gr6Cbk+52pqFLEjsWEWrlWMGZ1wL4xaakf1wkOwGgZsEY89PlmW
         CP0g==
X-Gm-Message-State: APzg51Bta4p2y21nFe1rgY2McSLkbIphBh1mT/8EcWBlP1vNjxSCR2nK
        xzD4ChJiNfnob80nrUTexstkrNMjEA99SMvNB86DTw==
X-Google-Smtp-Source: ANB0VdY9AFuMXL4fFTIYdT964/zUMXKBOyzVopP15mAnM0ubgrLskTyYd6aSK3JSU7Pb0kVozJuEpZRxDNZbX82S8r4=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr4724428iof.304.1535543206128;
 Wed, 29 Aug 2018 04:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <1534249957-15543-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1534249957-15543-1-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Aug 2018 13:46:34 +0200
Message-ID: <CACRpkdZVr1Y0NbX15jaS95MOptqS71miGF0Umj4iEFffwS3-hQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: gpio: rcar: Add r8a774a1 (RZ/G2M) support
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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

On Tue, Aug 14, 2018 at 2:32 PM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:

> Document Renesas' RZ/G2M (R8A774A1) GPIO blocks compatibility within the
> relevant dt-bindings.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>

Patch applied with the ACKs.

Yours,
Linus Walleij
