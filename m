Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-34232-1519432623-2-5695799628819837144
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519432623; b=IK+bVvsOsA8tZa23mSuW17tIjlSCAiex2qvbmnuFwTAYFJ2
    iLzyaxsjub5jcyPI0vphtaJGbVaS28oaknQZq0l4kL31sCbQ1RXEOTZn0bbt8UIg
    48XPp2G+PbEFO8SHG8GRSpKnbsFHjbnqwqeU7T0e38gJepOmV893l2esoPlprEHO
    8VQTdfWYfvPELhCfgLpBP53DRnoR1nM7eaUkb/krTP4ihP7oVi6KAd4OE0j47E6o
    /ymc6h8a7TxKlX4iXIUiBDQvE56f08kWMCW56PN/Y2M2GpxuNCsuTGCvcciQbAef
    t871QuCtg9R6TTtBaW5jOYIsBdFdrg03glmoxYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519432623; bh=3F54DpRUwHR3fX51jcH1JYYXgM8dknqPQSz7r+bvGnU=; b=Z
    QAT2mEAQxi35pbcVlSSkVa6VDJQQ6xzoN9Z5+oeqS0xeEiipXMRrraekmenUK3S4
    UjW7SbuMOYU0Vc3hGkF8nDgpUst7/Jlt6jlnWfeulpUQ0wacJbX5J98MoWTVLCn6
    iC56uhb2PtxNxvhtOhKW4ivaseuBXt5nA55mMSifL5F6GAX9JRfXKgp0CXZYXdbF
    8cDnGcLY8uBfSvSOOKLQ9dwXzIN+4B4VMEBGB21AbhjVp8oNI1CbzBRWwwYQUM51
    h9CBQP3+X4YpYH3hcadCGZb3cfgNNYWq0SfwjCWvPdtG50nPqr5jD7u/9yX1avnp
    D+XYqNYlxdVRmfUtaBeaw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752245AbeBXAhC (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 19:37:02 -0500
Received: from osg.samsung.com ([64.30.133.232]:48591 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751578AbeBXAhB (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 23 Feb 2018 19:37:01 -0500
Subject: Re: [PATCH 4.14 000/159] 4.14.22-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180223170743.086611315@linuxfoundation.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <9daaabd6-da2e-897a-d330-6eb0dc84dc00@osg.samsung.com>
Date: Fri, 23 Feb 2018 17:36:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/23/2018 11:25 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.22 release.
> There are 159 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Feb 25 17:06:38 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.22-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
