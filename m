Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE9BC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED9F26D2C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Beg0cEYQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED9F26D2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbeFZP1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:27:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751054AbeFZP1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:27:52 -0400
Received: from localhost (unknown [122.178.245.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D0C926D2A;
        Tue, 26 Jun 2018 15:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530026872;
        bh=lfGgPXng7U8cv0fG7mBqUpCu7wumR8EUlXxgAIiiyw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Beg0cEYQgf3ZGJgJnEa007g2OT//qTrPIZTUZ1//Ihu0ELLi4JTyLPBx97aIDsrxJ
         JVled+qgZL5v/xfefryJlSMINCPcB1hYKeTyc8MuqNllOuCTOSBeS+G3AqY6ZQ5W/c
         d+nG+C4nMhSGfVlZkpLKsxHLElnjr3iXfQNbm754=
Date:   Tue, 26 Jun 2018 20:57:43 +0530
From:   Vinod <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: rng: Add new compatible qcom,prng-v2
Message-ID: <20180626152743.GD22377@vkoul-mobl>
References: <20180619095430.26358-1-vkoul@kernel.org>
 <20180619095430.26358-2-vkoul@kernel.org>
 <20180625190609.GA3586@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625190609.GA3586@rob-hp-laptop>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-06-18, 13:06, Rob Herring wrote:
> On Tue, Jun 19, 2018 at 03:24:29PM +0530, Vinod Koul wrote:
> > Later qcom chips support v2 of the prng, so add new compatible
> > qcom,prng-v2 for this.
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> > 
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: devicetree@vger.kernel.org
> >  Documentation/devicetree/bindings/rng/qcom,prng.txt | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/rng/qcom,prng.txt b/Documentation/devicetree/bindings/rng/qcom,prng.txt
> > index 8e5853c2879b..03fd218bd21a 100644
> > --- a/Documentation/devicetree/bindings/rng/qcom,prng.txt
> > +++ b/Documentation/devicetree/bindings/rng/qcom,prng.txt
> > @@ -2,7 +2,8 @@ Qualcomm MSM pseudo random number generator.
> >  
> >  Required properties:
> >  
> > -- compatible  : should be "qcom,prng"
> > +- compatible  : should be "qcom,prng" for 8916 etc
> > +              : should be "qcom,prng-v2" for 8996 and later
> 
> Either use SoC specific compatibles or convince me 'v2' is a meaningful 
> and specific enough version. Some other QC IP has x.y.z versioning for 
> example.

The specs says QC RNG V2 :)

Said that Stephen suggested to make it qcom,prng-ee to point out that we
are pointing to an execution environment in the IP, so will do that
instead unless you have better idea

-- 
~Vinod
