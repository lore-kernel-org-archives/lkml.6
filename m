Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9345C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F54920844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnRXCp+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F54920844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbeGYN2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 09:28:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728809AbeGYN2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 09:28:46 -0400
Received: from localhost (unknown [122.178.229.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3739820844;
        Wed, 25 Jul 2018 12:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532521040;
        bh=6rKom0KnvXYnXjQ1TAOQsPTvAG3UzFhFngcOpaBtZ1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pnRXCp+CpM+ffrCFRrwdVUaY5eRChbArk40KDbuhzhQp97Dumrlw/s0svuZI96ghZ
         JTupKySJIApvDBqxV0TDs8Sa0dxTTBpyN/LjkOcGLplFRcjYo9wmLnXwO0aYH/p2R3
         KegWMDP0GJkl4a0UaPvGG9SgS+NDw2mNYNQZgNQc=
Date:   Wed, 25 Jul 2018 17:47:12 +0530
From:   Vinod <vkoul@kernel.org>
To:     hannah@marvell.com
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        thomas.petazzoni@bootlin.com, linux-kernel@vger.kernel.org,
        nadavh@marvell.com, omrii@marvell.com, oferh@marvell.com,
        gregory.clement@bootlin.com
Subject: Re: [PATCH 1/1] dmaengine: mv_xor_v2: use {lower,upper}_32_bits to
 configure HW descriptor address
Message-ID: <20180725121712.GP3661@vkoul-mobl>
References: <1532439630-23555-1-git-send-email-hannah@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532439630-23555-1-git-send-email-hannah@marvell.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-07-18, 16:40, hannah@marvell.com wrote:
> From: Hanna Hawa <hannah@marvell.com>
> 
> >> drivers/dma/mv_xor_v2.c:647:36: sparse: constant 0xFFFF00000000 is so big it is long
>    include/linux/device.h:678:13: sparse: undefined identifier '__builtin_mul_overflow'
>    include/linux/device.h:678:13: sparse: call with no type!
> 
> Use lower_32_bits and upper_32_bits to set the hw_desq address, instead of
> using constant.

Applied after adding reported-by, thanks.

You should always give credit to error reports

-- 
~Vinod
