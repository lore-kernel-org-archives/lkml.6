Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1367139-1518569493-5-16359183649517106809
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518569493; b=NjFEHuz9116aQoLhmus+YgP20dJD67oVZWtQlmgPsHc3vcf
    cOixRKaeYeuGSEpRgoLUA6HX+XsVelIcHljAdp4CPQnBVkxHtGv9RyWsPkwFtObj
    PoAzaNd1Unt5X07uPvmNi/9rfdk9xnWizNrqPKhwMIoZBYrChqgjmkkmcQltIteB
    +OH/+SOzMM2Piyq7rRc5ciKZ9qJ3RDCKmMrmbNzggFnTUPVY+RgpGCOW428p4noz
    WOiI4rhWurWd+MymDlF0TTWldaEKVtvtFHJHy0tDhPgGcVy4OEfRsBoixxmeemZu
    B4N/Bs5QCfvfHWxMQ+NQWInwCwv4UIeesb2B42g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518569493; bh=ZVLJsJEo4psS2alTdKeHloosgI
    KTg8mFoXmCRTPzf6k=; b=vZFFm3Mw5/mpzXXzVKnaHb40rkXj+9g9nKYUjrgova
    x0BKrjVdi1knPvtUXV3bsIqjozvXMoNQClYa7+TPKvcwZ/ef23VxChuUNfMs+kHK
    zqFUdweRgyq9awDx3qbh2PFdP997d65Zzar/ejDB7g6hjnSvATqGfcPaDeKmgcU2
    aw370L/9zPqR4AP0vqXSSzOrabj/nLMxFkUu29d0EE2fTIcCa6seuRYg7nve18gu
    W/pbIHDv0QF9dmTm6IrQJuaRyYTbTv8p1d+VaY1PDVaxJLnD9ES4EkdhVauQ7yqu
    w+SLQLnB3ZOh+T7jLt3yxLY+H/QnE5koO8dWFKnkcOLw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=stgolabs.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=stgolabs.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966224AbeBNAvb (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 19:51:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:37651 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966220AbeBNAva (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 13 Feb 2018 19:51:30 -0500
Date: Tue, 13 Feb 2018 16:42:10 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mhocko@kernel.org, mtk.manpages@gmail.com, keescook@chromium.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 0/3] sysvipc: introduce STAT_ALL commands
Message-ID: <20180214004210.7hj3g4zit5uwqgvp@linux-n805>
References: <20180213174136.6346-1-dave@stgolabs.net>
 <20180213150643.0bf5b03f49be656728e1475e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180213150643.0bf5b03f49be656728e1475e@linux-foundation.org>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 13 Feb 2018, Andrew Morton wrote:

>On Tue, 13 Feb 2018 09:41:33 -0800 Davidlohr Bueso <dave@stgolabs.net> wrote:
>
>> Hi,
>>
>> The following patches adds the discussed[1] new command for shm
>> as well as for sems and msq as they are subject to the same discrepancies
>> for ipc object permission checks between the syscall and via procfs.
>> These new commands are justified in that (1) we are stuck with this
>> semantics as changing syscall and procfs can break userland; and (2) some
>> users can benefit from performance (for large amounts of shm segments,
>> for example) from not having to parse the procfs interface.
>>
>> Once (if) merged, I will submit the necesary manpage updates. But I'm
>> thinking something like:
>>
>> ...
>>
>> [1] https://lkml.org/lkml/2017/12/19/220
>
>It would be nice to summarize the above discussion right here, rather
>than merely linking to an email thread.

I would have thought (1) and (2) above sumarize the situation. Patches
themselves also have a thorough changelog.

>
>A reported-by:mhocko would be appropriate.

This was really reported by a customer, but sure.

>
>Really, the only reason for this patchset is to speed up the userspace
>interface, yes?  But the changelog is awfull skimpy on the details
>here.  Who cares about it and why and which apps can be changed (ipcs?)
>and why do we care and how much better does it get, etc.

Yes, better performance is the goal here. The customer application is
a large and well known database vendor. When consulted as to why this
functionality was needed (and why the process couldn't be pimped to
CAP_IPC_OWNER):

""
The databaselayer saves its rowstore for some reason inside shared memory
(so large amounts of shared memory). The DB instances communicate with each
other about how much memory(ANON, but not shared) each instance is using.

Due to the nature of shared memory one instance might remove a segment,
but it will never know when it is realy gone unless we ask the kernel
to give us the correct information. When this happens we would be fine
to tell others, but to speed things up we currenty allow each instance
to calculate the shared memory size on their own.
""

As such these very specific workloads that deal with large (+10k) number
of ipc objects (shared memory segments in this case).

>
>
>Dumb question: an admin can do `chmod 0400 /proc/sysvipc/shm' and then
>this data is hidden from unprivileged users.  So doesn't this change
>represent a security hole for such users?

Sure, but you'd even hide data that the user can legitimately have
available (the same data that SHM_STAT would return). This deals with
permissions at an ipc object granularity, not file.

In any case, doing a 0400 on the file would cause 'ipcs -m' would not
show anything for other users.

Thanks,
Davidlohr
