Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCD2ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE212150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE212150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbeJQXfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:35:31 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34748 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbeJQXfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:35:30 -0400
Received: by mail-oi1-f194.google.com with SMTP id v69-v6so21459924oif.1;
        Wed, 17 Oct 2018 08:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R/r+9E9x/YXHTQIJUwnTfmoqBSk2wtx3XUUKDM+pdcM=;
        b=uXxM2mp16/xh2KvPzvpJcuk4zBI1SP5sG5ks38//1M4HoLe74Y8GJtALRaGffHVVQu
         41U+B4p50+ynpfU28IJaZDsrCQDzzxNFpwOhlfVTxTUydijacn4hklipd5A+uSMOWVYJ
         IRbY69IP3ZWRMuWgQCz84Ayry7qQTtnMucSZZUH/eryqKa/B2nZCvAj8jRbKsuw/7BcT
         HUhrhDSxEHTbqNhaiWYX6B7SLwECxQqV/LD2nE2lApub5ouqv9veDp4QBMfyXH1bN4Qu
         lo9kEcZCigxNQ9+9KFWBkECY6o7z9wLkYQPQU1BlkQkm0t+yrmQvWuiii2IrY9URJS41
         LUCg==
X-Gm-Message-State: ABuFfoiPBqgtyDKeUKjFC4amAhlOeBO0dwBTVg8DXcxSeqCjkI+xfJkS
        6CxuiXjhR+XbPKHTNlrisAc4oeY=
X-Google-Smtp-Source: ACcGV62iE3FP6hXujCm7AOxiscV0bQYehkOmdKSAl2m+s9mkT0mZsGpSPXEzFeCwwAWDV8Z1vkpybA==
X-Received: by 2002:aca:c444:: with SMTP id u65-v6mr14797510oif.8.1539790754870;
        Wed, 17 Oct 2018 08:39:14 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j79-v6sm5693540oiy.13.2018.10.17.08.39.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 08:39:14 -0700 (PDT)
Date:   Wed, 17 Oct 2018 10:39:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 02/11] dt-bindings: phy: add cpsw port interface mode
 selection phy bindings
Message-ID: <20181017153913.GA13333@bogus>
References: <20181008234949.15416-1-grygorii.strashko@ti.com>
 <20181008234949.15416-3-grygorii.strashko@ti.com>
 <20181009144000.GL5662@atomide.com>
 <3fa09831-0f70-dfcc-3fd9-f877215a4631@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fa09831-0f70-dfcc-3fd9-f877215a4631@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 03:10:34PM -0500, Grygorii Strashko wrote:
> 
> 
> On 10/09/2018 09:40 AM, Tony Lindgren wrote:
> > * Grygorii Strashko <grygorii.strashko@ti.com> [181008 23:54]:
> >> +Examples:
> >> +	phy_gmii_sel: phy-gmii-sel {
> >> +		compatible = "ti,am3352-phy-gmii-sel";
> >> +		syscon-scm = <&scm_conf>;
> >> +		#phy-cells = <2>;
> >> +	};
> > 
> > Now that this driver can live in it's proper place in the
> 
> right
> 
> > dts, you may want to consider just using standard reg
> > property for it instead of the syscon-scm. And also get
> > rid of the syscon reads and writes.
> 
> Could you help clarify how to get syscon in this case?
> syscon_node_to_regmap(dev->parent->of_node)?
> 
> Also, there are could be more then one gmii_sel registers in SCM in the future,
> so I hidden offsets in of_match data. 
> As result, "reg" not needed at all now.

If there's a defined register range which doesn't overlap with other 
things (other than the parent), then use reg whether you currently need 
it or not.

Rob
