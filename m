Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7399BC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B77125EF8
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B77125EF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934686AbeFYRRj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:17:39 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:34676 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933920AbeFYRRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:17:37 -0400
Received: by mail-yb0-f196.google.com with SMTP id e9-v6so1399913ybq.1;
        Mon, 25 Jun 2018 10:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nj5nBhMmmoqDuD2jiumQBrscEjyk2fDr/66k/DlvIuY=;
        b=d90KGiKMva02PWxS544UUdm57+2HKBfnnPgbkolKI9HPWK2SJZMhWgsUw6vUBdTKI9
         infggOej1ktabnZV0TepRbQ2CYQJf/YJZGwqDaPnaCjy1+A6h0+lumYgWoapZ6bRn3CC
         QJRVQLWMfa2iZcwlON4+6ZEAngHP1DIWST6sOnTUHoc2rLhJPD6wUigjPD1QAaltyaje
         7fEEf/ph8JAjwG7BFkM6gfJ2Uh+cSlzxI/eqVcj9yn3vu1e3ERdFWujqHhjldUUpSCCN
         Nln4JImepk8teK9Q9A6ywi8vi7M/4zHwhLAaYUSFDWePyVofnj1iwZIUUCGxtHY9l3Xd
         S1/A==
X-Gm-Message-State: APt69E1rXkdkfkVM/FGuhWxNm1FqxdrB0hTXoSvlIYTphsRiNgjg/Gno
        qhahUFL2sZOrDrJV00djiw==
X-Google-Smtp-Source: ADUXVKKmwrfW0eHU7Ul4VjiD3mtku8uY/crnP0ARpYugQ1L5xjp7i38YnQY1YqPr+Pfy/1mdFWVf2A==
X-Received: by 2002:a25:b097:: with SMTP id f23-v6mr6608244ybj.167.1529947056577;
        Mon, 25 Jun 2018 10:17:36 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id 83-v6sm5940045ywm.108.2018.06.25.10.17.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 10:17:35 -0700 (PDT)
Date:   Mon, 25 Jun 2018 11:17:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dong Aisheng <aisheng.dong@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, dongas86@gmail.com,
        kernel@pengutronix.de, shawnguo@kernel.org, fabio.estevam@nxp.com,
        linux-imx@nxp.com, Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/5] dt-bindings: mailbox: allow mbox-cells to be
 equal to 0
Message-ID: <20180625171734.GA20153@rob-hp-laptop>
References: <1529676720-7533-1-git-send-email-aisheng.dong@nxp.com>
 <1529676720-7533-2-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529676720-7533-2-git-send-email-aisheng.dong@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 10:11:56PM +0800, Dong Aisheng wrote:
> Mailbox devices may have only one channel which means the mbox-cells
> at least 1 does not make sense for this type devices. Let's remove
> that limitation to allow the mbox-cells to be equal to 0.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> ChangeLog:
>  * New patch introduced in v3 series
>  * Actually there're already users in kernel with mbox-cells set to 0.
>    See:
>    arch/arm/boot/dts/bcm283x.dtsi:145: #mbox-cells = <0>;
> ---
>  Documentation/devicetree/bindings/mailbox/mailbox.txt | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
