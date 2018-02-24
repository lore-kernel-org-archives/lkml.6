Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-52214-1519432849-2-14374369464917691356
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
    t=1519432849; b=XEuAytuPwc6zxfLhBgNE992RgUCscNye5xcUSyXPdbrRGyr
    BqwnAViuH0NfG0XvVF9PaI869CBuZQ0ixr+r4xPTPy+WIfAp/MRXJTSULUAC2Jwu
    DkTpklj3fkePUfFEYhWxPB8Dzvy7uNFNhjkWF8+MjCPPanjrRZDyvZmJ4vLRj1lf
    Rx5Pv0BsK2zhbUfARZ2N2qe4cRTqS2JrlAWK7usJ/8+yTAZmpJKd0FE5camRSRpv
    lujOH7Tx08kfaN1hBxZUGRAyg8ANe+mrw12Q0oFQR54jHH/Bs5HjEU2/8AuAKRK3
    7+dLbcOKdCyIkap1NrJV6amQR194ZezKbRVKh2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519432849; bh=36XmzDMpxmnJpIg0zSPPOD59HO6WFsn2opRRBfu5juA=; b=m
    keZd9ZrUTqScp/Ght1DCNgBRp7NcXLerLwc2dd8dy9tBVvOaEk2WTp7ONb2g/dVm
    w0lQ+Wn2TvWF3ya8UdlG6FJAasGD7EKGOUItqVqzNVBH2mSvP5c13IgLmGSmSS0Y
    CQJepxgZ0lbwsX8/jkTOgr5LvHxHXToaID0mlRuKfvOfyMgPM5deWCtk8llDhJPh
    xQ6hgAyFxYmRXD99Qmy4S29rYOaU4YsyIIog4LG2vORVN1+Knv6WvB+o/K4MdbzV
    MvRR/wQN24xR+h2DC5Xc0Ths3kh3dlt5sL/vS+7Ky/qQ6kJlgar2ha6Sm8mQVjVg
    FMwdeJ4lXMC0/qRFHgeVw==
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
        id S1751955AbeBXAkq (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 19:40:46 -0500
Received: from osg.samsung.com ([64.30.133.232]:34332 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751864AbeBXAkq (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 23 Feb 2018 19:40:46 -0500
Subject: Re: [PATCH 4.4 000/193] 4.4.118-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180223170325.997716448@linuxfoundation.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <931ffd8f-e286-25ca-f83f-b56b782466df@osg.samsung.com>
Date: Fri, 23 Feb 2018 17:40:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/23/2018 11:23 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.118 release.
> There are 193 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Feb 25 17:02:20 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.118-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
