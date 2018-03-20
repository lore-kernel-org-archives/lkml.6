Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2173734-1521576762-2-13347425433645000333
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
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
    t=1521576761; b=kRq5+0yH2fowYZluUd5SivRhTPaPbL3h7+TiB9r2YR1GSfZ
    XUanjoDdaUJ2hbZG2J9QELzgKg6pngG+JWxKWt+wBFJD4s6IMJY9EiyAlkgFx4yi
    qAS43Q5iM3mJ8RZIzpH/pZCk03iuhXZThG6NaIvyKt70XPkntu64yBj1qhFh7+qe
    V+ToRG+rAGVxz6ZUsZvuqafb9yBqrqqHutHW5hnq+F9lpaAdtt1UXwEI0VY8RoWv
    YgJ613pVpD64zZcgn+W7y1/q+hoXSE888txU3Ln8qAHRF5haJO98bpHJh3F2Zj/4
    Pq6acuNDFEWkPPNasXO8inLdigzdU/w/3kVFENQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521576761; bh=x+PTfMnuYHlQ6JcxMCVi1xUmUyNmdX2JSpIQT6ktLcQ=; b=o
    1+8asRFxe1tbXP8cG7XEBRdQaegcBXWM1ApcxJEpykb66CTAzwCqvgyvKqMp5Cv8
    uR3TVD6ZGGbppfKnOETyEN3kIq7Hbd86Ahfa/qQLTEovNtPX4/uKkSW1xxwLmv82
    1/FJX7o/zEIZzIBOENntek4/64YW30Wv3rW+VklTWTSvO+Z66rC/hvq5PQ1GmMaX
    2pw7f8aMbnPWPdCj98bV+g0uGPAER59lYEqtSe6lKLDtPvU5MgIxcjewEg2IVG6c
    sgblcwkBpFs4iQXp30/sZ7VZwbgFcCDOK1VTeoOTHEGDxx3c8clj+DW82PsxACkP
    pf2sPBjTHUmVAAhopJE5Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751774AbeCTUMj (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 16:12:39 -0400
Received: from osg.samsung.com ([64.30.133.232]:54779 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751765AbeCTUMg (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 20 Mar 2018 16:12:36 -0400
Subject: Re: [PATCH 4.14 00/41] 4.14.29-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180319180732.195217948@linuxfoundation.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <4cf46668-9c7c-653c-3d2f-36b4c051875b@osg.samsung.com>
Date: Tue, 20 Mar 2018 14:12:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180319180732.195217948@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/19/2018 12:08 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.29 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 21 18:07:09 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.29-rc1.gz
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
