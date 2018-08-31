Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A0CC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18DC020661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18DC020661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbeHaQZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:25:46 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45953 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbeHaQZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:25:46 -0400
Received: by mail-qk1-f196.google.com with SMTP id z125-v6so1221946qkb.12;
        Fri, 31 Aug 2018 05:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wloCvhove7VsyV7AsDhDwVU0AK1GY1YThF+nB/ph1PY=;
        b=ZrruJM6nke6Iztk5ykhph1Vpqk1Wf3LlECcUKqGf92oe2dmuM+JiALGpzc+dSCmAam
         3ki/6K1qHF21nRJCmVNr72uUok5s960H+iaYcToc6NelSgxgPXTnGdfUfyRmF6n0tWe7
         BBIznz0AgViq6SZ5UyoYL46t97jOFBagv2zzesyy8RJIs8OVCkZJwmHR0MDDlPpGqp1l
         XNytoFuXZoMnILtepc2hASXdyHo3rGWn+UJXgJJaI2kiue7XStdagdX0whAMywjo7AQj
         skVYKE7ChWX72J076Ngbd/gG+vTsVJvRLsuR/mnYPOrnmqiTWxuRoUNoUG7+3iwKa9gu
         Rt2w==
X-Gm-Message-State: APzg51AlKrmwiGBblmyVbtw/SKbAdvMtvzeZH+51vLmNQH3LTIdHGa6e
        6nbOmeUfjlv3LIMBz4ikxw==
X-Google-Smtp-Source: ANB0VdasbyOit1wDAEvQSSBIxHryPLtCMlg9l7Ey1X0f8BYSwt786bZvF+hlgiJ4/qI53RyuO5Y/Mg==
X-Received: by 2002:a37:d911:: with SMTP id u17-v6mr14773267qki.202.1535717912227;
        Fri, 31 Aug 2018 05:18:32 -0700 (PDT)
Received: from localhost (mobile-166-170-28-234.mycingular.net. [166.170.28.234])
        by smtp.gmail.com with ESMTPSA id f10-v6sm3624518qtq.52.2018.08.31.05.18.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 05:18:31 -0700 (PDT)
Date:   Fri, 31 Aug 2018 08:18:27 -0400
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: rcar: Add r8a774a1 support
Message-ID: <20180831121827.GA23224@bogus>
References: <1534867426-25533-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534867426-25533-1-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2018 17:03:46 +0100, Fabrizio Castro wrote:
> Document RZ/G2M (R8A774A1) SoC bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
