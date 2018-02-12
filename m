Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1443743-1518443298-2-516563704295993139
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='windows-1252'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518443298; b=KL/GkeNPbUqiy/oW3lRh5LQ8EO0WmZomySKDjnA6Da38fVm
    2bM0x5RJvH/4Avj75sgxcTtV9vJv/yAX1DizrblJZNsHq7RKAj8Tnoj0tWhHRnfa
    BbRLE4WB79WXRkF9aVWxKZF6C2z++5DR2LoVxo6mjQG2LFxyxe/27lHvzvnq/eaE
    WPr2SZyJ1vpXgvCcPAwhXd0XcW/HodQw2saSglh237qVixE0U1Gi8BqE1+TCZvpe
    8+5Sd2QuI/e6tV58BzegW/OkO1tjdoYSODnJrX4H2A2nd70dhXEgRxOiCEXWL8U4
    a0sWL+1vrB1EXmt/z1jdmUvps55x13DF0S0pZ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518443298; bh=dGSheOdRrNswu6mzFJ8gnfTSfF5IJNGiyDYXVAGuL24=; b=N
    HZKGlkRO3dfnwhB3BMWUneFrTqt05mbD2GLB2HJ8dGd72ZCgkzOIkFY6wcjjKhoR
    WOCfnb0H/eLYyVCjt6vYsUwK2p3GAWhIVvV+PSEwIrW46pmGCSRG3ne8HK1iFdNo
    ilNeFggNif+gbsUQN+JEEy+Z5ciludgslXnbE9EIbQ6kkLhG51idbNxbhlvywXWZ
    d3bMokj36tWbQg9KwQrJRncr+pRnANH1e1HI9ChNtkObLEmUZFSBum+OY4FR00o9
    sYjxF4a/Wj6uWUPqJXJDodqdasGRR0XljrUBTv6EvJ1dfaEFWVqxRpD4jMztlb0O
    F1t8wly7LRVzPoj+BH0fg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933420AbeBLNsG (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Feb 2018 08:48:06 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39704 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933332AbeBLNsD (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 12 Feb 2018 08:48:03 -0500
Subject: Re: [PATCH] acpi, spcr: Make SPCR available to x86
To: Peter Zijlstra <peterz@infradead.org>
References: <20180118150951.28964-1-prarit@redhat.com>
 <20180212133429.GC25314@hirez.programming.kicks-ass.net>
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
        Will Deacon <will.deacon@arm.com>,
        Timur Tabi <timur@codeaurora.org>, graeme.gregory@linaro.org,
        mark.salter@redhat.com
From: Prarit Bhargava <prarit@redhat.com>
Message-ID: <1e69fffc-1c3b-8cc0-f1cb-695de5ccdcb5@redhat.com>
Date: Mon, 12 Feb 2018 08:47:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20180212133429.GC25314@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 02/12/2018 08:34 AM, Peter Zijlstra wrote:
> On Thu, Jan 18, 2018 at 10:09:51AM -0500, Prarit Bhargava wrote:
>>  config ACPI_SPCR_TABLE
>> +	bool "ACPI Serial Port Console Redirection Support"
>> +	default y if X86
>> +	help
>> +	  Enable support for Serial Port Console Redirection (SPCR) Table.
>> +	  This table provides information about the configuration of the
>> +	  earlycon console.
> 
> I just got asked this by oldconfig, which left me rather puzzled, WTF
> does this do?

Odd -- I thought I had taken care of that :(  My apologies Peter.

ACPI SPCR is used by a vendor to define the serial console for a system.  If
SPCR exists a user can add kernel parameter "earlycon" (no extra kernel
parameters) and the console will work out-of-the-box.

The serial console configuration varies from vendor to vendor.  This takes the
guess-work out of defining a serial console.

P.

> 
