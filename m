Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-914709-1526916319-2-8067628077075004351
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526916319; b=WNUegLNcJKg56Ks2+SPxAVYaq/LwVm4WFgHTxomxL0nvDW0m2s
    b0a39Ys2BOMA9m2CS/b9+u5m48YpmhnSt0s8v+DL6/zxqyCWWAB/q7A25i1z9YBH
    DlwpkFTR2+QMub08FXmfzN5/tSJxHaE9w0tRLk+Bh4UQYr0Vm3PeTRcac1Fhx2vL
    Np4D541zoh8SXQoC7Ke9xWhDfoVlca89dMFC1bqtnlnsdnb3sPdSGy2Vet93XVk8
    Ij1p6hkaLjU+HPgBvjdFz32SQIx5IAymgAutFihtV2Xzg4Z8tsMgHugAY2PuZQHL
    bqe1rVpwUxRyqgOu8czd1hgDefmESh8kzPiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526916319; bh=0WVMgrIZ38oRn+x7m8Sd23sr+FHtzf
    9UNn4B0W9HiGA=; b=NMK/3jl46whGdSzXmcWtNXA+MECSGdPFHBv4+5sK7f+J9s
    FhqVmPanMJE+4rhCbrWu7qmEWpSUxnGH2xayq2WYAXkgek+3006XBYeTlVNslru7
    Ud7cRn5185CocVUB8rWDSTZANeEKE5dN7SlF+tXHaO3Bkh5ry8vKyUJp4QpzdHxk
    12v/9Fh3fdQlzaG01rIV8/UkqCFVL0d1y/hsv6RkxuKcako6hUIh9rt23oA9UeFQ
    1ckvQVbM1U2eUhgYOt9l282+6AIfvNv0R5p8ghgMr2mVffF2TSalvUfx9GaUrmu2
    +eqEiv5vFnCAA9VOUpqHVo3fYOpcz5zfc7+0jGmQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=vWGpNtlE x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=HkaiF7/F;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=vWGpNtlE x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=HkaiF7/F;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDy7u/llkZ0yNGSg9cSx3qi+k2SGvJVEZrIWlX9dGpwWvS4PqCY7xNNFjDigHR2LKKsxGJL3YroLnhrnEBga4TPnttJJHU5PTtVWf4e1AXd7ZjLQwVq0
    dAHdItPTNx6j5liY+2ZxhT+DdKpmI5RXvdYYHSZLNdCmxvQ6ou+iAi4gSiPTSBomS2sGVkLH26ub+s/UAmnsvxTtlGQiLuj6Fdy/mJI0DTrOhdd+B5NhmJkq
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8 a=CGns4vzfYPPi7LTlLBoA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752623AbeEUPZQ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 11:25:16 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:38922 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751682AbeEUPZP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 May 2018 11:25:15 -0400
X-Google-Smtp-Source: AB8JxZqJLSaDFMne4CdqLFY52WHinJjI6bMzCZ+BWctGPsCj7b5YLbuxyQtYF1H39w0yeeHLjTEp1g==
Date: Mon, 21 May 2018 08:25:11 -0700
From: Tejun Heo <tj@kernel.org>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH resend] libata: blacklist Micron 500IT SSD with MU01
 firmware
Message-ID: <20180521152511.GL1718769@devbig577.frc2.facebook.com>
References: <20180519212936.3155-1-sudip.mukherjee@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180519212936.3155-1-sudip.mukherjee@codethink.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, May 19, 2018 at 10:29:36PM +0100, Sudip Mukherjee wrote:
> From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> 
> While whitelisting Micron M500DC drives, the tweaked blacklist entry
> enabled queued TRIM from M500IT variants also. But these do not support
> queued TRIM. And while using those SSDs with the latest kernel we have
> seen errors and even the partition table getting corrupted.

Applied to libata/for-4.17-fixes.

Thanks.

-- 
tejun
