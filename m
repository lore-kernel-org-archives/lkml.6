Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2180492-1521837979-2-12943899181192868118
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
    t=1521837978; b=UEV4w7bQDOjN3LrX4JrMkD0bs0NKCkYXDjj8yBzr+qoGQn5
    HEH4DuskQGDCDi0Co47HOk6wU/jVJZeMBAm+nOBjzZPixgq+0h+QaDEkoA/U1SJM
    RfTGw16ifgMnNoNzhRy60Do9Biyvhun0emR1hoZHZNe2Zr5c2NSO/b+KrV/yhcWE
    w1AtfkE3/MgTcNx+3Ck27QtL1nuCex0buKfpP7TF4cl0hOI6/JyuC1TJFZOX+CQK
    Mt4J1fDlObv9W0+qeG2RjU/GD4cGotpgAvoWSm68ocFKGm5r5OyR9RUBnkpwbxmn
    ayZqcfZcdk8wujr0tES4ldoo2Edk84Isa5lTGJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521837978; bh=M1245JxhoUJqjkLDGSyz4GvkHVTjzGOWKZwaSMn8pwQ=; b=L
    e7ttFBapsvY8VlR9JscBgQ8733lNLgchiw/BYwWvaBRiRFduc7PpgyNiJ9em+Fkc
    UfFlkSYDbDWWVqehpj0nM9sCb0Jb9TsPgaepdBi18DsMGJXm8Nssdm8R9q41kR/Y
    VtpwmNJ0DpA6ZDG36mD2EUseHzeFApHAwKAJzEDUxIItvg+0GnVfjLd1vF+JKylP
    XN0J95FIc/GTQNCQ4wChNf6uPwR+u7x5S3W54JAKh2CMaF2RRukpgge5cox9nHIQ
    zkaP+Atfk/Gl+t6rsFS/DsUZXDNvE9Q28q0gh5Nsy0jKOF4HNEDFc+deZG6gQsxL
    KsFX7xWqdzzG24GFOaP8g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
        id S1751747AbeCWUqQ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 16:46:16 -0400
Received: from osg.samsung.com ([64.30.133.232]:45218 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751632AbeCWUqP (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 23 Mar 2018 16:46:15 -0400
Subject: Re: [PATCH 4.15 00/84] 4.15.13-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180323095411.913234798@linuxfoundation.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <4396b9d6-9e2c-cc33-6419-dc1b41e2448d@osg.samsung.com>
Date: Fri, 23 Mar 2018 14:46:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/23/2018 03:53 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.15.13 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar 25 09:53:34 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.13-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
