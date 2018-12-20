Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73042C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E7921720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545325650;
	bh=m4U3zVVItje9ZXPjv60FHEUC3Y2UybKPf+mr0OcI8/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BCrFPKHrb8R6QliN5bQNU/cRy8YHZ6TNh22WDgG2gl/jrO9i8lgXEBX6EPA82A7Ne
	 tvME75n3e7SIdLy5hi6yQ0Qars8wF3Fb0OdRWUDZyGKzr1H6VcPYncSQ4H3hUMxWC/
	 pMyMWwvejw483/wPLLTkg4jLrQSKj9iyB2T05Qxw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387543AbeLTRH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:07:29 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38343 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729720AbeLTRH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:07:29 -0500
Received: by mail-ot1-f68.google.com with SMTP id e12so2575892otl.5;
        Thu, 20 Dec 2018 09:07:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xL0zgMszuckqIPQQ1s1mmtV6vFWdJXlKun3iStFYcJU=;
        b=c+pEcZd8a+1iWmdK+EWsmgzVxygPgQtGBvDtMbs3XK09Dl2Ahk9Dn3cYlEMtSeaAsL
         1CcCz0CJR4DTWTYIdwl/zoEs3+2XLIz6AduH9RiWShgpJZ5fOrp0ySpqBlK8moAxtJJn
         iB7JGRD6VGblfB6ciXbTC+KGvD5LtVRBdNc+ep9b4X/IZP5pdR/LwM50qP+wDSUgkhTE
         aPRog3OTXKr3QWZNWlh9JyYpaFd6diO9FsXvcSD3GpJ+BH+U1Ss9p2UgWLMByFikPR+E
         FPaqvqUVcuVuY9vcIoroTHLOEFdtEpccD3jvU3s/wCuj1iFyHri7Kdw4kggnGN4Gd1Np
         d9gQ==
X-Gm-Message-State: AA+aEWbTyUGS43X/TgAMCDVX0iwWzgT/ViJEeMDl2QUgIYuLEXqvKy2w
        J8BBrjsIyaFPQ9WRoDyiIg==
X-Google-Smtp-Source: AFSGD/VuF3XDmhTEwbv2nRu60OpM6CHrhgPOurM72S+TZI97GyDO4utSswk59MMdE8P+7hGAkTewyw==
X-Received: by 2002:a9d:2c46:: with SMTP id f64mr20046468otb.192.1545325648239;
        Thu, 20 Dec 2018 09:07:28 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m3sm10109726ote.64.2018.12.20.09.07.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 09:07:27 -0800 (PST)
Date:   Thu, 20 Dec 2018 11:07:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     gregkh@linuxfoundation.org, mark.rutland@arm.com, kishon@ti.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawn.guo@linaro.org,
        vkoul@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: Add Qualcomm USB Super-Speed PHY
 bindings
Message-ID: <20181220170727.GB19862@bogus>
References: <1544176558-7946-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1544176558-7946-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <20181220095245.GA7783@igloo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220095245.GA7783@igloo>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 10:52:45AM +0100, Jorge Ramirez-Ortiz wrote:
> On 07/12/18 10:55:57, Jorge Ramirez-Ortiz wrote:
> > Binding description for Qualcomm's Synopsys 1.0.0 super-speed PHY
> > controller embedded in QCS404.
> > 
> > Based on Sriharsha Allenki's <sallenki@codeaurora.org> original
> > definitions.
> > 
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> > Reviewed-by: Vinod Koul <vkoul@kernel.org>
> 
> any follow up on this patchset?

Check DT patchwork[1] if you want to know where you are in the queue. 
Just so happened to get to it now.

Rob

[1] https://patchwork.ozlabs.org/project/devicetree-bindings/list/
