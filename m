Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286D6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD2F220866
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMeIQVfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD2F220866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394146AbeKVU6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:58:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:53306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387447AbeKVU6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:58:32 -0500
Received: from localhost (unknown [95.99.132.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 586BC20684;
        Thu, 22 Nov 2018 10:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542881984;
        bh=7Hy75sedsmdfhYJlUrli3retcrV6H23abLfSc3ymR1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iMeIQVfS8pIijhYxYhYM3ajvkoZaioDaBkdvNh0t3KhA4c6fnup55QLcjdT+4r0tO
         t+poAvUmUG1j10ly7qjH8zomjeL13x3OT4HSwmOskjSUwxHXpoasinKi3VNfT8PuvE
         Wfl7FDEF4UC1A2TcPwf3QyR+7lir5okShGvHglCs=
Date:   Thu, 22 Nov 2018 11:19:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH 01/10] staging: erofs: fix `trace_erofs_readpage' position
Message-ID: <20181122101941.GC3189@kroah.com>
References: <20181120143425.43637-1-gaoxiang25@huawei.com>
 <20181120143425.43637-2-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120143425.43637-2-gaoxiang25@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 10:34:16PM +0800, Gao Xiang wrote:
> `trace_erofs_readpage' should be placed in .readpage()
> rather than in the internal `z_erofs_do_read_page'.

Why?  What happens with the code today?

> 
> Fixes: 284db12cfda3 ("staging: erofs: add trace points for reading zipped data")

Should this get into 4.20-final?

thanks,

greg k-h
