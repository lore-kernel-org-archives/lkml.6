Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2087801-1526772187-2-4483546274568231164
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: cc='iso-8859-1', plain='iso-8859-1'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526772186; b=CLwtWh3mwVFhBuGFQrwe1aqwe0w5O+eXVw2wIzq5V7j5dO6Pf3
    sy51G/ECeClmCf7HUUu9GIUFYQTTNuyFS5drdwvfZ5PO0Dv55OK6rUFhceVuU8Hj
    GytIzi2Nf0KjF+22+tMLxmyVSxWS7A7r7dYg0lvl5EilCZxcg+EfkE7Vc8EQWABC
    xncO7OwYXLXQGRT86Z7II4aAUZoF2/C4M0c/xrGemNhMb7694pHFptCWKAylVz+8
    Uq1e5u2GS30YGYWhwfIzMiAc7bKdddhzVw8iNu3UUQDadnlRfquQ855HRmR+3ue9
    AIZJ/NO+3dKMQLL3XCCsA4WS4alb+BbIaVOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1526772186; bh=dbJhFLalRw3
    cqlEy1gzyibAhq1XfDplycrtrtp7y2gA=; b=al93151bmEc3Qw+ynuUNrZfzCu4
    Q65vgiRnaMzBP1luTG3q4XdGzjah3HdHHESeL25LzlhnNjd+w4bigEVnS2H7I/a6
    VNgaHZZdWp7kEAfysEoZ3h2Exn9Jay3WNe9J1GLjiSj+pekUThTcWDWkCpRJAljx
    VIUkxwFlozuqg1pJYNRfXwDeS7V0x8xvaucQzVXvUU1kCkRglPsZgNr6p1M/Lpon
    9TF05lPoOqGyjBUb0trbry3VJr2cxV0c9LS6o4UDldGua0+i09aHGlh7IvSaySB2
    aH7JB4oKTtKxM5jJyTdPZBsL6V5kBF6emuFo5Be0nHj+nN844Ii3pU+J5gw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=fromorbit.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=fromorbit.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=fromorbit.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=fromorbit.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGI8pMDHXvQAa4xajFPT9tfL7exw8k9inUgLPHfzSt/96LKiEWhMeGZ+HcTRMSyJbfnTBf4wYu3dN/a/6q3cFv1gHISvfEq1M2/fAZS0f5EcaRaM9Pnm
    toy38t/gaUEG1PsVt3R5V7Avdp1U7grXtBEV6NcyQprEzAuuZPq0MQaqBOMmhFZ2wE7tS9RFb5ojd+ZfrrTot00L/ypWGYvDeJ81n8mEWhN8PBc42Yxy5uDc
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=VUJBJC2UJ8kA:10
    a=hGzw-44bAAAA:8 a=yMhMjlubAAAA:8 a=07d9gI8wAAAA:8 a=7-415B0cAAAA:8
    a=lne0lcxjm3kkixPgLNUA:9 a=wPNLvfGTeEIA:10 a=HvKuF1_PTVFglORKqfwH:22
    a=e2CUPOnPG4QKp8I52DXD:22 a=biEYGPWJfzWAr4FL6Ov7:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752518AbeESXXC (ORCPT <rfc822;linux@kroah.com>);
        Sat, 19 May 2018 19:23:02 -0400
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:17328 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752389AbeESXXB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 May 2018 19:23:01 -0400
Date: Sun, 20 May 2018 09:22:57 +1000
From: Dave Chinner <david@fromorbit.com>
To: Steve French <smfrench@gmail.com>
Cc: Ralph =?iso-8859-1?Q?B=F6hme?= <slow@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCHv2][SMB3] Add kernel trace support
Message-ID: <20180519232257.GL10363@dastard>
References: <CAH2r5muobq1gDbGcPE1AYeeKmdFx681=mpCyAZWfSPUa5wLjSQ@mail.gmail.com>
 <20180518184630.axfa7oq4pewb7foj@kazak>
 <CAH2r5muu0Hjx1SwMKm5aRLRa2Cwh6tQ7y0h33C07kkPbkhswFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2r5muu0Hjx1SwMKm5aRLRa2Cwh6tQ7y0h33C07kkPbkhswFw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 18, 2018 at 01:43:14PM -0700, Steve French wrote:
> On Fri, May 18, 2018 at 11:46 AM, Ralph Böhme <slow@samba.org> wrote:
> > On Thu, May 17, 2018 at 09:36:36PM -0500, Steve French via samba-technical wrote:
> >> Patch updated with additional tracepoint locations and some formatting
> >> improvements. There are some obvious additional tracepoints that could
> >> be added, but this should be a reasonable group to start with.
> >>
> >> From edc02d6f9dc24963d510c7ef59067428d3b082d3 Mon Sep 17 00:00:00 2001
> >> From: Steve French <stfrench@microsoft.com>
> >> Date: Thu, 17 May 2018 21:16:55 -0500
> >> Subject: [PATCH] smb3: Add ftrace tracepoints for improved SMB3 debugging
> >>
> >> Although dmesg logs and wireshark network traces can be
> >> helpful, being able to dynamically enable/disable tracepoints
> >> (in this case via the kernel ftrace mechanism) can also be
> >> helpful in more quickly debugging problems, and more
> >> selectively tracing the events related to the bug report.
> >>
> >> This patch adds 12 ftrace tracepoints to cifs.ko for SMB3 events
> >> in some obvious locations.  Subsequent patches will add more
> >> as needed.
> >>
> >> Example use:
> >>    trace-cmd record -e cifs
> >>    <run test case>
> >>    trace-cmd show
> >
> > pardon my ignorance, but are these tracepoints usable with other tracing
> > frameworks like Systemtap?
> >
> > Last time I checked, Systemtap looked like *the* tool.

Systemtap is great when you have a need for custom tracing. But for
day-to-day kernel development, tracepoints are far more useful
because they are always there and can cover all the common
situations that you need to trace.

And when it comes to debugging a one-off user problem when the user
knows nothing about systemtap?  Nothing beats asking the user
to run a trace on built-in tracepoints, reproduce the problem and
send the trace report back as per the above example.

> > Is there a generic trace
> > point infrastructure that tracing tools can consume, so we're not tied to
> > ftrace?
> 
> At the kernel filesystem/mm summit a few recommended using ftrace
> (trace-cmd).  Don't know what
> the thinking is about this vs. systemtap these days.  There was a nice
> three part series
> describing ftrace/trace-cmd on lwn
> (https://old.lwn.net/Articles/365835/) a while ago.
> 
> In terms of useability "trace-cmd" looked good to me and much more
> powerful than the
> current dmesg based printk style debugging.

And then you learn about trace_printk() for putting custom one-off
debug into the tracepoint stream and wonder why you didn't know
about this years ago :P

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
