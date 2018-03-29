Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3704688-1522288441-2-3823143771372755313
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='ie',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522288440; b=oroYCU9plX/+E40N4o+XoEvpQ1PJPylVyRrydZnbdEqIfCR
    nHreW78a6c2mAWzRXp5x99E46YF0FjarSF7np5aa+QNsep3lzNG24hfWH8Hi3MpJ
    AqAFYoHQQeqPHVmhN3uvkM7Qh6+fZHLxetQbMM3ah1beqMjba88bMKFSJBRHDzqV
    BzaL7dZ5GcWJOUijwzSDQw2WzGdUEKBoGqoXiUav0CXCVcSdTTi2AknrPwUwGXJu
    vKx7/u2aoCVFkAcM8+3qTBlLcyzryuK3WD7ADNwS/Tq5jbXPowPOA/qvMvZqsgLQ
    xV2wAEUWuWxduJQzZ+HV/RHfJBaqu6a/G5t3xqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1522288440; bh=0b+4G/a5mW3q43by8C5zh+B96fxiYPqV7RAWDVw/uZg=; b=m
    g0CN2i1Namc8/t3UBJ2wk6nATsO8vJjlzdIlUnY3dGhbxucdixt6Lf6HKD/uRZ1x
    JBtXnAXzcUCISyioeKgewt0fWf2iSDDjuffHFffYa/mIHlBTurUW0WrYmbfDtqnb
    CgvEevDgetBImiOtpXOw9fsiT8K4UJk/OcHtlv+b8J/MXj8pTcE010F3CGU6DYSO
    IebC33BklhSsSKoV4LWZ3uAMz6w65bL3qEiB4ma/3K6D4eW16a8TqdxV/LjVRfYI
    dBoMWQ4ZU5tscKwqpaflbNghAy940GZfMlB4IIaaprNvuj0/TmPD+sm6u1nVeKX0
    gfx1dV7Zxh8mZBNxYwuoA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=nexus-software-ie.20150623.gappssmtp.com header.i=@nexus-software-ie.20150623.gappssmtp.com header.b=lXVN6vVm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=nexus-software.ie;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YlvcYqyS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nexus-software.ie header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=nexus-software-ie.20150623.gappssmtp.com header.i=@nexus-software-ie.20150623.gappssmtp.com header.b=lXVN6vVm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=nexus-software.ie;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YlvcYqyS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nexus-software.ie header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJWnsGdX+BLVyP1+eluf7x3ngPsKLcFx+M1VxwSIK0ew9tZ1WLiTCwnl0NwKKzHi14I2fh8xtZ+xR3bCp6hdUfmurGvM5v2H+8zlgH03WccVUp39zn1N
    JMcslOPSYtmNjS3s/UonZjQYYMEtHsj3mH7GWNCUtNTgV6G16pFmn7ecMOA5T6EgVOyyUSi2oYMTQEmmno2Qvdw9TYQmLlJZASB7qjH0rh2MHLVUrCGpF0hw
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=voM4FWlXAAAA:8 a=uNjWGi2kqzQqe1dH8VAA:9 a=QEXdDO2ut3YA:10
    a=IC2XNlieTeVoXbcui8wp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751218AbeC2Bxr (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 21:53:47 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:53010 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbeC2Bxq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Mar 2018 21:53:46 -0400
X-Google-Smtp-Source: AIpwx48iGwIrLguT0/Nhx8M68mxmJqLj10cKyM/7ndGL9TrfL+eRCbjL0+qnKTiG8VarM/ISJpPfIQ==
Subject: Re: [RESEND] rtc: snvs: Fix usage of snvs_rtc_enable
To: Trent Piepho <tpiepho@impinj.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexandre.belloni@free-electrons.com"
        <alexandre.belloni@free-electrons.com>
Cc: "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "bianpan2016@163.com" <bianpan2016@163.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "guy.shapiro@mobi-wize.com" <guy.shapiro@mobi-wize.com>,
        "Frank.Li@freescale.com" <Frank.Li@freescale.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
References: <1522264445-2398-1-git-send-email-pure.logic@nexus-software.ie>
 <1522282337.10662.268.camel@impinj.com>
From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Message-ID: <f380bc29-c8dd-5c20-efc4-ffc0ad69b8d6@nexus-software.ie>
Date: Thu, 29 Mar 2018 02:53:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <1522282337.10662.268.camel@impinj.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 29/03/18 01:12, Trent Piepho wrote:

> I sent a patch a couple weeks ago that addressed a similar issue, see
> https://patchwork.ozlabs.org/patch/887090/
> 
> Does this also fix the problem you see?

It breaks the endless loop that happens later on in the RTC read path.

This patch though is about fixing the bug with not handling the enable 
of the snvs_rtc_enable() correctly, which is why it should be applied.

The right flow is to handle the error on snvs_rtc_enable() as soon as it 
happens as opposed wait for read() to -ETIMEDOUT.

> I think what you've done will prevent the driver from loading if the
> clock is not working, but if the clock does not tick properly after
> loading, there are still points (snvs_rtc_read_time for one) that will
> lock up in the kernel.

I'll dig out your patch and give it a review.

---
bod
