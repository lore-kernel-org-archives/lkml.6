Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3943043-1525649817-2-7785227355658382530
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525649817; b=jnNBBvQsYcdDwPXTSF67diOO5IK1BLowD1nIJvqiGJkmNRnIGu
    xt6BATZ2/bGmQz4XQ1Q6l9UfJ70+wL+PbwU5dBAKN7A8IzHWq12V1WydRxUwJrKB
    tbpuSU/X/Pk6+emOoQY3QksfijcSvDIZxT0we9DCwiB5u1CC5XI1PNCoXzvuzkd9
    eotEsPZ3Xx50gW7pZhl8ZyVLOjkYZaqPfm0Ne8p0UgnsIznEeH/3jEfdY1goqXc2
    mI7URvAFz7jpcILrTFIdwK/ZX/38i1r7IUYuj2FEowndbmI/h0bLHEcWb9v72wLa
    uQ9CBXIpPaD/4c1j8Qp4t5MkT+HfSaJ/6bhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525649817; bh=HtPW+9lcjFc3LaKkkhjzOsB1rxdkxNgeEAogRl1q1G
    M=; b=cLB45uW0n3u65IqRPbs5OzptFEs2zFw12rhNTvQgWoFhKY1vi+KW0X/U20
    rGO85SQhvgk1ANMzScLU7zfai1DznJUrnj9xG0dPmb++6DtR5HbsB/S/uai6LArN
    4qbgXgHqGdeDMT9DkjDbpVF7PKMbBWp6MC2o8H5hLIlUvVJQczP68myOGGxlg14O
    uh912jc9oy/7A+Wgi3TqKw8Z78Z+nG3ZYCz03fzbeZxkX+0rUaNBS8rwUXgDjFIN
    evkuEjsekPAVnjga9U/YJTTv7abQO2kQpZRYkUX2w5AjtdvU9Aa+dtKeZha4lbIt
    +2bMGeAy0XCQhmOK2BsacdmqLOBg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=chromium.org header.i=@chromium.org header.b=X+L7yOtA
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=X1T8gVA9 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=K1fdqzeI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=chromium.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=chromium.org header.i=@chromium.org header.b=X+L7yOtA
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=X1T8gVA9 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=K1fdqzeI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=chromium.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAUDYG0Y9nkUfbYsrGWp1Slj7qBl8ZiYNxpo9/SbCGf9CiErJEzXlZsKyFVGKlBP0m96rE0SGX9/PraRvQsrUdkzO/gt69Z44d+Pzk49tNhGpo0b9JS6
    GfO8u3ozOr4LeFSgVaNBNefqKVloU+oWOXYcbfgtGy5EBn7Ex2YToRgKqL7tf4LROfzMSJqAuamg5WaZaPrT39C4mbGncdPm1AhH0soNXWgsJtZXskyWhVr+
    6i65dagD5MrEDSRpmvq7nQ==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=xVhDTqbCAAAA:8 a=DfNHnWVPAAAA:8 a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8
    a=7qeQYpzoQLmxHY6nwEwA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=GrmWmAYt4dzCMttCBZOh:22 a=rjTVMONInIDnV1a_A2c_:22 a=xmb-EsYY8bH0VWELuYED:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751864AbeEFXgw (ORCPT <rfc822;linux@kroah.com>);
        Sun, 6 May 2018 19:36:52 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:39674 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751849AbeEFXgu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 6 May 2018 19:36:50 -0400
X-Google-Smtp-Source: AB8JxZrIEUfv3DdVuEYxoBS+EH7R2x4Rfp7WEjjmwYvmXxCTLhWHKxZqTA1KdZFTvUis12uuPXycyKmQ1E6qM2um7/8=
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQb46F0q4bbum9NMqi-spuDHaVDG7xSPDmOsWDP0RZ47g@mail.gmail.com>
References: <1525396095-27737-1-git-send-email-tyhicks@canonical.com> <CAHC9VhQb46F0q4bbum9NMqi-spuDHaVDG7xSPDmOsWDP0RZ47g@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Sun, 6 May 2018 16:36:48 -0700
X-Google-Sender-Auth: z478aClRDNeZoRkqrdo54EPi8qE
Message-ID: <CAGXu5jLZ5MRrQzg0zOvLbmnq_sJe3EA_VN6S=xwRmzgHLTzCeA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Better integrate seccomp logging and auditing
To: Paul Moore <paul@paul-moore.com>
Cc: Tyler Hicks <tyhicks@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Audit <linux-audit@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, May 6, 2018 at 2:31 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Thu, May 3, 2018 at 9:08 PM, Tyler Hicks <tyhicks@canonical.com> wrote:
>> Seccomp received improved logging controls in v4.14. Applications can opt into
>> logging of "handled" actions (SECCOMP_RET_TRAP, SECCOMP_RET_TRACE,
>> SECCOMP_RET_ERRNO) using the SECCOMP_FILTER_FLAG_LOG bit when loading filters.
>> They can also debug filter matching with the new SECCOMP_RET_LOG action.
>> Administrators can prevent specific actions from being logged using the
>> kernel.seccomp.actions_logged sysctl.
>>
>> However, one corner case intentionally wasn't addressed in those v4.14 changes.
>> When a process is being inspected by the audit subsystem, seccomp's decision
>> making for logging ignores the new controls and unconditionally logs every
>> action taken except for SECCOMP_RET_ALLOW. This isn't particularly useful since
>> many existing applications don't intend to log handled actions due to them
>> occurring very frequently. This amount of logging fills the audit logs without
>> providing many benefits now that application authors have fine grained controls
>> at their disposal.
>>
>> This patch set aligns the seccomp logging behavior for both audited and
>> non-audited processes. It also emits an audit record, if auditing is enabled,
>> when the kernel.seccomp.actions_logged sysctl is written to so that there's a
>> paper trail when entire actions are quieted.
>>
>> Changes in v3:
>> * Patch 3
>>   - Never drop a field when emitting the audit record
>>   - Use the value "?" for the actions field when an error occurred while
>>     writing to the sysctl
>>   - Use the value "?" for the actions and/or old-actions fields when a failure
>>     to translate actions to names
>>   - Use the value "(none)" for the actions and/or old-actions fields when no
>>     actions are specified
>>     + This is possible when writing an empty string to the sysctl
>>   - Update the commit message to note the new values and give an example of
>>     when an empty string is written
>> * Patch 4
>>   - Adjust the control flow of seccomp_log() to exit early if nothing should be
>>     logged
>>
>> Changes in v2:
>> * Patch 2
>>   - New patch, allowing for a configurable separator between action names
>> * Patch 3
>>   - The value of the actions field in the audit record now uses a comma instead
>>     of a space
>>   - The value of the actions field in the audit record is no longer enclosed in
>>     quotes
>>   - audit_log_start() is called with the current processes' audit_context in
>>     audit_seccomp_actions_logged()
>>   - audit_seccomp_actions_logged() no longer records the pid, uid, auid, tty,
>>     ses, task context, comm, or executable path
>>   - The new and old value of seccomp_actions_logged is recorded in the
>>     AUDIT_CONFIG_CHANGE record
>>   - The value of the "res" field in the CONFIG_CHANGE audit record is corrected
>>     (1 indicates success, 0 failure)
>>   - Updated patch 3's commit message to reflect the updated audit record format
>>     in the examples
>> * Patch 4
>>   - A function comment for audit_seccomp() was added to explain, among other
>>     things, that event filtering is performed in seccomp_log()
>
> Kees, are you still okay with v3?  Also, are you okay with these
> patches going in via the audit tree, or would you prefer to take them
> via seccomp?  I've got a slight preference for the audit tree myself,
> but as I said before, as long as it hits Linus' tree I'm happy.

Yup, it looks good. I have no tree preference, so you win! :) Please
consider the whole series:

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
