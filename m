Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E07C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A1A21773
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550517650;
	bh=vEPaxTXyKNsv0EJIzyfzb729EB5Pdf2G5qelbRv8x5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WONLqMnBeG1epWPUOXXRK1ufc2o2EMfdUkKNGDO6h1z2g+EwyKJ6jxbRii2MzehoS
	 DcWq2I7T0V5XH42EHCKA/c3wfLF2RXlO16Tx/GOX9ZIssD/S8EoXlGMrYg5pZIMRaS
	 miYMGge4sa+1Lokuq9yvbRp058CiU7mSstn2ABFM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbfBRTUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:20:49 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41703 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729004AbfBRTUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:20:48 -0500
Received: by mail-ot1-f65.google.com with SMTP id t7so13737916otk.8;
        Mon, 18 Feb 2019 11:20:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q5PP/fqqcw8lPXLf7c7x4bNqQ7ZyZBNggjfmpsk5TuA=;
        b=S1OhZdGNMS32H4amnF5Be8V/HT0FO5FIxvYyXwpzQNZm1Hv+B2/om8hlj3XoGOi0Ey
         zG6ZI7BuQoguQ5eq5LYUoFYzqYactpoGjqOfTOhhiZUadIsPEE/m2QORS7os3PEqzRYH
         N6wXjwnp8NiRtu+tqo+KLpjCdI+cc8/POiT79HsGy33IJYqo7oWvbj8h5rG29Cts5w1T
         ODazVJzL6xhra0YEjbR1WhnLLy9EvVRv4pVR3S7VNTTytAYpopUSDAXJriGD40apcEtb
         afvGk4USTKrCgX4PNPBylhDGYA0PAM++A8Okm6AceOgflJVI/R/G9GSV205iz+Bkc+EM
         u7pQ==
X-Gm-Message-State: AHQUAuarqWGFnc/BURduqsf01rsAnbeA1xgqQ9zUyoTFwro4ZvCEkepa
        r8mD6AAr63+3jYLk21h0bw==
X-Google-Smtp-Source: AHgI3Iamy8mpSiY+fCQWkRDykm8Z7Jt88LCZ+RiawaIm/zRUQFF51d03jDXbUQZCC+u3pD6ZtSzpRg==
X-Received: by 2002:aca:4c8c:: with SMTP id z134mr244587oia.158.1550517647652;
        Mon, 18 Feb 2019 11:20:47 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s186sm6368090oif.0.2019.02.18.11.20.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 11:20:46 -0800 (PST)
Date:   Mon, 18 Feb 2019 13:20:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Rutland <mark.rutland@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Mathieu Malaterre <malat@debian.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 2/9] dt-bindings: mtd: ingenic: Add compatible strings
 for the JZ4740
Message-ID: <20190218192046.GA27154@bogus>
References: <20190202231926.2444-1-paul@crapouillou.net>
 <20190202231926.2444-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190202231926.2444-3-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  2 Feb 2019 20:19:19 -0300, Paul Cercueil wrote:
> Add compatible strings to probe the jz4780-nand and jz4780-bch drivers
> from devicetree on the JZ4725B and JZ4740 SoCs from Ingenic.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Changes:
> 
> v2: - Change 'ingenic,jz4725b-nand' compatible string to
>       'ingenic,jz4740-nand' to reflect driver change
>     - Add 'ingenic,jz4740-bch' compatible string
>     - Document 'ingenic,oob-layout' property
> 
>  .../devicetree/bindings/mtd/ingenic,jz4780-nand.txt | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
