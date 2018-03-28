Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3460534-1522281147-2-9101928537722731464
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522281146; b=vE7eCtZV7TzDL1UCVkuv9X6rHPwRuSW03evCetQ/weHKUUi
    0SUG0YyJHNWfpDaL93L3FeTfNCY6BBy86hf8/oPd9d5H0Zp9E7r4O5x+25CFFRzi
    JYBGGHarMlA2yvik2l0dK4WivUs+dgnG0F0ry/Ovghnb9b2cKYTWmfJ/cw8OFtOA
    WoZ6Hl6nwXOiB/Qk2aaSUqLZGJHOGdvHCxPxIhPXKWB4pwCE90Fv13eCl5EgT7sP
    Bk2PT8oeEHy6NyUDPj4xaT2xgnLT4sQbqrUT+0o7ncBTKCT+HMhvnK2bsMBT9eY8
    05QBt69dm6yogxX70+qDzk/iUKetpt4uO+FDJ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522281146; bh=V5oIAilHCji/8qyqiG/cf4pBE4
    EszC6p7XVrCMBkKo4=; b=sR2G5CjtXtNVeKHVKM5LLxy6uGWpmziaydg2gb02aD
    FbPnNrr1jBRBogjtZRdeHkhxbx6fBGYRcZwZE1s57I2PT+Y9QjKnS+g78RpCiaNt
    09j5ABqes9XyqH2fjH4znxYvfwf9A+buCAjEhh3aKP9VnPo04w0l1eAyL0BSRlI2
    Xl+nCY8ZEJl3XoxkCnH8Qbk+U0x1hvigqd3FpL+2Q4zRzOsdKkmTNQF0EeL3M7Uk
    3pyEM0zfPlQwU9x8SwQqekU1y66wE9qGASaIALpoLrlcGpFm5xO7FMtdNlillb86
    A7TeI41mTOqAiaLB/S0B5VcZUcyG8u4ljXwc7DwlfqIw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=stgolabs.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=stgolabs.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO7D5H/5WEPcD8fACFyqmgSzZUVIQDaKB2PNdA5wQSP/e8DUb+aJr+2RpcEF0DgR7c9GKqfO/aDbui1i4lCJMAMaSjZp6UTScbh4T7LPZYmhPdwiJ8L0
    OvpYtpirU1iWQ8F3jyIKvAbQKD+Jm2JADBIdMXP53xERomR2l+1f2qyDk7ocsZ8iLhkMAvWEB562SY3NZ97r0Nbu36aRkSOkM2xi5W2tGArERuprw09S1fUj
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=PtDNVHqPAAAA:8 a=VwQbUJbxAAAA:8 a=KvnCcgDnqEfP5TpirUYA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=BpimnaHY1jUKGyF_4-AF:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751187AbeC1XwY (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 19:52:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:35892 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751113AbeC1XwX (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 28 Mar 2018 19:52:23 -0400
Date: Wed, 28 Mar 2018 16:40:01 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Containers <containers@lists.linux-foundation.org>,
        esyr@redhat.com, jannh@google.com, khlebnikov@yandex-team.ru,
        linux-api@vger.kernel.org, serge.hallyn@ubuntu.com,
        linux-kernel@vger.kernel.org, prakash.sangappa@oracle.com,
        linux-security-module@vger.kernel.org, luto@kernel.org,
        oleg@redhat.com, akpm@linux-foundation.org,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Pavel Emelyanov <xemul@openvz.org>
Subject: Re: [REVIEW][PATCH 12/11] ipc: Directly call the security hook in
 ipc_ops.associate
Message-ID: <20180328234001.asfvlyjawfmklpms@linux-n805>
References: <1520875093-18174-1-git-send-email-nagarathnam.muthusamy@oracle.com>
 <87vadzqqq6.fsf@xmission.com>
 <990e88fa-ab50-9645-b031-14e1afbf7ccc@oracle.com>
 <877eqejowd.fsf@xmission.com>
 <3a46a03d-e4dd-59b6-e25f-0020be1b1dc9@oracle.com>
 <87a7v2z2qa.fsf@xmission.com>
 <87vadmobdw.fsf_-_@xmission.com>
 <877eq2m3or.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <877eq2m3or.fsf_-_@xmission.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 24 Mar 2018, Eric W. Biederman wrote:

>
>After the last round of cleanups the shm, sem, and msg associate
>operations just became trivial wrappers around the appropriate security
>method.  Simplify things further by just calling the security method
>directly.
>
>Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>---
> ipc/msg.c | 10 +---------
> ipc/sem.c | 10 +---------
> ipc/shm.c | 10 +---------
> 3 files changed, 3 insertions(+), 27 deletions(-)

This is nice to see.
