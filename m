Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20506C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE1C620893
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxsvvyYD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE1C620893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbeGYNqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 09:46:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728492AbeGYNqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 09:46:03 -0400
Received: from localhost (unknown [122.178.229.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC7A620893;
        Wed, 25 Jul 2018 12:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532522073;
        bh=D9N0AX2Mw7rhs/Rsm1QzVnzEK8GmsJNoosMhfTgz3Ro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hxsvvyYD0j2f0JTfKfu2L0ll0wDvP5Xnk2L9btWbtXxqdg/xnvPt2v3P7yEjgrnDq
         WfCVfqqt2FqzyCi0ZlFJ2HrE3jfw9L2IvawRofGWXHKXDH3Tue6jacsfZfogdEmL4N
         hi916coe0dApS3tzD1xUGfueBVI+gsIDXRoVpnI8=
Date:   Wed, 25 Jul 2018 18:04:25 +0530
From:   Vinod <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dma_request_chan_by_mask() to handle deferred
 probing
Message-ID: <20180725123425.GS3661@vkoul-mobl>
References: <20180718092957.1934-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718092957.1934-1-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-07-18, 12:29, Peter Ujfalusi wrote:
> If there are no DMA devices registered yet, return with EPROBE_DEFER
> similarly to the case when requesting a slave channel.

Applied, thanks

-- 
~Vinod
