Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B628C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2510205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2510205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbeH2EW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 00:22:29 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:38326 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725199AbeH2EW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 00:22:29 -0400
Received: by mail-oi0-f68.google.com with SMTP id x197-v6so6171623oix.5;
        Tue, 28 Aug 2018 17:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DUCW6Ati6WZgSvRN3U0eOlC9a4No/HO7JURbRNOR0YY=;
        b=J7dS7LsWjxS1a20yDhoB/DKRqjnBpHiUCXc2kCYyvda9+L26TpqIU60cpsPXyFOc5Z
         AncxOfLzN39JM78RvLttovBUkwmz2L9FEEkk8yzQ5pJw0+MbSV4muEY249aJ2gzahSbC
         wHcBTudyUMDdwleJtlWcJxRx8IvaUAB5gL6bDBp70hnzXjezRDDBaTQIvOcVYI7wxTcj
         fPVAm9cxJ9SSoMomn+gGzrjO4oeo1lvMvCAon1iDsJeyK+IMl5CX/ubX1S9/ZZA3gO5x
         3aGNgy4HGrRLf7ml3G1U3y9vXSTq7eCnAc1XfC9rmRrDoC5AeFzIvHjX+QGMhhFxD7wE
         A9pg==
X-Gm-Message-State: APzg51DAmSrw8TVGPXebqNe5El9LALUKgVBQzAoRpzGWHSRltDHmt4cN
        nUbYLFduCPoliKSbb7IrZg==
X-Google-Smtp-Source: ANB0Vdbp4fJztQBWUxBEBzLJdwvPIflDOaejJUjjllCdypXbmm94eKk8t8AY/9aLl9M5fjhvqHQBEg==
X-Received: by 2002:aca:e184:: with SMTP id y126-v6mr408418oig.313.1535502500206;
        Tue, 28 Aug 2018 17:28:20 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v5-v6sm1285331oix.36.2018.08.28.17.28.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 17:28:19 -0700 (PDT)
Date:   Tue, 28 Aug 2018 19:28:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Damian Kos <dkos@cadence.com>
Cc:     David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Damian Kos <dkos@cadence.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, pgaj@cadence.com,
        ltyrala@cadence.com, stelford@cadence.com, jartur@cadence.com,
        piotrs@cadence.com
Subject: Re: [PATCH v3 4/5] dt-bindings: drm/bridge Document Cadence MHDP
 DPI/DP bridge bindings
Message-ID: <20180829002819.GA12330@bogus>
References: <1535451894-2518-1-git-send-email-dkos@cadence.com>
 <1535451894-2518-5-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535451894-2518-5-git-send-email-dkos@cadence.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018 11:24:47 +0100, Damian Kos wrote:
> From: Quentin Schulz <quentin.schulz@bootlin.com>
> 
> Signed-off-by: Damian Kos <dkos@cadence.com>
> ---
>  .../bindings/display/bridge/cdns,mhdp.txt     | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
