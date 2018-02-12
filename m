Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1572815-1518448238-2-8140890740743223876
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='windows-1252'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518448237; b=u84/fc8CHtpuGq3fCjq2moHByds33RzjHyE6mvv6UFbAUIy
    OhfW0XHhfMisnK8ewfR5gZiLWn6/mR3NpL5T7xBrGQkAEJff4iUrKB+1mi6FUlF+
    uFdMxiNNSGKANA1mIDWKKT3FzqeN7i4p2srvjI3nypbBlM8fx/9r9K16FYleJ5zF
    WPkyXZk7tagBj55JSwNU2mA8F5oFbKgGeYsdG/zZ6zobdrkXv3HOwnpWCxiXwNea
    VJIbw1mvLTNGGJ4KC6+PN0TD/393bdJyj55kwUPB7Cm4rJsdLoa84nc6rgTC/Y7O
    /mDzWadyKNaFU8Fg2PCTz4qM5pq4YtwcnWiJyew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518448237; bh=6Tu89L55fzdSQC8teunxoIJb1vjOalNcvnkhLtWzp5k=; b=W
    hYtlgf8bUvBuBOblu2ITJ32e1tgn/+0HHM/1m1qSvUd7BzJXKhsaaDLtTK8DAlH3
    R4JxEZEPnQmrlXEQHCpx24FMEQsfyNz3aHy9A/fWHfjQo1AqwgwUyWQ2RmK2M0S3
    uq41aUFuiXGNnNbQ47FMsxUt6Mh05Cx/cABNidzbq2W5qe4MalCpL/GZFOlH7Las
    JCDJOCMyZrVorb3d4SachcdJ4Gs8xZOIpNFSGBrYqgb/mT06YoN0V477f+xpSp9Y
    Fy2pMP0hh2uX64TuGqaBNl8VJq2qPAEfqis6RSTY37tdHQ9SDKqNMR4wPRy/5eGr
    5WYRMCOu+aT7VzAOb98Dw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=EjtJguRE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=EjtJguRE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=EjtJguRE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=EjtJguRE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751359AbeBLPKf (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Feb 2018 10:10:35 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48826 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751315AbeBLPKd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 12 Feb 2018 10:10:33 -0500
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 41E1C605A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=timur@codeaurora.org
Subject: Re: [PATCH] acpi, spcr: Make SPCR available to x86
To: Prarit Bhargava <prarit@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Lv Zheng <lv.zheng@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, graeme.gregory@linaro.org,
        mark.salter@redhat.com
References: <20180118150951.28964-1-prarit@redhat.com>
 <20180212133429.GC25314@hirez.programming.kicks-ass.net>
 <1e69fffc-1c3b-8cc0-f1cb-695de5ccdcb5@redhat.com>
 <953565bd-436b-c1fe-d3c5-cde731dee83d@codeaurora.org>
 <7bd5897f-d6da-7e29-29c4-aa26d24f6355@redhat.com>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <50309183-d8e4-aa24-f37d-596e4334f50e@codeaurora.org>
Date: Mon, 12 Feb 2018 09:10:29 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:52.0)
 Gecko/20100101 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <7bd5897f-d6da-7e29-29c4-aa26d24f6355@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2/12/18 8:49 AM, Prarit Bhargava wrote:
> That's true on ARM64.  I specifically did not enable the console by default on
> x86.  There are users who do not want a console active during boot & runtime.

Hmmmm... That's a good point.  On ARM systems with SPCR, you get a 
console whether you like it or not.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
