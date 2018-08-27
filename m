Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77628C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D00F21735
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1fgcqwD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D00F21735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbeH0LEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 07:04:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726978AbeH0LEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 07:04:42 -0400
Received: from dragon (unknown [45.56.155.152])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F9A0208B3;
        Mon, 27 Aug 2018 07:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535354358;
        bh=7bf6RrIMoDUdtN6sbxCcEEy5l0MU4vTcc2BmyAqpYD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G1fgcqwDbZNL3m78PDvE8LBtvyXIJRNLf1ul8oVGVFzvB6yDuhxJGofN8eufcHt4V
         NtY4xjvS6NOkIXUBpeEjUSXrsOQ+fAyTIJKYLVfSRtUCPfzcqq1RDj+QTTC+jwM/wU
         CLW1W92ghC+2wQ0Sxl158Zr2iL+ThUYlRvzSJqhg=
Date:   Mon, 27 Aug 2018 15:18:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpu: do not double put device node in zx_drm_probe
Message-ID: <20180827071824.GG3850@dragon>
References: <1534472646-10368-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534472646-10368-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 10:24:06AM +0800, zhong jiang wrote:
> for_each_available_child_of_node will get and put the node properly,
> the following of_node_put will lead to the double put. So just
> remove it.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Acked-by: Shawn Guo <shawnguo@kernel.org>
