Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCDBC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7899C2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7899C2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbeLDW54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:57:56 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39195 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbeLDW5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:57:55 -0500
Received: by mail-oi1-f194.google.com with SMTP id i6so15837948oia.6;
        Tue, 04 Dec 2018 14:57:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d0LhsCTLV6qHHhR/sj3cVjy7jDlm7mP1S7nUySnGl8g=;
        b=L+dP5/0/r2cM8adlYT2whP5l7iXMWH2iri/oevfAmNrB3RzXcXs9qdwvTy8GOK9Fbe
         JTWyBrKiPFPCFiekRNElSueCuAYFY3olX2E9oIq5HYGjzcG7VyZz5XLw5mnDPo2ig76u
         B3tomkPt1BS1sUipfjPvhwhaWbXhGBbO5X9vV5EGQmzxkbeQOkNka1ke72gPkHUOn/vQ
         /Lvnv7vjp61dwkblWfEaZoyaIDBu8/eKC5VGUsRPQUtvbshshwBcvQWZlYprSL/S3T26
         iczsBeECriMabsMS1b/HBOUWjoVF39xO09Z3rs3y9OCUGfySDMNYq5PoucYb3ezxAgS2
         7VFg==
X-Gm-Message-State: AA+aEWYyYpNK8dEq6wSW8Kf0zlXpS0tCxCYnjQ3/YKo95/OYSEDqs0yC
        4ynDG6uFJgTjbRM3rq4MzQ==
X-Google-Smtp-Source: AFSGD/X2QLMdDMe/7l/pPIc3BNcJqMo9JPfUrZPwq7sjp8qk+cgh3oxiwpl1eZn1oxyxaOXHFNX7tg==
X-Received: by 2002:aca:1c02:: with SMTP id c2mr14055786oic.74.1543964274158;
        Tue, 04 Dec 2018 14:57:54 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m2sm14548403otp.34.2018.12.04.14.57.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 14:57:53 -0800 (PST)
Date:   Tue, 4 Dec 2018 16:57:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     johan@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH 3/5] dt-bindings: gnss: add w2sg0004 compatible string
Message-ID: <20181204225752.GA23361@bogus>
References: <20181118215801.12280-1-andreas@kemnade.info>
 <20181118215801.12280-4-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181118215801.12280-4-andreas@kemnade.info>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Nov 2018 22:57:59 +0100, Andreas Kemnade wrote:
> Add w2sg0004 compatible string since devices without wakeup
> pins are now supported.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  Documentation/devicetree/bindings/gnss/sirfstar.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
