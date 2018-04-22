Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2669103-1524407716-2-6321336857691020154
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524407716; b=L3leMunzH6LUjK/OTPBS+XHm1P0rYzZ6wmTSoT+qDWa3MY7Bml
    3TbzjbQQ979yPGf6XRDZpDF0WmaZukUL015qBkp2TPOUVDfC+/7xE9yrU4caJJ1D
    z816Ktf1aopJ+alqwJZnALMhTtWOeHE6fG7X4Mp/aAoCgRJWG9scdJWTHwJfuk4t
    Ec2EhrSlxgmupji/yw/cqR5A08+OklrwBiJm/Qe780pvHzhlswW34jA6wASAXZ0c
    bjn+iSo1WcjO+HresV7RGYcOVAobXrx0YpNMutszgPhN0mJwMyatgFXjVF1Vq9Lp
    DwUWuVbUKVOkdA63tkjxHTscDZoyPv228c+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524407716; bh=MMSiTqw2LXJ3uHVrZT4zgIgyRx6Ut9euDULAc2xfIJ
    s=; b=AgybdtWvM8kEQ4UBEY1iag95WjRYAZ5tskNlMIlUCrmOSs87UsjFVf6SeB
    icEfGaznDeMIxRPXPvI8DVvjMO5Lmi6ziGsEzObHsZCJJrGj/iMqkqgfYaTtLjlh
    W0PdIgRgEywvyxwTBbK8SO0bCW5nIwas/Sz51wL8VmxTF4+jHBx6ZRZnQMgLZnjD
    xk/smDV02nJ7UHRgXZ+5rIFPlMl6pomMJotIgJGdSNkg4RZpawkzY6UFTBHeP46g
    7rK7h6nRKqVaW/7QBbrN2jSHEqRIHRWaNFtXukBIid9WSAOdKYTqxJs4vz4EjVPI
    kMtaInmOnNY0jn1KTk3oDkudhQfw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFJFTw+tx8YR/4vUbcqjZ64b+1DIeF73zOLVSAK5JaESKz8UdykE3qS8pOSUj/aiajbtujewI/2vBpgnl9KCIjrgqmnlMcNRIZJqGDC00xj+06aZVWJx
    v8QS6X1nlABwl9uliWvfcMVoZhZujnLnw4oi2ufsuqE8ZJdYbz02+NKizFJJZqwaB6A971dSnemanAhb5c9WSIJHFddA5WYIssOTeTdCVP5DLVkdSerNrt3+
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=UQ0nF52vKhe9zVpqaboA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757225AbeDVOfL (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:35:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757360AbeDVOfH (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sun, 22 Apr 2018 10:35:07 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D329F217CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AIpwx49/EzQojcR15pcvNtJs5rw8UpK9OrbFwKPHknQep7SL5pHtYKzhHPMbSsOYbyhNJOKZA1l5fZPMJqUOmfXx5GY=
MIME-Version: 1.0
In-Reply-To: <27926.1524148733@warthog.procyon.org.uk>
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
 <152346392521.4030.5108539377959227838.stgit@warthog.procyon.org.uk>
 <20180413202234.GA4484@amd> <27926.1524148733@warthog.procyon.org.uk>
From: Andy Lutomirski <luto@kernel.org>
Date: Sun, 22 Apr 2018 07:34:43 -0700
X-Gmail-Original-Message-ID: <CALCETrWnucpY8VueVh==ZGo8LpvVBpppoK6MLwW188A89TwzQQ@mail.gmail.com>
Message-ID: <CALCETrWnucpY8VueVh==ZGo8LpvVBpppoK6MLwW188A89TwzQQ@mail.gmail.com>
Subject: Re: [PATCH 07/24] hibernate: Disable when the kernel is locked down
To: David Howells <dhowells@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 7:38 AM, David Howells <dhowells@redhat.com> wrote:
> Pavel Machek <pavel@ucw.cz> wrote:
>
>> > There is currently no way to verify the resume image when returning
>> > from hibernate.  This might compromise the signed modules trust model,
>> > so until we can work with signed hibernate images we disable it when the
>> > kernel is locked down.
>>
>> I'd rather see hibernation fixed than disabled like this.
>
> The problem is that you have to store the hibernated kernel image encrypted,
> but you can't store the decryption key on disk unencrypted or you've just
> wasted the effort.
>
> So the firmware has to unlock the image, asking the user for a password to
> unlock the key.

Why firmware?

Either the boot kernel could figure out how to ask for a password (or
unseal using the TPM) or we could defer this to userspace.  The latter
should already work using kexec-jump, no?
