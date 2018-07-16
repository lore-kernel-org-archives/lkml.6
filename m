Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02511ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48CB2083E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A48CB2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbeGPQCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:02:19 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:44878 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbeGPQCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:02:19 -0400
Received: by mail-oi0-f67.google.com with SMTP id s198-v6so75588099oih.11;
        Mon, 16 Jul 2018 08:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KW8yF6pUBRxbGFLgf/jtic29TClShcaVlsMVImthBJc=;
        b=EbMhE/pX4utrh2ubusLGMmEPGAEAISVPHU8Vtamph1GcrNtqBmXejLrAXbPVDeAFc3
         CR4+7OWjY9slpOceW7d+nzIBieALLaBS5B5NIgLhcTm1ESsWIITNRGnno19nGjxsQRPJ
         QBiGdj84n/XZFaZE0dCJV9s/pAFnPPgOMbGObtJ5dBsmdsWI5FC5XgGbKrfJd0t416Ks
         pKcdAPRwC1qUa/9roq6a5SdSkmO/xgo8Mi+ZbEWEBK/Q+iRATs+8ux17ysa5LOYV/HMb
         ln4GtkvyynNZtj1ndHZNIaSggecxOikdo53uE8myIvJTkvsqaEoIwWIGherVpQxa8/6r
         7P0g==
X-Gm-Message-State: AOUpUlFdXwFk5eJ0528g3FIrXVotS+smw0C0XcxBCWnkOTdUq4fNyLP3
        z/I3LEZr2rufvKAWJWgy2A==
X-Google-Smtp-Source: AAOMgpedvqpiJyNL+Nw7i3mSf1Vc750QacJoApxhF7Ty/83d7n/2m/fggz9SRez6V2NhfKkJeJItgw==
X-Received: by 2002:aca:5f0a:: with SMTP id t10-v6mr17487905oib.337.1531755262018;
        Mon, 16 Jul 2018 08:34:22 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id q124-v6sm14916774oif.8.2018.07.16.08.34.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 08:34:21 -0700 (PDT)
Date:   Mon, 16 Jul 2018 09:34:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luis Araneda <luaraneda@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] dt-bindings: Move Paralella board to Xilinx
Message-ID: <20180716153420.GA15187@rob-hp-laptop>
References: <20180712041024.20583-1-luaraneda@gmail.com>
 <20180712041024.20583-6-luaraneda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712041024.20583-6-luaraneda@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 12:10:23AM -0400, Luis Araneda wrote:
> Move the Adapteva Parallela board to Xilinx dt-bindings,
> as it's based on a Zynq SoC from Xilinx
> 
> Signed-off-by: Luis Araneda <luaraneda@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/adapteva.txt | 7 -------
>  Documentation/devicetree/bindings/arm/xilinx.txt   | 3 +++
>  2 files changed, 3 insertions(+), 7 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/adapteva.txt

Reviewed-by: Rob Herring <robh@kernel.org>
