Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1991257-1528149788-2-4412210922430191985
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528149787; b=caKlKUmBNsOebymTUGTttmjXiQJJsO0HCuGvX/IlOn0g5lVfrs
    ij1WbAEKG6FuqAsHJlMkDpSqLEjZB/qNukJtlKhSA9VvX5BavEh5vG6d+z0q6BTN
    lmorIaJkq+MyVHbUT0sR1e6/oWEbNoE6lvzRoBg/nAL3wUw/HdrqZNNOgb5Z/EHU
    CUnvbxn+4vO8qg4rvXDBr2HlHue6PTSKdwNT6hqch3W8GS5rei8JxrCrWIbz0hlR
    e1UDOY5RuPtrsfYVtU7w84iTrXzC4D1JIbzFWXbFT4JW6WpP67Qsvp7g7piWhbil
    K70zfmGYBmIizygfsrPUiwQZvvO5FVMtfAKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1528149787; bh=luWKsTT8GQlVrAhXjrYhrZ/wnEAGxfKXijsLkvJdfY
    A=; b=IuQOhakCidv6bbnCK2mgF0dU1Rfo28wU9L4OVyIn79vn8rHk6h0XiaYqFB
    dQ5rSWgWm9JHbSIUd9zsmX058hXIN2t55xhG6bUb8/jJg4trGOZCCcrR3luQosbn
    mlk0OvgcGaXxSl7h5o8jc6nej2aj9YQ6nhT60j/e8LuTbcZTNInEZCJx1wZ1nA2h
    WNMo8STwjxxUDgrz8EuAUZgkxmVzSFT1nevb3vSDNDwtV0VwJTDmwikDgoULq0x2
    jx46MXejh0E4g0Bf/Ju/v9pcHTYUh72qR4WAeSzjy/BZKPT0NADhg5kIRDCu9/f6
    gSy13X8vA6D0052IOekg45YL57JQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=chromium.org header.i=@chromium.org header.b=RYugXKOX
    header.a=rsa-sha256 header.s=google x-bits=1024;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=UTlqTp8F
    header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=Isl+dwPj;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=chromium.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=chromium.org header.i=@chromium.org header.b=RYugXKOX
      header.a=rsa-sha256 header.s=google x-bits=1024;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=UTlqTp8F
      header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=Isl+dwPj;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=chromium.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ47WBatsqusafjsCS/mLwN7yZkEvuD11KsEEp4l9/i5DuU50W9XUTY0vAbZLSX/Xa5NMaOB891uBIDCWpabs2pMLiRuCNndqvCurcxR+mozo0FIUtqY
    MdA6+O5GQY5DSzLjqwz2Xr7mNPorXc8XjLziEivSA+BFyvMiDnauDPLDH3b2p9qtMXxfzA4GyREI3hAPCmm7PiE2NTXNoQF11hF51vvQmeTo9pgdrnldZMr+
    6+GKhh9AOvPo2PUztMfTIA==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=ERPsdMwY2ETj0A6qEoUA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751477AbeFDWDE (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 18:03:04 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:41280 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751398AbeFDWDD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 4 Jun 2018 18:03:03 -0400
X-Google-Smtp-Source: ADUXVKJ1Kk20LybpZu1n/DV4TmE89jJMjlUybWSNCRnZOjvYkLYovch8eMHwGYgJ67YiK/pi1TOidXbkqzn67+FudGg=
MIME-Version: 1.0
In-Reply-To: <1528121025.3237.116.camel@linux.vnet.ibm.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com> <1528121025.3237.116.camel@linux.vnet.ibm.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 4 Jun 2018 15:03:01 -0700
X-Google-Sender-Auth: qAmtPcDbTkBG7pKXqGyycWIw_og
Message-ID: <CAGXu5jJGrPtOUa8f4pMiZTiYBEP_eVJ1oEUqum8YBr9JbfuLmg@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] kexec/firmware: support system wide policy
 requiring signatures
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <james.l.morris@oracle.com>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Jun 4, 2018 at 7:03 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Tue, 2018-05-29 at 14:01 -0400, Mimi Zohar wrote:
>> Instead of adding the security_kernel_read_file LSM hook - or defining a
>> wrapper for security_kernel_read_file LSM hook and adding it, or
>> renaming the existing hook to security_kernel_read_data() and adding it
>> - in places where the kernel isn't reading a file, this version of the
>> patch set defines a new LSM hook named security_kernel_load_data().
>>
>> The new LSM hook does not replace the existing security_kernel_read_file
>> LSM hook, which is still needed, but defines a new LSM hook allowing
>> LSMs and IMA-appraisal the opportunity to fail loading userspace
>> provided file/data.
>>
>> The only difference between the two LSM hooks is the LSM hook name and a
>> file descriptor.  Whether this is cause enough for requiring a new LSM
>> hook, is left to the security community.
>
> Paul does not have a preference as to adding a new LSM hook or calling
> the existing hook.  Either way is fine, as long as both the new and
> existing hooks call the existing function.
>
> Casey didn't like the idea of a wrapper.
> James suggested renaming the LSM hook.
>
> The maintainers for the callers of the LSM hook prefer a meaningful
> LSM hook name.  The "null" argument is not as much of a concern.  Only
> Eric seems to be asking for a separate, new LSM hook, without the
> "null" argument.
>
> Unless someone really objects, to accommodate Eric we'll define a new
> LSM hook named security_kernel_load_data.  Eric, are you planning on
> Ack'ing patches 1 & 2?

I'm sorry I'm late to review this series. Reading through what you
have, it seems like the existing hook is fine. If the name has
slipped, we can rename it, but I think adding another hook for the
same logical action (loading something into the kernel) is confusing.

It seems that only patches needed are 2 & 4 (new hook callsites), 5, 6
& 7 (IMA coverage and policy). 1 and 8 seem needless to me. If the
objection is that isn't use on non-file objects, sure, rename it. But
I don't see a _logical_ difference between the proposed and existing
callsites. enum kernel_read_file_id covers the "type" already....

-Kees

-- 
Kees Cook
Pixel Security
