Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C59C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED572089F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546409158;
	bh=7t6xnz3an9WewU8yhl2w/qZDgDCntt1Db0zLy9MnU0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kyOvSlO/jqrGmtv1br0zKtJ2bxPB/0O7IG0RyfleQp+/9ExuchXVzEFUNCMO08LJa
	 EZkP7QWp1lXIkp34Vf2mA44B+cpGbGS+f6gb+vIEcGNczc6VPWV4nFohIzvsEu7Qtr
	 tudypRBi+dqYkX4z5sApXR5PO5WaIql0g2bNZC2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbfABGF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 01:05:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:58954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727623AbfABGF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 01:05:57 -0500
Received: from localhost (unknown [171.76.109.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D7682089F;
        Wed,  2 Jan 2019 06:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546409157;
        bh=7t6xnz3an9WewU8yhl2w/qZDgDCntt1Db0zLy9MnU0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EgU5DSbeM5dXpd6m93rg75ih4l0FOX95nnEe0yTBtgDZGyN1LY4s7NbnciKDmUS7n
         jicU2mqp+JW4ZdRvzCPZXxp7ACAU5jO91brgs/iwHFdqyO2m5K82clRsdJAMcLkFEF
         31jO7tO2JCUgROyujYDKZ+NpuI66OUj6LIpKFK54=
Date:   Wed, 2 Jan 2019 11:34:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        kernel-janitors@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/20] dmaengine: sa11x0: drop useless LIST_HEAD
Message-ID: <20190102060423.GI7581@vkoul-mobl>
References: <1545555435-24576-1-git-send-email-Julia.Lawall@lip6.fr>
 <1545555435-24576-19-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545555435-24576-19-git-send-email-Julia.Lawall@lip6.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-12-18, 09:57, Julia Lawall wrote:
> Drop LIST_HEAD where the variable it declares has never been
> used.
> 
> The semantic patch that fixes this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> identifier x;
> @@
> - LIST_HEAD(x);
>   ... when != x
> // </smpl>

Applied, thanks

-- 
~Vinod
