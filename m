Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3763980-1521493071-2-2341658817541026091
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521493070; b=T2GDT4dAASJ+ATERUesCtzTsjyAUu/gLwTmgHEL8ZbGhhQz
    0j4iG83xoALvzcsxvCqkSt52Eh9S61qqnjbEqPmAQ3KJksBKvgBB6YUKfhxy0vt3
    nHWfcaZgcxBrWLrcoaCGA78YxB9QqcsrPuhM0+IXa697EKT4aKKMHJRb2FLCsZLj
    /MVv638SE2CKS7x1IALKM64t9tGrFZPueAQB20WngHkTdeVUmvKe2q3s71Ugk7ar
    uJyjbGvjCNIqUWG23FM8j4scKHz9VNLNDpeHysqHfVS9tpe1nBzSdx763n+5McAN
    2mwxm1fvdSu+5zXqchtpWRZAPE/4MpBr/sGH/hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521493070; bh=CP7OnBsqaF7musx2QyGa3qHYp1
    jCra3rcQMyUBTyL3M=; b=GjapPejpXknxGBZhWO7S7pfC5urQZ7BAKhjBVn87zG
    a/Ue9G3o6R+eLoX65A+NXSUP7FJ3xjhuzVNLeDnsYAjHMjlR77MV9q3L1jTrFVEU
    a+z64EwScq69MomMOTrhTobnWJB2/ZIGGE+AB6FUjOY4pImyfsB9/qSBd5ik6TGi
    aAVueuy7spT3srmfYexgo4cMfhinNUVWDZtJvwqWAAHSyVoTxg2aOPdUkf6KcpyF
    474v0de4CVLZy+plOsypRmyM4enIygyuhg6gNKhqdu1wex4Si/IIswCTQbJPLEz+
    Ca8igocjY8FiJmmhkPOUjQlF5+MGwGDzGAdQhlkw5F5A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=tk9sLgvj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujggfshhpjeesthdtredttdervdenucfhrhhomheppfgrthhhrghnucevhhgrnhgtvghllhhorhcuoehnrghtvggthhgrnhgtvghllhhorhesghhmrghilhdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpddvrgdtudemgehfkeemuddtsgemvdegrgehmeemvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeegfedvfeenucevlhhushhtvghrufhiiigvpedt;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GiUA0ooG;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=tk9sLgvj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujggfshhpjeesthdtredttdervdenucfhrhhomheppfgrthhhrghnucevhhgrnhgtvghllhhorhcuoehnrghtvggthhgrnhgtvghllhhorhesghhmrghilhdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpddvrgdtudemgehfkeemuddtsgemvdegrgehmeemvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeegfedvfeenucevlhhushhtvghrufhiiigvpedt;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GiUA0ooG;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968502AbeCSU5P (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 16:57:15 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39522 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968202AbeCSU5J (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 16:57:09 -0400
X-Google-Smtp-Source: AG47ELuVr/kCcbPSGdLh7qBWW7J1ZzhCMAD+KQxq405tQ+WIpWljmY1pEjCCrEC7yXecQNoc/szffA==
Date: Mon, 19 Mar 2018 13:57:05 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 000/134] 4.4.123-stable review
Message-ID: <20180319205705.GA30951@flashbox>
References: <20180319171849.024066323@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 07:04:43PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.123 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 21 17:18:04 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.123-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
>

Merged, compiled, and flashed onto my OnePlus 5.

No initial issues noticed in general usage or dmesg.

Thanks!
Nathan
