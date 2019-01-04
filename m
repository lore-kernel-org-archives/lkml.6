Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54754C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 14:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD8121874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 14:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546612527;
	bh=m2OXGPKIOx/RxVDkAg/ve0NZOqXHe8oCZ3dOZiulKYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ovO07yMIhqw8MWY7/J77Gc+hunK0UuC98GUcjWLseTd/ywxqcWeWDfFVEPRTNzmp8
	 CagtYAXRTQrMDMti5Z9OXzZLM8HAGtJMpLl6weyiqCLeqvWF1IQXCcGQKm2WT34I4n
	 Vp/i5bEu7PECIThN+DFTkKBqQDz4p9n6O8j+ma5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfADOf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 09:35:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:53128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbfADOfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 09:35:25 -0500
Received: from localhost (unknown [171.76.109.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3193D2070C;
        Fri,  4 Jan 2019 14:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546612524;
        bh=m2OXGPKIOx/RxVDkAg/ve0NZOqXHe8oCZ3dOZiulKYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gx/X/wnJ+TefjwjSPOb/S3HY+RJ+MYg5VoZrNAZY9ZSWAV6W77uagDkMhgdgoAMLD
         LSH8Vdlq2tYG1NuBqZnu39pzjtKJKpjDd/cC1LMkPNbMOpUqhq+5G20OBwwBnYDei5
         vwOl4oWrOhQZT59iPkG2Zn8QjvxmucoOYWA9zl+w=
Date:   Fri, 4 Jan 2019 20:03:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: stm32-mdma: Add a check on read_u32_array
Message-ID: <20190104143346.GC13372@vkoul-mobl.Dlink>
References: <20181228192641.9713-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228192641.9713-1-pakki001@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-12-18, 13:26, Aditya Pakki wrote:
> In stm32_mdma_probe, after reading the property "st,ahb-addr-masks", the
> second call is not checked for failure. This time of check to time of use
> case of "count" error is sent upstream.

Applied, thanks

-- 
~Vinod
