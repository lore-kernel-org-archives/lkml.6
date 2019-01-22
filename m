Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5455CC37124
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D103217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548118214;
	bh=/xD9S6HAY5UrqwZSmUwYROHyU0A7LoGs0J2ESPlgUuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c0NmXbO54q0EJHJaRjIj9xQJ5R5KNzz05IYaT735XcShFasTQbNchEL+0nXjaG3UI
	 cqdgidkMPCiKSxRzB6BSBefpL0RxEDhyMqO4LB8JFsFHhoLRX7wF59v4I4Nw8q7LPg
	 /kaa1dMiG22qXO0g1EiC3Fssmixc+5HQm55vEKaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfAVAuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 19:50:11 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34931 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfAVAuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 19:50:11 -0500
Received: by mail-ot1-f65.google.com with SMTP id 81so22210927otj.2;
        Mon, 21 Jan 2019 16:50:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E5hzTcVQDkYfktvOGZ6pQ4EqR5N/hq7vmJPB4pvKxYY=;
        b=eaUdDVudhyoN0lvP2YrJDMKBQWHC6L8rINu3tPOEOLdoT0l74PneF8z2ZbNskzlr6A
         JIDb+KC93J4J0Kl/rl2pzpghskbDyxLDaLIX7SS5y3cc37HM7tTuoMfvLBnt29ItFkpU
         PuSsyIZ2GpdDV67IHjPwNBn+s4hETvFkpr91NZK0mGXojpkIKrcERu3U1FM4p747fiPf
         Z+PWGEO/DqqGGUnHD5C74c8rkMaO/EjkFanyQmLhQ7KHJb6hna3EYMW9sPu4Ke+DNwZY
         0UjYEvVRVBkbgpk9XyiPe30Rbjyvdvb796lpRdVNA/RBw3OhPXsp5DGXh+zGL/89rVHH
         Zw8w==
X-Gm-Message-State: AJcUukeW6F5+L753LllqevlRW20yNjdqljX3cRojrkRDwRDZJBKYssQp
        9qvUCSr7884GuyPImhZwXg==
X-Google-Smtp-Source: ALg8bN46w/2Fw2peFWJHR+D6fVv+ExMsrBUd7y/SzIrPhQAUyj5aYKNHhacydO2FgZdbibuUmd/DiA==
X-Received: by 2002:a9d:ac3:: with SMTP id 61mr21688347otq.272.1548118210574;
        Mon, 21 Jan 2019 16:50:10 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r184sm6729488oif.56.2019.01.21.16.50.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 16:50:10 -0800 (PST)
Date:   Mon, 21 Jan 2019 18:50:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org, zhang.lyra@gmail.com,
        orsonzhai@gmail.com
Subject: Re: [PATCH 1/4] dt-bindings: power: sc27xx: Add one IIO channel to
 read charge voltage
Message-ID: <20190122005009.GA28344@bogus>
References: <76a12fe5d0cc670266100b0587b047714c9a8a83.1547544142.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76a12fe5d0cc670266100b0587b047714c9a8a83.1547544142.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2019 18:32:34 +0800, Baolin Wang wrote:
> Add one IIO channel named "charge_vol" to read the charge voltage for
> the SC27XX fuel gauge controller.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  .../devicetree/bindings/power/supply/sc27xx-fg.txt |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
