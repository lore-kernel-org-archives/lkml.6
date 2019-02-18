Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9ACFC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40BB20855
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550522314;
	bh=D61QD1haHpNP+7nuWOaJbEqyRz7EpRfOyk5CudZjh6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XNrozdvKsgHnJdgKnqcXVzBlBL0LX8LmUb7iGyWQUVeAzgHFatHjnqsUtDz3Fbf1L
	 xw4rPEsJCwCjM70V9ufECfYL1ZtqRxBT7S7DWbuZplQVjYuz2KaOYzgjlcQ3ngqKtX
	 N4WXF1spv0sOhOgrCj8S5k4VdKrBtKGe1BvGNZd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbfBRUid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:38:33 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42386 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfBRUic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 15:38:32 -0500
Received: by mail-ot1-f66.google.com with SMTP id i5so30462825oto.9;
        Mon, 18 Feb 2019 12:38:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+iubiBzRbH/fHfgfShr9Oh6WrzhFtDL9VNH6fDaBPdg=;
        b=J6Nhm7taMKQgpPy1HcE9r1rlocqNWZoDU8jE/RR+ITHmOH709o8CT9YBKKyku6ZAnz
         m8nRfe3RxoHsGEDh+CP6qij22bFvSz2wL0b7YsGkG2Qi36J4M2BfKD+aL3ForgrUwFMX
         zS7hH8BRJQnHnzdktzx/B1zVlMJzJn/9p/m9CyeHsY0ViB/QAKt/Fs5nhiZn5BdWONjn
         WHPdA/od1tYzLGFEW6FujnG90U0limUnTwI83nXB5iz2sW24ahugVC3qZk1qVRaSETMX
         UQqOG0JU0v6b6ekMP7XOkaDTtAvBH17NviRsXRQGazogRpY0fQQBNUIR2ldGaLWzNqLu
         Us2A==
X-Gm-Message-State: AHQUAuZK76ir+8nxSGUkhqN898MD4teo3MMlGF/oyD0ULyI+OVcQ251K
        qs7Lik20fscNfdOqsp8J2A==
X-Google-Smtp-Source: AHgI3IacNmoAKEddLhbkOEtx94sthcrdDVgeDCUg1UD+dKeI/oKG0dMDH0Ja1x0bMwn+yplyAmF9ZA==
X-Received: by 2002:aca:6c04:: with SMTP id h4mr436056oic.10.1550522311952;
        Mon, 18 Feb 2019 12:38:31 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g3sm8145493otb.66.2019.02.18.12.38.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 12:38:31 -0800 (PST)
Date:   Mon, 18 Feb 2019 14:38:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Weijie Gao <weijie.gao@mediatek.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH v1 5/5] dt-bindings: pwm: update bindings for MT7629 SoC
Message-ID: <20190218203831.GA26838@bogus>
References: <de316385a84e079d3b23891e61c959094b9fa7e5.1547781007.git.ryder.lee@mediatek.com>
 <e7a59d288a4e23130e0303fec3aeba1f46ed1c26.1547781007.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7a59d288a4e23130e0303fec3aeba1f46ed1c26.1547781007.git.ryder.lee@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019 11:24:45 +0800, Ryder Lee wrote:
> This updates bindings for MT7629 pwm controller.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
> Changes since v1: add a Reviewed-by tag.
> ---
>  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
