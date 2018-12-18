Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38526C43444
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0097421850
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545155286;
	bh=aogbVM9GqEZ5QklLYCxcjKLceQkeVG2iktp+2Xhs0So=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L+Fmw0wcg9mC+MqqetUkW5em5FgxJsUKvnjg6BxrCGtsvAMgJpxzMzYLPY/JYGCjB
	 OE7HxLjQzUr7lqE5RIIi5mI88EHOhE6ETVIhOJX0PtwDqszWB+dXKeDAqlkXXBrtoH
	 MtMal4IeCP9TE81Nm90E0gNYc2q3s4r5M0Ce2uaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeLRRsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:48:05 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46777 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbeLRRsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 12:48:04 -0500
Received: by mail-oi1-f196.google.com with SMTP id x202so2615184oif.13;
        Tue, 18 Dec 2018 09:48:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QJcFXHzMMQRFTlXGvFeja8YdzAn/YAEOhiWMYTn96M4=;
        b=sURuzwxx+7VtXyEd9pl6TvjOUaBM/ov0cDowP5B/O+JpWOUXiRWmIQ6pSmJu3O9xPC
         sB8nNyrcTuFX1R0Zjq3Nv9jnKFT9TfNMf0/TCMLcNy5UD6fSYgMNYKvjVqJs0x86+/9o
         0OJWISE28/lnx5ewcm/kHz4gF/wRxjI7sv00hBj9CxteRnyWTjbPIrVs/igu++RlCKkA
         iPhv2+GU+bwhlMqYxKpdOZnnHabDjSQQj2D1T/9pZ3T9ZNYuKEvrBGla5oif6rRdce2p
         Kz/FPSOWRHbpn0lBAX3hJNUKAbnD7TmSiEuitn16XAKmnNjmdnAuXwICGg+GELrn56gG
         Qkrg==
X-Gm-Message-State: AA+aEWaKr5KwG1vJv8aHdHRgyoJz1o3iEM84tVebA7fuQAnfBGp6gk/Q
        A/e8FILyZnJ76BDl7DrPOQ==
X-Google-Smtp-Source: AFSGD/XKvoysa/d3wKaB7Y7gocBWX3WmxMpHGNf8gX1SqY7ueHR3UTbqiC6CT6+6kpGlRmU3EachZA==
X-Received: by 2002:aca:4f16:: with SMTP id d22mr8009247oib.255.1545155283566;
        Tue, 18 Dec 2018 09:48:03 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s66sm13329460oia.55.2018.12.18.09.48.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 09:48:02 -0800 (PST)
Date:   Tue, 18 Dec 2018 11:48:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: PCI: rcar: Add device tree support for
 r8a774c0
Message-ID: <20181218174802.GA27290@bogus>
References: <1545134562-22450-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545134562-22450-1-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018 12:02:42 +0000, Fabrizio Castro wrote:
> Add PCIe support for the RZ/G2E (a.k.a. R8A774C0).
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v1->v2:
> * Dropped change to the description of "phys" optional property according
>   to Geert's comment
> 
>  Documentation/devicetree/bindings/pci/rcar-pci.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
