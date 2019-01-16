Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A732C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED5F20652
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547673006;
	bh=/7KrTE4lay0d/cTprD4AApoBmv8M4NWo1aAbU7D7k7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ukS+oL1UqNxqEQvJIjfdoRq93/RGB3G/XF6u9FGU+Y35U5ddKG6uLD1NE1LIll5+w
	 W1Mj8ynKRWZ0oier0VZbvhkhWSNrEBhghhE50f/+Ei2C6sgbIs1nkJIDUcGS6u7zle
	 RDMIfvXzcxozxd1O9LskqAGJvl0Fj0y2DhBR0IBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfAPVKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:10:05 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46213 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727557AbfAPVKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:10:04 -0500
Received: by mail-ot1-f66.google.com with SMTP id w25so9063067otm.13;
        Wed, 16 Jan 2019 13:10:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QOpLlDE3MXdAfWS+hVJqkwoSmmq5lOB31j7Y8tLfD1Q=;
        b=C51N+/PcdXyMKx/JJwBqjT3fFF4ujo1V6SCKXUO0r4ICtIn0o7rvv3N1vuNRVAhWgx
         pKn4YANEGHG1f1w8dFhjarwvhz1MgjD2+Y0VmFncWfYETfaredEE+CxEu3g87mPYX/5X
         3Pnel0OI6cDn5n4I/yLuUtGKcya6nZ8g3me4V4t8ag+oMZ5eiARxKMEXO0l8i7HmYfKn
         fRGC8IP4H0DHBFwfuGoAh56P8lM9Yk3I2ikSNEI9Xh+5mLmAnAV99vLHSgiIRky3V7hn
         UrncGbZlhZesbJsceQ3GN6kNhR+RccHwE+bmBm28WGIV3SjZ/rXtaziIhd1ZkULGlPkE
         9PFA==
X-Gm-Message-State: AJcUukekaegmhaZIT28d21jsouDiva1+KhUrOTA0+WQo70DFMRwastdt
        uqMwVodvLLpSkGeZXN0uxQ==
X-Google-Smtp-Source: ALg8bN4NrCqGUKO4jltX9Z3v4IYS1KC8tDJ9z0x2IOQBLFxDXKDBucgIbz1wjVr7IqhEm4kuewH0Lg==
X-Received: by 2002:a9d:f44:: with SMTP id 62mr7082950ott.182.1547673004001;
        Wed, 16 Jan 2019 13:10:04 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m133sm3308321oib.52.2019.01.16.13.10.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 13:10:03 -0800 (PST)
Date:   Wed, 16 Jan 2019 15:10:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, a.tropschug@ebs-systart.com,
        m.bittner@ebs-systart.com, amit.kucheria@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add EBS-SYSTART
 GmbH Vendor Prefix
Message-ID: <20190116211002.GA25860@bogus>
References: <20190114102053.16013-1-manivannan.sadhasivam@linaro.org>
 <20190114102053.16013-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114102053.16013-2-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2019 15:50:51 +0530, Manivannan Sadhasivam wrote:
> Add vendor prefix for EBS-SYSTART GmbH.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
