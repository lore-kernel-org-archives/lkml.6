Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3830203-1521630252-2-11231197946069328815
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
    t=1521630252; b=FGwVZB9/uJlOFIFhSRVnDSf7Q6O1mAuLRgfzUwBwJEdhZB1
    33m6W0IhWM7nwdYMChN5zqgNbOxBrAyNTBT9aRg9fp5X1pzgqF/os+EG6j9yPDmT
    0HYOoi02IAwRsIGp89Unz04zcvKbUZEnkpOgPv0x2xTAhKgw9uf/qZHJyxavIV4w
    +Aa38YyJj1MkHU5qSRug+Ue+eOGqugwF2giAhHzZlQRFc6M9oS8LdD76beK0JLtN
    I6KU7FE7xefaoNudIYN37z26H27tAFOgL2aDO9/YgGkn1rSz6K8+ZlJedDp9Punz
    WmraHvDT9YGTFx7t2MEZt/OmL3gm1IoxBGOlPSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521630252; bh=1YSFC06ZuRVAmnJr3wxLkFi4R8
    D2jQ/hgEsUiI0hDvM=; b=BncxM85P6V3KT3UAfzDl4PbU9KxDto0qEohvwFnqxH
    b57mPQJwgUtO6QGLttVsnbxvg6fLodYdN4RboDUNzd/6nl99U3KUhfeQ2UVF1xRJ
    esQsfHwj9i9rD+zHYoG3KDqWwhwRbfXEI+tlkeT+nzZbJ252QjfEUI5I+ZeR9Jlm
    Zy/nQbEEVbNbgKhcJuN1fH/Iha4E1mlteQ1MrkCmKYQD1ymDUtlQt7/+fsuwZp45
    AqXTWhabv3rQrAujA7jvq6FG2SkI9v4DDGXJ5n6L8gcxiTiT4GQ1G3O+imrUhHmC
    ua1McshSe4RCkRhLaHs9YFMjd83ewNMQqOJXPUAYSWfw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751851AbeCULEJ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 07:04:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41932 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751737AbeCULEJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Mar 2018 07:04:09 -0400
Date: Wed, 21 Mar 2018 12:04:05 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/68] 3.18.101-stable review
Message-ID: <20180321110405.GD24810@kroah.com>
References: <20180319171827.899658615@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 07:05:38PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.101 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 21 17:17:59 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.101-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
> and the diffstat can be found below.

-rc2 is out to fix a build problem with -rc1:
 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.101-rc2.gz
