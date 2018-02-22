Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3826835-1519287080-2-14498315337721486895
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
    t=1519287079; b=Y0bCrgjZewA1Gkfaq7A3oHZfhFmSNDKylIh9YGCbpV0zZAu
    b7FA38JTJ+LypXInVKAUd1fqqBkp5pUg0+Ewl1Q5FJTtcnacg9gZkWUcD0a+i/08
    MRTPlagnGDkHZ0THAE7nLngS+2cvoZxAhd3hSxPYpIYsh3oWE9aICW12pEisrTxH
    /85a/Crj9M/C6HzAQu5NsuD15LGju/qknqBQhAvymC3sE10pHwCSTH7horFs5Bc4
    Zf1ezM4u03APdREOLwdhXhhZJX6YAI6uTblWNTJjGoxTUuAtxoRL7zq52Qi6adny
    eyTHQsQ01ccACzp3PqDy07LjxCRC5Wotr6bkhUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1519287079; bh=iVzyKbL
    jqMIu4zEF0Ogfwd8PRhUEF2LRNVMlkxcW3XE=; b=n9UX+Mp8MzsjEDnIKI/fGh+
    T5MmZdFNHT75O+iDXSkrlDJOedQFkdU+TSy5ddmGA7093MH/ptUkwpTwZgWLnZRl
    XovsxvqqEEE3YvPDqH9JByvAmDZ5YW5K7kmvUNwH+PPY2W/N+eCrexta+qcgNEvu
    Z/iR99KphdtDNZ9W7QUq7IU3p7FxFJkfAWrjtxpF8Y9BSDIqPX/TpKV2w8npDOoK
    e5KurylzNVqKec8dT057/U4apk4123i55mjik8KCmoJZOfbKWbU7+aowDZ353D9G
    iPecPJpEDtdW22NHlf5lJ+rN8Tsn6dbLPPT4YrzZgBLWdhm4AdcWgOuW6sLifBA=
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
        id S1752679AbeBVILR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 03:11:17 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:52190 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752646AbeBVILQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Feb 2018 03:11:16 -0500
Date: Thu, 22 Feb 2018 09:11:17 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.15 000/163] 4.15.5-stable review
Message-ID: <20180222081117.GC5687@kroah.com>
References: <20180221124529.931834518@linuxfoundation.org>
 <20180221202518.foztizbl2r4kyio7@xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180221202518.foztizbl2r4kyio7@xps>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 02:25:18PM -0600, Dan Rue wrote:
> On Wed, Feb 21, 2018 at 01:47:09PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.15.5 release.
> > There are 163 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri Feb 23 12:44:46 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.5-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> > and the diffstat can be found below.
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm and x86_64.

Wonderful, thanks for testing all of these and letting me know.

greg k-h
