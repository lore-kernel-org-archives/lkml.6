Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-874968-1517912846-2-11095253230725816800
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517912845; b=apFk8FZehjSFDfQhrP5/ud3ZL+Px5JG0KozBtrkHSHKxgrh
    3QsEMI+6NOQsVjJ/dLXjhcqn8fctFAsCyvzp1uUGdiUNwlo+8qvgD3HpyFXLz/bx
    9ZrSbdP8BNIDuwKojc6qW0fc1/XAZSejyqwBXjJuPb8Wuvf+7ts8tf/lcZ7M7cYz
    FaMZYIighAq2FI5HwIomvDiqC5AYxQQjskMvLQCT4Z4fCdeHKuHzQ3of3HTEXfzR
    x/vqM7tnLmC6NRzxNi5trefFFOsqtYhMH+VptuMBQivW6Mliy57rPOK0hJ0rg4es
    ZgCoqKXaprNTfsuN6S/2Xaji5WTDMid2EfOA0/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517912845; bh=ZqT7hU3gAWIseys8wW43hN6eOp
    PhspfhkKUjBVlC5AQ=; b=e60xOo31an3les+aUhJuq/g4n789W5jPASOpAcuz5R
    ZNaMYKT0o+3R+YtTVj2Y9VEGXjOB8MT8r35qlaNYC3qmvQmG8jyZYvwiGixG/GK4
    2jQJUyLUYhS8qP1ZQGBnGESg8Mg+yWKvWVV9oRG/Q3QFDrzNFTjgPa9x32h3mcX2
    ug5XKnXEIdya5v2giIFxjq1gNa0f80VQ9eoXT5tZkK3OCc+zba8Vz5pn4u/H5f3l
    gZ+J5tb3lRJLjBA4FIM+Z+SsmkVrXpZThwAh/Wre54O7RyecFNl/sLbWS268Gf1p
    ZcQ+LuCnAe/TMc5F1wMudhKdXYqMbzafTKR56G/DwBaw==
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
        id S1752246AbeBFK1Y (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 05:27:24 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:42604 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752183AbeBFK1Y (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 05:27:24 -0500
Date: Tue, 6 Feb 2018 02:27:22 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/36] 3.18.94-stable review
Message-ID: <20180206102722.GD7889@kroah.com>
References: <20180205182351.774761393@linuxfoundation.org>
 <20180205213544.GA28867@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205213544.GA28867@roeck-us.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 05, 2018 at 01:35:44PM -0800, Guenter Roeck wrote:
> On Mon, Feb 05, 2018 at 10:23:28AM -0800, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 3.18.94 release.
> > There are 36 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Feb  7 18:23:41 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> You'll also need upstream commit 0b5aedfe0e66 ("um: Fix out-of-tree build") to
> fix out-of-tree builds for um.

Ah crap, I knew there was a reason I didn't do a 3.18.y release last
cycle, and it was because I needed to fix up the um build :(

I'll go queue up this patch now, thanks for letting me know.

greg k-h
