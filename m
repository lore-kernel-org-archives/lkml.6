Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3684987-1522423265-2-7454008661340834267
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522423265; b=GB7u2qCBHw3ugBSVy+UaDT7RaqaFbMysFIZVxPbDoxbLVPUJWR
    8eeSkjUZLTphpbxh+pS5capZOgt4ImP1ooBHizigMLeMB7zUwIdYJgOwFKEGek1m
    EZszicJdu5Jc6iVBb2YLpBNnwLgoBh1lI/k2JXvxIFQR6ZPC1Y47bfzV4bAVYx66
    CQiltNYZt4xj6oBB/xZej2mwiBNUZ1mHB9rCbgwmReoS429Gc8oud2VRLOrh2JZF
    4raUUzMlivMkuPeGsAMizZBGUNhKsqPRrBpbfRVSfal1XTre8KmR+9PNzfXwvwfE
    G2E/iVN6lzkVeoua7UMrObVotxxh81nyjDAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522423265;
    bh=uWoN+E7L5Zxsz5R6QVU+EqdVNxxyOm8oqIqcAJQNHTU=; b=qYvb1mNU7cdF
    gDlRxICWfds813OQd538ZBTmUJ1eVqbwyByqhndd6hUMBD0h/g+7gJF7MznvCU/I
    JwOPJFO6t57XBZ3Venm73NPlIO8pZunLdeGLOGSUVt1xbDQp4aMQ2/aqXSFUPkFC
    gkNelHSSy+dtT9jsIplobdtiVvjBUVtZhtMkJFicA6h/rpfjskEVBla8Gu4F9B7V
    cKWzTsPU0Rg7pIi9/XEqyKMW0Bcjp8fRV21ZXerPJMRt45ckgcxjCECPeFwoyDmd
    ax7gn1Lm152bjBHIid3mBX1PJeReF+/UEBJZoOxcKGAGpknWxTXikIRPA2QvVmyU
    2C1W+fzuRg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=vQ7S3IX7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RP7ga5xG;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=vQ7S3IX7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RP7ga5xG;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIH0POFLlOe8VkqAfUfny447wD66yAeBZwfsvUB7YD0uRSH9x5c0wrIGyAjmorRd3gsuWCYONmSPLS+m6FHQ4HSB2cji29oekbm3I4/nVd1EUaYinQbm
    p81L2pzoyqgyFqeRxWQoEsa0pEtiUugZV12qq+JYj8NsdJ1HQtOfWSEPx22lYGk1LhVu/+mQKGPlULxtQOD4MGGnfh16wSzRjPG4uHASs6KsK+rkpeh4oGhz
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7x_52gkKHtEA:10
    a=v2DPQv5-lfwA:10 a=-R11wnHvavWBbUzspcYA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751244AbeC3PVC (ORCPT <rfc822;greg@kroah.com>);
        Fri, 30 Mar 2018 11:21:02 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:32845 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751215AbeC3PVB (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 30 Mar 2018 11:21:01 -0400
X-Google-Smtp-Source: AIpwx49yLBNzxweWCiz241h3Vq6Vlzip7hO0KX2V/0FtDy1BA7dDob9QszTzTujTBK8lGmfdPxyKMA==
Subject: Re: [PATCH 4.15 00/47] 4.15.15-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180329175729.225211114@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <f467948d-bcd5-5a8e-b42a-231804a7ba81@roeck-us.net>
Date: Fri, 30 Mar 2018 08:20:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/29/2018 10:59 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.15.15 release.
> There are 47 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Mar 31 17:57:05 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.15.14-48-gcfaa8b0:

Build results:
	total: 147 pass: 147 fail: 0
Qemu test results:
	total: 141 pass: 141 fail: 0

Guenter
