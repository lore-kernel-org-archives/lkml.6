Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3864901-1526858275-2-6126179774716089216
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: cc='iso-8859-1', plain='iso-8859-1'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526858274; b=cAzm7UMjlCeFoBlwuX+ik9LW7o8Kj5ZwDDdDBg+N6qL1Ny97mh
    kUregl2oPtqrW0Ws4/uICKl6TKIk10TbN90zyN7DeeS2VKSDloXQWrNzXG+DT7OP
    a40r0gicWh2sAbAtllvm1TVwXwyW2VrVMzfrn45rJhaP67ywcwGXi9ZzFGNv+jdu
    5jRt07A7OzqbXgYVXPtqF7LXefnqcrb5eZIQarWMRuQvaRu2U0PKksNljr9apGkN
    UZdm6ozpAbC/vcSRyfmbzPZWxyLVKPj/bPbG7bTFg1YIZvVAdVvFITmHDBWmPZdm
    5SAYu4/Fs7zRiJtQe1IWCqdn8uBwX5liht2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1526858274; bh=ZKI9i2u7Hdz
    cO1vrREVMBeKTxvpnVXQQNMEYLptfk5A=; b=iiSnl84vaT/8BQuco3fkGswETPK
    F6axWWIFV9tQ31u9ZQ8CcajpU3biOmu/vUOBv7Td7mb0tqll9VFdgK9UbP9LE54j
    k1f7+8RhSVlI8Tb+UFBHC9BrBJmDHzim2a2eCTv76xNY+acv8gvn0H+927fGtSBn
    19Ekn80AiSBTg3YKNgWC9dl8AwjH/XrKXRnmuRw/F4DWgIKxS9A61V1YD8EBfAtt
    fTEgb4zF3l1349f5tL0hZ9z9CQJPdjyYLTmPTa6W9mIrdc6qWli0lDNZ42+rORSE
    +pRITCeL2ym8C4EhlUiO8aT1ygEkuGYNCe9xNtYAkfxprgKYBqgTKYPcW8g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfOejoHRNecN3lLxzhdJ8NCKQibiO0ByTfl9fdRTKnFxu78hFwLl/cGrRUwO3fcTMj0Ma6R6vVWrUfynqxyOa323iGWd2nIbLAOw1uB9W/wwD0XBsXi6+
    HfAPtxCPBUW/hinpZBFbIGFkcVhSTj2G5c01CRDKXr1ySQITcdj/tunmar3UoQYP+H/cnK/wZuYDThCBd6o21xbqS7Ju7bDXOv1vO1tEzdDivuSL//+6whLf
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=VUJBJC2UJ8kA:10
    a=7-415B0cAAAA:8 a=hGzw-44bAAAA:8 a=yMhMjlubAAAA:8 a=4U_CFZYFwRlSCSlgbLUA:9
    a=wPNLvfGTeEIA:10 a=biEYGPWJfzWAr4FL6Ov7:22 a=HvKuF1_PTVFglORKqfwH:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751905AbeETXRt (ORCPT <rfc822;linux@kroah.com>);
        Sun, 20 May 2018 19:17:49 -0400
Received: from ipmail02.adl2.internode.on.net ([150.101.137.139]:48258 "EHLO
        ipmail02.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751650AbeETXRs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 May 2018 19:17:48 -0400
Date: Mon, 21 May 2018 09:17:44 +1000
From: Dave Chinner <david@fromorbit.com>
To: Steve French <smfrench@gmail.com>
Cc: Ralph =?iso-8859-1?Q?B=F6hme?= <slow@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCHv2][SMB3] Add kernel trace support
Message-ID: <20180520231744.GM10363@dastard>
References: <CAH2r5muobq1gDbGcPE1AYeeKmdFx681=mpCyAZWfSPUa5wLjSQ@mail.gmail.com>
 <20180518184630.axfa7oq4pewb7foj@kazak>
 <CAH2r5muu0Hjx1SwMKm5aRLRa2Cwh6tQ7y0h33C07kkPbkhswFw@mail.gmail.com>
 <20180519232257.GL10363@dastard>
 <CAH2r5mtFtX4t9-xFRh62DRv=09TJjF2Z6JkbXXF3siaHqZuY2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2r5mtFtX4t9-xFRh62DRv=09TJjF2Z6JkbXXF3siaHqZuY2A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, May 19, 2018 at 08:56:39PM -0500, Steve French wrote:
> On Sat, May 19, 2018 at 6:22 PM, Dave Chinner <david@fromorbit.com> wrote:
> > On Fri, May 18, 2018 at 01:43:14PM -0700, Steve French wrote:
> >> On Fri, May 18, 2018 at 11:46 AM, Ralph Böhme <slow@samba.org> wrote:
> >> > On Thu, May 17, 2018 at 09:36:36PM -0500, Steve French via samba-technical wrote:
> >> >> Patch updated with additional tracepoint locations and some formatting
> >> >> improvements. There are some obvious additional tracepoints that could
> >> >> be added, but this should be a reasonable group to start with.
> >> >>
> >> >> From edc02d6f9dc24963d510c7ef59067428d3b082d3 Mon Sep 17 00:00:00 2001
> >> >> From: Steve French <stfrench@microsoft.com>
> >> >> Date: Thu, 17 May 2018 21:16:55 -0500
> >> >> Subject: [PATCH] smb3: Add ftrace tracepoints for improved SMB3 debugging
> >> >>
> >> >> Although dmesg logs and wireshark network traces can be
> >> >> helpful, being able to dynamically enable/disable tracepoints
> >> >> (in this case via the kernel ftrace mechanism) can also be
> >> >> helpful in more quickly debugging problems, and more
> >> >> selectively tracing the events related to the bug report.
> >> >>
> >> >> This patch adds 12 ftrace tracepoints to cifs.ko for SMB3 events
> >> >> in some obvious locations.  Subsequent patches will add more
> >> >> as needed.
> >> >>
> >> >> Example use:
> >> >>    trace-cmd record -e cifs
> >> >>    <run test case>
> >> >>    trace-cmd show
> >> >
> >> > pardon my ignorance, but are these tracepoints usable with other tracing
> >> > frameworks like Systemtap?
> >> >
> >> > Last time I checked, Systemtap looked like *the* tool.
> >
> > Systemtap is great when you have a need for custom tracing. But for
> > day-to-day kernel development, tracepoints are far more useful
> > because they are always there and can cover all the common
> > situations that you need to trace.
> >
> > And when it comes to debugging a one-off user problem when the user
> > knows nothing about systemtap?  Nothing beats asking the user
> > to run a trace on built-in tracepoints, reproduce the problem and
> > send the trace report back as per the above example.
> 
> Yep - it has already been helpful in debugging problems.
> 
> Main problem I hit using the new tracepoints over the past few days
> was entries being discarded from the buffer - I had a counter leak (now
> fixed) that xfstest showed ... but about 90% of the entries were dropped.
> Tried increasing buffer size but might have made things worse not better.
> Ideas how to force more entries to be saved?

The only tends to be a problem when you are generating events faster
than userspace can drain the kernel ring buffer. Generally speaking,
this happens when you try to trace too many events for userspace to
drain in the CPU time the kernel assigns it.

I'm guessing that tracing an interrupt driven workload like a
network protocol this is going to be more of a problem than
filesystems - it's the perennial "tcpdump/wireshark/etc cannot keep
up with the incoming packet rate" problem - increasing buffer sizes
never fixes that problem. :)

Storing the trace data output file on tmpfs can be helpful here, as
can reducing the number of events to just the layer you need info
from, filter the specific events you want to see (e.g. filter by
client/server connection, by process/CPU, etc), set up trigger
events so tracing doesn't start until you want it to, etc...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
