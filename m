Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010BBC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 04:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA8820883
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 04:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fygDve5G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA8820883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbeGZFZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 01:25:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbeGZFZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 01:25:37 -0400
Received: from localhost (unknown [122.178.199.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 196452083F;
        Thu, 26 Jul 2018 04:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532578246;
        bh=rIPWl1+keZODLsibjOltTI32bA3R9rpg/d7wWSTNENM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fygDve5GnqIk9wYWFcG82Mu1Y6yOQ57N2bLkGxbi+Ahw845PDUomv7kgsvWsqBr8c
         ZPj2FaIu/b9dEC6iO4OwyWlDxDt93+ZfUhTA7b2Ut1PqA7Qj/tWSjZZHvy+zHAMbd1
         /CkMAVoN5UYdMe12pl+fVKrqSGYau3h5TOcyuLsg=
Date:   Thu, 26 Jul 2018 09:40:38 +0530
From:   Vinod <vkoul@kernel.org>
To:     Huang Shijie <sjhuang@iluvatar.ai>
Cc:     corbet@lwn.net, dan.j.williams@intel.com, robh@kernel.org,
        linux-doc@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: add a new helper dmam_async_device_register
Message-ID: <20180726041038.GY3661@vkoul-mobl>
References: <20180725054645.9723-1-sjhuang@iluvatar.ai>
 <20180725123826.GT3661@vkoul-mobl>
 <452f2991-241b-1f0f-efad-9c7e37814c5e@iluvatar.ai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452f2991-241b-1f0f-efad-9c7e37814c5e@iluvatar.ai>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-07-18, 09:21, Huang Shijie wrote:
> > > @@ -240,6 +240,7 @@ CLOCK
> > >     devm_of_clk_add_hw_provider()
> > >   DMA
> > > +  dmam_async_device_register()
> > can we name it dmaengine_async_device_register, not to confuse with dma APIs
> ok.
> If no one objects the dmaengine_async_device_register().
> I will use it in the next version.

Relooking at it, we also need to suggest that it is devm api, so:

dmaenginem_async_device_register() would be better IMO

-- 
~Vinod
