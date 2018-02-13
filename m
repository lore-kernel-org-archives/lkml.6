Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1215397-1518563208-2-13016858822398944419
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518563208; b=rdJHfMUZFbjnIf78Vg2gNKIA+J6vVvdz5OTKO7Kv9YklZys
    IqcCNSP0bJJ8UQLQQ5YQyM3iJR2f3grook5Y+2pZ4nt2pSxaZIL8DQ2QpmTZL1iO
    reB6/9qsX4f+4LkoooKsHHZk12xsjoHiLQHxpSrxoisJgOqjkIly21MYzIbpFCHF
    V4bYfFayufbe07Wt1chXjl0XV7of/I+QPW+WU6SkSEQcjr4YkBzthkK3zAr7ty4k
    ZAhkKanBx0F6E1KfLlK/lEp1v+pvtxNR6GBiRVG9Jmt1IOC0cenbz9/z+hEXyXup
    aqHFhb+HkWPOlIa5iTjeSacY1Oa7X2p51MFiDbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518563208; bh=BPhlCEgRKnX/lne87lrbHnPbXFH9osRDDCrDEouOZyY=; b=E
    TTgcq0a4k/RikSUhg4FHHu4y0GEprR5sPG7GoZbJ0rNG+xjUJzncmffEKDEYHCsg
    n/BysLzNEgyM6dSRzlvq00NMEzuJUn5U0PLaxYDHEJ3bZHS2kKicix8bf6UVSMun
    8QOmyX0DyjQ7mShedpMn1W4CmDhy8tngr8sDcno2SghB9riYBaVTylm5nYcKH7WE
    yYxdq3njlOXBWRUGL+ikWUj4RQySWRDPomP79QtmIbTT8In6hXnxmYSvQ7FaJQcR
    clmRzuvm2k4Vdj7W5qy5ITRwLKjd3bpPQ81qHphgSim22/KVD02oMOaqnU1fl4fv
    0aSoUoKyG2f6mHrAWGjpA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966075AbeBMXGq (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 18:06:46 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:53150 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966002AbeBMXGp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 13 Feb 2018 18:06:45 -0500
Date: Tue, 13 Feb 2018 15:06:43 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: mhocko@kernel.org, mtk.manpages@gmail.com, keescook@chromium.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 0/3] sysvipc: introduce STAT_ALL commands
Message-Id: <20180213150643.0bf5b03f49be656728e1475e@linux-foundation.org>
In-Reply-To: <20180213174136.6346-1-dave@stgolabs.net>
References: <20180213174136.6346-1-dave@stgolabs.net>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 13 Feb 2018 09:41:33 -0800 Davidlohr Bueso <dave@stgolabs.net> wrote:

> Hi,
> 
> The following patches adds the discussed[1] new command for shm
> as well as for sems and msq as they are subject to the same discrepancies
> for ipc object permission checks between the syscall and via procfs.
> These new commands are justified in that (1) we are stuck with this
> semantics as changing syscall and procfs can break userland; and (2) some
> users can benefit from performance (for large amounts of shm segments,
> for example) from not having to parse the procfs interface.
> 
> Once (if) merged, I will submit the necesary manpage updates. But I'm
> thinking something like:
> 
> ...
> 
> [1] https://lkml.org/lkml/2017/12/19/220

It would be nice to summarize the above discussion right here, rather
than merely linking to an email thread.

A reported-by:mhocko would be appropriate.

Really, the only reason for this patchset is to speed up the userspace
interface, yes?  But the changelog is awfull skimpy on the details
here.  Who cares about it and why and which apps can be changed (ipcs?)
and why do we care and how much better does it get, etc.


Dumb question: an admin can do `chmod 0400 /proc/sysvipc/shm' and then
this data is hidden from unprivileged users.  So doesn't this change
represent a security hole for such users?

