Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA65ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB762145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB762145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbeJSAtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 20:49:53 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34089 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbeJSAtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 20:49:53 -0400
Received: by mail-ot1-f65.google.com with SMTP id v2so23297325otk.1;
        Thu, 18 Oct 2018 09:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KBCgC3emnbTyvDwVNYcd58uwTHqzO7iwqTFEVJZOOjY=;
        b=kIM33+iZIU0ueAzvxO1xZf8mEOr+lNPVZf88MIsLgMcSA9SnATMQ9d2F7pXRErlI2g
         nwz5xjHR+/v01TSlTDCn9Yc+arH+1IjblpPXSFz9QV+eYTFZRhgz7VkE91ws3VY5eIIB
         JsjF8WkycF9UsGjxQXzHj69/NAYtqAJFCgPWQsV6L4vmUK72QaFFvoKG13dls7wqiUmu
         puzIR/gEN8mrbCgH1lOeMwtx7C3l96Vh91iBvhsg2F9nBZ+Zjo2w3ooCnBotkDL4h7iz
         3VXXtOEuxulC8drJE9qJGgxhhU79H/Sw33z71O21GEOpFl8MjBotWgupgF6as1RvplpD
         m/uQ==
X-Gm-Message-State: ABuFfohV3nrkRipI1wLYDwtdY6uYcogBsbpeM2qN6f0hLp405mmvTdh1
        MwB3KkJSMP3AThAWHuudHkdTlCM=
X-Google-Smtp-Source: ACcGV63H2hAa0Twu86ZA6FhxA0oL2MGdZR814W3jrn64bjzXui+X5Onjihn5WAyN1Z3+IyzUvlta3A==
X-Received: by 2002:a9d:5910:: with SMTP id t16mr1600414oth.99.1539881284110;
        Thu, 18 Oct 2018 09:48:04 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o88-v6sm6767455oik.27.2018.10.18.09.48.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 09:48:03 -0700 (PDT)
Date:   Thu, 18 Oct 2018 11:48:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jianxin Pan <jianxin.pan@amlogic.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-mtd@lists.infradead.org, Liang Yang <liang.yang@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: nand: meson: add Amlogic NAND
 controller driver
Message-ID: <20181018164802.GA11264@bogus>
References: <1539839345-14021-1-git-send-email-jianxin.pan@amlogic.com>
 <1539839345-14021-2-git-send-email-jianxin.pan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539839345-14021-2-git-send-email-jianxin.pan@amlogic.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018 13:09:04 +0800, Jianxin Pan wrote:
> From: Liang Yang <liang.yang@amlogic.com>
> 
> Add Amlogic NAND controller dt-bindings for Meson SoC,
> Current this driver support GXBB/GXL/AXG platform.
> 
> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  .../devicetree/bindings/mtd/amlogic,meson-nand.txt | 60 ++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
