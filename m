Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1474708-1526335495-2-5812609557113868192
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526335494; b=OaY3b2KWFdVEJm4dAcTV6VXftn3tpE/sidNdEKu3JUxiCFxKcO
    fDjQ/pQxN8CI0yzsAWQcLEYvjb9uT0od85cGsZ5+wLHhDmhPiBbXVuw3wv51ngvo
    fsp310BHsprWL7sB9Sf93LWWbX9GtD6Tm/gvkL0s/YIvlo8QMkE1K1tYm4AyzgX2
    4MXmfuR+rLI9bpcbYx5RfK7iCMz1cCMSxT1sXpcduDWszmR2abRDJ5JS/QAChz2j
    qsTvQNy5XtRZS964BNxKmPe961B/O60tmQjm/DVYZ2WLWu7bAC3rkNJcINrSkF4Z
    yT4rtqw7Yq+ZudybQYk3xTwNY712qYZwCfCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526335494;
    bh=xtKLXKpDQKpMmGAMqqPzHubryOTpvrko+CgRCUNvVpY=; b=AL1/rltdaGOG
    kptHdvOasFKpqCtVBdbnPcI+tidcRZuiuqENFpuw/KqYpwobWGFFYwOxCZxROO1D
    +qRdgYPzTym0mMbe/xZVPCShl4rqF28Tz6g/Mecnr+ii5Vo2mHpbIVJbTZA7Nnhw
    ZOoR1DWH9YZlpLPQr32oIUZAG09k/xtGygOQ/Ey5PikTe1urIWdtnanJdtCENOPX
    8ROmHq7Vlmpgy7uxWpWohJsl60FnfwczHb7wczW0bJGnQ0pWr9+Mbf3VCXV8E+Kh
    +Q2SjIKTSEAdPrBO6XuTD3LNPuiKgte9Et7p2lCLkT0JAJ19h/adf1b/0jhbqEzb
    LqpCrcSI7Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDYi2U/kY4+3CikzdttiUOveS1hknhqwc/d/g34748eVBHyljWN4lxBd+XpPx0PYZdgcgbSKEOtvjZ7KzQqlgPuHON11mMy4qyQ8+DA61vV8GWuyyx3g
    N2D1rXrv3HT+BXK5LiMaZg8x0PFXAm9t6VTKXdVSyRKI+FT8rInU4gx/oMumJUV6Sbubx6DWHFsDMPnvNqAjVr75D7sOLJAidn316lbm/RNYq4PgJ+0IIXXF
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=_yzArvceousA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=8-vRK6DNSD7UNujOA5sA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752024AbeENWEw (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 18:04:52 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:44757 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752013AbeENWEv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 May 2018 18:04:51 -0400
Subject: Re: [PATCH 4.4 00/56] 4.4.132-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180514064754.853201981@linuxfoundation.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <d693d0b6-917c-f7e2-d7d6-355533779d0c@kernel.org>
Date: Mon, 14 May 2018 16:04:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/14/2018 12:48 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.132 release.
> There are 56 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed May 16 06:47:39 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.132-rc1.gz
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
