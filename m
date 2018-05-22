Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3081717-1527021700-2-11698480476197709568
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
    1527021700; b=MGAMGUoR91B5M/FsiLhE5B7wrnBugj1Szpm276SOHOA+Ccwsuu
    +UcrPMI4EFslGJUJax5lK4DZ/rl1LmgQ4gizqvUYJxDzrDwznRPPxDadjBdGI5t9
    V+kFGljvQcx483HlBIaarDV9QpU7f43dz2R1+PYAYK3AR73pKo9UF4Q1FeCg6/1L
    qRWeO7KSyYYQwdrKKKJXz2MFnzhiPsyf2u4cp275aFtWz5CyBR0YuYy3jSTkSuXy
    fou3mZZHasJd9SlZSPpa7Zf4iz8aKv0iwQGDD+A+LTGvhrmzDwEpaYrfe/Sf9pQm
    9v5i6BIliRYzxDT2hbwg+jcZbLbCrFtXMcbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527021700;
    bh=ndUwxwKzMS+3Tkywm4qp/ri4tqg4yaeWzTzsH32eOFM=; b=Lvcq/dgiiXGe
    p7rC84AOfJ0RtyKVXOAfUDIKMz/skLK6tXO20MZxP21XN6T/pr4FWPVQqNHWMmQw
    oqOQy0bSDeEGpQ6Cye8v7mFybITZI43FsYidyXLTWRu6O2Wm/2axU+nN25z+FfbD
    qoijiKIGh1PFn8PKSGbDwVki29kxD2YCZ+AtGimniBWjtSwenjzXGCw99RAUp6LT
    Uyp7rUMuIXRKpkhRrb2BTQDsF4uKdDslWb24PNEX3gf1z4Ld1zQUW7en7hTC7Q6o
    miyoGLfrNRpB7oTKMMa29C04aps4MlA5xr8Lx2SsnH+RPXiNAZsWASzwHMeq9eIb
    IaXg3nzqzg==
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
X-CM-Envelope: MS4wfAY0qY+kk2e3Ic09/LVgnMYhS+hUD0s7+uocRxBX9JEJw7+sJaMsZUhv8JEnzewP5vt4+rLo1ZTuma+W7ryQb5FStT+n4EChR23NuzzjqJzxq+h7CplS
    qecBKXo+Wsfr7kaI5mpkGxxgtejhqqS3caXxJygbCoPNAXgzPBt9W8Ur7uj7X8xznEjIA3fHFwsp8iyA6+r1sjBHRTVy+OdkVmD9Fpd28u2s7r2rqnxhwPWQ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=ptgvbpQxxUAA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=8-vRK6DNSD7UNujOA5sA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752416AbeEVUlg (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 16:41:36 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:47564 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbeEVUlg (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 May 2018 16:41:36 -0400
Subject: Re: [PATCH 4.9 00/87] 4.9.102-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180521210420.222671977@linuxfoundation.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <bd8e04c2-0295-c876-7225-db870cb51612@kernel.org>
Date: Tue, 22 May 2018 14:41:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/21/2018 03:10 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.102 release.
> There are 87 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue May 22 21:03:57 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.102-rc1.gz
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
