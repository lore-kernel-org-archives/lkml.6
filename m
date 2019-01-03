Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E212C43444
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF01D21479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546547574;
	bh=auFI8m+Y2LxvyPxkTM1r49ZQymS+/d9voUFYCedqaVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=02+TntqmcUzSxUPdy+w1Glc1ACXzkavhchQ1rc2HkgRG52AEgNg1eLRwt9DdB96S3
	 z1/f8lamqyMKWO39b2VRQDKHucvwPOfw6+4HE3ZPJhLTS1OESqCDrZu1aJp2Mu7Yr9
	 tlLQNDQqFefEh1Kplnmaewtpf4kDyIsm7475z070=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfACUcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 15:32:54 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:38481 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfACUcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 15:32:53 -0500
Received: by mail-it1-f194.google.com with SMTP id h65so44276254ith.3;
        Thu, 03 Jan 2019 12:32:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wyWKg6QQzd0++yCE9tpTni4D+CKDpBnDQ5Ci3BNJi0Y=;
        b=kIo3cK/nMDW91ZOPbaidfgwLBWjnyatRThv6kxp4X7o2xJzShd7Yyt0P7Kv5pJcAG2
         Vecyx79vpCXr2BRoWr7jyc0hLVY8Wuh1BGXnG7QJ2oMQoGxK9lxo3AkfseDfoKBnlpty
         vDhM5GgFNpmDfhM2f6T94OYdcv/SPX3ieYFGXe805T2S4KbRWmaZO56uwzlK05eNqlEs
         /iTo4RxofmqibfGw4NKN/EqJb2XMArf8t8KCt5wxKsFJdFpidMJNtHck1nAOfak8isfb
         Sk80EroYW17cQjEFvAsvRm6vTQoSF4Pgb2mpYXakCEcqrQxWbYMLLeeT/LOn/MFMqRhF
         AY3Q==
X-Gm-Message-State: AA+aEWaIaWPLp76kKd0uvFTlvBbp0uGk5c3/Et5MI0OO1nJF4PjwpkhD
        xxFv/0V/HlBGY0dU4mi7Mg==
X-Google-Smtp-Source: AFSGD/UzXtwBazWW5K2Xjqcep1RMKY7loZ0PhnQZmAs35pHtrip8bYTcwIK/qMOb75FEUdWltO46Ug==
X-Received: by 2002:a02:8785:: with SMTP id t5mr33960534jai.73.1546547572332;
        Thu, 03 Jan 2019 12:32:52 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id d199sm26395152itd.31.2019.01.03.12.32.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 12:32:51 -0800 (PST)
Date:   Thu, 3 Jan 2019 14:32:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     Leo Li <leoyang.li@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Roy Pledge <roy.pledge@nxp.com>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] Documentation: DT: Add entry for DPAA2 console
Message-ID: <20190103203250.GA18731@bogus>
References: <1545406240-3061-1-git-send-email-ioana.ciornei@nxp.com>
 <1545406240-3061-3-git-send-email-ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545406240-3061-3-git-send-email-ioana.ciornei@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 03:31:11PM +0000, Ioana Ciornei wrote:
> This patch adds a devicetree binding documentation for
> FSL's DPAA2 console.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
>  Documentation/devicetree/bindings/misc/dpaa2-console.txt | 11 +++++++++++
>  MAINTAINERS                                              |  1 +
>  2 files changed, 12 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/dpaa2-console.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/dpaa2-console.txt b/Documentation/devicetree/bindings/misc/dpaa2-console.txt
> new file mode 100644
> index 0000000..f4e16b1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/dpaa2-console.txt
> @@ -0,0 +1,11 @@
> +DPAA2 console support
> +
> +Required properties:
> +
> +    - compatible
> +        Value type: <string>
> +        Definition: Must be "dpaa2-console".
> +    - reg
> +        Value type: <prop-encoded-array>
> +        Definition: A standard property.  Specifies the region where the MCFBA
> +                    (MC firmware base address) register can be found.

What's the relationship between MCFBA and the console? The binding 
should describe the h/w block or firmware interface not the feature you 
want to implement. Are there other functions provided by the MC 
firmware?

Rob
