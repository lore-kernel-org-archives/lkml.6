Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-766844-1524467270-2-11244730021767795138
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524467270; b=pfeNotG4iHt/3tgabYB2vAJA5eY7olWU0ipngj/Sr7lA1VIgHa
    XeLJILh9yWB8bmpFBOVFfSQcNn/u53XuxqXTrz3HHTNFrvROneienUKK2dDiLs7n
    TxGbon+dxrAnLkGReQ+IljCXneTvp39JTfjemJ3hlQaYB1O76ToNmTPEfcPJyjLG
    oxj98NKRKmZs902yFlKSYDznQ8Vi+46D0ygl7iJYMkuNvzVIF692bP0NxwLUe3X+
    TkON7c3yyDOz4WBma+waf0nqzxFEr7LeXDh2PNCn2mUAoHLtFe2RNsiU2beSKx2P
    5Hf1u27dBT+7hfgJR6Gp8dq19gv7x1z4ToAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524467270; bh=PnWUMfQ6klZjh3Z9Ziikv2qTDWdyR6
    YSp8O+8jwdZ8U=; b=ZbygZqmGbGesdd9Vb9ZJ0Kv4bqbEA+GbyZERAOk6xKKdpl
    I7nMnHYSIZxD9C67GwUlRrfS3C1j59LKeH3k+VL8tW5whliDwKAfO5KsDzzZz3WL
    SaxHrnFNg1kPfxDl9VGN9ZvUbEfGcw/be8alaGPcZRsNuf1K7oUaGwvZu0L+H/DC
    m8OZT3rdMWnSTlhzt3C6XN+hM0SgMEAbxNzeMSom9wx6wa70UANYGWxdnDd6o+zm
    VwcFeVNxN6RNUZLw4wAR17crsmaSQITdjj+iYER+bNKA0WGWWX5L9W2bFX3Oy3ES
    xqsC+Od9qXgopijqG+K+5fRRzxPozaZUyoftkFwA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKMtv+DewZ9jIO1jOKm92ext8WbTwpdHc+Fo1YZ4V4FGn9eTacfNg1s0DmRaXp5OKMCgPsTzy4Ji6gzsoT89m7q2UnC1z7iajdR1vHoqzdAVyk4A8sll
    7EOeisKgTdT70aTZmpdqSlA/IhsQv9lJ6TIPMvcdyiezKYvImMtM9tn97GlTQS+jWNm+5yB3wY58MZwKwh6nKXVFg6fML6ENnBE0wVqCEwX52iYzUmHk/fM/
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=xRDiy12qv0EA:10
    a=Kd1tUaAdevIA:10 a=oZLSOeXGZXE7TXH0mp8A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753121AbeDWHHt (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 03:07:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58934 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753007AbeDWHHs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Apr 2018 03:07:48 -0400
Date: Mon, 23 Apr 2018 09:07:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.16 000/196] 4.16.4-stable review
Message-ID: <20180423070742.GA28186@kroah.com>
References: <20180422135104.278511750@linuxfoundation.org>
 <9fcfb52c-bac2-bce5-f84d-929f1045b054@roeck-us.net>
 <20180422202501.GA2319@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180422202501.GA2319@flashbox>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 22, 2018 at 01:25:01PM -0700, Nathan Chancellor wrote:
> On Sun, Apr 22, 2018 at 01:13:53PM -0700, Guenter Roeck wrote:
> > On 04/22/2018 06:50 AM, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.16.4 release.
> > > There are 196 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Tue Apr 24 13:50:16 UTC 2018.
> > > Anything received after that time might be too late.
> > > 
> > 
> > 
> > Build results:
> > 	total: 143 pass: 141 fail: 2
> > Failed builds:
> > 	powerpc:defconfig
> > 	powerpc:allmodconfig
> > Qemu test results:
> > 	total: 139 pass: 133 fail: 6
> > Failed tests:
> > 	powerpc:mac99:ppc64_book3s_defconfig:initrd:nosmp
> > 	powerpc:mac99:ppc64_book3s_defconfig:initrd:smp4
> > 	powerpc:mac99:ppc64_book3s_defconfig:rootfs:smp4
> > 	powerpc:pseries:pseries_defconfig:initrd
> > 	powerpc:pseries:pseries_defconfig:rootfs
> > 	powerpc:powernv:powernv_defconfig:initrd
> > 
> > arch/powerpc/platforms/powernv/opal-nvram.c: In function 'opal_nvram_write':
> > arch/powerpc/platforms/powernv/opal-nvram.c:61:11: error: 'OPAL_BUSY_DELAY_MS'
> > 
> > This problem affects _all_ pending releases.
> > 
> > Guenter
> 
> Looks like 3b8070335f75 ("powerpc/powernv: Fix OPAL NVRAM driver
> OPAL_BUSY loops") has a dependency commit that was missed: 34dd25de9fe3
> ("powerpc/powernv: define a standard delay for OPAL_BUSY type retry
> loops").

Thanks, I've now queued this up everywhere to resolve this issue.

greg k-h
