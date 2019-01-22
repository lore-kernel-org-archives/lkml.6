Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D126C37122
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171BE217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548119133;
	bh=stlh0ut7Orb+Y6dRCWCRNgKpmbveGsuFvrhUd616Hac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EezURD+EoiC+rPiHLIjKIhI2DFHqx+t3ictwyhl6AG9anNxWw4KAeRg4BaZcre9/Z
	 DHEsClK4ZeTKkAFjgA80NVn//7qy1E/uPfgB69ADd9K2MeXivtbb/Pj4oOMH8+TZJA
	 PI5aykndf4XXquyowRmGWVOX6JwG/9X0B6LS4H5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfAVBFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 20:05:31 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40269 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfAVBFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 20:05:31 -0500
Received: by mail-ot1-f67.google.com with SMTP id s5so22184352oth.7;
        Mon, 21 Jan 2019 17:05:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gxl0VBPO7E+5K/VBg1k064AKPgPuNyZ3QDJgA/cl13E=;
        b=nfq8ERzAWSYO4UpAG+J45eZwhtyzqrVdHm1Zugc77sq8eWgoaPhJlgN7DduSH/Y/FH
         /eE3qXKeVeXMZKrzpsuT0GFVWlyelKZ1dHQTrqG/ChVShzV7s5otFK0EOqDwUbHjI4EK
         6BXjQU2UlJM79T7suks2jSL5eoViWPhTEVLFkGwA2eapXT4zg7PMgqP58qgOyxroPDfM
         92PHPS5uWsXLiiBCStwIBAzsxK4JeCivdj9SxK++NMRfJWxyirS+e0g3asjfOpQyrRB+
         DTCXd2AR3eqfCLjZgPeK6VeR658jN7xhlke+Guq61vz/HEj1k1s6OcCIESKXWznCEVvx
         fcCQ==
X-Gm-Message-State: AJcUukeK8AQpBs+7uSMcE76CBHCT6cHzN3rqWXNPsZNE/7x/mpVH0z7A
        EwfaCkTjCtmmF3TMbU1AcQ==
X-Google-Smtp-Source: ALg8bN6RDyQxrnw2O99C8eF2VvDyPMoFMJ09B6GINUOIQ+dqC8pyHPH3HPonpWPmVtuwYfbTfKqTXw==
X-Received: by 2002:a9d:70d5:: with SMTP id w21mr8012993otj.301.1548119130119;
        Mon, 21 Jan 2019 17:05:30 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n185sm6967674oih.18.2019.01.21.17.05.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 17:05:29 -0800 (PST)
Date:   Mon, 21 Jan 2019 19:05:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
        linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH 1/8] dt-bindings: arm: atmel: add missing samx7 to reset
 controller
Message-ID: <20190122010528.GA20975@bogus>
References: <cover.1547629763.git.nicolas.ferre@microchip.com>
 <b073b46ab85e9c855640e674f12f2a0801876140.1547629763.git.nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b073b46ab85e9c855640e674f12f2a0801876140.1547629763.git.nicolas.ferre@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2019 10:57:37 +0100, Nicolas Ferre wrote:
> Add this missing compatibility string to the Reset Controller
> compatible string chip list.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
