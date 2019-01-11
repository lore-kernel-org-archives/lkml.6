Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA82C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E2B2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547242289;
	bh=wTwNNBLK9XKCazXMD/eW1bS2NsXJImOUTCWAhVot3tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rjQTrtUmLO96TCqitxIhhUQnTGELiIHbLTGznxSkpi/chyGqvobTtkMyBYw5a6aAb
	 dBZN/69P7uQOjGf0TFrOeQHWG7dUJ3dC4sysyClXAt3dggBTK5tbXTODmu/jpC6UxF
	 kkojH1e9uCHxJ3Yv6+IgLUs8JQ3DG/9CbP+2RCtA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfAKVb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 16:31:28 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38541 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfAKVb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 16:31:28 -0500
Received: by mail-ot1-f67.google.com with SMTP id e12so14421248otl.5;
        Fri, 11 Jan 2019 13:31:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gjKUWXoyBGsDaa8XCbDtSc0bf22b9KFq3QUlcdNswu8=;
        b=MODSclUDgiUqgeoszXJNXvXOLXcdEVfRQsmttn09oVFzelhT59ErewuLj+QxbhXEI6
         /CJTNiiObUdMhjgNm0kklPbMDtmLsphLetXtXR5Hul+LRIAkwL2tUJ3fLIf3wJ58nZkE
         uypkNQZv3G52J+Geo72fDBTXa22bndnTs1VKLQ1TF485CdtZm7gHPSKcvWqdMCp9TMsf
         wviY3J9ZA7tyRJSFBC4S1CaLgQi37L8y8qZL5R0tZJPo7b6golvJ79MeUSmMdGczj2fP
         1qFL+1fWDADNyZgYv+yqLB0PT2N2djKSpBoG0as8E16uWPNR5XcIEqJZEx0MijxMhrXi
         JLig==
X-Gm-Message-State: AJcUukd4eh/in3zS5MaY/nJKLguuaF8TxqvQ1WJ3vDeFuVn0PjW9JDR5
        OH4tr4gRYJLCEmjEHEsdMxw1xwzs6Q==
X-Google-Smtp-Source: ALg8bN6d4Z8GKELVgQhwT9GQ8zNFKKcGCQ9iEoA7pZXP9S6unRhX+0lis370YTiwc/1j8/RfkY2pKg==
X-Received: by 2002:a9d:3b21:: with SMTP id z30mr11596657otb.132.1547242287215;
        Fri, 11 Jan 2019 13:31:27 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g138sm77317127oib.26.2019.01.11.13.31.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 13:31:26 -0800 (PST)
Date:   Fri, 11 Jan 2019 15:31:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: ina3221: Add ti,single-shot
 property
Message-ID: <20190111213125.GA17790@bogus>
References: <20190105004904.17947-1-nicoleotsuka@gmail.com>
 <20190105004904.17947-2-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190105004904.17947-2-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Jan 2019 16:49:03 -0800, Nicolin Chen wrote:
> By default, ina3221, as a hardware monitor, continuously measures
> the inputs and generates corresponding data. However, for battery
> powered devices, this mode might be power consuming.
> 
> This patch adds a "ti,single-shot" property to allow changing the
> default continuous mode to single-shot operating mode.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  Documentation/devicetree/bindings/hwmon/ina3221.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
