Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1541957-1518447003-2-1538095312204190492
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
    t=1518447002; b=aScXKB70wIcpv+AuzvNrbXdVA2DIpw9aONMyKWBjuNqH11A
    +3tUMUDMEzH19UQLQ00mYYY6bRy3TOzFj8s2ge+8dHfFETw3fNyvQPmy7ciP+AOp
    hOS0EwuHwPFUvkhRwOf4wbVWzyiOkDiu801lNyjJkQQ6IZs8gjF3U3Vm2Y2KN3+3
    RKQN3Jih1Mj/g7SDq/9sDZiNj78xCxWMIYXYZN9qwO5KllN5T/pX0W5gDCNQQNFG
    aGZa1P78wfWEiFnvnRAH2PWdMbuoeIsAuJ16wbHkLue/kbD7JHLEfmKzbN4X2dXo
    MH1gaYb31gX5UO/adJdSxey8NFEIZiV9/7CHE4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518447002; bh=ExXu27Z8OBn0fvwIfwj0FdoGHJ0hbQvPZuFHSN4Hho0=; b=k
    PpeFDBz00yUh7jt0aEkfRo7S12hQmV/I/ip3KC0dr5SHDw+S4dsneI4t5gWRV0l3
    kJ/f35YfUzrEOZ86TbOqTOoCjYFwmPDXLq/UOr4RT+CASC/D9rgYLHBSH6bnFbAQ
    O2NlvXSbTsSh1KWNHerfjdHSul34p5SwtGIUL4IfY9YycPDLUOw6/BN32NdSGg2J
    VetSdUtIerCcoE0/C7GFhYVJqghtjSZI4qNxnidInk/cBTiyuADJC9VmG0NUqSU/
    MubR0xg820mB/Qx228mn2QlzK5q4neHpKc9Kc9nzpE3lQltFrHCV5xEfNotu2j/8
    59hRC3bHP0Ks6SFxUjUIQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754493AbeBLOtx (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Feb 2018 09:49:53 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751623AbeBLOtt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 12 Feb 2018 09:49:49 -0500
Subject: Re: [PATCH] acpi, spcr: Make SPCR available to x86
To: Timur Tabi <timur@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20180118150951.28964-1-prarit@redhat.com>
 <20180212133429.GC25314@hirez.programming.kicks-ass.net>
 <1e69fffc-1c3b-8cc0-f1cb-695de5ccdcb5@redhat.com>
 <953565bd-436b-c1fe-d3c5-cde731dee83d@codeaurora.org>
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
From: Prarit Bhargava <prarit@redhat.com>
Message-ID: <7bd5897f-d6da-7e29-29c4-aa26d24f6355@redhat.com>
Date: Mon, 12 Feb 2018 09:49:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <953565bd-436b-c1fe-d3c5-cde731dee83d@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 02/12/2018 09:43 AM, Timur Tabi wrote:
> On 2/12/18 7:47 AM, Prarit Bhargava wrote:
>> ACPI SPCR is used by a vendor to define the serial console for a system.  If
>> SPCR exists a user can add kernel parameter "earlycon" (no extra kernel
>> parameters) and the console will work out-of-the-box.
> 
> "earlycon" is needed only for an *early* console.  You don't need any command
> line parameters for a normal console to work with SPCR.

That's true on ARM64.  I specifically did not enable the console by default on
x86.  There are users who do not want a console active during boot & runtime.

P.

> 
