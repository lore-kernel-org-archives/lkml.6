Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3EFC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 220A620652
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 220A620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbeHaQ1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:27:41 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:40772 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbeHaQ1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:27:40 -0400
Received: by mail-qt0-f193.google.com with SMTP id h4-v6so14238865qtj.7;
        Fri, 31 Aug 2018 05:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JS4nGoBV3fTsdln9nWMpDI3LYIXE9ROEJaZO5akxGRo=;
        b=SJnCHLBOLmyx5SKniO4t36GLepBzonHMqw6OgsUFL3IT33TK2LWwDUIjwsD101wgw4
         o/aYtmFO/1w2mVqKjq9kYUJyTLcZM8+grIENC55+3xQLRuJCdQ/QI3v26Zsin3D+xg0n
         EQju5LIe9YKWq/j3WGTVt5mX1Z0mnpCnRrRJYjv8GSzxcYZuy1Xbf2dV11nwkDLkH7OB
         sAqcOV8mblMAG2U8X8h6Xxwp9dqW17R15UzpbuuOmsLvcrCR0+IcELVa8DfCqbafNgRC
         owpSOApwyN3ElsLB7/HW6JMnVuRlRRqpFKfmjs8hMtwareksOm8z03D4BNA+9HaYaZAm
         UX3Q==
X-Gm-Message-State: APzg51Ct5pEJ99Bk10XR8616eColwko0TI+6rMpNjbt3sbiMfWrLzJzA
        HOpo2wD2aVRvRd0odK22TzKJBA0=
X-Google-Smtp-Source: ANB0VdaUQsXGnQgaePEO98lCXmQcJmZWyp0198k8MJs/gMcI+4+xxmChUkxuf1b5j1FUobjsHErU4g==
X-Received: by 2002:ac8:1c4e:: with SMTP id j14-v6mr16173352qtk.159.1535718024999;
        Fri, 31 Aug 2018 05:20:24 -0700 (PDT)
Received: from localhost (mobile-166-170-28-234.mycingular.net. [166.170.28.234])
        by smtp.gmail.com with ESMTPSA id b16-v6sm6115613qkj.76.2018.08.31.05.20.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 05:20:24 -0700 (PDT)
Date:   Fri, 31 Aug 2018 08:20:21 -0400
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] dt-bindings: usb: renesas_usbhs: Add r8a774a1 support
Message-ID: <20180831122021.GA26062@bogus>
References: <1535097375-5561-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1535097375-5561-6-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535097375-5561-6-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 08:56:14 +0100, Fabrizio Castro wrote:
> Document RZ/G2M (R8A774A1) SoC bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/usb/renesas_usbhs.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
