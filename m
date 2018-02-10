Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3376651-1518247379-2-3089654219600973031
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
    t=1518247378; b=EGUk2vWDcpkSyY+7Uo8e1oPznRep0J0NLW54M0VbWD+fwsm
    w/vVxavCC9yGaTqhyDojinDSKsRiRNaovUI2rdIem8kDYQajv0FtuL7J4SBOWbpo
    zKPY+U1mv8skf09Q9qtyOnNZBb/omc/J9yLMEb/uDJkUff+xaFcJTO6ss3NDoIeD
    xmx1rJ/uBYV/l6h8P8I+DSH2TaNWtmJUf4nnULSS0F7c9qB0jCS5V+Vw1K0sKX1E
    Ba83B36qpkRsy6FNlFjd/Ybnro95z7S+uCB/s0xDj3unjbglfgSuNXD9qa8guc0Z
    LQ6N99dsHX40z14w2BAWphPr57rwLEbQk3Tfzqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1518247378; bh=K4OWczU
    iQ/Qg2ipu/W9KO54ZnIfVIDqQsEMdgHMnrG0=; b=Y4PjA/fe9VXMgRzo4ZqbUEX
    uOsVx/sPtnTiSyQ2+hw1gECi1E1sAKh/BWFYeuBHh8ZC4dkEIdNvk3TM9n9ydV1P
    44qqZtYlXIrq5n1pZCTq4xBZLj2ojo8hCB1tMXWmRtoeI5mXRBEW4xwSYhwWfO2F
    6iW1ru1UU2zQOFEeLETNnb/xTbpzWmSRZKyBN2o6T8gjuthUz19sLUt+L/ZYlEN4
    jSwXKhzBibu1oyR+kkCoxiO6iTKyWlGTWg5PBA9PKgAhtcmyAgshQk2bYtkcBqup
    HkewI3iSCbTgC0JQmsD3tIpllytELtdnPkwUusgBhVS7f7dF2xVM/w8LR6u4ccw=
    =
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
        id S1751055AbeBJHWz (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 02:22:55 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:39732 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbeBJHWy (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 02:22:54 -0500
Date: Sat, 10 Feb 2018 08:22:53 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, ben.hutchings@codethink.co.uk,
        shuahkh@osg.samsung.com, lkft-triage@lists.linaro.org,
        patches@kernelci.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.15 00/23] 4.15.3-stable review
Message-ID: <20180210072253.GB8814@kroah.com>
References: <20180209133938.366024920@linuxfoundation.org>
 <20180209204041.vupzthy4cphzem4p@xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180209204041.vupzthy4cphzem4p@xps>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 09, 2018 at 02:40:41PM -0600, Dan Rue wrote:
> On Fri, Feb 09, 2018 at 02:39:58PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.15.3 release.
> > There are 23 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Feb 11 13:39:20 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.3-rc1.gz
> > or in the git tree and branch at:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> > and the diffstat can be found below.
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm and x86_64.
> 
> Since the last RC, we have upgraded LTP from release version 20170929 to
> release version 20180118. The fanotify06 (and "runltp_syscalls")
> regressions listed below are due to a problem in LTP itself (see
> http://lists.linux.it/pipermail/ltp/2018-January/006915.html). We will
> either carry a patch to fix fanotify06, or skip it until the next LTP
> release. You'll see this noise in the other branches as well.

Ah, nice you upgraded LTP, lots of fixes are getting merged into there
lately.

And thanks for testing all of these and letting me know.

greg k-h
