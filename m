Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663CCC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A783F2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNYOXajp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A783F2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbeIKMjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 08:39:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbeIKMjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 08:39:35 -0400
Received: from localhost (unknown [171.76.126.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC04C20865;
        Tue, 11 Sep 2018 07:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536651693;
        bh=zVXVupPeMtn2zez/1jKCHfcQ4XWjrhgai04j6vKm1Zc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JNYOXajpDmU0CEL5KDMX6x4IqUwkWEog8X1lKF5k1PpT5OIU8HCs1Xbztpa2TlQq+
         pRgC1Y0HDTCzoSnUYRLmrTIXuF/dnAe8X1BgUETmRchZ5nz9piF8h9cGrEjLWggEOo
         R0BGCVoly0xhdXxYgYwtoWF+DCubluCrF52/OtCc=
Date:   Tue, 11 Sep 2018 13:11:22 +0530
From:   Vinod <vkoul@kernel.org>
To:     Radhey Shyam Pandey <radheys@xilinx.com>
Cc:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Michal Simek <michals@xilinx.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] dmaengine: xilinx_dma: Fix 64-bit simple CDMA
 transfer
Message-ID: <20180911074122.GM2634@vkoul-mobl>
References: <1532688639-32230-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1532688639-32230-4-git-send-email-radhey.shyam.pandey@xilinx.com>
 <20180821155553.GI2388@vkoul-mobl>
 <MWHPR0201MB362803E975383398B361330FC70A0@MWHPR0201MB3628.namprd02.prod.outlook.com>
 <20180829040111.GD2388@vkoul-mobl>
 <MWHPR0201MB36282BE6CB5BD242480757F8C7090@MWHPR0201MB3628.namprd02.prod.outlook.com>
 <MWHPR0201MB362841247B08AFFA21CB0A18C7000@MWHPR0201MB3628.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR0201MB362841247B08AFFA21CB0A18C7000@MWHPR0201MB3628.namprd02.prod.outlook.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-09-18, 12:08, Radhey Shyam Pandey wrote:

> > > Yeah that part was clear but the implementation can be better..
> I thought over it and it seems having a new interface dma_ctrl_write_64
> taking lsb and msb bits input looks better and scalable. It will be similar
> to existing vdma_desc_write_64 impl. I will send v2 if it looks ok.

Yes that is much better, btw why not reuse same routine as common xilinx
lib functions :)

-- 
~Vinod
