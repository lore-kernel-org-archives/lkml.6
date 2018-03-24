Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3414317-1521877644-2-2546565575765514914
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
    t=1521877643; b=o0at27G+DDgmxTRkQvmTrhnXEe3VFtfBfWAGor7dRVeJ4+f
    luMoUfeX1AseE1OG63k8uCsO5uBlmO97MEU01xHtZC2mJJ5SCa2Q22uETl4/prLq
    2jEOhoMJp3h+KB2zljWR7W3xGNgWNdqrcluO60xVgFDUgzICK9bowtf/X7vNDLGG
    BkvhfaZiUkqaisSdv/mc3Y/jzi+L+/CfttKmwcgTkSlif8Zx9nD0fc/ROBKZ+Wfw
    Hehnv6b+HV8VuTg92oXxrzZPGd8WOLh0jeKajWeGlaXZSjydOYS2/okKzd3ysAds
    svukWSrKY3vWGb/G1zkEw4glUTAkpFVHaoI/hLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521877643; bh=iynxDsOwROxImmnXSnzJyb9jGi
    lb/q3pksFHbdk8AmM=; b=qR2wAcAB6x5GCPK2pf86nmtoBjNfcqRhgWlCKNrxtO
    9JamdvJSM7ToJFuCEXkkPNnxrpFDk6LhMLiYs5cF1+b9aykvhwKIz+Yw6LW2fOgj
    CwoMd2cLoVtGBjk5xpYQGxWDi9hZTEMXRYcxw9EkBg0sgjwBgm+nY62aeQPHPlML
    KZZgWy78YlhTMu8aD/vPwG/YXdEsYhTrliiBMkuRhP/pLbYkV7P7lkitgbT4/YZB
    yzWcMb/eZVN08YZcoTqg4XquzzAvkx0m/uuE3CpwBSNIykcE0d3hGDfNdTuLAWfV
    OdqQ0MOLAMmjq6A7VyKqFfyujmrQuN2Ez+YEufWGwlVA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
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
        id S1751980AbeCXHrP (ORCPT <rfc822;greg@kroah.com>);
        Sat, 24 Mar 2018 03:47:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54902 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751976AbeCXHrN (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 24 Mar 2018 03:47:13 -0400
Date: Sat, 24 Mar 2018 08:47:09 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.15 00/84] 4.15.13-stable review
Message-ID: <20180324074709.GB27433@kroah.com>
References: <20180323095411.913234798@linuxfoundation.org>
 <260984db-e162-23ee-d848-9208f40b5dee@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <260984db-e162-23ee-d848-9208f40b5dee@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 23, 2018 at 05:12:17PM -0700, Guenter Roeck wrote:
> On 03/23/2018 02:53 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.15.13 release.
> > There are 84 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Mar 25 09:53:34 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> For v4.15.12-84-g85ccdc8:
> 
> Build results:
> 	total: 147 pass: 147 fail: 0
> Qemu test results:
> 	total: 141 pass: 141 fail: 0

Nice, thanks for testing all of these and letting me know.

greg k-h
