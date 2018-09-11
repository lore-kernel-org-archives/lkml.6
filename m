Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F63C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7AC520839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6TwYVeZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7AC520839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbeIKMmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 08:42:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbeIKMmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 08:42:54 -0400
Received: from localhost (unknown [171.76.126.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D82620839;
        Tue, 11 Sep 2018 07:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536651892;
        bh=jas5CSfN/5hP8JPc0IfjBmGCI677S/tTPp2O2scbva8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W6TwYVeZtG9yAe/atSXqvExdkMA20iq+tuyth1Wo2ZPjbon/8tqIM/C+pQHOOsvC+
         R1SK/VA5IkVnDEI0dOwdCD8WslFrSQkOJyzCzsO6tj7+hcsqFfILiJO/COfYniWoim
         6YbpnuQlCaovORIg7KNqpt/For7B8+9eEofQJzQA=
Date:   Tue, 11 Sep 2018 13:14:42 +0530
From:   Vinod <vkoul@kernel.org>
To:     Zhaoxiong Yuan <yuanzhx326@gmail.com>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma: idma64: replace spin_lock_irqsave with spin_lock
Message-ID: <20180911074442.GN2634@vkoul-mobl>
References: <1536346930-6842-1-git-send-email-yuanzhx326@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536346930-6842-1-git-send-email-yuanzhx326@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-09-18, 06:02, Zhaoxiong Yuan wrote:
> idma64_chan_irq() is invoked in hardirq handle function, it is unnecessary 
> to call spin_lock_irqsave.

Please add a line after log and s-o-b

I have applied after doing above and fixing subsystem tag (dmaengine)
-- 
~Vinod
