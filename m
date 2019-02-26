Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4423C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716942184D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551199192;
	bh=lcwJmi+mbC/puoxwL6ouKhjYjp327Z2coyGiJttKJ2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eON3n7bSyCbrIoVMPg8RFJgCSBNpo+QmSk//4HwluT2D5GtHBbtVv4YXYPV7eAOnr
	 jTat6hfXaJ0mh+N7COU8M0QBDmsHBX/kTBpWRsyqqCN8VVhHSUxWUK15vfKwyiOxkR
	 Ey9j2mqjc+ai3Jbgges+bXW8MrQ27wmwgRV3RGMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbfBZQjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:39:51 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40458 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfBZQju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:39:50 -0500
Received: by mail-ot1-f66.google.com with SMTP id v20so11625974otk.7;
        Tue, 26 Feb 2019 08:39:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cMT88YQQfyXIgu4kn+RVboLvqoRCCLw3kepgIJfJrq8=;
        b=ESZK3O0t98A2/CEK/piD4qjJ/E+jidKkx039uXYk9rJbZQFuXn9yh0G4sMb5bdEAAz
         yQE5qoYuCBU3Gumtj/oiL5Ls2O9ftcU84ol8Hhw5TYlkpg0KKOUQoKrPZCcpbm+VQhv8
         zSFbBL24l0ZKcXLj6YjJ4yemQWBXiYrhBn1CmoPq1Fin2QGg8v+ksXP1fERMg6r7b+3f
         Nk0WjjvM0gs+CPxYWL1G60JQsYXlHU4Ob6+NgA5bCFIdZNnTZRNyz1MuSet1+pgCmnqM
         HvEbT5rMsTqqF4YHO3VCXXqkHeO+zakQsrbOjY+ugTtOw7CedQoQTESOTEFog3E/okbZ
         nfJw==
X-Gm-Message-State: AHQUAuZPllbfeaJ/uajS4D17dhAy1FVnraB0Jpjqv2QExF623XtKISHr
        P4CJDPz4pGgnbptdr6OP8YlLZ8w=
X-Google-Smtp-Source: AHgI3IYYsd3s1omOgAVurathtKI24siCJUkO0pB8AksCs175SuHSWgNFvkXLYYO1OeNxvsmW6EnBlg==
X-Received: by 2002:a9d:4c02:: with SMTP id l2mr15855630otf.56.1551199189701;
        Tue, 26 Feb 2019 08:39:49 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y37sm6061269ota.17.2019.02.26.08.39.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 08:39:48 -0800 (PST)
Date:   Tue, 26 Feb 2019 10:39:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yang Li <pku.leo@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: Re: [PATCH v3 1/2] usb: dwc3: Add avoiding vbus glitch happen during
 xhci  reset
Message-ID: <20190226163948.GA8854@bogus>
References: <20190226070016.27372-1-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226070016.27372-1-ran.wang_1@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2019 06:59:21 +0000, Ran Wang wrote:
> When DWC3 is set to host mode by programming register DWC3_GCTL, VBUS
> (or its control signal) will turn on immediately on related Root Hub
> ports. Then the VBUS will be de-asserted for a little while during xhci
> reset (conducted by xhci driver) for a little while and back to normal.
> 
> This VBUS glitch might cause some USB devices emuration fail if kernel
> boot with them connected. One SW workaround which can fix this is to
> program all PORTSC[PP] to 0 to turn off VBUS immediately after setting
> host mode in DWC3 driver(per signal measurement result, it will be too
> late to do it in xhci-plat.c or xhci.c).
> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
> Changes in v3:
>   - None
> 
> Changes in v2:
>   - Correct typos
>   - Shorten the name to snps,host-vbus-glitches
> 
>  Documentation/devicetree/bindings/usb/dwc3.txt |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
