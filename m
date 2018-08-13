Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03390C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F352174C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGn9JJY2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F352174C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbeHMP25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 11:28:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728923AbeHMP25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 11:28:57 -0400
Received: from [192.168.0.101] (unknown [58.212.144.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F3222174B;
        Mon, 13 Aug 2018 12:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534164409;
        bh=SE8R39Ly7k2lmQSlzbceuYY2s+RvPg/CHeL4yCrv/qY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CGn9JJY21SWalGPR0gfGBLshAB+ipHj27C1gGOX1NkzEsuFbv535bYcgJWfq39S3H
         ypzkOFL2bKspbItiVrufSJSN7cxAWH4L0zq5kN+5cqKPQF0MGWiPL+cYRDNSQ54Kvw
         BzIIG1hMrWCw3F4Nx/wlyjwzcH0xsjBXIPEOL1xk=
Subject: Re: [PATCH 3/8] staging: erofs: add error handling for xattr
 submodule
To:     Gao Xiang <gaoxiang25@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        Chao Yu <yuchao0@huawei.com>, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20180812140150.13397-1-chao@kernel.org>
 <20180812140150.13397-4-chao@kernel.org>
 <20180813114725.kgoupvppcwsw2vyj@mwanda>
 <c14184af-6378-fd96-3b9b-52c9a7da8463@huawei.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <961b0caf-7a22-1a15-9641-69b218396980@kernel.org>
Date:   Mon, 13 Aug 2018 20:46:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c14184af-6378-fd96-3b9b-52c9a7da8463@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/13 20:17, Gao Xiang wrote:
>> Generally the rule on likely/unlikely is that they hurt readability so
>> we should only add them if it makes a difference in benchmarking.
>>
> 
> In my opinion, return values other than 0 and ENOATTR(ENODATA) rarely happens,
> it should be in the slow path...

Hi Dan, thanks for the comments.

IMO, we should check and clean up all likely/unlikely in erofs, to make sure
they are used in the right place.

Thanks,
