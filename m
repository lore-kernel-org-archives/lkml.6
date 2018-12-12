Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BB1C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9042084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y728RWkN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9042084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbeLLQkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:40:49 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52392 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeLLQkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 11:40:49 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBCGelEd034003;
        Wed, 12 Dec 2018 10:40:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544632847;
        bh=PEUIKOM5yNF/zaWdsp5iT8qdaevq7r5XBOEcPESK+9w=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Y728RWkNeh1DD/8f2bVi6+sunwLstRNeVCn4FJTRrS49Mcucj55wTczksLTnxPfc/
         0LVmdHFsB1itQAeUxlfmoeoyb/EsxRie6QfaWZPihKNHaKrItjUlpxIJ1l7Bjvb+ZO
         BrRByXFeFqr+brNR4eWXXZgIaHnoh1baaFuSWqm0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBCGelbX118697
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Dec 2018 10:40:47 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 12
 Dec 2018 10:40:47 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 12 Dec 2018 10:40:47 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBCGel3C002065;
        Wed, 12 Dec 2018 10:40:47 -0600
Date:   Wed, 12 Dec 2018 10:40:47 -0600
From:   Bin Liu <b-liu@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 4.4 81/91] dmaengine: cppi41: delete channel from pending
 list when stop channel
Message-ID: <20181212164047.GB30432@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vkoul@kernel.org>
References: <20181211151606.026852373@linuxfoundation.org>
 <20181211151613.281713570@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181211151613.281713570@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Tue, Dec 11, 2018 at 04:41:40PM +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.

Please drop this patch. It really should go back to v4.9 but not older.

The Fixes should instead be

	fdea2d09b997 ("dmaengine: cppi41: Add basic PM runtime support")

I am sorry for the noise.

> 
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
