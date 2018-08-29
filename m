Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A883C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 01:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B891720846
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 01:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="rklpXvzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B891720846
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=aol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbeH2FgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 01:36:07 -0400
Received: from sonic304-50.consmr.mail.gq1.yahoo.com ([98.137.68.232]:40727
        "EHLO sonic304-50.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725882AbeH2FgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 01:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1535506903; bh=sfYkNKiurRi4lF4gMSlcFRG0PTXQO/6HnMLP9RnFDlw=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=rklpXvzTTMX181K1PW8KkwxD1LVwGW5g6wMCWSS022zonW1bfv3EXfYDqSrGyaj9GhnUVAmJKVxKxoBicyRzFROVEeLl2+vbe4kekzpdW5fdtohMTAS5TX/SvfFoD78f0G7fMHdDHE0t0Trjq5oDN59GEO/t+9/6QVsWC4n+hL+1OHQDnU+R252U/C035hgFQ0H5tXADNaqVUA3xInpyKmyUhNnb8H+0spxZDZmaydAxuN9pkh1QuI+8pOxA1+MD9aZkrWOC60IYtCEnQQ+0Br10NAIinM57GEUUeXNJNIJ7LERl/5BcWu5MKASrG0Zw0jyz/kIduWrx6ZphhsI7BQ==
X-YMail-OSG: yUXbMXsVM1nzWIO_HJUhjSHQ4_qquyzEQTmZj4DhvZ8fkfUtcKCuWjvxeGygKac
 WAtDfqF_V9wk5kFklgavPMeBdXsQGXsJ6c01EztlS24isMQGm40L3l4t9Xv8T6J8IGrLPyen32Yo
 FhD7tQ9.8620wxb3TrFabpx4aAO6tCWJp1yz6eqTUDU6U1fYgRWZmJVC3DQYlBk8J9FsHFZj7Wis
 5xpxKaitptqa5kjxhr7ou7GQAdJ604nEtoiCaeW.wUhRgDJexB3ocu7qPT_zwI5CEVmWiNU96Tqs
 1PDBlFaem2Zt._AD4guU9rZVcCRX1d28.IlJPzPVQbX5.bn6DSJS8DCOXvsg1ZdaLLHUCGG.IK7h
 oTXejuvFAq9Zde25jbqjqGeHykpXMyX3K7bjPvomsn6xXwV.vqi5NFcPz.zdZXbsoqkFDtUObZAi
 syMFGSPRj9z0__rb8qL4JWsUndi.w7.KZG7k6aWh3VjlPeCNMDLA2XvHJ5n0Yr6Ki6A3lr10Lua3
 Ygjb.irE28HUcxzXSe1qHtz8B67mCQ7VZxR4gmORVLiLuwR5_b14Nq3jX1msyQjVgENiJWIsUTDr
 lYonDZk1bFGdaZ4GDsAgGiDnP7tGJqm9xyFAqGkTkPBKWTEHHUo053EehhQFXKmQzt2Km2bXqDDh
 Vxf.gRj.I80_EEUSYjIqB6r6zArf23DtZIUsKVbgRQXhbhTdOakXut6_KnVBZJQ1Kowo2uXrRYlp
 mUDNJy.AG3ZvtniqCUhdwO59Ru3X2SbFc4p1q.INcs87IEW0EsNhBhjRUAT_tqDlCSbBN19DZVQ1
 fEObXTnjtG86QjFObv1JUkrI1QCwSko3vcHi_fU4nru3A8LXDS49UYFN9ORAniT60pVR7DmqhEzt
 U4OZqLAqnNzQJ5X0IIpDytSUXxzjJD.0Gzjyigp8vF6.E0gH80v69c1GVqjOSS1N8lNmv96Ot0Zb
 QaGR1EgzzTEuI7nh97_o4Spz2AgLvytlqizqzf9jtyHTx0nbB_e4fx7CnMxulkGti6D1hpMhnzAX
 xDbV2TyU58BqHUhl2Hg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.gq1.yahoo.com with HTTP; Wed, 29 Aug 2018 01:41:43 +0000
Received: from 117.132.196.206 (EHLO [192.168.24.100]) ([117.132.196.206])
          by smtp421.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ebc54bb238843bcff924d791f4b0b65e;
          Wed, 29 Aug 2018 01:37:43 +0000 (UTC)
Subject: Re: [PATCH] Revert "staging: erofs: disable compiling temporarile"
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Chao Yu <yuchao0@huawei.com>, devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, weidu.du@huawei.com,
        Miao Xie <miaoxie@huawei.com>
References: <1535427588-69630-1-git-send-email-gaoxiang25@huawei.com>
 <20180828054444.GA4453@kroah.com>
 <0c701b3c-5553-cf4c-c0b3-ad151b84662c@huawei.com>
 <f12ae5df-3130-f293-5863-3d9ff0802e92@huawei.com>
 <20180828130559.GA5427@kroah.com>
 <16974cb6-2eed-7c12-9e27-c65a32b81673@huawei.com>
 <20180829094403.3a3bf19b@canb.auug.org.au>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <2f9ffbd8-b6e8-f5df-fb5e-f08f0b739070@aol.com>
Date:   Wed, 29 Aug 2018 09:37:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180829094403.3a3bf19b@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/8/29 7:44, Stephen Rothwell wrote:
> Unfortunately, those vfs changes are still in the vfs tree in
> linux-next and cause a build failure in the erofs code.  I have
> disabled the build of erofs again for today.

feel a bit loss after hear that... :'(

> 
> Dave, Al, it would be good if you could add a patch/revise the series
> that adds the necessary erofs changes.

Hi Dave, Al, could you please kindly fix EROFS in vfs tree if it is
convenient...

Here is my patches which were intended for 4.19 (they could be rewritten
if needed...)
https://lists.ozlabs.org/pipermail/linux-erofs/2018-July/000282.html
https://lists.ozlabs.org/pipermail/linux-erofs/2018-July/000284.html

Thanks in advance...

Thanks,
Gao Xiang
