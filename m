Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3830203-1521630475-2-6298594900230157031
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
    t=1521630474; b=OtM2hxUS6ub3xvcBvOZEZX8nXclNhWnJInRiCnNufSuW72a
    lNDMFkHHmWWiYk5G+hr3GEQcAJDsid2oHtcVJM/1wkv8FkLqoxRJMSpmuqRLFeXb
    pcVWd6fn9a9KnG4H0KsBiFpp5svdeY0CFWKraQwecTVXQeo+bMKMUobfjWGsbtji
    k+jdWHVfXaydQJdiSmhyJA+3F3SGMmYEIBY8xbR94PMwNaYD+wwae4O5hiZTCixf
    hQaAPs7MwEermXl31FTTtzR1nNwqVb3tE2jHhpq6uY8RHcfhloBYHBngy2CNUQs/
    BhrL+wMD5FEpJZXWLVldwvlJJlVX1cHhf+neEBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521630474; bh=hS50Nq31qFfJhT9OD/kLlys5QA
    0YvMVHHLZ09s++JWY=; b=UP5zyIChJG5RqbHvwgNszLnfsF7FKO4CIvDTNLmGlu
    xF19D52CnKxcKK3t1665tAFC6gWMTdqYZ5dRP6hOSY+jgv3u6p5p17Ak6zucWkZ9
    UAA/O48UFdKA3HgggEAdekFUVOOkioJrGH5yiQtcrLh7kCsVvMLqNSMVhTi7Ku/e
    FR3nHHhI5FX7IqDTpS6+tKMp5jqSeQ0/UKs8QvbNGenyhLgbDC8stOuMIQy1yyAG
    uHEw4TtcZjKGFskw0C38LBdvoQe6tk8XmAqPVDxG+khDhWM5ldpdXidwaf7o8EG5
    4yeLa+oSnUT2VR6UmycElx/YXob7ge5TpOFhA5Cx6gsA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
        id S1751477AbeCULHw (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 07:07:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42478 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751411AbeCULHv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Mar 2018 07:07:51 -0400
Date: Wed, 21 Mar 2018 12:07:49 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.15 00/52] 4.15.12-stable review
Message-ID: <20180321110749.GA6889@kroah.com>
References: <20180319180734.976730813@linuxfoundation.org>
 <20180320122428.GA3632@calabresa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320122428.GA3632@calabresa>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 09:24:29AM -0300, Thadeu Lima de Souza Cascardo wrote:
> On Mon, Mar 19, 2018 at 07:07:58PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.15.12 release.
> > There are 52 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Mar 21 18:07:15 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.12-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Merged with Ubuntu bionic changes, build successfully on amd64, i386, ppc64el,
> arm64, armhf and s390x.
> 
> Boot tested on ppc64el virtual machine and amd64 Thinkpad X200.

Wonderful, thanks for testing this and letting me know.

greg k-h
