Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3931483-1521377343-2-8725855723446903521
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521377342; b=kTLdpAPDPv958LRXcJq3QfpE/62bfdnc/fTWw4laMK0huTV
    mxQnnHx1cbZupU+MkwxRzude7J0mouTnFG4rDO4G3mTlFoW6dWqaW7mYmr9gL7j0
    XomeUS3ZIp/iCnXyTVKvKhs3rY/b4sLD+Y5kFWHLauqu9ZJ5mFfgwoAmVZj8vO03
    LN1aGo/MgE8A9LGuyIjD5b1EjfXxX5Lm38+pcXCYgd0cED2XvimWZxZ/4+klvBjy
    g9mJU2U2ww56INrKzxBnNE63xpjYhqF7UtkZ6fwo6p+bWJmLQFqLS+or3tEWp/sq
    Y4pTm1uzVSLxhSdSRU5T2acsC8/f815QCqfQaHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521377342; bh=RQxiPlXs+bZLU0PfvUHxDuBnEO
    KBodCR71Jvf7oY5p4=; b=ioeOidtJdjK9vphowU8PvqpRQPQ4UaFmgHzKd0ZE6g
    J6r035+1+w2Sw+1kt2T3O3m1RgI6BBEGgzMfCKsEG6k5fyO7AaG/ByynkzRoTtyH
    iCCqDWr/2GPZxq5h06MBmgPojXRvS5XjueaH+sXf+7/jBNTEaECwpmJYFt7ST7rb
    EzMdzbim7CTf8SZCm29hBAIKnUBL0ZUEecaE9ZWFJEWoQ9pcq6d9cJtrr2eXGl7O
    1+I4r7UXspFatqx3u3iAxpEn4bl1ndP/E4PJankPrG3+FI9RZt1We12cNIWT4xGU
    wP3aL6Qf29W4KEekQR5y6A5c9Pwxzur1Eyf5T3ppqzKg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qsPpkwXW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qsPpkwXW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754134AbeCRMsq (ORCPT <rfc822;greg@kroah.com>);
        Sun, 18 Mar 2018 08:48:46 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40500 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754126AbeCRMsl (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sun, 18 Mar 2018 08:48:41 -0400
X-Google-Smtp-Source: AG47ELvkZYFSM7KqU9HW7TVAUilPuJjRC/gLQRsXd2Tn1aIqwPb+RkXC3FKiXvc/WZalYwgns0M5KQ==
Date: Sun, 18 Mar 2018 07:48:38 -0500
From: Rob Herring <robh@kernel.org>
To: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: phy-mtk-tphy: add properties for U2
 slew rate calibrate
Message-ID: <20180318124838.ruakamqywz4jd6jz@rob-hp-laptop>
References: <c9679bc6e969ebf0f97a01c6d1aff3bbc0e8e4f7.1520832210.git.chunfeng.yun@mediatek.com>
 <94a7d3b1240297cd0cac82df52954d0a53d50d36.1520832210.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94a7d3b1240297cd0cac82df52954d0a53d50d36.1520832210.git.chunfeng.yun@mediatek.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 01:25:40PM +0800, Chunfeng Yun wrote:
> Add two properties of ref_clk and coefficient used by U2 slew rate
> calibrate which may vary on different SoCs
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt b/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
> index 41e09ed..0d34b2b 100644
> --- a/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
> +++ b/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
> @@ -27,6 +27,10 @@ Optional properties (controller (parent) node):
>   - reg		: offset and length of register shared by multiple ports,
>  		  exclude port's private register. It is needed on mt2701
>  		  and mt8173, but not on mt2712.
> + - mediatek,src-ref-clk-mhz	: frequency of reference clock for slew rate
> +		  calibrate
> + - mediatek,src-coef	: coefficient for slew rate calibrate, depends on
> +		  SoC process

What are valid values? This is one cell?

>  
>  Required properties (port (child) node):
>  - reg		: address and length of the register set for the port.
> -- 
> 1.9.1
> 
