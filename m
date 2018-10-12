Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C850C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28E721470
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D28E721470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbeJMDHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:07:37 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44112 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbeJMDHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 23:07:36 -0400
Received: by mail-oi1-f194.google.com with SMTP id u74-v6so10702675oia.11;
        Fri, 12 Oct 2018 12:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VVRSg4Ew/RFd1d2ecK/O02QkN62mEw9Ki2l+wroNxns=;
        b=hLHmgGUusBvPo076jjFC2X2j4MCUoPwUhZz7RFXSyNfz6gw3MAsNzzNInmuoqtE+Ro
         ajqmlVrhltQ8p/yqaTCV4xHgLMciY9DWjST/VQLSsLRpGVwVq9HKeBaG0LeSJoUXAjWB
         Yw0wwtZuY5F5EWFnLGDBT+Y0iDKk2upGaNL0aEw8pgNejoeZMFvr/uX6LdwsR4u29znh
         CvlYBv+HOP+02JHI90JgLy9CjG7V1+OBZcmKrPG8cVOg9HeqDlhXOX9TrKNYjAbrMHUS
         VCGeSfaHlV0orUAd0MqNAMs0iqR1ORytMDdgNufdfQ+wNU0B4tOe6dwS7MXAQi/jxSep
         wW9g==
X-Gm-Message-State: ABuFfojsac0w9byQv2MMbzitWMci67jyzqsFbxGAtiPSlCgDNiQlQ9kO
        c25v8e8S5ozwHu3XSkVAGQ==
X-Google-Smtp-Source: ACcGV61JcWwJ+rT7rj1GeLaXyf200ywzbm1368fQb1EgxULzk5IWA/l9PkNKg99ONPFws2b+E0diQw==
X-Received: by 2002:aca:f154:: with SMTP id p81-v6mr4106288oih.240.1539372815801;
        Fri, 12 Oct 2018 12:33:35 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h70-v6sm725525oic.17.2018.10.12.12.33.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 12:33:35 -0700 (PDT)
Date:   Fri, 12 Oct 2018 14:33:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Vignesh R <vigneshr@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Nishanth Menon <nm@ti.com>, Peter Rosin <peda@axentia.se>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: i2c-omap: Add new compatible for
 AM654 SoCs
Message-ID: <20181012193334.GA29966@bogus>
References: <20180928052557.21663-1-vigneshr@ti.com>
 <20180928052557.21663-2-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928052557.21663-2-vigneshr@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2018 10:55:56 +0530, Vignesh R wrote:
> AM654 SoCs have same I2C IP as OMAP SoCs. Add new compatible to
> handle AM654 SoCs. While at that reformat the existing compatible list
> for older SoCs to list one valid compatible per line.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
> 
> v2: Reformat compatible existing compatible list.
> 
>  Documentation/devicetree/bindings/i2c/i2c-omap.txt | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
