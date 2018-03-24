Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3642640-1521885914-2-17208436078078214297
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
    t=1521885913; b=hwcB5zJYH4kMusUKWDh0hTkMrRfDAW1CI2uUXeGtsu7JqTb
    XRERm82f39f+tRTCcvo16qNqXyAPBBdhTEObL6y34wCzfa1G6J4yDNryY8v3k9Fn
    aDY01wJUz4cr0AicIDqiO8SyHlWkNe1bpJQ5DKgOsans1euZ4117kKcAcewFgO/Q
    zywtuAXD9vg/qyqawobecGaLkdoEE+fOtwvx8uBRvfkKxjnPHOvMRYUd9TrBgF7Y
    z1q2NLNoew09qN/1AxOzF9gDgEr6MdzGHwNgjGu5TmCz257UM2BhbpyPR+BQQpqA
    r+iSlAU8Qig2Lj51rFUxNE38UDI2qvWpFkHL0sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521885913; bh=dkre5Uq3CXKYyqV3QekViEwJPl
    ExVFIEwpMKlptYA/M=; b=sEy6FZ9OyME1ByAcUvjqLdEdOZrYFfJMC0NmNCnhid
    WprdEWUsP2oyK/54WLyVs1VxVnOf+ZUak4H04yP3/IjAJf6B75SicpaM06ulKsoJ
    9OP6pDweq4vZyf2uk8J5WTmQXeg3O+BEINGEMmnoVot9/qxU7zahaCdJMfahWk9Y
    1VyBa0vIXSMdWBdYU3YLTYMGESkjQtCnM7cuE9Jn7p8yFZEn9fVaG2+1Ek/YZSdn
    srRfB6P9yd19tzL2JmaIfdugH3lpsaeKnGvxwAXVV9bLugTu+77TJ4POKTSm0SWE
    /9ojXNgUwGleRVjnes4c2MkqzpwAEseBJzTVoaRkBsmQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
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
        id S1751853AbeCXKFI (ORCPT <rfc822;greg@kroah.com>);
        Sat, 24 Mar 2018 06:05:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43894 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbeCXKFH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 24 Mar 2018 06:05:07 -0400
Date: Sat, 24 Mar 2018 11:05:04 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harsh Shandilya <msfjarvis@gmail.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/47] 3.18.102-stable review
Message-ID: <20180324100504.GA31016@kroah.com>
References: <20180323094248.117679641@linuxfoundation.org>
 <8B6252C0-646E-498D-A599-13B3A1CF51D9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8B6252C0-646E-498D-A599-13B3A1CF51D9@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 24, 2018 at 03:10:06PM +0530, Harsh Shandilya wrote:
> 
> 
> On 23 March 2018 3:24:51 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >This is the start of the stable review cycle for the 3.18.102 release.
> >There are 47 patches in this series, all will be posted as a response
> >to this one.  If anyone has any issues with these being applied, please
> >let me know.
> >
> >Responses should be made by Sun Mar 25 09:42:36 UTC 2018.
> >Anything received after that time might be too late.
> >
> >The whole patch series can be found in one patch at:
> >	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.102-rc1.gz
> >or in the git tree and branch at:
> >	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> >linux-3.18.y
> >and the diffstat can be found below.
> >
> >thanks,
> >
> >greg k-h
> 
> Builds and boots on the OnePlus3T, no regressions noticed so far. Slight merge issue in GPU drivers due to CAF changes, kernel-common should merge without a problem.

Great, thanks for testing and letting me know.

greg k-h
