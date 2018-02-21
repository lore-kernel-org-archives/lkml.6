Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2345133-1519244072-2-13231445515467681845
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
    t=1519244072; b=KEH+2cmIVx/pJnRJXhu4hzDMi+JiZ95Em5mOVzfpjoD1aNm
    ElmaKb4kumPEm0JiPTo/ET8qjoi6bDZCwFrlJx/LQkiCk9TmhFjDVCIPNcVz37k7
    dNg0sZYZK1IpZxMs3ShxQHS4lTNhwbSOMkvsqrHKDUw0wiGsWYi5lScAAZmxwxqV
    PRnNFuezUGE8Nk1eLPETHFb1JP9JpZOY7ZG6eBjHnwBq7S71jTXn+faQ3Pxv59Gq
    Td9QTAWexiR+/qOptOPOetpJDZh6L58mWA0PPFRXrpx19lOA/6mvKWZlMD4kcYZF
    yVufkcahbtjBC4bUUdEQKX4duxc9283PEvv3LSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519244072; bh=mHrsKCGD7p06eqaSFJMW1ZQIFqhCmLNAK+6zFYbJqLw=; b=E
    FaOoPcu6jPbrfpu56Wb6Nz79TmZ9yww/mSfdXknGHJbQS4nMqS0rwUVl7JCspKZR
    3m/lpsZN+oflq/uEy+xbKOQYkzP8DbMPo+5J+HdOqMvQH1GGMyjTQWRxSYA20IIm
    Q1KY/wMMX3o8aq67NGncuiD9rgoxCSIyxhY6+0CnhOOQOpLfR/SysnTW4w72fmUa
    KQ+IPZHKK8PF4ivPk1BP0J3aiqb/Gq84uvS7IzBBl33/w8ST/gSZpqchJm8UU4WG
    XQN9+QMDcAn8/f5Dxw9acX2PH407p/BYduebxWnhPrl/OAkS3sy3DVaFG5tv6JkY
    yoAwlJ5EeULZfK65k6flg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750786AbeBUUO3 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 15:14:29 -0500
Received: from osg.samsung.com ([64.30.133.232]:45142 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750716AbeBUUO3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 21 Feb 2018 15:14:29 -0500
Subject: Re: [PATCH 4.9 00/77] 4.9.83-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180221124432.172390020@linuxfoundation.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <4ee87b75-22d4-227f-0baa-ff128c69379f@osg.samsung.com>
Date: Wed, 21 Feb 2018 13:14:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 05:48 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.83 release.
> There are 77 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Feb 23 12:44:14 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.83-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
