Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DFDC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B3220672
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ubzuW656"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B3220672
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbeLLQib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:38:31 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52134 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727897AbeLLQia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 11:38:30 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBCGcSdf033596;
        Wed, 12 Dec 2018 10:38:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544632708;
        bh=jihNBbmKqh8cz5W1WyigqLLSsawlyEn+aIg95rkhU64=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ubzuW656ImkVEipyA+04kIKyi7zPgXOZ3COnGPX84bmrKwpzj502czgPfM3lkVxye
         BxTRgIR5fbhdtu5vrGIKHOxckVYcEHQvRi4xNLEJfxETFu5d8ETBlW+QRbpFqziVS6
         Niz0myIp8sj1LRn/Bi1k6vLosbeNKH/AOdTwOong=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBCGcS0f020718
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Dec 2018 10:38:28 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 12
 Dec 2018 10:38:28 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 12 Dec 2018 10:38:28 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBCGcSn3030218;
        Wed, 12 Dec 2018 10:38:28 -0600
Date:   Wed, 12 Dec 2018 10:38:28 -0600
From:   Bin Liu <b-liu@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 3.18 48/54] dmaengine: cppi41: delete channel from
 pending list when stop channel
Message-ID: <20181212163828.GA30432@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vkoul@kernel.org>
References: <20181211151546.010073210@linuxfoundation.org>
 <20181211151548.757658735@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181211151548.757658735@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Tue, Dec 11, 2018 at 04:41:36PM +0100, Greg Kroah-Hartman wrote:
> 3.18-stable review patch.  If anyone has any objections, please let me know.

Please drop this patch. It really should go back to v4.9 but not older.

The Fixes should instead be

	fdea2d09b997 ("dmaengine: cppi41: Add basic PM runtime support")

I am sorry for the noise.

> ------------------
> 
> From: Bin Liu <b-liu@ti.com>
> 
> commit 59861547ec9a9736e7882f6fb0c096a720ff811a upstream.
> 
> The driver defines three states for a cppi channel.
> - idle: .chan_busy == 0 && not in .pending list
> - pending: .chan_busy == 0 && in .pending list
> - busy: .chan_busy == 1 && not in .pending list
> 
> There are cases in which the cppi channel could be in the pending state
> when cppi41_dma_issue_pending() is called after cppi41_runtime_suspend()
> is called.
> 
> cppi41_stop_chan() has a bug for these cases to set channels to idle state.
> It only checks the .chan_busy flag, but not the .pending list, then later
> when cppi41_runtime_resume() is called the channels in .pending list will
> be transitioned to busy state.
> 
> Removing channels from the .pending list solves the problem.
> 
> Fixes: 975faaeb9985 ("dma: cppi41: start tear down only if channel is busy")
> Cc: stable@vger.kernel.org # v3.15+
> Signed-off-by: Bin Liu <b-liu@ti.com>
> Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Regards,
-Bin.
