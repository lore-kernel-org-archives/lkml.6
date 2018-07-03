Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3F5C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361BA2469A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361BA2469A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934271AbeGCRUt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:20:49 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:40821 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932759AbeGCRUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:20:47 -0400
Received: by mail-yw0-f193.google.com with SMTP id p129-v6so965472ywg.7;
        Tue, 03 Jul 2018 10:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qogwY903pMM6DzGpevVMU3jkZGXp4p4ngCxyZtNN8ts=;
        b=I0SUSaOYUjjBV4kMd8kRtSIrCjLKUXcifV+gSrHZuj+JLRvj8aRGdgQ0EWTCNoCrtd
         08M2YJgaTBssqrRMikZxxdbPN87KxV9wX9bVIRRV5Il0cMbGBJMckCEz6hC4MJBLJotz
         RfSOWrOKn99U9Ls561kPr3FKaaEMOWyNLKsD9vhq7Pd2dnvJowAIIjsA48gjqwZNKiV8
         ZWh6RHTlCCuI2dg1tp2df+W9ORVoTZoKng9XbmvlTsKdooxLW6hRYzDcF9l2EXVe2sn4
         WO347gbvYAaCBkq0a8YBQ16OP0PExkG94b6w8zTrXQCpnb/7ffn0Mfu7wyNuBOvKr6lp
         fCTg==
X-Gm-Message-State: APt69E3qJDYu1ams5r31iChItB8VwpW6wCWJvNCUONewfaNFAm7Ih2PF
        K+6HZFR7YOiyAISF/DSoFg==
X-Google-Smtp-Source: AAOMgpcRVPGHNTjYavhcpxClvjnn2JPPHP8zzksYbeY78VcNSLT2KECSxkxeDTEtIK4S00qSgSmNLw==
X-Received: by 2002:a81:8987:: with SMTP id z129-v6mr15089100ywf.110.1530638446708;
        Tue, 03 Jul 2018 10:20:46 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id b190-v6sm522762ywf.16.2018.07.03.10.20.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 10:20:45 -0700 (PDT)
Date:   Tue, 3 Jul 2018 11:20:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     thierry.reding@gmail.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, hl@rock-chips.com,
        briannorris@chromium.org, emil.l.velikov@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v5 3/4] dt-bindings: Add Innolux P097PFG panel bindings
Message-ID: <20180703172043.GA14703@rob-hp-laptop>
References: <20180702102721.3546-1-heiko@sntech.de>
 <20180702102721.3546-4-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702102721.3546-4-heiko@sntech.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 12:27:20PM +0200, Heiko Stuebner wrote:
> From: huang lin <hl@rock-chips.com>
> 
> The Innolux P097PFG panel is 9.7" panel with 1536X2048
> resolution, it reuse P079ZCA panel driver, so improve
> p079ZCA dt-binding to support P097PFG.
> 
> Changes in v2:
> - None
> Changes in v3:
> - None
> Changes in v4:
> - None
> Changes in v5:
> - use separate file for binding
> - keep power supplies as required
> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  .../display/panel/innolux,p097pfg.txt         | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/innolux,p097pfg.txt

Reviewed-by: Rob Herring <robh@kernel.org>

