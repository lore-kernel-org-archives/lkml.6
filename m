Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1070886-1518560315-2-85655643071147348
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
    t=1518560313; b=csp6DAgHIGUWeRfAXNK4yyNV+X0v18N+IxPyMgK42wKI4jk
    tTzjbNtKogS4j7SyFbOJe7DDaoXF6gdCNRSNGKYP8D2+1zgR5YKmKPUnbZf6JuWD
    zgBu4G00FgMCmDbAt6jWuX2pSnbh/+22pYNJElgQ1ympnch/IwNVsJjOuQ0n+vbv
    yqJk1YlslQOT1GAjNJNcTdW406t046XHHFwb5ehOOK+HQtgIS0kUYazK8X5JlGBS
    /807JWtj/kkdG6LEPDc4IM/GqnXUVwgh3HTsQgGVrCxXM2uUhoalkTeTmviE7rjE
    qTtwn4n1AP30e+zi46TCTgL/0iYjWYen4j3rmqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518560313; bh=XabWefLfxIfFRTcARX4GWbIqfV
    zZI1T7ac9XwQLPlSA=; b=buja8HvZuNg+vwRNy9Sgwl53KiYwhYmrX5jcNBO0gx
    0eSp20vKniwvVjVCFWFe62OOQxmDFZ4Nlj+ehX97wJ1dsMI4nhmLsOTKHYJ+gtFP
    HxWM4yhEqAQG7qTT26VBtXIu+SCej9JVz0ELKBPt1RekXb0TH6SJ6MBjzGm1NJ2Z
    6jYmGNbWRq5BaHAob0PKDYh/SKfxNVtpk99AmYAJzZEvKhMYnVWiAG1plpQjGyYh
    /IodFtX3SkeVU0um1z5l8X1RfqPQ3fWXVCR7yzoOUWKpuogXsZDafHOxKRs9Ysoi
    CwW7NANJpoj25s9loQETRF1QOr5Xbae2uChChb2zhHsQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=stgolabs.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=stgolabs.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965997AbeBMWSc (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 17:18:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:59358 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965900AbeBMWSc (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 13 Feb 2018 17:18:32 -0500
Date: Tue, 13 Feb 2018 14:09:11 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: akpm@linux-foundation.org, mhocko@kernel.org,
        mtk.manpages@gmail.com, keescook@chromium.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 0/3] sysvipc: introduce STAT_ALL commands
Message-ID: <20180213220911.e57z65efqx52pz53@linux-n805>
References: <20180213174136.6346-1-dave@stgolabs.net>
 <878tbw3ak4.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <878tbw3ak4.fsf@xmission.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 13 Feb 2018, Eric W. Biederman wrote:

>Davidlohr Bueso <dave@stgolabs.net> writes:
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
>
>I am just going to kibitz for a moment.

Nice word that, kibitz.

>
>Could we name this _STAT_ANY or _STAT_NOPERM instead of _STAT_ALL.
>
>I keep thinking a name with _ALL in it should affect all ipc opbjects of
>a given type, not simply work any ipc object regardless of permissions.

Yeah, and _ALL similarly makes the difference of IPC_STAT and SHM_STAT wrt
the passed shmid that more adhoc.

I'm going to go with _STAT_ANY.

Thanks,
Davidlohr
