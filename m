Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-335416-1521654437-2-14278017011074285218
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521654436; b=Qu8CvphoXnOhh+6CUQZL6TBomq8gHGAGbP66RevnkAXbi+6
    w5/tVnDAlfCyt5FP9Vs5VcXXZW2rEMfFNg6VBsJMM+b/eJ5awYThqayb8BjH3zi3
    BaCoriR2MGvYqPYr6bGlURyK3C1xtXGbYL3N5rn7uITq0SI1MWxcOiWWkOoUIa3Q
    nyfR609zev2zM9UD3pKPh1x22Q3GuPyIfJwQPH5m5ctDe3HoJo/+pBiDXggMC7Fm
    9EoCACkRhkZvdDaBZF2D8+yAQ/7nxW3uXWP/oYubGW6VydqKdOlO20hPhZVhUjmO
    yszEOyZFN3ugi7TUfx4arB53TP5WShBWUb5tPcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521654436; bh=dvzo1pQOySktLMdTmw1kEfXQoc
    fWPYYNKiWU8ZCccas=; b=cY1ZMw16Qm7xRMB96DKOAXGPwwGjduLnuBUfTzNikC
    mtuvDNlZUkAtNKCRQn/ky1xNUUdFUwneW+dIfr9bAH2xxUCF6z5RF8ifvPCrbH1R
    L/znKBgOGB3GSRBOkTuGlr/spOKeDqOVrHszuxkWKzkTC8kpj4guIspk8zgCFKJU
    Q7lBL9kNWaBQAwRXOHXxLp+Y8er42un9HSXo/iF3ztFL3P6cE+8YtifM6tZc7Qu0
    9LeInHXhPmDPOYFtABH/t0cjkMt60ySHQNdeW1NpcUePzU8Fq9XbruwXCgFiXf+b
    w7uGGNJg2i5ti+XIDiCdeNNq9xqFrfu7Vz4vbqRCoGkw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Y1gSA1U4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bnKMqNsG;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Y1gSA1U4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bnKMqNsG;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeCURrO (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 13:47:14 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43726 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbeCURrN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Mar 2018 13:47:13 -0400
X-Google-Smtp-Source: AG47ELsFPSBZ++r8FsFxOEjpI+mPcD3TXVLyr5J8zR2l00KtWiY3uuhakuK2cj13DtPGAG9hd/tf+g==
Date: Wed, 21 Mar 2018 10:47:11 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/68] 3.18.101-stable review
Message-ID: <20180321174711.GC6008@roeck-us.net>
References: <20180319171827.899658615@linuxfoundation.org>
 <20180321110405.GD24810@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321110405.GD24810@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 12:04:05PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Mar 19, 2018 at 07:05:38PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 3.18.101 release.
> > There are 68 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Mar 21 17:17:59 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.101-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
> > and the diffstat can be found below.
> 
> -rc2 is out to fix a build problem with -rc1:
>  	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.101-rc2.gz
> 

For v3.18.100-67-g5a9e460:

Build results:
	total: 137 pass: 137 fail: 0
Qemu test results:
	total: 119 pass: 117 fail: 2
Failed tests: 
	powerpc:mpc8544ds:mpc85xx_defconfig 
	powerpc:mpc8544ds:mpc85xx_smp_defconfig

drivers/mtd/nand/fsl_ifc_nand.c: In function 'fsl_ifc_chip_init':
drivers/mtd/nand/fsl_ifc_nand.c:995:10: error: 'struct fsl_ifc_ctrl' has no member named 'version'
drivers/mtd/nand/fsl_ifc_nand.c:995:23: error: 'FSL_IFC_VERSION_2_0_0' undeclared

Guenter
