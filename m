Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63238C37124
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A20A20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548118995;
	bh=dSJauaFCbCkNabX6dX1d3My0HO1pu7Q8BuTkrQBxbQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sbu3HdpoaPbQWRA53i3F3FZOJRlHnDDBqh6CvcLOc+rnrVTSeCo7p1Iv2ggZ958M+
	 B63FzKkheHesb92G3hAI6UdbvuDXumrnxRit/zrxER/zI9N+thb/lUSwq1CCjXGdC7
	 MUnYcrrYFExuG378Wemde3kapwoR7CR4A1Sxc6Iw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfAVBDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 20:03:13 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33722 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfAVBDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 20:03:12 -0500
Received: by mail-ot1-f66.google.com with SMTP id i20so22246449otl.0;
        Mon, 21 Jan 2019 17:03:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vLRN6zdO2xPeyW7SDGtM/z29346KS1SxytgAwhX1KqA=;
        b=OSCaUz7UsSQQi14k4Kk2CrVtxHsB1Ykxvmv+q7iCgpfRh+GVtmIbQzpptAclpSgnaE
         yQnzxpNe6NvoGCzgksL1JjZKE9AEU5O+C/FwJMULe2whqvyYoZX4MPWSQtN1m8CPX9aa
         0d8YWEmUqwEzBd8JyxfucasgLTgevAXo1pUKJBkc1/9vwJOx7l7WKdX1wZtZRplGyb1P
         3YCuaXZ90/3Bpx+0KZDuMDUrY9r26KOYklD6Fk31mxtdJ+7npPIwfQDONm+eqgJfiStK
         ncDCFDOTOo3qd3eYM/B0wgD3uQOkLP7UgoEX2L9noHDyDfl5BviPYnAVW8DlpQb1dLfl
         yOtA==
X-Gm-Message-State: AJcUukdLSeOMkxqTXUTEI1u0yLC4b4en0TxWvXeLMof8ymz/kMJUOsE1
        ejv/9HkUs4geBTomB+d6fw==
X-Google-Smtp-Source: ALg8bN44/yvdJrhxcAYvCpoiC3f+A698S+7ChifmeynB6AKPugDXrW698PK4ILwAQ1A5n94MxfwJ1g==
X-Received: by 2002:a9d:325:: with SMTP id 34mr10355389otv.94.1548118991621;
        Mon, 21 Jan 2019 17:03:11 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i12sm5946004otr.74.2019.01.21.17.03.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 17:03:10 -0800 (PST)
Date:   Mon, 21 Jan 2019 19:03:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] usb: dwc3: Add avoiding vbus glitch happen during
 xhci reset
Message-ID: <20190122010310.GA5165@bogus>
References: <20190116064820.20007-1-ran.wang_1@nxp.com>
 <20190116064820.20007-2-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116064820.20007-2-ran.wang_1@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 06:48:06AM +0000, Ran Wang wrote:
> When DWC3 is set to host mode by programming register DWC3_GCTL, VUBS

s/VUBS/VBUS/

> (or its control signal) will on immediately on related Root Hub ports.

/will on/will turn on/

> Then the VUBS will be de-asserted for a little while during xhci
> reset (conducted by xhci driver) for a little while and back to normal.
> 
> This VBUS glitch might cause some USB devices emuration fail if kernel boot
> with them connected. One SW workaround which can fix this is to program
> all PORTSC[PP] to 0 to turn off VBUS immediately after setting host mode
> in DWC3 driver(per signal measurement result, it will be too late to do
> it in xhci-plat.c or xhci.c).
> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc3.txt |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
> index 8e5265e..dadb530 100644
> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
> @@ -106,6 +106,9 @@ Optional properties:
>  			When just one value, which means INCRX burst mode enabled. When
>  			more than one value, which means undefined length INCR burst type
>  			enabled. The values can be 1, 4, 8, 16, 32, 64, 128 and 256.
> + - snps,avoid-vbus-glitch-when-set-host: Power off all Root Hub ports immediately
> +			after setting host mode to avoid vbus (negative) glitch happen in later
> +			xhci reset. And the vbus will back to 5V automatically when reset done.

Can't you imply this from the compatible string. You should have an SoC 
specific compatible.

Does this even need to be conditional? What would be the harm in doing 
this unconditionally for all DWC3 hosts? 

Rob
