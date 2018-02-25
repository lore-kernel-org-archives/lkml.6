Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3662072-1519552746-2-13843838051192874829
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519552745; b=L7HDWXKXGr/KAyUbqufupRTNrOVm12sGcLrFBn1sipJbk6Z
    I+8W6ZFQ6EBbVSsE89EwCl2Va0Kie6Tzh4jEGVeWKEolyHLL2eyhdGrMQNImM4Om
    rotjtH1cKy6SKe++ixODo2q4ZZy6rca0HqNeghS4PAYr1iOkC3rXTlhVE4UlaZR7
    3DRhaDu42eVV7T0QukVRftQOHsw1SnZNRNyF0rgwgr4gPnViW2Vzdw5vBXreUSjy
    s1UqrO2clgZVFByqBmrYT8Pdpi0AfEDkndW0V7C2AedJD2EOPJfCPLVP4HIzxfF5
    4WFmXtDHqhXfoW+tomKPYSeajNHDg2p+1eDS4FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519552745; bh=+Mob3xRNm3BDj9T55ckHZ93Tss
    ufCJ648Xe+PICXHOo=; b=c3kT6vYecY8hnwZYC7+iP+dbujWAMH17xnE3QutFbU
    qh1mSjpUZ5C+QZi4bP8TLNWiMT7RpbIQ+HvDrGK24hz5/wLqZcFK2t2b3LDHVx0o
    KALut72yLC5t9zU2oXRLWCb2lZH3ZazGsjwalwkG933Q93Zz0FnMZAAXUvXKfzQ7
    ZXfsfYm5KEAWH5Qen55kf+OJvWgtW53h7O1tmg0/NUUXPS9Um5oKz7zq6w7OGqQS
    WglC5tWhgeNlPiYB/pL0EsfAmVyqrirwH55FPHS9XS+fIaeWdP5bilUp3udf7ASb
    PW7QyC7To2aLqrHnmnm7mwXCsYmtZGqkTz2nrXaDO1yQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751698AbeBYJ7D (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Feb 2018 04:59:03 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50640 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbeBYJ7C (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 25 Feb 2018 04:59:02 -0500
Date: Sun, 25 Feb 2018 10:59:01 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.15 00/45] 4.15.6-stable review
Message-ID: <20180225095901.GB26428@kroah.com>
References: <20180223170715.197760019@linuxfoundation.org>
 <d751b526-1ce0-8308-3413-8652756a0368@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d751b526-1ce0-8308-3413-8652756a0368@roeck-us.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 24, 2018 at 09:58:58AM -0800, Guenter Roeck wrote:
> On 02/23/2018 10:28 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.15.6 release.
> > There are 45 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Feb 25 17:06:43 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> For v4.15.5-46-g82ca63f:
> 
> Build results:
> 	total: 147 pass: 147 fail: 0
> Qemu test results:
> 	total: 126 pass: 126 fail: 0
> 
> Details are available at http://kerneltests.org/builders.

Wonderful, thanks for testing all of these and letting me know.

greg k-h
