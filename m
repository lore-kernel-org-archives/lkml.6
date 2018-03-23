Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1536617-1521817691-2-112834126980442898
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521817691; b=i+WGC4/yHBaE0fLL5xMrWriTiOOVRSlvRpeHsP8qPaeD4II
    qsQXYcwI6EBgQ+fM5RHv0vVn3a7ZM8JJtBZHjeM7Py9R56L0RUGNZ/uc/Y8Hzl8Z
    tl5tD6dxKxV/5YjsU9jYxuttr2dz4ICoWKzzEOCX12RGDILWpHrUyldU8kb50Yip
    cfw4CceMSm6hu+KhWDylgcPupYrF4Z/fD7xeq958tRaQ6WrrPXd/fcCk6FvBUvaB
    N1Fgy/lcRWr6gODOkfPpMvS0y8VdCq8b6wkhSX5GhALj3dbPfCvhmrwqaUwHsTJp
    RY+36nasdS80btEpWDIRt1SX4gbB33CEGyZWCNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521817691; bh=dnMrVFKk6PbrFWaO311l+MmalO
    Ytpnzk120U8dtvpvE=; b=GWL3BMO0116QUUKmrWcMZaRACzrn+H8wRSzk6q6+Sc
    X6hyD8yCpWewcwWB7FIwwD7AXrLZtskRaI06NvRFzT81jpuoVbyBVz0z88CENh3d
    cL1k+GOoaF7g/mAW+pmUwu18t9Ytu5vABXDoy18O3dnc+/dIEVUtKX98OTX7XxTf
    u9yKo6JZHA3cUSL+H5W633oaFCRMTAFSvOJscnMoF0/UwGQqWV40FOE1tceFQosZ
    u3IO9b4OlXHXvG7kVS0JDyswAlcnAi+v4u6zRzZZ86JvyyuYJ7/iZw1b0xA1j/98
    NnSl+CN4HBhMMEhyO7XgZ8dnYJVcqkoKFbws2QMdOlrA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751531AbeCWPIJ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 11:08:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37208 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751504AbeCWPIJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 11:08:09 -0400
Date: Fri, 23 Mar 2018 16:08:06 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuahkh@osg.samsung.com>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Subject: Re: [PATCH 4.15 00/84] 4.15.13-stable review
Message-ID: <20180323150806.GA6892@kroah.com>
References: <20180323095411.913234798@linuxfoundation.org>
 <CA+G9fYtYBMr84wUTshzryQRLuH5o1u8q71SnKVp_cq0ohofFsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtYBMr84wUTshzryQRLuH5o1u8q71SnKVp_cq0ohofFsg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 23, 2018 at 07:52:45PM +0530, Naresh Kamboju wrote:
> > Richard Leitner <richard.leitner@skidata.com>
> >     net: fec: add phy_reset_after_clk_enable() support
> 
> This fails to build for arm32 with default config on both 4.14 and 4.15
> 
> GCCVERSION ?= "linaro-6.2"
> 
> drivers/net/ethernet/freescale/fec_main.c: In function 'fec_enet_clk_enable':
> drivers/net/ethernet/freescale/fec_main.c:1876:3: error: implicit declaration
> of function phy_reset_after_clk_enable [-Werror=implicit-function-declaration]
>     phy_reset_after_clk_enable(ndev->phydev);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors

Why is 0-day not showing me these errors?  Is it not building arm32
anymore?

Anyway, thanks, let me look into this...

greg k-h
