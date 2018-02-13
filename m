Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3813382-1518514636-2-14725207404296453974
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518514636; b=wRLZHw6hohv3ShhDpo4uRiWe04sUrawezLyWVKQG5lO9c61
    rVdGPgtB0w2sJLTkS3zUlPdF3mgIlUQO2eZlsLsYiEnx/foV8f6SAWVkKe2RyILg
    f7N54hiKWuEEgRW90se/rhS77eZsLjwSY0JsFfFTsYHYKtXWy/NMclJYdxvr0oUG
    l80hrqwBV2JAa3vCK8b4I26Cd+W+ggBphhxJiisIISdoDDVTLaq0LxdiniOJBfQw
    gkvCNnoauaU5eeKuLWzEGZL16wp//vyVz05pERpuMVcF2e8Z+nI/hJdGK0RvcM2i
    SwBnfVmEbdCSPNcbt8OUcw1qkOMuU+Ga4ElwjWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518514636; bh=jILnlYkLuocOk+Q2yNVCTbMRkK
    4rQ++JYJejCLofBIY=; b=QDpSE0Rvmnpv704ilVJG7ybrOj5Ji920Q/JFyudLRc
    1UA37C0Y1P6GAgGYXt+bYzaN3IFMNESfl2rVZ1h2HynTlXr0VHP48HWPCNAgYJ7v
    UUgMYb9ygNxe6uuu/e5PzjLj4u3L8bDAkrcW8t57MKO9vs0+9Fu5Q0KnkwD4Id4m
    UiL088wG0xqSL9hY4EQqZKz+fmCdtX2Hoxt9uMKDb6MsILVIcAuw0ZAnOY/NNGG8
    +eoHZdQ8a0LpCKY9e/nUCxMPDLm8AvkuP59alfPMidoKYh5hm85Yd8ysh7WRf36G
    ofGpSijyWQO10BsCXEnF/q3pfAIETod8q8c0h4w6dEzg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933805AbeBMJg4 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 04:36:56 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:55900 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933494AbeBMJgy (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Feb 2018 04:36:54 -0500
Date: Tue, 13 Feb 2018 10:36:51 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/92] 4.9.81-stable review
Message-ID: <20180213093651.GA29675@kroah.com>
References: <20180209133931.211869118@linuxfoundation.org>
 <556ea00b-e265-7f14-395c-c5e6629bf194@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <556ea00b-e265-7f14-395c-c5e6629bf194@roeck-us.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 10, 2018 at 07:46:50AM -0800, Guenter Roeck wrote:
> On 02/09/2018 05:38 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.9.81 release.
> > There are 92 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Feb 11 13:39:04 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 145 pass: 140 fail: 5
> Failed builds:
> 	powerpc:defconfig
> 	powerpc:allmodconfig
> 	powerpc:ppc64e_defconfig
> 	powerpc:cell_defconfig
> 	powerpc:maple_defconfig
> Qemu test results:
> 	total: 118 pass: 113 fail: 5
> Failed tests:
> 	powerpc:mac99:ppc64_book3s_defconfig:nosmp
> 	powerpc:mac99:ppc64_book3s_defconfig:smp4
> 	powerpc:pseries:pseries_defconfig
> 	powerpc:mpc8544ds:ppc64_e5500_defconfig:nosmp
> 	powerpc:mpc8544ds:ppc64_e5500_defconfig:smp
> 
> All builds and tests fail with the following error.
> 
> arch/powerpc/kernel/setup_64.c:41:25: fatal error: asm/debugfs.h: No such file or directory
> 
> For older kernels, the backport of 236003e6b5443c4 ("powerpc/64s: Allow control of RFI
> flush via debugfs") should include linux/debugfs.h, not asm/debugfs.h.

Thanks for letting me know, I've now fixed this up.  Will go work on the
4.4 patch as well.

greg k-h
