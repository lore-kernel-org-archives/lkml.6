Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-617694-1519837045-2-10058131803008366960
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519837045; b=CnzM5J+6bE7nQEPIV49DZ4ZOGo8y9AydVq70PE5lxrSPVyB
    YcxTmWPsgVMgxCXKaiUCDd1tdsHU3dcwF5eNdIMzZFJtXAt65RmZYkpYyaRT9cYp
    zcKXvBS028ajam4nrq9FsD/UIlajKS+E8+2GEUA176D35Tb1h0ODPKO4g3kLbMdS
    eNKurz42fqeCwRk4zkggHKiYX4YOjqETOKkhUktDQBlP103rSf2kkcDxc8bHUXvW
    MjRVrW5eFOh1IAnq7L8BR0wdHVBCyzaRNFkP+rix5N/GeDV08QvQu3tV9WiM6G/Q
    hfAALNT/grMB6AwyUaTbLiNVcaNZOAYVyq8kezA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519837045; bh=KK98U9v8P/Gyp/rUrrD4TC3xuB
    nZRzBWH4wyxbTQOdA=; b=sMlJ3ZfPCCx1TZVeyjtwslDztzQdODf372a42/Tjjd
    mSh6xFeJM+V9t1U0L51X8pQZ0ZuDIJn7JRAVik8j2uF0Xk8e5RM9lWQIxbchNIFB
    fNBEZb35z8zLfMzDHvRqfaRCipnpIlvi2wVDQGYD4LjEfuCYl3t85jkSsmrAovEH
    35M9kGR8BQNd61WW25kSlI+SvnYNZkkBbcMUf1lBeZPMreWE69cUV4c/9uXKAZbQ
    nhardM5gDPJstBmbX3CzTgmN7YNmiEBBtQ//hybkN7kobiYfgaAC5A6S1k/AyMsX
    7hD5kkq1yXOA9lf1oIkOaG5xGwS9GguXSqT+fnelqgJg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=QXcNKERG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DfLGaqgY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=QXcNKERG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DfLGaqgY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932188AbeB1Q5I (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:57:08 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:44978 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932153AbeB1Q5G (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:57:06 -0500
X-Google-Smtp-Source: AH8x2272NECVYiSbDKl4aPZ3P1mGbUJ+e/bTdS3X4/ulkB3LMBvVL0ymg3JKQQkDsNPH+Gd4/G7Wkg==
Date: Wed, 28 Feb 2018 08:57:03 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org
Subject: Re: [PATCH 3.2 000/140] 3.2.100-rc1 review
Message-ID: <20180228165703.GA15218@roeck-us.net>
References: <lsq.1519831221.703311959@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 03:20:21PM +0000, Ben Hutchings wrote:
> This is the start of the stable review cycle for the 3.2.100 release.
> There are 140 patches in this series, which will be posted as responses
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Mar 02 18:00:00 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 86 pass: 86 fail: 0
Qemu test results:
	total: 69 pass: 69 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
