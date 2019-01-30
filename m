Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157FEC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4372184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548865371;
	bh=rjHN2f/BbtaUmc8BEwQwld70nKEdaVt83y9l5q0zm3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pTW70yCwBzDWiJ95wjRUkhOUasmkegGfwWqPcPsO0Eoq437AwZF1bI2JpaQ/hMKbq
	 aosmQD+fbTCwQf85aqprZOfT3ece39mdksJH6uN1YUFwEvbm4zb0VfGoI4N0YZiRip
	 kUHbI5RenOK5C8qZNyAinxr1IZf2hoUrwWqJ0BLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbfA3QWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:22:50 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:45091 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3QWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:22:50 -0500
Received: by mail-ot1-f46.google.com with SMTP id 32so46689ota.12;
        Wed, 30 Jan 2019 08:22:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fU3YTEP/2Tjt+O1XM/zfybg9MT3B3iPPfCLdvguDSQY=;
        b=curLzdX6jscTOH9j9B+jC2GkPSb7apndlsSurFt8w6iDQ006tzjnNeIhHTiMzIOKcB
         udmeaVMRtRnkNeo1CIX0zzeYkjytH7YJOZOh6GpIdajOsijpKpPJ9iYmBsPvJbLbBsTs
         8vHNzMwi06AgubgohNh6ih+aqtPp65CKfZDFnpelHqa7Bhkhp/O6brNtHWCSYddRLvsO
         5oNgjUZl1mR9rkQX7yZxuqOzODuTKxjDpHm1ZjogrnIPVaRkDQE810nReyaw9YNC4UZb
         RuXbbr3VXdoWqjklTScxwo0w+VN5fL7yUJ7ex6mdT5EqgAfBEG1TF3noaJpEashp0vB+
         JMHQ==
X-Gm-Message-State: AJcUukcdXLNiq7gr1ICCd3AFwsHpN6PajFLnvV3OastqMhU+b051Vg79
        FFHp/tsy4QITdK80Mh6UuQ==
X-Google-Smtp-Source: ALg8bN64Mlz8E4JpZTCWJT8D1JGVTf0eCWEALMjfkTw2fu9nBHwyxM/xGRxvN+KTPgrGiVNu0xVyWw==
X-Received: by 2002:a05:6830:110f:: with SMTP id w15mr22588176otq.222.1548865369344;
        Wed, 30 Jan 2019 08:22:49 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n8sm687013otl.40.2019.01.30.08.22.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 08:22:48 -0800 (PST)
Date:   Wed, 30 Jan 2019 10:22:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     axboe@kernel.dk, shawnguo@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, leoyang.li@nxp.com,
        linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        andy.tang@nxp.com, Peng Ma <peng.ma@nxp.com>
Subject: Re: [v5 1/2] dt-bindings: ahci-fsl-qoriq: add lx2160a chip name to
 the list
Message-ID: <20190130162248.GA8669@bogus>
References: <20190125081013.21663-1-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125081013.21663-1-peng.ma@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2019 08:10:12 +0000, Peng Ma wrote:
> Add lx2160a compatible to bindings documentation.
> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> ---
> changed for V5:
> 	- change the lxx2160a to lx2160a
> 
>  .../devicetree/bindings/ata/ahci-fsl-qoriq.txt     |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
