Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1718953-1526146205-2-5951259457873033945
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526146205; b=ikAe+Iz43n7Mt8Yair7MQAA90cyn+oeAoEh7WG+FN0f2LLOpir
    MQvso+aS9M1RGpVV8Pvr6ngaqWh2D/OM+9F5Z9o+1+Em0wGbp6B1ctBrS4GzwzcD
    RI8uUkDkA97Pcg626Sbce72yzfVWq48D+fjQSEBnr6v/9Dpx/KAiG7b9XJAzUV2Q
    uX7MJihAy0vVIHQJjsjtVbsOoM12F2xQ7xpJaXwlxIR4a2fHw/T4UORJVTgU79Dx
    xnWLIgZbCNK+7up/j62Ku6bqC9np/3PqQHp7uO0dpKTJUAfhj4IBRNToyuwoM5og
    a4sJS6H2K+u3sJ/wXIf50e0zsMfW/zTfzc3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:in-reply-to:references:mime-version
    :content-type:content-transfer-encoding:subject:to:cc:from
    :message-id:sender:list-id; s=fm2; t=1526146205; bh=X9RgrDtQCetJ
    uGFZeGUSgclmpGPgIKHsfdlMXqm56ek=; b=J4XmXjALcKTrgs4JXbMdTrMVfyNp
    GpItzWaKEV4l/1HDBzya3bIAJHpjax8XITePEJhwpjDzIaiRrBnbmmsnRzGkzYjS
    c8YFtd8uSSmsZBXrzcjp+HVee0sBI6HqNl8HHtuKP1nwz37cNrsy+JnQCXfcLHmy
    ygHJDQAqqS6mJzTuRjbura5OdNPRb/9O/w+BtFIqemY1lW84A13utaaZDprtltu2
    +pMFcoUJZWbLCnbF9CK/416mVfVkOJjxhJSpOsEq6zfGTNz13Xp11IdTJGbwPwuw
    Tr+2pJIypspO5H+5c3SBngTGu3/mklYd4K+rRnW/VdlkbaDmV8xGxaxb4Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=oIJp2+3C x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=YW3EZSY3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=oIJp2+3C x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=YW3EZSY3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE2RnmyA6d7YXCb2zaDJwlDU2lbG+YlycSfiSgB+4tnKofXfoaHrUPZM6CVNpX9ZIqVI6j1giAFle1EDbAEzBHlQa42o6Hy1ZbDqqWZ2xZTH68QaqFdD
    OkcSFDM7ghWp9EWakq6HVIZaKE92xiWaiDD00ihkYGhLrsP3c/6tQ9vnINhJhqHhv/YBgnxOY7+tBAH3irzz+OmoQcwrJdbDNYkUECpeWD8CtHe8yKfDq8Sj
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=P79jb94FTlEA:10 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=PHq6YzTAAAAA:8
    a=rJDXjKG7kyuV8yw0OHkA:9 a=oWD5Z8au7JVycati:21 a=NeUWoMxQjDsWu44V:21
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=ZKzU8r6zoKMcqsNulkmm:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751293AbeELRaD (ORCPT <rfc822;greg@kroah.com>);
        Sat, 12 May 2018 13:30:03 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:41346 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751048AbeELRaC (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 May 2018 13:30:02 -0400
X-Google-Smtp-Source: AB8JxZr6/uWvfioZcLt8rtEydbYogdRhujzHi8Kj4zT7QanyLns3QwpUG6gNexgYJP1awcksgwa3ng==
Date: Sat, 12 May 2018 10:29:57 -0700
In-Reply-To: <20180512203137.4c00f301c4359de1f6253154@kernel.org>
References: <152540727123.29650.13679359124038587629.stgit@devbox> <20180508112503.GD16141@n2100.armlinux.org.uk> <20180512203137.4c00f301c4359de1f6253154@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Autocrypt: addr=f.fainelli@gmail.com; keydata=mQGiBEjPuBIRBACW9MxSJU9fvEOCTn
 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
 uUuzv+GKZ6nsysJw==
Subject: Re: [BUGFIX PATCH v3 0/4] arm: kprobes: Fix to prohibit probing on unsafe functions
To: linux-arm-kernel@lists.infradead.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
CC: Jon Medhurst <tixy@linaro.org>, Wang Nan <wangnan0@huawei.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        David Long <dave.long@linaro.org>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <59CD6F84-9E51-469B-BB67-340A4F376A13@gmail.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On May 12, 2018 4:31:37 AM PDT, Masami Hiramatsu <mhiramat@kernel=2Eorg> wr=
ote:
>Hi Russell,
>
>On Tue, 8 May 2018 12:25:03 +0100
>Russell King - ARM Linux <linux@armlinux=2Eorg=2Euk> wrote:
>
>> On Fri, May 04, 2018 at 01:14:31PM +0900, Masami Hiramatsu wrote:
>> > Hi,
>> >=20
>> > This is the 3rd version of bugfix series for kprobes on arm=2E
>> > This series fixes 4 different issues which I found=2E
>> >=20
>> >  - Fix to use smp_processor_id() after disabling preemption=2E
>> >  - Prohibit probing on optimized_callback() for avoiding
>> >    recursive probe=2E
>> >  - Prohibit kprobes on do_undefinstr() by same reason=2E
>> >  - Prohibit kprobes on get_user() by same reason=2E
>> >=20
>> > >From v2, I included another 2 bugfixes (1/4 and 2/4)
>> > which are not merged yet, and added "Cc: stable@vger=2Ekernel=2Eorg",
>> > since there are obvious bugs=2E
>>=20
>> Please submit them to the patch system, thanks=2E
>
>Could you tell me what you mean the patch system?

This is in Russell's signature:

RMK's Patch system: http://www=2Earmlinux=2Eorg=2Euk/developer/patches/

--=20
Florian
