Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDD6C37124
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0FD92089F
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548116502;
	bh=BBQmE6ptCFV6qhqwfemURHS0Gr5YH4L4mFCOGbB2xiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XUcDnNja300fpkMO0W8fz/EdiqBs3Qako2NmlFMspWMASZ9f7l1JTEQ22vf3bo1bI
	 X77vyWeTLXBTqu7squau+BtZr32Xm6ttxuIHbOlP1+LCUeV7NcXUL5FhVsgogxxyL/
	 U7UlC6UNdbNInRS78vX2Qp0GWM70iIRPmfDW4qiQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfAVAVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 19:21:40 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40731 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfAVAVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 19:21:39 -0500
Received: by mail-ot1-f66.google.com with SMTP id s5so22111400oth.7;
        Mon, 21 Jan 2019 16:21:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aakOYreQ3zAZo2JIDOgR6vCM30IHY8efMLL5SarD+sU=;
        b=dJwmlPCkzcpeKFKNXhi1Q3m2T3EOoWiIKPXpng4bcXjARDUOj926C1AqDs+a0VBg3L
         8I/2zTKjLGBdPVBRrb69V/ItO+yXhE3rxLJhTwPVULYNTYidXjVBBjBkWSJJrLdlghdg
         bsFb3s+VSpfqSWgygkF2++bEgGNNVXS/Tpw5QptuyLPXwiMhszmhWom2uJZzo1HXB2z0
         nhYmWdxDu2QVpofaYkGumjSvDTXnDRakGeqTxaVVpDOBpIH0zOCGboqvZpOYXdAcGOOu
         Gt26IGznXi52gE61OlGX/+BUZyLXT3gzT7aU6/evrQBTKdn76z1aPvFA/X1BYgGml2wx
         VVnw==
X-Gm-Message-State: AJcUukd4Zq+CkQY8ixtnC5BWC1ePGSxZkXXZ+OsxzD4Gz0tMtnGNen1D
        DBlJe4o1RAfPfzGD/O7c5A==
X-Google-Smtp-Source: ALg8bN438gXxCIBY1ST4YuhxY4I7q1mcz1XsnycXsyamRB00M7PSrVMoYh3tk82FEW5y7qj/MZ/R6w==
X-Received: by 2002:a9d:7ac6:: with SMTP id m6mr21138183otn.62.1548116499047;
        Mon, 21 Jan 2019 16:21:39 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s17sm6451270otp.36.2019.01.21.16.21.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 16:21:38 -0800 (PST)
Date:   Mon, 21 Jan 2019 18:21:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/8] dt-bindings: phy-qcom-qmp: Add UFS PHY reset
Message-ID: <20190122002137.GA14435@bogus>
References: <20190111230129.127037-1-evgreen@chromium.org>
 <20190111230129.127037-2-evgreen@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111230129.127037-2-evgreen@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2019 15:01:22 -0800, Evan Green wrote:
> Add a required reset to the SDM845 UFS phy to express the PHY reset
> bit inside the UFS controller register space. Before this change, this
> reset was not expressed in the DT, and the driver utilized two different
> callbacks (phy_init and phy_poweron) to implement a two-phase
> initialization procedure that involved deasserting this reset between
> init and poweron. This abused the two callbacks and diluted their
> purpose.
> 
> That scheme does not work as regulators cannot be turned off in
> phy_poweroff because they were turned on in init, rather than poweron.
> The net result is that regulators are left on in suspend that shouldn't
> be.
> 
> This new scheme gives the UFS reset to the PHY, so that it can fully
> initialize itself in a single callback. We can then turn regulators on
> during poweron and off during poweroff.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
> I realize I'm not supposed to add a required property after the fact,
> but given that the UFS DT nodes that would use this binding are not
> yet upstream (and this would be the first), I was hoping to squeak by.
> 
>  Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
