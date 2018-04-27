Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-599759-1524852861-2-94694628020181170
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
    1524852861; b=CyqOPTA1EUIiYuchwd6Yrs9duRe15t/73Lr38vPPC2o2GY1sDx
    3m4F1tDEq2SPiQqRkdfI2YWBKuGUIMH8Fp4S1QMZVJg8ZLDx0joS0zw1Xcs4yEFb
    eUztCS9eISRp9tnQ6w2pOti2zgOU1pGjIVzRsUw8SU4oiQAfqG68L7X39av0CTfI
    HeCkA4QJfxCya3DpDnihEt0VPkA5RJ0TfiXs9GOXjLyUY/3PXF89djEDdgf/FBEx
    WjW+W2fMVa/8E5tPQsWsflAu/uQJ+GlBOCemZi4XLeeE95iRnpYeIae+JmPCSkGb
    odTFAeXvZKnjhR2q4cG7zDM6UzC+xdf1Tzrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524852861;
    bh=TIIJ4qyCCupqf1g1ZrD3OLrHQA8KZqllhhgQ61ItweY=; b=nv4i79/zRN8x
    Ia1w+i4q4Q0Tspuj84Kfkb3I4bvqLd+y9sk0wSVrNgBg6RhCJO47PrTrBaiYV82S
    NkiKwiFRa4PrLslsuspODXVi0EjsY3cxMACK3TVvbMiuwlgriBY0WX/uLx4hQ0hH
    XcRx5Pkn4c/HCmsXVkT9YOcoq/57q+MdHpoYgAxfJZDdASJgmQRB/L3ZrwquSkXM
    BwrgXdU3bi7xWuyAYJz5ZsXt1iTdHwSFS7f4+rT6QgMqvClGEFdP5sWXtxBw08wR
    +YP4P2N9OPIiQcFE7Km6DcbeK3/0cFPJcJJxgUNnNHtX+z6kzmDzh/NXjW4c7sPn
    WRecE6DoHQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfBnWsFDM1dwOvL5um8iMiSB7I03ZGMZhOlg6M1ajF0OXuGrCY7nHUDOqN5cxaPH/lHIGGxDMeOwqdBzbLdKII53tohSXp7wdhjoSIZYTQjF5XmIpUZRk
    oER+I+FFb/sEbBRKre3e6rLIQPSCfM4QBpZ0vQqXnCdSx5qciylyfTrj6vsT7JlGSOaHA6PPyRE6v7F1vw/1M9m91EmMdx0etOB+GD7zTqcxv/EZD7Uu/CDd
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=cfKjV0Cyj4QA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=8-vRK6DNSD7UNujOA5sA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932451AbeD0SNy (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 14:13:54 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:47222 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932430AbeD0SNw (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Apr 2018 14:13:52 -0400
Subject: Re: [PATCH 4.9 00/74] 4.9.97-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180427135709.899303463@linuxfoundation.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <b7102f15-089e-12e6-f506-ea2bb4c3c3be@kernel.org>
Date: Fri, 27 Apr 2018 12:13:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/27/2018 07:57 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.97 release.
> There are 74 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Apr 29 13:56:52 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.97-rc1.gz
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
