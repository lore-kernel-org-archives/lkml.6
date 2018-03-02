Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2531373-1520026280-2-3210239248352070950
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
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
    t=1520026280; b=GTCZcFhVF0AK5HBR6bSc451+6Wbkaql4tkGJJ2UdCpsyQl7
    /ZeIo9M+TuKQqk6wX+76Y+G6x4ucdqbYTXbx3tV11UyLyxrrU6r1qi06L3ZH6b8z
    6WFhNJV7iRhbwVO7KDWUnUaehcrQiCKIAOs/hLpJcwzaY+ZLaHaVHjZ3IarjhG9i
    2uMh6x9nH5fWPxG88OO3R3H7Wyb26c6opZjKC9eNS7K3hBXmwihVDPCToetL5G2S
    oIExtoNL54jjdP3+80F/dsSf6+M5CHzcQSkr5eWB8sTlEg40Jn1o0XMyAeK0bkhf
    fjCQJi7EGutWO+RmKjSPDmrxSYkSSiMJq2j4FWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520026280; bh=Zr13mSkXM7UTOzeXAQB7vmwPR+SybE7pHgZcwR3BKqY=; b=H
    r3V5RjO49sbJdkvBnkvrQjUV3+FZgUdTUCdbkeFBtzj0OMcFYVZTPRfdsYMT+kjV
    DXUEPGoAPDmsneiVVFuwzQSxDva87K9sB8tUjTkHG/qEouQZV+68gFttil+PtY9e
    jzmX+GWQ0lY1Lq97J4egIMM9I67hEzaQFx88Tcir2Yk2MBR0udrl7D55aujGqYJc
    vCkEpfGq3BjHPe3g66jCOP4UAo/P2oR/mb8aU9s5dcEQtOSvIGwWYXv/9wp4gDKw
    YZKQA4DBiaMc+uFS/AzQUJD9J0t12/o4ItTj6vQtbjoygu1cdxBNbn1qHsPobzix
    VaONN6zEf9WAfewp7TDUw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933945AbeCBVbS (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 16:31:18 -0500
Received: from osg.samsung.com ([64.30.133.232]:37519 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933687AbeCBVbS (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 2 Mar 2018 16:31:18 -0500
Subject: Re: [PATCH 3.18 00/24] 3.18.98-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180302084239.157503766@linuxfoundation.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <fb2df4f7-6e5a-8041-3378-1dc9dd9e0dca@osg.samsung.com>
Date: Fri, 2 Mar 2018 14:31:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302084239.157503766@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/02/2018 01:50 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.98 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar  4 08:42:22 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.98-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
