Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8C3F8C07D5F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC9C208B0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC9C208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934183AbeFKSQu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 14:16:50 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:42896 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933452AbeFKSQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 14:16:48 -0400
Received: by mail-yw0-f195.google.com with SMTP id q7-v6so6620928ywd.9;
        Mon, 11 Jun 2018 11:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iEV5UPO6kCcstLk6E4Ssxa6zMBliSE1fNJWNsKzC7uE=;
        b=d0fdFARsL/RNvtAMs0XGSIod8nR/WnDevYw52+d91UwT7BGjwZHpm7Qu8ndHvXM6CY
         q/7JnFzJ9v+NE7WWJC7Vh9v33iqMF22qd4XAwJ0lrAPzZpbtCRHt5IgLxMaaw8GSS1AL
         LhZdTqi9qyZxbt7rH4jNBrOBEYc+8/VCQ4ze3Fgq8TILTfEGP2dsQ7lxidAmxr+NKdHA
         XD3ykZRDBYyOtSFaoykiMrwjjkNPHVTiRF2uN3GwMZiUuxQ2z0cQiW9+b6E5fVIhgGOB
         UeUMsobXY05AK+FP+yhA/shCpk/Jeyp88aKtttB/zSE8HTYUETBGo5esUdWKeX2Dbw9F
         66KQ==
X-Gm-Message-State: APt69E1t1YTPb1+IaefYeYnE/3g+OEEnqERLDDzeEu9riANrG9OvSM0l
        wsuk1jlGJHa8+VO3IE70pw==
X-Google-Smtp-Source: ADUXVKKKzd8evpJupPo1G5UkUcl++GNUe5eXeHL+0q4flkwLqV5+ggdYRN/EqhvO1BJXHNq6eWP55Q==
X-Received: by 2002:a81:710b:: with SMTP id m11-v6mr161815ywc.404.1528741008206;
        Mon, 11 Jun 2018 11:16:48 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id h1-v6sm26882983ywj.86.2018.06.11.11.16.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 11:16:47 -0700 (PDT)
Date:   Mon, 11 Jun 2018 12:16:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     avifishman70@gmail.com
Cc:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        tmaimon77@gmail.com, venture@google.com, yuenn@google.com,
        brendanhiggins@google.com, mathias.nyman@linux.intel.com,
        bjorn.andersson@linaro.org, jhogan@kernel.org, albeu@free.fr,
        chunfeng.yun@mediatek.com, tony@atomide.com,
        baolu.lu@linux.intel.com, elder@linaro.org, digetx@gmail.com,
        kstewart@linuxfoundation.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        openbmc@lists.ozlabs.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-bindings: usb: new ehci-npcm7xx dt
Message-ID: <20180611181646.GA5537@rob-hp-laptop>
References: <20180607145821.322979-1-avifishman70@gmail.com>
 <20180607145821.322979-3-avifishman70@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607145821.322979-3-avifishman70@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 05:58:20PM +0300, avifishman70@gmail.com wrote:
> From: Avi Fishman <AviFishman70@gmail.com>
> 
> Device Tree documentation for Nuvoton npcm7xx EHCI.
> 
> Signed-off-by: Avi Fishman <AviFishman70@gmail.com>
> ---
>  Documentation/devicetree/bindings/usb/npcm7xx-usb.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/npcm7xx-usb.txt

Please add acks/reviewed-bys when posting new versions.

Rob
