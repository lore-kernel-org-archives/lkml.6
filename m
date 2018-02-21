Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1717131-1519224424-2-14094136422614811668
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519224423; b=IVXtv1zfVfJqvlQ4v8V1+8gnL3G3BTk/oeYtKCcJCWuKa0e
    1fNJqTroZcTqllepi1XBeCXOw2d3ZARm1hidBz86jARw2c0KAKcVxWY3XLdCqWzh
    uh6RXt0p6MYuxLZbv1FsDTLcrNt23JpoVwRWy865RgjfE1aaaKJp6JD90hkOoH7q
    0UrK+DbwiIRSxkUagSKPgtx+RxpaheZn1VPIh5Ip4I82MUItvgTNbTProlGwK1j8
    eR9ikEyrpWl2Oce2PcjXVLeBNQJiV1NX4BjSbT4dHQIcFrs+73dW68YAjjn+oeFo
    OrZ7LigiKwQALsAO3eCXEG2fhYtQ0A9o3V1209A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519224423; bh=x9s0W+1dMNgOgaAnl4xOYgET8m
    BmfN0JrXhc8dR0g74=; b=FOx2hIR9EFxgfgFEuy/V9uSmDc/TlSuSXLnLaKeTp5
    8djPWUV07mAQ7v0InwezWkjOs9GYnvzeLG9fnJFAQfiPi/ugPO88X2RaT36gDn+X
    81tHsfgqZTJYSdyEK3ykcu4LLb+3WYLFNf9ZcUeC1UrcEgeEZeXRvIZWAYvMbFdQ
    KS8uf3YFLr7VhmhQRy5BnpKE8vzF2HrecrsuipE96oUWM5O3KdL1nsDdPDLD8s3I
    liESAttG4I9tByTRI7KBkxnZCr5gt/Lbl5Oumsbf2Ib2FUAME/yN0B/MsQWjstr/
    DhdhGP2uD+ai9SlyGEleRjxrl6x4BoxoMHj7X+1Cs7hA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=W2fjpB3l x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=s2QR/EyV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=W2fjpB3l x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=s2QR/EyV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934555AbeBUOqe (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 09:46:34 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:32788 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937986AbeBUOqa (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 09:46:30 -0500
X-Google-Smtp-Source: AH8x224wDYWYCUfIE1mmaIFcnLPPHl/sFf6rSIbudv0IZHWPAMUlFNzM+/yF2s3MypzAQHLK1qRO9g==
Date: Wed, 21 Feb 2018 07:46:26 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/33] 4.4.117-stable review
Message-ID: <20180221144626.GA21376@flashbox>
References: <20180221124409.564661689@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221124409.564661689@linuxfoundation.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 01:44:43PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.117 release.
> There are 33 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Feb 23 12:43:54 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.117-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
>

Merged, compiled, and flashed onto my Pixel 2 XL and OnePlus 5.

No conflicts and no apparent issues in dmesg or general usage (I've been
running the RC before this one since yesterday afternoon and not much
changed for Android since then).

Thanks!
Nathan
