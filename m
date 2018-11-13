Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850FFC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 541E72245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 541E72245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbeKMMFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 07:05:53 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46242 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbeKMMFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 07:05:52 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so4903479pgp.13;
        Mon, 12 Nov 2018 18:09:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hcxcKf8u2ED2HanzmrIBYTF6D782+dAj9cWNYAb+79s=;
        b=PCpQRQq+hViI0iJhzzggSJqMtH1kC82CbyWdx8mXDDIesrBJ2O5xSSbvXFnsVyhniw
         fuSd9GFFs3YIGqVmjUiamVJYzxqMRi2x9fKZ5/cHvxWkBSd7ut2FMGNTYaziY68mLM31
         34bS/0j3uQHb6qY8opXDv/H0L+HasNAZiWaRON082VhvjWUbUXpETKDlJwAiCA4hq9fW
         6C1meH5ybJ1bjsryk6pxLr8VRotSFExcP8xQ/cE1mQHvgHJ78nWs3dTWErrzLajmPJOy
         WepU1SYu6PbVtfNoTexUEhNzmmupvq/IcuplG2R40j7xjTNQcQvjXsk//CIL/oLWd9IL
         pIuQ==
X-Gm-Message-State: AGRZ1gI77FZNTph8VGpGfouTdZMnoegNYxhh4txWJnJjd5LjYRKun6M8
        0pIE1ZCbokck57Que7cctPGBacvx5sN1
X-Google-Smtp-Source: AJdET5f4TUjrVfDTwSPx8uN8XLH6AfYdazsQs4OHdvEW5huhk9H8U4xmMv2SI0S2Ai5gpV//1BG6Sg==
X-Received: by 2002:a63:ee0e:: with SMTP id e14mr2965301pgi.8.1542074998859;
        Mon, 12 Nov 2018 18:09:58 -0800 (PST)
Received: from localhost ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id l3sm17613689pga.92.2018.11.12.18.09.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 18:09:58 -0800 (PST)
Date:   Mon, 12 Nov 2018 20:09:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vitor soares <vitor.soares@synopsys.com>
Cc:     boris.brezillon@bootlin.com, wsa@the-dreams.de,
        linux-i2c@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, gregkh@linuxfoundation.org,
        arnd@arndb.de, psroka@cadence.com, agolec@cadence.com,
        adouglas@cadence.com, bfolta@cadence.com, dkos@cadence.com,
        alicja@cadence.com, cwronka@cadence.com, sureshp@cadence.com,
        rafalc@cadence.com, thomas.petazzoni@bootlin.com, nm@ti.com,
        pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, linus.walleij@linaro.org,
        Xiang.Lin@synaptics.com, linux-gpio@vger.kernel.org,
        nsekhar@ti.com, pgaj@cadence.com, peda@axentia.se,
        mshettel@codeaurora.org, swboyd@chromium.org,
        joao.pinto@synopsys.com
Subject: Re: [PATCH v3 2/3] dt-bindings: i3c: Document Synopsys DesignWare
 I3C master bindings
Message-ID: <20181113020957.GA31668@bogus>
References: <1541697251-20392-1-git-send-email-soares@synopsys.com>
 <1541697251-20392-3-git-send-email-soares@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541697251-20392-3-git-send-email-soares@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 05:14:10PM +0000, Vitor soares wrote:
> Document Synopsys DesignWare I3C master module
> 
> Signed-off-by: Vitor soares <soares@synopsys.com>

Please make your author and S-o-b emails match.

> ---
> Changes in v3:
> - Remove dummy characters
> 
> Changes in v2:
> - Address the changes in Documentation/devicetree/bindings/i3c/i3c.txt
> - Add controller version on compatible string
> 
>  .../devicetree/bindings/i3c/snps,dw-i3c-master.txt | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
