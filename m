Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4013316-1526651817-2-8965320569566259374
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526651817; b=jBpLQQdxFWnsLRrkxU/Wgq/mmIF08G3xLIB8Si5T46Yyx39laU
    Lnz7wQF4zJs4XGVjnEHkucK8uh/6uJeBXSTCEnJCWMO95tDWaqYZyBcF+nFW7PFn
    5Xw27/f2vN10W9aEBlQ0hKh7rjmctPWuL0qcWiYaK8RK8w9j9VAK2aTPsRVarv5I
    tBiK9Sncx0gy2lNPb5OkWBQEwbH2wcKygHLmug9LNx1gw9KF9p1pKLSMc+YgbGyc
    Lah+ojzzfgYU/qN5wvMChXywnOBoUuuACmtHaeHDa4j8WA+MCnBiSBqbzlHl61xe
    NHJLbVPyd2JFiShrHr8QYFFhns8MHBta/MkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1526651817; bh=1x15LapIM1d
    FwLh+Fjzg/2ryBbltVMGtBCpUOHjBCGU=; b=lfudqKV0zvl5bWRR9sMYrGKu02M
    hq0sBDF46SOq10rJXDXY2ZBC3/D4dqyHCWqncy3M8LcZ2BZCpWvnNgpMciCyT3Jv
    aROKCR3idkm2K4yZ1I14n0L+Za+DrC9aV3yAB6ADnle/z0mBt1VaCCcOnlzODQVp
    K6O5VpckBflrgRWIzIxNCyozXb4WpRV33uOeeK3GNVmdsxaDWcZ66lV6wO8D733N
    WJ+ULC9HcOj90Ao9mZEcSIYNg8KFd0VNAaX6Bp/CXePRvrt0ez3/5b37Y1UMUmjb
    9TVikG2nIOCE0113tb36baAP6RwPunx7V4EGUMEiFA41EsVapI6y99ajNeA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=0n9lvziE x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=0n9lvziE x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKOPoFXOVwYRQjIT6busw1hZiuDH/sb91DkFfOW85GQTrYLIBHEh0KFYPbxX8cflX4jBywGChIHDVuv1wQYQrK+eZyZAFLfgxafkzKHpIDyzh1P+SMXD
    Mj7jnOtdfp8SnYYDpIO7e2ci03h9DabOZJVw9DllsyWmaCErapeQsO8sXzuMQB6O+gFioKIV4+UZWdBMgN6HObX+H1rMhfyKpdwQPMdGo1gojDu/+IibM4ev
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=cED_tJPvky8A:10
    a=VUJBJC2UJ8kA:10 a=YWtRXzOXAAAA:8 a=2Eb-G1lGI5zEIgYQx4QA:9 a=QEXdDO2ut3YA:10
    a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752646AbeERN4y (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 09:56:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752588AbeERN4s (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 18 May 2018 09:56:48 -0400
Date: Fri, 18 May 2018 15:56:30 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.16 00/55] 4.16.10-stable review
Message-ID: <20180518135630.GG24822@kroah.com>
References: <20180518081457.428920292@linuxfoundation.org>
 <41f4df0b-53b6-cf63-2d01-bae3c9b45c07@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41f4df0b-53b6-cf63-2d01-bae3c9b45c07@roeck-us.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 18, 2018 at 06:29:57AM -0700, Guenter Roeck wrote:
> On 05/18/2018 01:14 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.16.10 release.
> > There are 55 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun May 20 08:14:42 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> For v4.16.9-56-gde63ee0:
> 
> Build results:
> 	total: 143 pass: 142 fail: 1
> Failed builds:
> 	xtensa:allmodconfig
> Qemu test results:
> 	total: 139 pass: 139 fail: 0
> 
> Build failure:
> 
> include/linux/mlx5/driver.h: In function ‘mlx5_get_vector_affinity_hint’:
> include/linux/mlx5/driver.h:1284:13: error: ‘struct irq_desc’ has no member named ‘affinity_hint’
> 
> The build failure is inherited from mainline with 'net/mlx5: Fix
> mlx5_get_vector_affinity function' and affects all non-SMP builds with that
> driver enabled. Still not fixed in mainline.
> 
> Details are available at http://kerneltests.org/builders/.

Wonderful, thanks for testing all 3 of these and letting me know.

Hopefully someday that upstream breakage will get fixed...

greg k-h
