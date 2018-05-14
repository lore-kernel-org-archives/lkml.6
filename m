Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-460432-1526286543-2-10494025687630384876
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526286542; b=NH1DZlAeES1BCmOdTPCOPHXGh8NhBFiV9+QrjNqfWo8DVW/VLs
    BiKW68xL2mW/inqV3kSWlu3ARJPTQBZeHICKuAec/5NZ4/pl14qZ7NDYM9qsZmah
    4gxHa3mBe5uN6Cvdck1dNn8vpzcPxj085UtiGdvNdRNuCpcI4DGNL+K0Zr6cxNIk
    Ka+HYow8TIy2rmyGLzciqBKpscOCZlAPZrLaDUyBSyaGWG+P5ExR1JP2nB4GZRpj
    pL4u68wIolizrAb05Pis19oAr6uPv8DS0AVupBhhEeb1w7wfM1OnYSRsyxS46Yn6
    dQbOQAHw4EJUlsG13DnZywSw9+ydPP98EUOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526286542; bh=3de0qlDM2aaXVkMUOw3xuFJRtvE5j6
    K7I2BOKXfT46Q=; b=WtV5rkLBa3zh6IsHzof4CYueIN0ssjMoxNPUmXSUN7Z+uc
    TGlHCYYoyknVdafzHOa56FMDUtgKk7EGUekg+TYdoMqjtn0DrRmisGZE8nAGEY/V
    rXn/bshTRcylhQXEomSciLF/YkBdm0KIUABI74WH573sT49ECBiyMHKUf8dkyjd8
    9NqE6BLDDXnZgWBO4QaJ+BzePCCmg9kd98GQqhXenrtISzkgsfmRLk3Iu0oJMgDp
    AC/iU2NrL2ex5yrXZfP6CHBCTDiixOX9MFnuegmWkuSg0SlorOaaXgcJt7XpQeIJ
    MROSs7YkTKQFIgUd5l5qB2W5bnLd42+5gF3L4d1A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=jp1QVp4B x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=JjUDIhrj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=jp1QVp4B x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=JjUDIhrj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIqLmS9G/VGVaLfKHYhvGHJePWagpLhZYiVkdSMI0TiyovVFCFO0VgCgwHZIN9MdDvkOOlvVNC9qcnGwarHrQf5CfyYlkzc+OWsaDMcKIFffcd5Naz+6
    BeVDDcM7/JDNe24YEPxnPDSzFI1cVQ1d3n52jvN2d2UQFJnhbXMP2kdwAH6Drg9PAEBsPkyRJlAqAADDDaztweRE5ZmiuGxQnQ4vLUdQgQp2OCM6xCNzgsbK
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=vY_346TuTMEA:10 a=UNgQRUVOudEA:10 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=N1qFQJjma9AXqH7gfsgA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbeENI2q (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 04:28:46 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41416 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751364AbeENI2p (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 May 2018 04:28:45 -0400
X-Google-Smtp-Source: AB8JxZqpsOQsXvmYFsLAdZUnyNjlfh+frUywmTdquH8o8fJ4Jes4dWHGchD2jrUT2wHfPFbBqg0k8A==
Date: Mon, 14 May 2018 01:28:41 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/62] 4.14.41-stable review
Message-ID: <20180514082841.GB6839@localhost>
References: <20180514064816.436958006@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 08:48:16AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.41 release.
> There are 62 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed May 16 06:47:52 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.41-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled, and installed on to my Raspberry Pi 3.

No initial issues noticed in general usage or dmesg.

Thanks!
Nathan
