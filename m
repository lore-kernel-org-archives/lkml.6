Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D7CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 02:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B2B20883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 02:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547780255;
	bh=63KWczrR5Lw16qxmC8r7HpPCmARTKmezeAF9ITtY0m4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bKtMaU72BuM1K8KRzH0XrwMVOgJn7wAtg8yMSrooecJbn0IZdOXmnpGttRiCK3v8m
	 IAYXGu9+6GPF0COxoDkwGCY70QkW6nvsIdQE4OhoVAjW2o1G8YYXyttEcRj6HJ4PvO
	 z5nAZMb+qE251QclrsAYm8BNhFWi5oX8vtx1BNWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfARC5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 21:57:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:33806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbfARC5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 21:57:33 -0500
Received: from sol.localdomain (c-24-23-143-129.hsd1.ca.comcast.net [24.23.143.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D65F20873;
        Fri, 18 Jan 2019 02:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547780252;
        bh=63KWczrR5Lw16qxmC8r7HpPCmARTKmezeAF9ITtY0m4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oobvhGjj2UTC550g3KnWkiI5B7iC412EIOiSdm73YoumEns7bTa7cwPK0LOzZCyhe
         JpEeqKOtb0SMo2WrPRKsiW1C5Hue0v2iaZMFmpjeOaB4dhNbDevFyzNy2FlbZDvUzH
         dOCziCgaHJhJpn7mTDwmcLXrb7c7TJBCEe4vudzk=
Date:   Thu, 17 Jan 2019 18:57:30 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, ard.biesheuvel@linaro.org,
        jonathan.cameron@huawei.com
Subject: Re: [PATCH V2 0/5] Crypto Cleanup
Message-ID: <20190118025729.GA737@sol.localdomain>
References: <1547707683-45878-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547707683-45878-1-git-send-email-wangxiongfeng2@huawei.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 02:47:58PM +0800, Xiongfeng Wang wrote:
> The patchset introduce a helper to (un)register a array of crypto templates.
> The following patches use this helper to simplify the code. This is also
> a preparation for a coming patchset, which will register several crypto
> templates.
> 
> Changelog:
> v1 -> v2: 
> 	rebased to cryptodev, fix some format issue
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
>  crypto/ccm.c              | 78 ++++++++++++++---------------------------------
>  crypto/chacha20poly1305.c | 37 +++++++++-------------
>  crypto/ctr.c              | 43 +++++++++-----------------
>  crypto/gcm.c              | 73 ++++++++++++++------------------------------
>  include/crypto/algapi.h   |  2 ++
>  6 files changed, 104 insertions(+), 156 deletions(-)
> 
> -- 
> 1.7.12.4
> 

For all 5 patches:

Reviewed-by: Eric Biggers <ebiggers@google.com>

However, you need to fix your email address to be the same in the Author and
Signed-off-by.  Right now it's:

Author: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Signed-off-by: Xiongfeng Wang <xiongfeng.wang@linaro.org>

(checkpatch.pl also warns about this.)

Thanks!

- Eric
