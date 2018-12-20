Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FC1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24FB21907
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545338181;
	bh=N5G0yDkpdD1N9e8Q8NLDJxhYMayveV97MgHObcP/AkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bqMDzSW0+r4ylo6bWquwvYuchtX0GzzEZGDJ2HWia9YycHCiTbQAnEYEMzIZoEfEK
	 1H8RF5bcPrrE0hc4yXnuXd9ZTRKjH3jOG4UMPr7W7EW/fWoS9MhcjXwFfJY+heXy28
	 3xSA6EYAnwNK7cpjvpj73VZRug9gkUV1zSWIZNqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732396AbeLTUgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:36:21 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:55628 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbeLTUgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:36:20 -0500
Received: by mail-it1-f195.google.com with SMTP id m62so3932084ith.5;
        Thu, 20 Dec 2018 12:36:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cWq/JI6sBy72pbbAKi9t+bxuJD77VGB/IaIRKVR0DOs=;
        b=VujNC6mm0wnxQjeJ9H0FxBGeznczlFDgfXMeuVpHHtVPbJ4fJwDFk04KLkwBlEeMb6
         C5vjIAo/QDtGk7Vis30xBlqv0Ucgcdhp5u+7Zegjtvvs65pMEvOwzv9lWU1ctRhyE9wU
         vDWL5bkTlRq3aNiDTMiqf45zaEqy9Xws/c3zMQOulgciMF/hFp7XZaNNEEMJDt0wH7C5
         OOxJRa85/VhprZyxWa4VR71Kzaz5OGjw7vO/Vc7jPx2qR9h04eKVDYXP/zwKqEujLmj6
         wFBePYzr+t9RqNl6bWFjkV5Zj7VBK3y6M2V1i/31+JBK0Xyy4FahwMrwfR2YXvI9EhKy
         K4KA==
X-Gm-Message-State: AA+aEWZ+URAI4ON8jLdIZwRPbfGqUn5PwZ5D54zCCmXOFh9uLVHCdIzd
        4mhWfZ0FmOxAeRW6n5uFwA==
X-Google-Smtp-Source: AFSGD/XTEpeA1t9mz28MT4R5bvcWrhHUX3IpdNHmeHOstxMpr6EeETcgxiIfDK2W7oOC46Z1bXn7zQ==
X-Received: by 2002:a24:6fc4:: with SMTP id x187mr137757itb.93.1545338179071;
        Thu, 20 Dec 2018 12:36:19 -0800 (PST)
Received: from localhost ([2607:fb90:20d2:a5e2:49af:e73e:5a36:3b50])
        by smtp.gmail.com with ESMTPSA id n129sm6218824itb.20.2018.12.20.12.36.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 12:36:18 -0800 (PST)
Date:   Thu, 20 Dec 2018 14:36:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: thermal: rcar-thermal: add R8A774C0 support
Message-ID: <20181220203617.GA18535@bogus>
References: <1544732388-6313-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544732388-6313-1-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018 20:19:48 +0000, Fabrizio Castro wrote:
> Document RZ/G2E SoC (a.k.a. r8a774c0) bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> 
> ---
> 
>  Documentation/devicetree/bindings/thermal/rcar-thermal.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
