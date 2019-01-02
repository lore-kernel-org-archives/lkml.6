Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AB8C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C5621019
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546409144;
	bh=YaTXbsrBGf3P8LzK7jPQ7RjSDxK4wJpAMlNsCAVrALQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NeDECmtMuHAVC7oyNmLVY7nw1qPRZYimXG7uf0cqzO2FLsBh7Yfy9XT/8W0akC65I
	 esk73EClhOhlX4fEEtMWGoNArAkMUjiBPuPWmOZnj0PNPyDV6sgOeG3CnsUOg2f+hz
	 cY6UiGlmlKUXisIHKijdrIt9zlq7Xp81XwCWnDAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfABGFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 01:05:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:58888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728595AbfABGFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 01:05:43 -0500
Received: from localhost (unknown [171.76.109.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3841A2089F;
        Wed,  2 Jan 2019 06:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546409142;
        bh=YaTXbsrBGf3P8LzK7jPQ7RjSDxK4wJpAMlNsCAVrALQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yeGig9o1f/a0/91Zm41UkI8/lOnZswNGJ74GWg379xSC5zG3iZD04jR1dQFjjDl3J
         7M7Eacqp9+hcni3LCRfbIkBGrU7VuzksuKqEhjaQS3whbrpNIX2VRM17e7xZhJRJNP
         gZwR0kk3leeyyhHnszqUyfQJ3/Fi/EFrpQ5CSImo=
Date:   Wed, 2 Jan 2019 11:34:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        kernel-janitors@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/20] dmaengine: pl330: drop useless LIST_HEAD
Message-ID: <20190102060404.GH7581@vkoul-mobl>
References: <1545555435-24576-1-git-send-email-Julia.Lawall@lip6.fr>
 <1545555435-24576-18-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545555435-24576-18-git-send-email-Julia.Lawall@lip6.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-12-18, 09:57, Julia Lawall wrote:
> Drop LIST_HEAD where the variable it declares is never used.
> 
> The variable has not been used since the function was introduced
> in 740aa95703c5 ("dmaengine: pl330: Split device_control").
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
