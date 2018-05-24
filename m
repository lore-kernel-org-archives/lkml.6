Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2090925-1527173083-2-1630185789623854625
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527173083; b=ZqzY0wB32NaoEnZZRwGPHoI3BiALBWoAElgdRe8w953eJJ8qS2
    5/NCrD0NCNpCeKMUCPwnz1QnlN0eQb+p2UySe64I5ZJEyjoPXCPLz/UJGpFhRLSY
    9Du8nQBEZ2Oz9Dvu/zauLPCY2C0/LJhnzmbrKOb1F6Nl0CEJ2RrmzLSoJHWr05wh
    Y2PgjFKGKD9y/XWdoEqktJ6HvdBQ4LbWdPZvw2BtuyNfhVq4GZpGlapx3Bvi8Et3
    o2qSRmQqx29HTzznK2qc4ExSb5Rb/I9HqDbzQAYQ853T0I7EABl8ZgCQGXb/aG9L
    5lqdumt8uLhNNxBHX9GNiKSYfpLOyWjF4kuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527173083; bh=hCG3Ya83EoyRDYavNFwdmAUh0I62OV
    DF1QU8MOBKKMc=; b=X+gLN9mFy9B3n9cv4MCupgyK4pID3UzHGcnmwoqvDbnvX6
    FE/o3BSS9iI5XZwpYv/XIQ8EGUxtttGxocnLyZN/dno7ysF0VozyqPUQS6VVlQiB
    PIYM7uFAyXr3vG4tvKxEkm/tREZz2LV1CQp6F2AeFMD5xt3LzigplAYfr0oqMZCd
    RQpGRGSN2JEYb7SGYd3Suthb1WTswMpJlOVwnyI6ukm3HNKUbY27OMcJ1GXUk6VE
    qc39Dol6vTtndQQ0NEdxNugAAm6bFeP15VbDrQWyHrbIjObIEBSoPG1KYt4gd8PK
    i5u51newWOktrZvnt4CoY6P+PbLv5FdviXHGRHjw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=FwgnccKx x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=GJSasjHL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=FwgnccKx x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=GJSasjHL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEA0Y0w8eXE7OjEvxCrUbPu00nzIZfbmIokYnrWk0SDMMaHyAx5wOD6v3l+jgpdyhrcnLvFMIBUJ0ZTj6Skb54AV/eETh+6uSgKoc5ikQd4gJ1tI/pXi
    STNRrjOlaV33aayxsUTggns3XRU1R2Smaihu6Re6HOrNAgA8vcVd2skuPNg1tYsWnoh6IC6ED5B2W72ghtKpvlym13uROtumh/bCJEVMPx2UHZd8DwKq7NIC
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=TpujumX0jH7REod0KhDaHZOp9kI=:19
    a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=vY_346TuTMEA:10 a=zhKW8NK6TxkA:10
    a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=sPiy1xkkMUnSoSMqoVQA:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970477AbeEXOom (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 10:44:42 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54614 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966153AbeEXOol (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 May 2018 10:44:41 -0400
X-Google-Smtp-Source: AB8JxZqEkgfWuf+kX+aEsIA+RBRq0NQP9XA0ISZJD89wsdYoVcuDWA9JDWul/tAhxqMm9KsfiuQXlA==
Date: Thu, 24 May 2018 07:45:17 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/92] 4.4.133-stable review
Message-ID: <20180524144517.GB9229@flashbox>
References: <20180524093159.286472249@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 24, 2018 at 11:37:37AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.133 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat May 26 09:31:28 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.133-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed onto my Pixel 2 XL and
OnePlus 5.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan
