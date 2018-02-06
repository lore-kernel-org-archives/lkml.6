Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-900111-1517913229-2-6230593878796230035
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517913228; b=UCGNtCkFh/jpSIQci3UrewmUdedlmStHpqjfSJpvhyvoJrd
    vVE0EJTrxJeuuEOvVZRRD1xD9j+K/5Xj6eKPSWVbcMAQ8lJRVDjaQvFdLVYTTfAY
    DeYDGo3Rh1u7hRGzTgr1055sE8wrTlAXxhvFD46Ow54YkZ8YO0JJK7NBDcdd386x
    lTpcaHIXIUBUvRTT5F0e88pPbEnwsd0/EkDHl/Cy7/SJmSAk4Fx9ZSrs2I8eryAZ
    VDDnPy6zktTJ6pDy9QFdv5XMzxihjqyTzSHViZ9Mblknjd1Mb/iGCbe5iOTJQVHl
    YCB/tPmYg1Oz0HVzc2WAMQnMkxxTMn1V/qG9l/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1517913228; bh=9KeUzD2
    V6aQuSx3Wavygb2BZZ1zFeyAUwPeMsA6vC/0=; b=RQSZ/jfd6at6PTjkkWXysoR
    0/ZIkLm/9Skca6P7Db/yEZyK1q5p8tgPEi4WYwyQ15ZeuJSzX/l/b8FxCO2j/xMt
    nvkKzxOW6QOLJy02rz6OFh7xE7RpQSwX+Qp0kvT0nDP/5IG4YAqJCwcrSwwkeS7N
    jxC0+ENsmedmxR96nZUCvlhpzD5D+2m/jZ4zYcsrdevboE8TuIOkiwnNMuZ5S+T9
    k19whHi11r0n4p+e5eBP4ejWw/pcmbwMP10Ix2O8RYy2x/eoLwmnHyvtRtZUTxGJ
    5G6jnO/OEB8ArJ7vRm4CgMseRwXZDf+tvY1NC8p3PNM49dAmkZm6jXTTy5bTAiQ=
    =
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752524AbeBFKdq (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 05:33:46 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44856 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752187AbeBFKdp (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 05:33:45 -0500
Date: Tue, 6 Feb 2018 02:33:44 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, ben.hutchings@codethink.co.uk,
        shuahkh@osg.samsung.com, lkft-triage@lists.linaro.org,
        patches@kernelci.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.15 00/60] 4.15.2-stable review
Message-ID: <20180206103344.GB10790@kroah.com>
References: <20180205182213.902626065@linuxfoundation.org>
 <20180205235823.vjqdgvwbsdh7olqe@xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180205235823.vjqdgvwbsdh7olqe@xps>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 05, 2018 at 03:58:23PM -0800, Dan Rue wrote:
> On Mon, Feb 05, 2018 at 10:22:33AM -0800, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.15.2 release.
> > There are 60 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Feb  7 18:21:57 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.2-rc1.gz
> > or in the git tree and branch at:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> > and the diffstat can be found below.
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm and x86_64.

Wonderful, thanks for testing these and letting me know.

greg k-h
