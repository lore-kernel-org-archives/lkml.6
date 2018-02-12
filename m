Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1572815-1518446883-2-7176846018689230093
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
    t=1518446882; b=PjauWXkw6qmDfErHZ+uAek3mLIx5T67fXPA3La9IjW0dWUO
    7RSxVmH65Zqsd3UcUikRt5gOCh8SAJj12AswKGBIAdxrM5M2hjA5D1jjcAYH4hBq
    3+lm9yUPE/kj8/Mirjy0Li8VOS0TSieQ9KrGJXCxO+385KqI7iiWSCTiRxnPbWCI
    A9m2NDh9acpv7IasH6KC0lu3pOJkvoLpveac/pAJAQXhF9UOaanUcmLWNKGyf9kN
    Aau5bS5yHSWq4oTd5angbOg3W2R6sI6gaIdarWe+oG8YmFcf9pKjb8DeN7xWjMTo
    PB6mbu/SkREbrMxjv2/pRMAYzzHK7c3gc/X5zjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518446882; bh=/E8G6HD2e1zxpHl8V8XI7fUCWJZLn8SivKotxuMwlAE=; b=s
    JzclAWV6xEhcx3gSooNlCN9oHtLubobYLIcQjxDTo1Ljqx60rvzjhs15pdbDPKLm
    mac/OfkdETJHDYZFKkcKGCqemD3DHQpc2xcQGH5lgGJ8kIDLegd3eUqtqIqBgKaa
    uDtPKqEKYDGoDZjgEpMmdHszXv0Nb9XkAQYBl/rUXTKsQJhqcBFTf8QLYHYAfrM2
    SSlgVflPurtCgYhraP3BhxhUaFlRWPKSZp7deVXu2l7aeQMUC1EW+VFQkZsd6APR
    SQ1OPrqfTNZB0DX22thg98DzMuT9KCZ8uhNtLCBAL8Z6Mk6uvOo1JujGsDGbyDU5
    ZDJI38JmjKmjRhfvS7Tqg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=MgzvhQRa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=NAjTiiWs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=MgzvhQRa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=NAjTiiWs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754330AbeBLOnw (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Feb 2018 09:43:52 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51880 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754321AbeBLOnt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 12 Feb 2018 09:43:49 -0500
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7C26F608BF
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
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <953565bd-436b-c1fe-d3c5-cde731dee83d@codeaurora.org>
Date: Mon, 12 Feb 2018 08:43:45 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:52.0)
 Gecko/20100101 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1e69fffc-1c3b-8cc0-f1cb-695de5ccdcb5@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2/12/18 7:47 AM, Prarit Bhargava wrote:
> ACPI SPCR is used by a vendor to define the serial console for a system.  If
> SPCR exists a user can add kernel parameter "earlycon" (no extra kernel
> parameters) and the console will work out-of-the-box.

"earlycon" is needed only for an *early* console.  You don't need any 
command line parameters for a normal console to work with SPCR.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
