Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DA6C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B817221873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545153142;
	bh=1LwkZ1agk0fLg1UBEVvd1R4DUccu02ASYNSWgmrr91I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eIwdfULdpz1HtwScDn7T82OkZYJxvy3r51zC36UGyyLR+WQR74fQwTCgs1fVlJzcf
	 apRQwmadnZn+DhGnTCiYBw+cMrevlzK25U9tQib6UothVwdv5b0H4TukTWDU4Gthh+
	 ++PHkQGNUOgDwRDHE7kV24wIOwZnXwRVryVgKHfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbeLRRMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:12:21 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39236 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbeLRRMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 12:12:21 -0500
Received: by mail-ot1-f67.google.com with SMTP id n8so16356006otl.6;
        Tue, 18 Dec 2018 09:12:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KBkFXO7YRi0BzUDvdPfXCxza792mvEiWPj8RaAYEA9s=;
        b=sWflziprjzROwXe/GQTWrIJd5JuuQdQcb4QPfHbpkeN5VUTMQTw8IVMp2SQRkXUcfa
         ADFbF6l3pYxyqhybsOCWOLn3f4AXE5QKZNu8xr5rvxeOk/1hUSbRAe6HwD1hi93vKlyn
         AB6e3zGtytmQLeTPxaSvOJWbcB9Lb/WF1od8eyHhWVH1HZ9wyNJCr4lm41yR9Cjy8auy
         i3bU0buhGD7YZYrnCd91wmQK78JG2QO49NxLCVIy4diGbOJMfeFbOzeXQtjAVAJZbswW
         Uq4W0SwycYKiOSTOTBpFkS2g4Iwdai+fK3dhPfhSklwgmDlf3awB9gCOJZNvcypv9Rjj
         QX/Q==
X-Gm-Message-State: AA+aEWYzxsi7gnW1Qx1nRZUCjzN/95+pKeaXCp6CQV6XlB1bDG91epGc
        W9UibkgDiyRpN+EDRCI53w==
X-Google-Smtp-Source: AFSGD/W0RbkhQE/hbR2ucUC5FLqh2omYCjayYQThSOC+2/XIkt3VxfOMEbKGUOKyxIvQBk2Jrtrygg==
X-Received: by 2002:a9d:3e4a:: with SMTP id h10mr13640993otg.74.1545153140609;
        Tue, 18 Dec 2018 09:12:20 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h24sm9612983otm.72.2018.12.18.09.12.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 09:12:19 -0800 (PST)
Date:   Tue, 18 Dec 2018 11:12:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, alexandre.torgue@st.com,
        mcoquelin.stm32@gmail.com, arnd@arndb.de, mark.rutland@arm.com,
        gabriel.fernandez@st.com, fabrice.gasnier@st.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: stm32: syscon: add clock support
Message-ID: <20181218171219.GA2223@bogus>
References: <1544604495-4082-1-git-send-email-fabrice.gasnier@st.com>
 <1544604495-4082-2-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544604495-4082-2-git-send-email-fabrice.gasnier@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2018 09:48:13 +0100, Fabrice Gasnier wrote:
> STM32 system configuration controller registers needs to be clocked.
> Document clock support on stm32-syscon.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
> Changes in v2:
> - move clocks to specific bindings using syscon as per Rob's comment
> ---
>  Documentation/devicetree/bindings/arm/stm32/stm32-syscon.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
