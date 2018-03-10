Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4013363-1520715597-2-9743359974792086020
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520715597; b=Lgp90/8hVxdE8XIPZS6Ht5rxA7TDo/Oma4Qg7s9n7Gh+8Dy
    P5SifbcZzz+Q/A9EHE5kQyT/t9qtSDoEzm8N27p1ngiwuRppYFVI7sCBgnfc3EpI
    OaoOvR4ZYXASPpJxh9eJdISKxcNqV6vTBjO7oNq26L6vnUakqzouMzBn0PGL6iXx
    PLL+00aU5NMS5scXDZEVDJ9rszOzegpCh7M3XAlZIi3SD3Ix8OXdc0CUliZIEUKO
    uaQG1ubg6oqiMvTpaXJoL/MqpVWLhyDhEWS2LtmrKhc1gNRPZLCqZ3i/AtiUQ6Bs
    doo8kL+IHWCjql4lhaCF62CdgQ2wD+2ehG1Hd2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520715597; bh=pHJVQNYqs1sXbADiibO58VinVL1cJ5NpRUW9hf9w1xs=; b=p
    t8Tkf7Vd4FuysBa7M8uf8ll3F9Q/emWLzF0BG8Grg2CFmYGGgPk17UJkdyvAr64i
    1DFsLt/z8kfB5QGxun7g2I9guMJrbUnQwBUX2w+OP/L5Wu8LbBV742LPCqOeTKLV
    HFGu3CXlw9dcsP9xVXQ94kF4hyxtq8932rg+TbAGFaduW4XJZblrjenfxhPP+Gh1
    3PWXFZrqbHNhCjN6Xs1HNESV33P3hi5H6xM9NOzxbl1wflsyw6lvgt9lgDlcmYVG
    g0+t9T2KPttLXvZwm0uBwsl7fr37eAvXofDL187cDAq08rUmIYwV6gRNnpRYwDfL
    EiGXa38LFr4qiBEKiDD2A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim-adsp=discard (ADSP policy from amazon.co.uk);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=E4M/vj8W x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=amazon.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.co.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim-adsp=discard (ADSP policy from amazon.co.uk);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=E4M/vj8W x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=amazon.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.co.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751161AbeCJU7y (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Mar 2018 15:59:54 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:9949 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbeCJU7x (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 10 Mar 2018 15:59:53 -0500
X-IronPort-AV: E=Sophos;i="5.47,452,1515456000";
   d="scan'208";a="335194601"
From: "Tautschnig, Michael" <tautschn@amazon.co.uk>
To: "x86@kernel.org" <x86@kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jaswinder Singh <jaswinder@infradead.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] x86: always use SYSCALL_DEFINE*
Thread-Topic: [PATCH] x86: always use SYSCALL_DEFINE*
Thread-Index: AQHTuLIpRQ4EwEJShkmMNsa2rpeMXKPJ9BKA
Date: Sat, 10 Mar 2018 20:59:46 +0000
Message-ID: <6490B647-209A-4CE6-BFDC-5EC2F62B466D@amazon.com>
References: <14A5C8D0-3F9D-486F-A20C-55849D70FC80@amazon.com>
In-Reply-To: <14A5C8D0-3F9D-486F-A20C-55849D70FC80@amazon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.246]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7E3E0FFC7CEC3645BBC232E601217066@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 10 Mar 2018, at 20:55, Tautschnig, Michael <tautschn@amazon.co.uk> wrote:
> =

> All syscall arguments are passed in as types of the same byte size as
> unsigned long (width of full registers). Using a smaller type without a
> cast may result in losing bits of information. SYSCALL_DEFINE* introduce
> adequate type casts. All definitions of syscalls in x86 except for those
> patched here have already been using the appropriate SYSCALL_DEFINE*.
[...]

Additional context: I had previously made an attempt to ensure type
consistency of sys_ioperm as "Syscall arguments are unsigned long (full
registers)" (https://lkml.org/lkml/2016/7/4/336). I hope the new proposal
is more acceptable.

Best,
Michael



Amazon Web Services UK Limited. Registered in England and Wales with regist=
ration number 08650665 with its registered office at 1 Principal Place, Wor=
ship Street, London, EC2A 2FA, United Kingdom.



