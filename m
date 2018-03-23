Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2180492-1521837938-2-10518273448815535086
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
    t=1521837937; b=QmJoeVG5DRjDHyrticyNILWz9+VVWCSTyj3+8OtTGbpo7JF
    sbmr4Yj5z1/0gHkj5utafpgldJCJ2Zr2qJFAeroI3h5Q+c1gWXWIRvlXVT+icO4g
    XfJQjMLvF1yAMwQ71qUXnePO5K58RDXlTLd665JZE/k+lJ17eilnCyhXz5R04I0s
    KAAGDHf5xy0Jo0JZ9BaEUjh98mTXHyvlL7FEoS8hHmQSUzGYjFfLDneTbYMkET/N
    D9FSZJcuYlc7vu6c08w2DBzlRfkMSRpkxE2rjprIrYYIMwJd4ztxwSm882poQRun
    ziPWCeTftzg9H9shV5b1EwgK4DMxghKehCQ8gBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521837937; bh=UAjAkcJB4cA9rij+1SZ4A+Ux95B896ZtF7njAxTiQOc=; b=A
    At6/vfQGgY3ZRA/Bc8AQiQgtShc2SB5gaTmbfbqKzxZatFinPg4q4TM3B/FdcWG+
    fjXp8o5kypHgKEcpyZa8ewbTpYEYAxAQRlev2NXVvdFRWozROQAoTqpMXbmqK8PE
    EzBeXUD0QD9WCz/o4ClHLF9VZR6ZJUfpJhYgfoXDUhxTirwze+gaEZj8zF7n6b6m
    lUEXMtna87rDkuo0xarQa151t/3jGNaQ9xMP63vquQa7w0EkXPFgLvLnvP+AgIx2
    vawdcT5PegXgB3xJCowVMxB/HnjIHzTw+PinMfR7Socx4nuYjskBkZedvvhKgVpF
    /HHBDPweO1fNQACPN7Hyg==
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
        id S1751853AbeCWUpg (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 16:45:36 -0400
Received: from osg.samsung.com ([64.30.133.232]:36517 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751828AbeCWUpf (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 23 Mar 2018 16:45:35 -0400
Subject: Re: [PATCH 4.9 000/177] 4.9.90-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180323094205.090519271@linuxfoundation.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <82f921fa-be73-54dc-a26b-edf70a88aa74@osg.samsung.com>
Date: Fri, 23 Mar 2018 14:45:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/23/2018 03:52 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.90 release.
> There are 177 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar 25 09:41:28 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.90-rc1.gz
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
