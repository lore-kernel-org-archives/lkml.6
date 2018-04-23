Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1816868-1524519610-2-7269614292576110001
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524519610; b=obIMeKhCmT3fNXDtulso7Z6/Up3Og7gh7Njh/7zAzn11ktswyE
    YAJL5gh1hEHIL7JYJWurQD523/J0lQvv2cCvdra+lzuyoRxao7zl7trmUoPeOcOR
    QdQCtAuKWvrRfMgqFZj+XaTBipqBs6C8ImVCb83bhqT7l+IacxMyOLLx9PUVyDsu
    Boe2c17s2G9bivfMEgISCV3V0M+beVQDk74kWOMtHPsOFd8MyGzZUz1cfZLr2Yh4
    JaBhcwCXsv4Xj+DDZid120EATp4eyH8jI/OH5hCHz53ixW4PrbJH3WFNUSq38yAl
    6nvE1f3YXDxMT6Vhx/2JzS9zRe4kcU4eLxcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524519610;
    bh=dmiBBRz32u/Mk84Bw95PVCUPfo6LEoCijETns/5w/iU=; b=o52IQJYs5w2G
    B94JpRW9aKNQvSODoNCd++/QWgOnVfYqA0KduQfXIULrP+MAAz3xBZe55LpI3FTh
    KafD7W27dVmXIPfZ/h09WPTxF5u5h+WmJlFSsHg2uXxsN/YhmJzktOzBazuDNt2f
    5O/fzFdkNs5aJGKupI6DSz1EjjXLtmHh22mfVdjAIfOaVD08+np14Yc6eEpt1waj
    ZhclkQ7+EJyy2jl2RU333JBNhphr3on7Go5rjY+6ktolvu0CHhjO49VFd/cdlqNk
    Lc5XSRftk9yZFgnmpADC4InlEkG/oi4dggJTEfsj/qpS93qcktSb9YGLmnD7RYye
    aqL7PPOh6g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMCQg2fq5shDM7epQ5eOGBuMQZlBS71RLL+297x5uc/kboDj2B7HWkqyoJlrk96ErQbJbZSAIescb5tc5C9kiBRDdNOSKHcq3wXODClsQ1UFPy7r/X7v
    1WThGNxwBNaqe0svhHFaF0c01H2GzGbPLLYgL9VhsZRQ4zq40q6qfKjsD0iu/XMHdwNbhRvD4YUEGB1AH/MXpFcOtr05g1VwcvVvgRH+YvYfs8XPtQ3oDkwl
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=XatMZvNwr2AA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=8-vRK6DNSD7UNujOA5sA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932528AbeDWVkG (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 17:40:06 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:38651 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932454AbeDWVkA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Apr 2018 17:40:00 -0400
Subject: Re: [PATCH 3.18 00/52] 3.18.106-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180422135315.254787616@linuxfoundation.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <c7a36d8a-eaa7-3070-457e-3cf1416f3fd0@kernel.org>
Date: Mon, 23 Apr 2018 15:39:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/22/2018 07:53 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.106 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue Apr 24 13:53:02 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.106-rc1.gz
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
