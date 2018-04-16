Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3053989-1523878585-2-14602993175667651455
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523878585; b=c0BcH/LtcSiPW3OsaCEwdd+LhaXa/lqxzeeiQLgObwDgOLcGJE
    Vkk1ViHhYe6//9fPcUWX3g4Jg6+KW5J1aTmtbCOV5lyfI+uQM/Ib+teahpsA7V7e
    oXyx8URHhDuzkdjvfBCbc+agQ7sbLZGG1rJWkkCseFPLWb88fRLRQ/SjclM7qWqO
    99kRlSDi928B6FfcfrlMwuvkb2rqma/rObSdSsxq2EZWbjCcG8u4uvid0u6vrKCa
    hvhsRKaJ8OIk8NYt22XoyAD32yAFbYxv41Jj/U7iYdPO69dgsOZeA6iBBVh4VFzv
    6y3pXv/zACg0AmcMgjOYz+0qv3cIKm2AJx7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523878585;
    bh=24ny5PY0L5RgC+Tm9DDYwdWSMoXLXwPiJL6YBkCfx4c=; b=LqhBCv0N3pH8
    YicHpnhy41o9cVir/+QDvqEytm5TPGltUg+SwmGCkuAQhI3gHBkxFy481rCYR0QJ
    9CAKXuxKizT2xOABApnalqH/GnZOxVaM42SetyJ1WkB91vkdlMXBs92mZsUXYTJO
    QKN75r5rK0n8wrJBwmZr7mHRqOEmhRaGNNikEBOl24e/7r1oy1oUr8CGWSUlKZQa
    Oa8TzrnfnVUSWQCEt8s4PbW+rjGBYNldfd1C+0XFpssVhQIw4iWhQdK+ykmeS7X7
    sTxdI92iIoa6CoeFwkjnhEACPeVQQ9gIDlrJq9YmWTehF9m4NAlsZbPhimQ6BNY+
    XDbGCjg6wQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Sf9ZfB0o;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Sf9ZfB0o;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCPLKj9omqt99p62fCMPUvOTRPWTmjtR1OFukMxDrylo+OwJw+Dq6n7fCANsY3e58d4VECfCgEMhuV08ZKVNOijLoDTj8wiNVHOx3RqgvjQphxwBc6P5
    Z4i/UPICuSY5iP1hXiQWMlUZ7DHjg6PGmkPGF9/CK3XWwpp698m+DHl6LOz2Ej/2FV19hUoTow1AZYF/50iVHxTuZVFp2hmhEXYw2kHAfOpm8qU9bJk2PyZT
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=B9zcGuyZrMb6SIPcIbYA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754192AbeDPLgX convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Mon, 16 Apr 2018 07:36:23 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:45891 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753398AbeDPLgW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 07:36:22 -0400
X-Google-Smtp-Source: AIpwx4+el01m+rXBw00+O9HylsP+qaqAhM8+0RLLIDUE3bHIRDypJnYBqpIcm9SBzlMNBw2ythcDI35IXP0Y7LhdAho=
MIME-Version: 1.0
In-Reply-To: <CAHcwAbQ4y3vWp7p7GayfdbzbomLrqLKMfu0egEoEODJ3LN5qOw@mail.gmail.com>
References: <20180312191917.21381-1-namit@vmware.com> <20180312192848.22104-1-namit@vmware.com>
 <E63288C3-BE4F-4D41-A074-1CB86C74414E@vmware.com> <BB21DC03-9168-4E5E-B5CA-D446E07BE52F@vmware.com>
 <CAHcwAbSijSmeU3WnznAC+ZaF9iCmYkizqiJNuvLcrYm-YCWxRg@mail.gmail.com>
 <219A03D6-7375-4577-90BA-45DCF2A29289@vmware.com> <CAHcwAbQ4y3vWp7p7GayfdbzbomLrqLKMfu0egEoEODJ3LN5qOw@mail.gmail.com>
From: Oleksandr Natalenko <oleksandr@redhat.com>
Date: Mon, 16 Apr 2018 13:36:20 +0200
Message-ID: <CAHcwAbTEjs6+oPYRJ1HTj--Xh6tORygYUL6aU9tMOJ1KHP_eKQ@mail.gmail.com>
Subject: Re: [PATCH v2] vmw_balloon: fixing double free when batching mode is off
To: Nadav Amit <namit@vmware.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xavier Deguillard <xdeguillard@vmware.com>,
        pv-drivers <pv-drivers@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Gil Kupfer <gilkup@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "ldu@redhat.com" <ldu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello.

On Fri, Mar 23, 2018 at 9:42 AM, Oleksandr Natalenko
<oleksandr@redhat.com> wrote:
>> Actually, rechecking the bug description, I might have rushed. The bug that
>> I encountered is related to the vunmap() but it is only caused when batching
>> is off, while the bug you reported has batching on.
>>
>> It seems that your sources support batching but do not include b91f108a3d54
>> (“VMware balloon: Treat init like reset”), which I think would have solved
>> the problem. I don’t see a mainline kernel that supports batching and does
>> not have this patch, so it would be helpful to see the exact module that you
>> use.
>
> Correct. The hash is d7568c130d0d0ff1fc5b364fc879b91f108a3d54, actually, though.
> Yes, we miss this commit in our code base, but also we've already
> provided a test kernel
> with this commit included to the customer. Unfortunately, we have no answer yet.

At least for one customer I can confirm that the kernel built with
both d7568c130 and the proposed patch fixes the issue.

Thanks.

-- 
Best regards,
  Oleksandr Natalenko (post-factum)
  Senior Software Maintenance Engineer
