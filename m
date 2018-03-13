Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-126535-1520983328-2-15265734610705401387
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520983327; b=UrUlfhCIkxSNvi1BWe1njlfs3vPDgQOMkBE5B7CdtXWt9O1
    UGbUYXWhN3l3qu75SAraAbiph5jetjagQTVKmtvtIzOpuvkXlUPdNLKo328lV88J
    ienNX/JyvoD5vUpjKZzpsDccfubhlAgiZwsotmK6OTlcEZf3pR+dfAgpjjVfQrpL
    w06bHgfsMCAD3K/54+6ro/q7GzeTElfNqXiLB2+yjjD79k33/IcUut4C1p79V+zP
    P7MMhhfnOF7otGkjHVmHTPX+ZcphkjLBKOPc6Aji6Htot3DwV/fYzGF18X4YRPb3
    Fzf/hqViQbnV/IqDeyczCHKvzHSNr5zOoo9B+Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520983327; bh=B95KEDVl8ivdt4FYJGHQsoYRu/7v8rF65xZIpAlDj1g=; b=m
    ByNCxdBE39dGAIEjoxyLiMm+liWEwux5q5qZNWE8gFhXyLrOQxjHBZRN8aZJhfGK
    LtyZNA8o/RuHOiY6z9XILVqFDRNirZw0AeAFGVWuITitTOJoaI/H3OatS8kKRQK/
    rnhjv2MQlO1NDzxY6GegUbDQFDl2dnZSoxIlB9AZMXKflzwC+BleCNDmJ8ROb+oV
    Yw1mrAZ4So++RVfoIML6L+KhzpgaoMqoFFKeBWbjycVRt3/emT6U0aN9HPG8KKOL
    u5cuBNo2ymbElrIJGdh9+pt0XKxSY3ZXpZhL7VQmymNukct3vn74Q14LmL868hLt
    cK9kSc7AONG8c5EbR0X7A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=O9TKnAon x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=LY9pFNGK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=O9TKnAon x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=LY9pFNGK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752979AbeCMXVV (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 19:21:21 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46172 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752757AbeCMXVT (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 13 Mar 2018 19:21:19 -0400
X-Google-Smtp-Source: AG47ELvVjYPExUo0NCAmZ6XVrB2DaR9ayO6+bsDB7pXZE5m5uEWXUyYGYEM2tncYUmp5KeROpQnjSQ==
Subject: Re: [PATCH v2 3/3] dt-bindings: phy-mtk-tphy: add properties for U2
 slew rate calibrate
To: Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org
References: <c9679bc6e969ebf0f97a01c6d1aff3bbc0e8e4f7.1520832210.git.chunfeng.yun@mediatek.com>
 <94a7d3b1240297cd0cac82df52954d0a53d50d36.1520832210.git.chunfeng.yun@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <6810b7b4-3023-2e76-5fbf-7e442067cbc4@gmail.com>
Date: Wed, 14 Mar 2018 00:21:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <94a7d3b1240297cd0cac82df52954d0a53d50d36.1520832210.git.chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/12/2018 06:25 AM, Chunfeng Yun wrote:
> Add two properties of ref_clk and coefficient used by U2 slew rate
> calibrate which may vary on different SoCs
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

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
>  
>  Required properties (port (child) node):
>  - reg		: address and length of the register set for the port.
> 
