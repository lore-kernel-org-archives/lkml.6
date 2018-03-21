Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-331223-1521654049-2-9319288117070545088
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
    t=1521654049; b=rT3S7fZQApcjRzE4t3E8GJaquTxdCMbGIry4BEey2am1QME
    8knVl3lUwgz8A+pm/yo4nFRGxLVhxSr+a5tlwe9uKvGxLoPLHkTHF37oL+8iGdvf
    Vd5dtpYugXRi9Fw5aoVFlUGCTEtj2p9LdhRL8B7kBCMz+uU3X12NQqLD8H/Tbv9L
    /v3ulYPC+Iy7CG1jI5taMOYrf24Q60+Ao68Qx4T9usWSAw80LueroWKKG4TEE6Q5
    Q5X4pxI1i0G0YjQHWkeXqgDiy9TdLcYeuF3bNex8KuqqP2+qm9sUvbAG3TdoVjeh
    TJbMBoGmy/iNXkKdmAJG4hBQ9JPlrycsuaRreHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521654049; bh=K4BLdf5yUTy9w2MEfhf08MI27s
    s0tdhWbMZz9q3Tjis=; b=MrI6gIdvemvtw0b1m9zDJ6q0UiNk/323FBzyXYB5Qg
    C9U3bEMI+xvVWc6kyvTR748i77fKc/E2N8JVshdfkf/Dsz/LI3xK/NZZwOFAFw7c
    tet3plRGC14yDBn1dJ/Itvs0KkhuEc6ZXb4sk7LI4KuYGLLYzYs7ieB95gF7XD1d
    jmLpz/TqEaookV25va731iU5V5p69l/hOHKlRVyetD4laok26yUUbaPB/vNN8mW3
    zEiAYMzbzYt4/pKdKFt96SZEtYHfkvra5xagSdHqx8bR2di/y1bMA30qbw+nQGil
    sVtVJNntDk7npA0y7sLRmERUpVePNM7+L9sNoeFSUtwA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=IsPG4cIc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VrXQbRaM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=IsPG4cIc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VrXQbRaM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751996AbeCURkq (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 13:40:46 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38372 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751877AbeCURkp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Mar 2018 13:40:45 -0400
X-Google-Smtp-Source: AG47ELv+rjn+qHb48JwitlSbDD9TgrtNXzMAH1NJhAzFfVIGX/Itp3wGXJXZWLxAcukUUpqncjPX2w==
Date: Wed, 21 Mar 2018 10:40:43 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 000/134] 4.4.123-stable review
Message-ID: <20180321174043.GB6008@roeck-us.net>
References: <20180319171849.024066323@linuxfoundation.org>
 <20180320075012.GB10034@kroah.com>
 <20180321131843.GA27151@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321131843.GA27151@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 02:18:43PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Mar 20, 2018 at 08:50:12AM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Mar 19, 2018 at 07:04:43PM +0100, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.4.123 release.
> > > There are 134 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Wed Mar 21 17:18:04 UTC 2018.
> > > Anything received after that time might be too late.
> > > 
> > > The whole patch series can be found in one patch at:
> > > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.123-rc1.gz
> > > or in the git tree and branch at:
> > > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> > > and the diffstat can be found below.
> > 
> > -rc2 is out to fix a build error that was in -rc1:
> >  	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.123-rc2.gz
> 
> And now -rc3 is out to hopefully resolve the last of the reported
> problems:
> 
>   	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.123-rc3.gz
> 

Almost. For 4.4.122-132-g78a7af7:

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 127 pass: 125 fail: 2
Failed tests: 
	powerpc:mpc8544ds:mpc85xx_defconfig 
	powerpc:mpc8544ds:mpc85xx_smp_defconfig

Error log:
drivers/mtd/nand/fsl_ifc_nand.c: In function 'fsl_ifc_chip_init':
drivers/mtd/nand/fsl_ifc_nand.c:995:23: error: 'FSL_IFC_VERSION_2_0_0' undeclared

Most likely commit 2a39eeb6949c ("mtd: nand: ifc: update bufnum mask for ver >=
2.0.0") doesn't really apply to v4.4 and older kernels.

Guenter
