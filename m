Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2079AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93A22086D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547588110;
	bh=p4ALac5h4XfJz/JcmL1ZCjGFkh/x4M1lCmsy0OtPf34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=na1wCBW1KlSvf/arZF3TvFb8VU/1kkIliaXRSa78+YlVwkpiyyyJ5tnvPt758gKqH
	 owioqt2IjGPm/JTEPaN4Z8U+Gcd3RDgxSUCGjWyo+OzswQc/gR4FOYoOloQ27biqar
	 UKTbI+y9Pz8GTl3w/n8Sn7rmBgfl/PZljkClps1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390532AbfAOVfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 16:35:08 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44890 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390501AbfAOVfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 16:35:02 -0500
Received: by mail-ot1-f66.google.com with SMTP id f18so3928911otl.11;
        Tue, 15 Jan 2019 13:35:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QFt4QkuaFBJ+UTKulGEgZAlvahKDtdbTQoMBcU2EktM=;
        b=TETT4pb3XM0gtS6mIPS3402WNnzH8Tvm5LpyU0H8QM1jGK214qfbybaYwSQAI6JFop
         9WJwwVJwC4Djja4Bf9ifvoH9bhO6n01Gu8M0crdRyPtLnSQubSCcefP2CxqLV+N/k6KH
         KlHUau2YhnZjZsk7ZgAA7TNRsQhmKCDQFI0RPbpaGxGN561Caz1DXpHtrziulNgZSdye
         v8Rspbgl2K4rj8q2Y6XkivEM4hnlLcmdQKzfzTXoRxP1VFd3fdRFdAdio9JrUtDkEpE3
         2+0AuMzJ6Ryu68DPBWDBirJlDKRrKhs5D4t6ibtDFcQzUUKmNHHR+/ajz5e17TCTbc8V
         IcSg==
X-Gm-Message-State: AJcUukce4Y3XCjHyVLyMcAYi13cfUXpC9AWDvzjYziP9baeRJ70nRq6b
        5pIsbUFdidiyObROfksu9g==
X-Google-Smtp-Source: ALg8bN5W9zcecLFMaJN9el8w9Tgj+puKvCmvR8bUvQh7VqmU8ojzesqceXrexGEcp3nSYtrUwIVPBw==
X-Received: by 2002:a05:6830:1193:: with SMTP id u19mr3681183otq.152.1547588101760;
        Tue, 15 Jan 2019 13:35:01 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c7sm1790205otf.59.2019.01.15.13.35.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 13:35:01 -0800 (PST)
Date:   Tue, 15 Jan 2019 15:35:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     balbi@kernel.org, vigneshr@ti.com, robh+dt@kernel.org,
        nsekhar@ti.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: usb: keystone-usb: Add ti,am654-dwc3
 support
Message-ID: <20190115213500.GA12172@bogus>
References: <1547132670-5908-1-git-send-email-rogerq@ti.com>
 <1547132670-5908-3-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547132670-5908-3-git-send-email-rogerq@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 17:04:29 +0200, Roger Quadros wrote:
> The AM654 SoC from TI contains a DWC3 controller. Add
> support for it.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  Documentation/devicetree/bindings/usb/keystone-usb.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
