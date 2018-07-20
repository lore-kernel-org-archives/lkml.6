Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5593CECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD3C205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD3C205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731910AbeGTPCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 11:02:51 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37153 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731186AbeGTPCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 11:02:50 -0400
Received: by mail-it0-f66.google.com with SMTP id p17-v6so14761772itc.2;
        Fri, 20 Jul 2018 07:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V9uv08rQ6Gw6IFyCeqC7QQzx5oQWH6hAziL8PKWpTbE=;
        b=UMFIGpVovksSBWB7BQSRkb+py7z2upx2ptTir0i/EpJQyJiostV174bObduV8X8k4r
         aGVCdLkMcPN/IFUdFV5sBNFBdnm5vi012/0/ac9/3qxsK1JttFLkrHSotpglX90D++B8
         v6MOM6ded4h/+ttNQUouHsBmWsW0qWR8L04bwK53H2R/KbPyiXBShy61YlAINeY+q7Aj
         xTpqJOrhY3OQmvQ/mYCgZDvGjeB6/5K1uIDqvZDcSJFBmsit1uv9lgOlSis1iI/JvaN8
         16dchogXnTIjq7/zuRPiPEdgmZq8URvTt3gzMNvtGlbcq/PJ+Apnl9kzDTdOZFHqCyFb
         u4Rw==
X-Gm-Message-State: AOUpUlGOzyCAxDUnXJKPY3+7EzYsTqcEIBgIddXooAUWFaeVq+Y32OEP
        f1M8lEj2dl/EcHgDfr5/Iw==
X-Google-Smtp-Source: AAOMgpdzBXKI+wfTb9ubSTfMk7JA8Gxg9gbfk++MjGncVSPAuv8dm/p2/xRbWpgO9PSxovQj5JQxow==
X-Received: by 2002:a24:491:: with SMTP id 139-v6mr2000589itb.111.1532096058741;
        Fri, 20 Jul 2018 07:14:18 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id t191-v6sm1009367ita.28.2018.07.20.07.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 07:14:17 -0700 (PDT)
Date:   Fri, 20 Jul 2018 08:14:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH 2/2] dt-bindings: arm: mediatek: cleanup MT7623N
 reference boards
Message-ID: <20180720141416.GA26824@rob-hp-laptop>
References: <34e4c13bd1deeb8e090a74b4e7e9192512b3eff0.1531199139.git.ryder.lee@mediatek.com>
 <99c1fce76e7ec4984c232bc0bdbd0fadbb86b0dc.1531199139.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99c1fce76e7ec4984c232bc0bdbd0fadbb86b0dc.1531199139.git.ryder.lee@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 01:09:26PM +0800, Ryder Lee wrote:
> Cleanup binding document to get rid of unsupported reference boards
> for MT7623N.
> 
> Cc: John Crispin <john@phrozen.org>
> Cc: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.txt | 3 ---
>  1 file changed, 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
