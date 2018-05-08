Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2176291-1525759780-2-7406547871598317997
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525759780; b=g9PJFy1d17CIMNz4Qtk+kVCBgUrnUP471SgGED7JXRFwsrD+tZ
    NpAA+sqoVO6ZQ2G5MT/4ddoDNUS/QpqFDQYbutwo0B2F03fdCYoJFimVbJ5uedDD
    8gsCnl/3Ab2TjVPUGybnoiZmt58PLuHesbsTpuMvy38r47DybJvoKhRmJNk79oE1
    qxHIkhtQTPBYvYh+ESCJbqaQg44JVcSxYW/R9ffsH9wyj2vKS4uSGryT5uf3mNAD
    0yI0Rt1qPf7Z7xk+BUq/CoYPYx9VF2pj7R7GdR5hlh5o/It7C/lNnz10jl2+39Ck
    tvRYGu6RY/AqCjFqWcguqXQBM4mVBNXOU4ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525759780; bh=UEMRMO65pwF1yEolnZErqTFngOHJC/NJT99AUkO7q2
    g=; b=Qnq265VnjEyGGi7+HQe45xxG98TZkzifcDk3Cs5Bqggm5n8u/zQTKPtMll
    wFCVncCayayw2bt5+sztpTFatqpEhQUivB/rH0MgKSIplUf1r2X/Rsx5uU6FbXbT
    PRQ7TJwgYSgzaMFRnEeFepzv993Q4lTZCqINrxEVcNMnPQ/AW2ZzI1dwcI2hK68b
    2+WekvUOCi77c+7tW72ldgCYpN/LdqlDv08pLeM0nP2XWFG6w0gTvPqWbzCwyFq6
    LDalF+/NppXp8N5RqgmmuhHzbkx9tezD7HZZ8FL9em3IJ09yM/v4dEZ8GjZoTawI
    XqWVFu5PUx+kkrcWLNXXbnMFRxAQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=paul-moore-com.20150623.gappssmtp.com
    header.i=@paul-moore-com.20150623.gappssmtp.com header.b=1Y4xoVL6
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=fj6BcXAU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=paul-moore.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=paul-moore-com.20150623.gappssmtp.com
      header.i=@paul-moore-com.20150623.gappssmtp.com header.b=1Y4xoVL6
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=fj6BcXAU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=paul-moore.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKOmw2Po7Wy7BAkLipTnOZVbLzFVMMNuVZaT3QhR/C6Dm+ypWCiw5U5VN/e7n6IOrLWNEA6RE9slXJ9xsvz5RrV+VFMF4rwoFoT+hn5LXi0kFg4Y1il8
    zc3dHWeErS8YyHYlkTqXXtBRmHIoCFAIUYlqSq/ud8sJ9y90QX7o+MUZBcAVcFQmhkCc+QsN+VvAyL8reXlLBzUpEG1uaOsBJoB/Npdht9s32Fjond8B8cR8
    12RvOxB29NpV3QuHYhhYGw==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=l-BAhUGsBN8A:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=cm27Pg_UAAAA:8 a=xVhDTqbCAAAA:8 a=DfNHnWVPAAAA:8
    a=VwQbUJbxAAAA:8 a=hezZqVWPKwz_WL9IGPoA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=xmb-EsYY8bH0VWELuYED:22 a=GrmWmAYt4dzCMttCBZOh:22 a=rjTVMONInIDnV1a_A2c_:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754009AbeEHGJh (ORCPT <rfc822;linux@kroah.com>);
        Tue, 8 May 2018 02:09:37 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:43348 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753958AbeEHGJg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 8 May 2018 02:09:36 -0400
X-Google-Smtp-Source: AB8JxZoqPyNro5ia6jfp5vBtml9j8ovaqZg5wM3uA7/85WqtkdSZKivGsKN24xg/e37amLwPQ+do+X96uyeQ4kN+QPM=
MIME-Version: 1.0
X-Originating-IP: [172.3.143.147]
In-Reply-To: <CAGXu5jLZ5MRrQzg0zOvLbmnq_sJe3EA_VN6S=xwRmzgHLTzCeA@mail.gmail.com>
References: <1525396095-27737-1-git-send-email-tyhicks@canonical.com>
 <CAHC9VhQb46F0q4bbum9NMqi-spuDHaVDG7xSPDmOsWDP0RZ47g@mail.gmail.com> <CAGXu5jLZ5MRrQzg0zOvLbmnq_sJe3EA_VN6S=xwRmzgHLTzCeA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 8 May 2018 02:09:33 -0400
Message-ID: <CAHC9VhSijj0TGaR7f_fM1OwpF73fjanJrkBwiF1j4n47DLnrYQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Better integrate seccomp logging and auditing
To: Kees Cook <keescook@chromium.org>,
        Tyler Hicks <tyhicks@canonical.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
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

On Sun, May 6, 2018 at 7:36 PM, Kees Cook <keescook@chromium.org> wrote:
> On Sun, May 6, 2018 at 2:31 PM, Paul Moore <paul@paul-moore.com> wrote:
>> On Thu, May 3, 2018 at 9:08 PM, Tyler Hicks <tyhicks@canonical.com> wrote:
>>> Seccomp received improved logging controls in v4.14. Applications can opt into
>>> logging of "handled" actions (SECCOMP_RET_TRAP, SECCOMP_RET_TRACE,
>>> SECCOMP_RET_ERRNO) using the SECCOMP_FILTER_FLAG_LOG bit when loading filters.
>>> They can also debug filter matching with the new SECCOMP_RET_LOG action.
>>> Administrators can prevent specific actions from being logged using the
>>> kernel.seccomp.actions_logged sysctl.
>>>
>>> However, one corner case intentionally wasn't addressed in those v4.14 changes.
>>> When a process is being inspected by the audit subsystem, seccomp's decision
>>> making for logging ignores the new controls and unconditionally logs every
>>> action taken except for SECCOMP_RET_ALLOW. This isn't particularly useful since
>>> many existing applications don't intend to log handled actions due to them
>>> occurring very frequently. This amount of logging fills the audit logs without
>>> providing many benefits now that application authors have fine grained controls
>>> at their disposal.
>>>
>>> This patch set aligns the seccomp logging behavior for both audited and
>>> non-audited processes. It also emits an audit record, if auditing is enabled,
>>> when the kernel.seccomp.actions_logged sysctl is written to so that there's a
>>> paper trail when entire actions are quieted.
>>>
>>> Changes in v3:
>>> * Patch 3
>>>   - Never drop a field when emitting the audit record
>>>   - Use the value "?" for the actions field when an error occurred while
>>>     writing to the sysctl
>>>   - Use the value "?" for the actions and/or old-actions fields when a failure
>>>     to translate actions to names
>>>   - Use the value "(none)" for the actions and/or old-actions fields when no
>>>     actions are specified
>>>     + This is possible when writing an empty string to the sysctl
>>>   - Update the commit message to note the new values and give an example of
>>>     when an empty string is written
>>> * Patch 4
>>>   - Adjust the control flow of seccomp_log() to exit early if nothing should be
>>>     logged
>>>
>>> Changes in v2:
>>> * Patch 2
>>>   - New patch, allowing for a configurable separator between action names
>>> * Patch 3
>>>   - The value of the actions field in the audit record now uses a comma instead
>>>     of a space
>>>   - The value of the actions field in the audit record is no longer enclosed in
>>>     quotes
>>>   - audit_log_start() is called with the current processes' audit_context in
>>>     audit_seccomp_actions_logged()
>>>   - audit_seccomp_actions_logged() no longer records the pid, uid, auid, tty,
>>>     ses, task context, comm, or executable path
>>>   - The new and old value of seccomp_actions_logged is recorded in the
>>>     AUDIT_CONFIG_CHANGE record
>>>   - The value of the "res" field in the CONFIG_CHANGE audit record is corrected
>>>     (1 indicates success, 0 failure)
>>>   - Updated patch 3's commit message to reflect the updated audit record format
>>>     in the examples
>>> * Patch 4
>>>   - A function comment for audit_seccomp() was added to explain, among other
>>>     things, that event filtering is performed in seccomp_log()
>>
>> Kees, are you still okay with v3?  Also, are you okay with these
>> patches going in via the audit tree, or would you prefer to take them
>> via seccomp?  I've got a slight preference for the audit tree myself,
>> but as I said before, as long as it hits Linus' tree I'm happy.
>
> Yup, it looks good. I have no tree preference, so you win! :) Please
> consider the whole series:
>
> Acked-by: Kees Cook <keescook@chromium.org>

Merged into audit/next, thanks guys.

-- 
paul moore
www.paul-moore.com
