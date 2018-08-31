Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124E7C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF2920661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF2920661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbeHaQ0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:26:14 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:43484 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbeHaQ0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:26:14 -0400
Received: by mail-qt0-f171.google.com with SMTP id g53-v6so14204389qtg.10;
        Fri, 31 Aug 2018 05:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iE9E2Io3sqeZ+JmS/GLT79njjytBiRNpIAj0qtL5Nlc=;
        b=optGbgtu7kTkcNbmiLerafLZN5DJRlyxwLclURxPAqoOGsr984XOR0LDuXe4YYQtCg
         OOn7caA9TVgVdX79SuQq2NfCj8fGaRxHx7ypzslXOWSbYs6zgtRrATFHfgE0Cv5ntfpH
         X5yog1zppogMFZ6RDpBqdeUFfJe0yTTA3dEYGnJWTsOSBZ6Qrj3ghZC+TCjL8+Of801X
         3aYmiVOzjSXSrOK5RQi+HTMamvmioCHHG2ycX0c3KRCOGfUi2hlAT9iSmam9erEMHaDy
         O7quPX/A6oqHVF0nx9v4xdT2ZwJUYZH1/eHps+AoI1OywSCiiXX31S1UOXSaJ0x+yu3z
         AmAg==
X-Gm-Message-State: APzg51BBOyCB6Y8+KsCCD3MfOCQw6eMosrjzCRfg3jVj/K1OaiLl7g+M
        j5MqXwBZYznbbTIQUThUIA==
X-Google-Smtp-Source: ANB0VdaWdngAhpADiopJH+Rdz/UGa34cm//JopscSvT7NAk7awuCBsDr045oxUs/3S3P6czu8mJjhQ==
X-Received: by 2002:a0c:983d:: with SMTP id c58-v6mr15124173qvd.221.1535717939666;
        Fri, 31 Aug 2018 05:18:59 -0700 (PDT)
Received: from localhost (mobile-166-170-28-234.mycingular.net. [166.170.28.234])
        by smtp.gmail.com with ESMTPSA id w70-v6sm5436649qkb.58.2018.08.31.05.18.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 05:18:59 -0700 (PDT)
Date:   Fri, 31 Aug 2018 08:18:58 -0400
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: rcar-gen3-phy-usb2: Add r8a774a1 support
Message-ID: <20180831121858.GA23975@bogus>
References: <1535097375-5561-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1535097375-5561-2-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535097375-5561-2-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 08:56:10 +0100, Fabrizio Castro wrote:
> Document RZ/G2M (R8A774A1) SoC bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
