Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13212C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F2224102
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F2224102
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752950AbeGCXdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 19:33:41 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:33677 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751962AbeGCXdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 19:33:38 -0400
Received: by mail-yb0-f196.google.com with SMTP id e84-v6so1394044ybb.0;
        Tue, 03 Jul 2018 16:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+1xW0Htd7MwviUq4ezIAO4KjkxwkT6kRmnTTSQirWBg=;
        b=EBw/dDSnMJf/zA1VrpNAIk3ePP3q0e+D6ylho1HounmbUIqQ4F/MconP2336lH9cqt
         3rE9WUBMiNLb56H/6mRQ/upZeMaw6UkBDlXtwYdO9XOKwD8VnvsnLQkz9oUJRPFtKv3R
         qhrTaUm4Wh9WX/0Xo4yHWJ65Fs2VmqnntxSFGG5EWOcROMCVTaO9dhneCqId8eN47ImD
         75Trlp3F4fGDBaIr9Dm5anvGm4rZHKgGmczjcAdpnPua4c/dKs6CBbvVOBrCKXKH7MyB
         LG4EdlJ8Z6aSUqUYnj1ceseGllXpO98bwl8S4i3ZMAlnN7Lw90xEwVEofi2W2LdNWUfB
         XFxA==
X-Gm-Message-State: APt69E1NF36795npzPrv5f2QYdCVrcuZB1eBjH/I3dSYHpX5AgNgmAjg
        D7DBletM7qsgXOV5cYIc3Q==
X-Google-Smtp-Source: AAOMgpcyi0bVsY4U4of6cA3HhBfxOGJS/QHVTcjuQsaJYTfDudUV/zlplI79LiTAlKRyksb4EBY6Ow==
X-Received: by 2002:a25:844f:: with SMTP id r15-v6mr5275800ybm.345.1530660818268;
        Tue, 03 Jul 2018 16:33:38 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id g31-v6sm900817ywk.84.2018.07.03.16.33.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 16:33:37 -0700 (PDT)
Date:   Tue, 3 Jul 2018 17:33:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: phy-mtk-tphy: add optional properties
 for u2phy
Message-ID: <20180703233335.GA32530@rob-hp-laptop>
References: <54260d59ae39c2335e97892fe85db16cac30b33b.1530238400.git.chunfeng.yun@mediatek.com>
 <86d49766059a738e7182a49e6c113a12403b3b01.1530238400.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86d49766059a738e7182a49e6c113a12403b3b01.1530238400.git.chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 10:20:28AM +0800, Chunfeng Yun wrote:
> Add some optional properties for eye diagram test and BC12 of
> u2phy
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
