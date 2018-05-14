Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1474708-1526335312-2-15789957661101191696
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
    1526335311; b=UbtaLgr+W5GJlkaPgTEMOEwaDVhtP/rDt6pS8Qj007EqUDEwy9
    0ga0WODgOtZYzYRLMTTFknHDtaqb0i19SSWaDpoyPn6389a1bZHNmaAsdAw6dYUW
    nWm8eLlbfoQ+KoUXY9Jv6r10zOdrTblhZqfbCmkMVfUOtyJZETolBQJkCDf04Hkh
    KzNH/RatkcH2VpCVyCN9XuLlLEk1MCX0GCZHoycKFC3Mrhs/7tiL+ciw0AquskA4
    89cbr+UVcqTLbbpJbtG17TvcFhRfUPXCX3JUozpDeuE7DPDUVDQiY3hUv8EFPiYc
    vq6yWm2/XQq/1JwknCLJCZP03JbUYUyf20Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526335311;
    bh=Bjwl8vYS3zozFoAFQExIphsot7uWdASxKWtNJvkyEbg=; b=CoLaMtwBmwR5
    +XPRPZHyRgzvX5PV4PViEsNVUPl86Fa7Ba7g5vZV6O3AGl66AE5xxixMOL3i+GDS
    2FSQ1D4hFLMpw+47BAgkWjQ2Ko4ggNy8KLwzg2RDoPxv8g6wVjW/ZsOZI2StSOKG
    OzCopwMnffw0Hm+wNkQW2egGFx1ZjMcgxklLuRHTbOWP4j0prsRh00Onk3q1RqmK
    YNA8kaRkYqkHA9h4q5JehkcQRtpxLSNGeHJCuYbAhrZK6R2fQNdGN/qHdD88+YJB
    kJuOmtt4/u1v3vAiRepN63/fDbQ0Cuxfm0w897/xrye/7EPUeUaQ5QrCn/YH4te4
    BdeY6bQtsw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfJdOpvUfvJEM/c+G9bEdWGh2z48OynQnSk6W0GVAtWWF/XqX/x0Lf4AM9hpJsB0LQbcl3n1fDtTsaeiht+ay3y0thm0F/XLHtGuNT/x5c7fOFeZAXa6d
    CCL1Js11etNowJp1YCQAjPPUNpqjhpuItgbKCyiLkAorUkmWvULNEdoQ1wPda1Yyrf2SUsgayNJIrk47OIPBOpW3TXcp0Mb7bO0oi8a4uDRPGpwlpv/it9JZ
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=9wKpNP2GB4IA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=8-vRK6DNSD7UNujOA5sA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752011AbeENWBt (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 18:01:49 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:44642 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752009AbeENWBs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 May 2018 18:01:48 -0400
Subject: Re: [PATCH 4.16 00/72] 4.16.9-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180514064823.033169170@linuxfoundation.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <1687af73-7c26-9e28-30b6-34e23147b157@kernel.org>
Date: Mon, 14 May 2018 16:01:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/14/2018 12:48 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.16.9 release.
> There are 72 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed May 16 06:47:58 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.16.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
