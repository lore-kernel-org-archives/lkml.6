Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3662072-1519552715-2-18217096797682273812
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519552714; b=G18B6cQq+nucGZ2NCX5Xko/ZAO3t0aokG4FsRvf9E/gOIbi
    RN1krUshwe0+Dci52BoZKydT5tXOBVUQAowhr/ypwluVA26TxVW+V0YUsYZTkKeQ
    E8N1qsmPL3vurWBaF/GbDGTmJXCQ+SwJRwk8y3RKFNwA31WpCbswEfNkng8p2wi8
    MP0hJMttZLYSEVPc3Pa53BysRqIjrilg9Q7M4eTMInmzxnJxgxniN6RpODQBHi50
    Z5N/1lwxFc+IwqXTl3N0sQUVsCMLJIHdLb8UHXpXJz2NYXFMFnaWn8wgUC8fFgmr
    f+Nq/JaTb6oPsrlKOHkiLkIgpCAS9NUfWVJ43mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1519552714; bh=SXBgkWB
    Hf45iIhu62wD0JWQgikvK24wj3KmpwLwnI9o=; b=PHYzVOY8a08EZEAWGHPheHY
    737rV9pnVwbaUJ/LfBaqLMrVtbfbtDE0Cza9Szyk/rO9CVRd0tjFvC22V8yj5yy3
    MRKA2CnOHfYJ7uAzc+g0cdk2Jz/scHc5sfnX1K6JgkLdW1bzNCTk9IaNdBYIaUlN
    MrZxRYet+U2IT0QomWnH0gVPNF9iHIOOR7bWpjcZqPUco79RgcJ2qe+WtiQ4raJX
    YHSZaDtpGtjrjHSdw8cBKC+pGHdCihah3Ll65n7Rf3nnLIeyNXLRSjgYXYBXosBh
    Q8Msj65ltRn/ftCT7Vy8fgnhLswmBwb5AGChZ3FUp/U/5zS0jtpN175qbMn48rA=
    =
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751557AbeBYJ6b (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Feb 2018 04:58:31 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50534 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751545AbeBYJ6a (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 25 Feb 2018 04:58:30 -0500
Date: Sun, 25 Feb 2018 10:58:28 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.15 00/45] 4.15.6-stable review
Message-ID: <20180225095828.GA26428@kroah.com>
References: <20180223170715.197760019@linuxfoundation.org>
 <20180225033736.pjiclhjqwmrcxyfd@xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180225033736.pjiclhjqwmrcxyfd@xps>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 24, 2018 at 09:37:36PM -0600, Dan Rue wrote:
> On Fri, Feb 23, 2018 at 07:28:39PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.15.6 release.
> > There are 45 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Feb 25 17:06:43 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.6-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> > and the diffstat can be found below.
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm and x86_64.

Great, thanks for testing all of these and letting me know.

greg k-h
