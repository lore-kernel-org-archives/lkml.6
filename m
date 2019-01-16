Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55A1C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 799D220840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547660996;
	bh=2lB8+ZRHIr5+BF5FHshO0P519gS9Y2UtOR9Afd54eB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QlBNa5I9kcOkZjCD780o19MioRTLJLLly702GczP3kjFvhbR0rjNmZ5iYBI+xHvRf
	 JPMSR3W/JXORco6GHLZj+Vz1zQyNBQb0OWbL27js6+38c7jxU1xvb7o6e8J1gs1WMN
	 YhqRpebFfqVAlgjrBuN8LOSHyQ6qOH5iUV9fny/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfAPRty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:49:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:42130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbfAPRtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:49:53 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C197A20657;
        Wed, 16 Jan 2019 17:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547660993;
        bh=2lB8+ZRHIr5+BF5FHshO0P519gS9Y2UtOR9Afd54eB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kYuOu02zgdW53TSXvVVGk0C7RxA7SpI4KE5i6QG9DXNXB7GONXSCsRVxB0qMDud1s
         OM8e5kkjE07txxAIO8yvjIeudc1chZIFa8cUX5o5XNEoQyZ/ObwMmi6hRjhuiMjYnx
         ch114F32nkugCLtZtk15odSLDqkyujEcfQB8J8dA=
Date:   Wed, 16 Jan 2019 09:49:51 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, ard.biesheuvel@linaro.org,
        jonathan.cameron@huawei.com
Subject: Re: [PATCH 0/5] Crypto Cleanup
Message-ID: <20190116174949.GA152952@gmail.com>
References: <1547607034-40948-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547607034-40948-1-git-send-email-wangxiongfeng2@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 10:50:29AM +0800, Xiongfeng Wang wrote:
> The patchset introduce a helper to (un)register a array of crypto templates.
> The following patches use this helper to simplify the code. This is also
> a preparation for a coming patchset, which will register several crypto
> templates.
> 
> Xiongfeng Wang (5):
>   crypto: api - add a helper to (un)register a array of templates
>   crypto: ccm - use template array registering API to simplify the code
>   crypto: gcm - use template array registering API to simplify the code
>   crypto: ctr - use template array registering API to simplify the code
>   crypto: chacha20poly1305 - use template array registering API to
>     simplify the code
> 
>  crypto/algapi.c           | 27 ++++++++++++++++
>  crypto/ccm.c              | 81 +++++++++++++++--------------------------------
>  crypto/chacha20poly1305.c | 38 +++++++++-------------
>  crypto/ctr.c              | 46 ++++++++++-----------------
>  crypto/gcm.c              | 76 +++++++++++++++-----------------------------
>  include/crypto/algapi.h   |  2 ++
>  6 files changed, 113 insertions(+), 157 deletions(-)
> 
> -- 
> 1.7.12.4
> 

Hi Xiongfeng, I think this a useful cleanup but can you please rebase this onto
cryptodev?  There is a conflict in crypto/ctr.c.

- Eric
