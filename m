Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9551AC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 04:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E59220870
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 04:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548994762;
	bh=UcMoDYJZ37NgRES6tkRz3UM54m3048QvIhNCj28nZQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s0fypRh1GrYCqF/J2hC90UZ4QlVaYGVigtnrKoJq8UfcndCzzAahj68fnEwdINFq2
	 K9JHiBFPoZfWh+4AwhJ1Mb2gmuk/yDi786FV54tUPRLUoX9Hraznrobv84MqKVtEHR
	 oXesEHvOwwxa48KVWJik2g8PtJKP8xpHIon/PqXM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfBAETU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 23:19:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:55634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbfBAETU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 23:19:20 -0500
Received: from localhost (unknown [171.76.100.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B51E920823;
        Fri,  1 Feb 2019 04:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548994759;
        bh=UcMoDYJZ37NgRES6tkRz3UM54m3048QvIhNCj28nZQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RxuvSSzo1+POeTY+u+7YGfmuiNllAmkhJ2sf8ezEFLUtV1f/qmj2CIVifBLLPK/Ny
         tTh+hsuG6TWsBN/8oVOjfgYCbZG5f5i66Rq+thzoke6969pOrBdWark7yr4XdoP8hl
         Pz30IkCNaqg7CJpQ4g5T9GYFt1TJDXAXsHb5VvU8=
Date:   Fri, 1 Feb 2019 09:47:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Federico Vaga <federico.vaga@cern.ch>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: DMA Engine Documentation: TX Descriptor and Submission
Message-ID: <20190201041750.GM4635@vkoul-mobl>
References: <1655406.8MLMLfCWyH@pcbe13614>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655406.8MLMLfCWyH@pcbe13614>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-01-19, 09:47, Federico Vaga wrote:
> Hi,
> 
> I have a new question concerning documentation.
> 
> https://www.kernel.org/doc/html/latest/driver-api/dmaengine/client.html
> 
> >From this document it is not really clear, at least to me, if clients can 
> consider valid the `struct dma_async_tx_descriptor` after submission to the 
> DMA engine.

Nope they can't and should not touch the descriptor after submission.
The client get cookie and that is supposed to be used
> 
> Clients get a TX descriptor from a DMA engine using things like 
> `dmaengine_prep_*`. These calls - may - allocate new descriptors and return 
> them to the caller; this may include other structures which are not visible to 
> clients. So, if my understanding is correct, this means that it's the DMA 
> engine that, on TX completion, releases any TX descriptor allocated by 
> `dmaengine_prep_*`. This implies that the pointer that the client is using 
> must be considered invalid right after `dmaengine_submit()`.
> If what I understood by reading the documentation and the code is correct, 
> then I think that this should be mentioned in the Documentation.
> If I'm wrong, please tell me where :)

And what exactly are you trying to do here..?

-- 
~Vinod
