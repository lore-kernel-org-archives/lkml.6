Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-222706-1526671508-2-4251825070320047921
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: from='utf-8', plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526671507; b=jqsgpWjZH1oZ3P9S1Kmf9vnNeDRH17QEMJ165ld4Sv9KjACc7H
    eL2bVq0pytwXWkb/zgbiwtsSKXyR3B8LjRJbk7WbEfSxfukx5CE+48f1yvejaJIK
    VqvfQq9ePsFKy40BZwgBZsD/VOKq7fXCPd2v7G4qIYjrLV86e+REyb0Gdac5DR56
    oJ12Ct0aNJVjWS6da6Nr9gFwnvnki81m7kKzXpgm744FJWWbtHvtUudPXQIAQszt
    +jFYwVgDxOZ9oZjtJSvVJ9BekSF2m7MNJzdSCSHEl+6rmX2/MJ6eKebROuM6UjG6
    tVqEq4TZW43KBUZoXYYqhqx3AY4wEzuGUg6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526671507; bh=6E3jPbF8zNX/ebWGpcArkd8mc4cl9m
    PnFncVyS3Umd4=; b=VKe5i24w9qxHxcCQR7rsloN9eaEYat+8uiB4yiUl+xX44j
    vWRYPNmIR9NBp+E8IrMLmlvMYEb7M9u1CZrLVT9bFevilCNhJrHsy5DUPR14u0ci
    txOPQjlFE10uggzQIiMi/Q1Y+hZ7QlAoU41iK/ftk/nmkwxw0smzz5pR8puf1SQ/
    Wm/oHTOKbMzVSczI8p7PDUs7R6jmbPLkEW8WLYjPYzgFSthrbUbraTvU7zWU2IUc
    AZuVcjKQdMTwEpX/mhe9MxXb5K6MbZ69kMlyqGPY5aA4G+6XuesQ3zsgxYcADOEp
    Ys5U4b3GsT6aaG8VE/Lva1msGwIgipQ+eK1oUf/g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=samba.org
    header.i=@samba.org header.b=lzjjpm4G x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=42627210;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=samba.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=samba.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=samba.org
      header.i=@samba.org header.b=lzjjpm4G x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=42627210;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=samba.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=samba.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGxNkaL9qBHfsGjYbnygVw90BhR3DXE6hwObBtp4gQ+UauC2eM1aZL9ZRT2UWatArwtqyjYlpSPIa6Dr7F8n2bWYeI+tu8N9NezzAm1vRgYvjqpi9yfV
    4R4A+4DuRx6wu4aQyMhXrhvyQgR04kLXXwzu365oQ14xD+qXrs9TykgEnSS06I6KFse9vA72yeySQdM4EFcfP0FczSOWBO7oL23gqXIou6HU4rZyq/WJHx+m
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yMhMjlubAAAA:8 a=hGzw-44bAAAA:8 a=3CfLrWFaAAAA:8 a=FmnfpCVx5hSLn2205IIA:9
    a=QEXdDO2ut3YA:10 a=T6BEcSaHHEoA:10 a=HvKuF1_PTVFglORKqfwH:22
    a=MCcIZ10OmGFeZTBSk2kH:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751693AbeERTZD (ORCPT <rfc822;linux@kroah.com>);
        Fri, 18 May 2018 15:25:03 -0400
Received: from hr2.samba.org ([144.76.82.148]:42324 "EHLO hr2.samba.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750763AbeERTZC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 May 2018 15:25:02 -0400
Date: Fri, 18 May 2018 20:46:32 +0200
From: Ralph =?utf-8?B?QsO2aG1l?= <slow@samba.org>
To: Steve French <smfrench@gmail.com>
Cc: CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCHv2][SMB3] Add kernel trace support
Message-ID: <20180518184630.axfa7oq4pewb7foj@kazak>
References: <CAH2r5muobq1gDbGcPE1AYeeKmdFx681=mpCyAZWfSPUa5wLjSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH2r5muobq1gDbGcPE1AYeeKmdFx681=mpCyAZWfSPUa5wLjSQ@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 17, 2018 at 09:36:36PM -0500, Steve French via samba-technical wrote:
> Patch updated with additional tracepoint locations and some formatting
> improvements. There are some obvious additional tracepoints that could
> be added, but this should be a reasonable group to start with.
> 
> From edc02d6f9dc24963d510c7ef59067428d3b082d3 Mon Sep 17 00:00:00 2001
> From: Steve French <stfrench@microsoft.com>
> Date: Thu, 17 May 2018 21:16:55 -0500
> Subject: [PATCH] smb3: Add ftrace tracepoints for improved SMB3 debugging
> 
> Although dmesg logs and wireshark network traces can be
> helpful, being able to dynamically enable/disable tracepoints
> (in this case via the kernel ftrace mechanism) can also be
> helpful in more quickly debugging problems, and more
> selectively tracing the events related to the bug report.
> 
> This patch adds 12 ftrace tracepoints to cifs.ko for SMB3 events
> in some obvious locations.  Subsequent patches will add more
> as needed.
> 
> Example use:
>    trace-cmd record -e cifs
>    <run test case>
>    trace-cmd show

pardon my ignorance, but are these tracepoints usable with other tracing
frameworks like Systemtap?

Last time I checked, Systemtap looked like *the* tool. Is there a generic trace
point infrastructure that tracing tools can consume, so we're not tied to
ftrace?

Thanks!
-slow

-- 
Ralph Boehme, Samba Team       https://samba.org/
Samba Developer, SerNet GmbH   https://sernet.de/en/samba/
GPG Key Fingerprint:           FAE2 C608 8A24 2520 51C5
                               59E4 AA1E 9B71 2639 9E46
