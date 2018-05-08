Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3452210-1525817503-2-15931464144928822729
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525817503; b=RBMPwzjGLId2GvTWkavfrBr2WhLTAzkmM1dVS3eviGpVxTGYbO
    +l6QoCgoEDupL6UyPHJaf4fc98bhFWPKr/z2Or1CD35cU9tubfUeRtdrsg+/6xco
    LPC2z2mL6nQtpnZkFTVUcMQqqoY7Co6k74W6V5KF0sKwx1pqsfKso2iqYDLPlXTg
    etMtXDPdofkSO8SWIBJz5XyFVqdcEqSe1CKB6tzhCLGw80orlvkPV+fSn1e0Wbfs
    4fSJVnPLo+Oped1zzGIME20Ggg+EOM9S1KJdyO8ZqPB73oVYCgG41KUMdEiRUAPH
    mcMhxNlybJ4OUqVfQxX9kt1Q6jmjEX2acrDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525817503; bh=rze9GfqovbxDAvLtqH2GvEPV3LIlx2
    7jncOySSmTraQ=; b=UnUTs5nGLwvtUMarzcThQ41+vEuPu0cVGww6h38rRuIERI
    tqmKyvGKmdtgV+BC38PeO/iAWrpBMOERh3W81SJpfPEYK56gst7/VxKsIKwDbAy4
    zTnimM1j8a5pJfKlvnc3X7oPkVuPIG2V5xBWGRQJcyuRWxssOPczai//QfOmzWJg
    pxUeqPGe3YhjwyTXMuOGCc5pB0tZL3GW24r0FauuhcBzgAkEZrRnTR5wLSotGloi
    BePF+fQWO1+L50tuzyzDP237lEj6otl8YIur3cgXbi/VqysztmpNlQlbCi5hyB3d
    hamv1K+PhQcJGKjlsiceeuPk/4wJRig3xUoVICjg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=S20XqcOW x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=YNYl4xBd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=S20XqcOW x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=YNYl4xBd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJeqrfVM9cGYR4DErPMEx09gF9KoqEtxeMfEib5WTI8qzRdEnpfv4lBOICz2rWFXooJVEsSdiuCkq0fYSQ7AvSUi+aVHJQfc3Yxdx1ctnDWUBE4VJwjc
    ZqTs20IQqCg9QCbx+i5iIPadQnyBsvJit2Kf/NNmBVSaVoIbmOX9ab01laPhvPk2hMD3LCB6eu/Vt5LR7a1NV1v/K2SUl/HSpg0+OvyhF6sp8jOfT3/YYfYV
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=TpujumX0jH7REod0KhDaHZOp9kI=:19
    a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=vY_346TuTMEA:10 a=bdhgAJw2s1sA:10
    a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=TsEAhlO8NvOpfA8BM9QA:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755713AbeEHWLk (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 18:11:40 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:47033 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755529AbeEHWLj (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 May 2018 18:11:39 -0400
X-Google-Smtp-Source: AB8JxZrwswFn6k1ZnXuA37bbJzB6uM2zOVycqdUejCkDIwbXBACCcE1H0l/jAp4BvNG4kJYKlHuIWw==
Date: Tue, 8 May 2018 15:11:52 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/43] 4.14.40-stable review
Message-ID: <20180508221152.GA7636@flashbox>
References: <20180508074003.984433784@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 08, 2018 at 10:10:19AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.40 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu May 10 07:39:32 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.40-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled, and installed onto my Raspberry Pi 3.

No issues during initial usage or in dmesg.

Thanks!
Nathan
