Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2147157-1519756348-2-16529518269711354915
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519756348; b=iqj3msXM05E61zFt/r7QaMpy41Ea0AEQUAtPsZGzt8MuTCU
    27Nzhyul5B7MmrH+ZzR5kFIbS+7O5pDVuY0tmGSfvUEhBSJnTVpz1jSD/xbh3gme
    Na1S8kn01p+b00Xnb0T/USawes6m2sGcHP4VV13jUKBqskx7HrrWp7ZklHdyX1lt
    oLP9KEn0Do1y98viqAObfwLnF4cXpSK6xhomWnX+ejpPmEgEfei3paYZPNswNY+U
    B5/uskSguAD6t1KArwNx+fUd0UWYGogPLrsvD/x9/Z4k+EGN/Db4IJ1RsjiFN1FH
    CWPKGPPog9Hc0SMutRMYRvs8UWWbzSsXoBpsM8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519756348; bh=+7ES092bzEkjk2MOzQphuYkISR
    mckSh+zIvz92OJ920=; b=t60Hmo2CMN9sFxgINGcR59zPWCQVYhN+2ZOuLchRzm
    7AY30DFehr4c+lzkkI6llz/xGNF2rJTlHpAZ69EnZ5Myaw+mTPNxsAM75471kd0j
    JUq7xoyDXhn2wx7pUMUlkS16qnqrytSULLCZoQeWt3RWJXDJOh4NUzXSb891AWKe
    6wKBYyqTYHo2gsLkufYdgVGxNfef2syazkbVvAIp+Km5Zoep3EptrMHRij17mp6I
    MhZtHYptD7/wypOmlihzJMsrRmH5CbJIX2ssgWEpOuiFYAv82VTkXQWFr18iYJPb
    n1lJgST9r6MleQejD3zlBpz0Bk4SatVJAypO9TQPsTIA==
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
        id S1751126AbeB0Sc1 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 13:32:27 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:56688 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbeB0Sc0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 13:32:26 -0500
Date: Tue, 27 Feb 2018 19:32:27 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/13] 3.18.97-stable review
Message-ID: <20180227183227.GC20601@kroah.com>
References: <20180226201527.242286068@linuxfoundation.org>
 <7030ade6-fdec-1f4c-99dd-4d743720b085@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7030ade6-fdec-1f4c-99dd-4d743720b085@roeck-us.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 06:53:58AM -0800, Guenter Roeck wrote:
> On 02/26/2018 12:15 PM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 3.18.97 release.
> > There are 13 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Feb 28 20:15:12 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 136 pass: 135 fail: 1
> Failed builds:
> 	xtensa:allmodconfig
> Qemu test results:
> 	total: 112 pass: 108 fail: 4
> Failed tests:
> 	xtensa:dc232b:lx60:generic_kc705_defconfig
> 	xtensa:dc232b:kc705:generic_kc705_defconfig
> 	xtensa:dc233c:ml605:generic_kc705_defconfig
> 	xtensa:dc233c:kc705:generic_kc705_defconfig
> 
> Presumably the xtensa patch does not apply to this kernel.
> 
> Details are available at http://kerneltests.org/builders.

xtensa patch is now dropped, thanks.

greg k-h
