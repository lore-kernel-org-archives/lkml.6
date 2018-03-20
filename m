Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2173734-1521576746-2-1664195513989757370
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
    t=1521576745; b=Y+TabmIf5iNRvitQMVq1Gep8Hp/had7/6+VTpVdMKu5XdIf
    xLxOkODQUN3iN+6Ynabm1qoH6NHM6Wd6SR7rxQ7TEIQ1rYBnhRXWDZJrb1KxlsAp
    eNP7dbbBUYOieqkuuAlKqeFN0zmmwEQ7E+hD/xjVrL3FNyc92f9Xj8YBwbXeKSgX
    958MO+j/Ubuvx9CXvxv0M/rJ8+/zzxhsG4t5QAI30QQL/3VtIW4WgnAv++uVF9Wk
    JgXt7ZT0iQeZGeLVfaOKuXf5JxtU1XIgVSm7gbrgTS+Ttmq3UPAkPW6P0VEvSb1O
    M7kRN4/jvbR8OfhsUvxVFSJusZ2fwLxKSnmBvqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521576745; bh=xgowtGO9xlcIzam0bFy+pLNGHY7UoWTo2igCGChwgRs=; b=P
    o1LKW78kjDikzpuomXD09QndwMpA8w1avlnP2C5KI1WfAZyMgGtek68s2jfAy0Ye
    9jSYFITKb1ZF9xETGGxEmW3RWiaMmUgtDl36JxmuWcSoj7g26ufiYUsYShk3SfRr
    JxnKgOIt8H4RgVp8gCj6HpmG2kxaYxAdRLITGvFIzeJj8bBoDt5TghKnsqI8kmeP
    TeQpw1ophIpk+yZ9u3l7lHyHaew8gMJAFeABwwu2cB2aRShJFsBtI6XMUPdSCoz+
    JS24Sp4gUZnm2eqPzKKCQsRo++jabkK5Uq6dNgc1+118g12qOIUTIcooxWYhnuA/
    oPmt7ZHMUmqoB2mYsudww==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
        id S1751550AbeCTUME (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 16:12:04 -0400
Received: from osg.samsung.com ([64.30.133.232]:36698 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751455AbeCTUMD (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 20 Mar 2018 16:12:03 -0400
Subject: Re: [PATCH 4.15 00/52] 4.15.12-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180319180734.976730813@linuxfoundation.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <a5af1d4f-1ad8-4cc9-65ec-a05022a99b7c@osg.samsung.com>
Date: Tue, 20 Mar 2018 14:11:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180319180734.976730813@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/19/2018 12:07 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.15.12 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 21 18:07:15 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.12-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No mdesg regressions.

thanks,
-- Shuah
