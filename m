Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-295341-1526676222-2-5894093082993794770
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: to='UTF-8', plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526676222; b=Fn1/I0jkqntazr7WfulkUypWV1DDcc79j7fhm/D/cuhdw/rSOh
    NzKjlw3/DfabX+0KoLyASG83PPdcDmpJHdHZScEC0MtXJD4r467WaDI/zFvktopL
    hgBapllcocciO2VAnCGKfE1cirHKiRgLszO075eDzbGHQu7wFbyMGzW3r6dLslI/
    1ZHyF8S5BzNrnPAQ9AU9Ow87MRw9iP3fpIK/CYNyc2e0nKhchpk8ua7nBc2d9Wpc
    4oTpEboG4A1+XMgJRILU5USGSug9EkneHbCo4rpDBBjFl/HRp+Dq5QhBsuJsUNaO
    Xs8PFNglTwTePgW4XqVFBJhF+C1JV8xF9R0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526676222;
    bh=L2TZcL0SLtKwrFlsze1WUvnn0Cl6ggBcsIXw44nclk4=; b=kYlHvdtGBqlk
    r3Own5ZlBw6/jPpkBpq8/6wC6c1F94CLJ1EE5GE1xZeZx9R0yBg79qqJusuTUzC1
    PisbhThmXZ2B6KrKGEPtPY6HghUNB9DInbnekwbE+hDaT+HV2wZ4J0dpNL292ryA
    6Z+zsXKi2+uoBJtH2AXZC9WRPyG5RfUsG4LoNN1Kdft+b/0qnPOuY2KyaD742Bti
    m5JKmGjk8d8PPCeH/kfBE4xsn6m3/FvLp5Wpn9k8mK3kOJi8P22oOwDA+VoxO7RS
    t4dkLv69elU501KY9ETzMHu0JSdI3+sMJiqeu5o2YIRKjCttimQVBgDAmpctYmPl
    IHtNJs0s2A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=lZMqP4T9 x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=hp1dYgqV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=lZMqP4T9 x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=hp1dYgqV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNrNTJd739NLcwTDolze4xfAsB4fwAX3KpM0nrjeu+Z3oVK49xMChIIkae5+QX0OMbv5kV2DxZnj7XFlXI8wrBt1gvpFuQ32JYFFXx5jnHTMA7amDX5Q
    7WH2un8Fz3UXmlj31IODIcYDi54k0osjcyJyQRtH2qB6fkaB98H5GeA/06sCxmX1wcoi1fpQzgNzGkHbX0IbPXzNXfoLo7Da7305Gl4ebmtdKQfv5D+ENvm9
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=W_uslV63yMIA:10 a=VUJBJC2UJ8kA:10 a=hGzw-44bAAAA:8 a=yMhMjlubAAAA:8
    a=07d9gI8wAAAA:8 a=8vKEuJQrF1bwtgb0HwoA:9 a=QEXdDO2ut3YA:10
    a=HvKuF1_PTVFglORKqfwH:22 a=e2CUPOnPG4QKp8I52DXD:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751747AbeERUnh (ORCPT <rfc822;linux@kroah.com>);
        Fri, 18 May 2018 16:43:37 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46323 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751156AbeERUnf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 May 2018 16:43:35 -0400
X-Google-Smtp-Source: AB8JxZqloaln+5bj6MrSBTZ6853T99f/gSpipMLe0jbz9KlUqSjkFGcise+0ghdXS81HVi5BijRJMgCfvvs3nsdOoOE=
MIME-Version: 1.0
In-Reply-To: <20180518184630.axfa7oq4pewb7foj@kazak>
References: <CAH2r5muobq1gDbGcPE1AYeeKmdFx681=mpCyAZWfSPUa5wLjSQ@mail.gmail.com>
 <20180518184630.axfa7oq4pewb7foj@kazak>
From: Steve French <smfrench@gmail.com>
Date: Fri, 18 May 2018 13:43:14 -0700
Message-ID: <CAH2r5muu0Hjx1SwMKm5aRLRa2Cwh6tQ7y0h33C07kkPbkhswFw@mail.gmail.com>
Subject: Re: [PATCHv2][SMB3] Add kernel trace support
To: =?UTF-8?B?UmFscGggQsO2aG1l?= <slow@samba.org>
Cc: CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 18, 2018 at 11:46 AM, Ralph B=C3=B6hme <slow@samba.org> wrote:
> On Thu, May 17, 2018 at 09:36:36PM -0500, Steve French via samba-technica=
l wrote:
>> Patch updated with additional tracepoint locations and some formatting
>> improvements. There are some obvious additional tracepoints that could
>> be added, but this should be a reasonable group to start with.
>>
>> From edc02d6f9dc24963d510c7ef59067428d3b082d3 Mon Sep 17 00:00:00 2001
>> From: Steve French <stfrench@microsoft.com>
>> Date: Thu, 17 May 2018 21:16:55 -0500
>> Subject: [PATCH] smb3: Add ftrace tracepoints for improved SMB3 debuggin=
g
>>
>> Although dmesg logs and wireshark network traces can be
>> helpful, being able to dynamically enable/disable tracepoints
>> (in this case via the kernel ftrace mechanism) can also be
>> helpful in more quickly debugging problems, and more
>> selectively tracing the events related to the bug report.
>>
>> This patch adds 12 ftrace tracepoints to cifs.ko for SMB3 events
>> in some obvious locations.  Subsequent patches will add more
>> as needed.
>>
>> Example use:
>>    trace-cmd record -e cifs
>>    <run test case>
>>    trace-cmd show
>
> pardon my ignorance, but are these tracepoints usable with other tracing
> frameworks like Systemtap?
>
> Last time I checked, Systemtap looked like *the* tool. Is there a generic=
 trace
> point infrastructure that tracing tools can consume, so we're not tied to
> ftrace?

At the kernel filesystem/mm summit a few recommended using ftrace
(trace-cmd).  Don't know what
the thinking is about this vs. systemtap these days.  There was a nice
three part series
describing ftrace/trace-cmd on lwn
(https://old.lwn.net/Articles/365835/) a while ago.

In terms of useability "trace-cmd" looked good to me and much more
powerful than the
current dmesg based printk style debugging.

Since the most active file systems (except for cifs.ko) on Linux
btrfs, xfs, nfs and ext4 (and
even dax and ocfs2 and nfsd and fscache etc. and of course various
drivers) already use it, seems like
it is widely accepted still and overhead is small when not logging (default=
).

--=20
Thanks,

Steve
