Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2922118-1519133139-2-9584229250611977345
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519133138; b=TRXUAgJuJTqr5KjRoOBU6qjSx6NrZyTTteHZSlVtTX6j8Jt
    pEvrwZMT8JL2IF6VO1rwuZk6a5BaRSQtjA7nfztMt6FZhTBRxfc5l9Bw5cXGZzc5
    bq58YsLoS4U+xSENsso1tHW4RKJxy8knjJnCUUQLYOBWNCEEP//7C4zaFz4JVx/6
    DXdSg26hfK3F1hpiGsPLTZBbBbdAuZor/5bxraN2oWHm7IGxuaK4xysHAwrWARWT
    n+nKqSG1WvW297BeHUxvMrHL+EgdWMEU1KUit7/mVzsrCw3DzdpTLlGs3rW7ho4K
    Gzpi4jAyoguYBy9xcodibXrb/D/DJRhlzZzXlHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519133138; bh=iGfSpZABuW+sTWJsus3rQV6jB6Ws9iG9jYL26u
    JIGKA=; b=c/lGcraawtGwN5GuIp0M0rXSa7EEm3Bs+Sppv+cGh9vD7wxok/gNRg
    t2b9QfbEGArFZM9BjgXg1XzNofTVGM9KDhh1fnT8EvaK6yhTifc4pxzwGRTajjML
    eBBYLhx/pQAVgLY8Qa7+0VzxCXmtHoTZOZSpk3Se/yiSTq2amOgeF7E5UhPUJGCm
    ubxao3az9QzsyVHCwU82zJOmpw1ZqJjOLeTqjgT+8AMvBGYgDMHTK7x0Z+uBhVZF
    vDtp4hdCn58z8TUJJ/LzMKHeoVTuI9lNN/1BjEfEzt9Z7L8VjGjG4l9sY6jpxjr4
    wi5XDbkYQuUnNszV3g+8evG03YMuHphg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=uXqfmtlQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Zmg/cC8N;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=uXqfmtlQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Zmg/cC8N;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751891AbeBTNZ2 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 08:25:28 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36873 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751841AbeBTNZY (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Feb 2018 08:25:24 -0500
X-Google-Smtp-Source: AH8x224VgNTDJzMuXdfVICnTErp7vK/wwNK1uYNdz+hspE4Zre/at2rRM1fKjfu8D085h6vVWorbyIPBJKxCvBXKq1g=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <20180220123757.GE25314@hirez.programming.kicks-ass.net>
References: <20170328122915.640228468@linuxfoundation.org> <20170328122918.597715642@linuxfoundation.org>
 <20180220123757.GE25314@hirez.programming.kicks-ass.net>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 Feb 2018 08:25:21 -0500
Message-ID: <CAHC9VhTOxzcJpVSFDign56jkkruQjujTp7GQzk107FNWYTXRYg@mail.gmail.com>
Subject: Re: [PATCH 4.10 070/111] audit: fix auditd/kernel connection state tracking
To: Peter Zijlstra <peterz@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>, linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 20, 2018 at 7:37 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Mar 28, 2017 at 02:30:56PM +0200, Greg Kroah-Hartman wrote:
>> 4.10-stable review patch.  If anyone has any objections, please let me know.
>
>> +     if (!(auditd_test_task(current) ||
>> +           (current == __mutex_owner(&audit_cmd_mutex)))) {
>> +             long stime = audit_backlog_wait_time;
>
> Since I cannot find the original email on lkml, NAK on this.
> __mutex_owner() is not a general purpose helper function.

Since this code also exists in the current kernel, I need to ask what
recommended alternatives exist for determining the mutex owner?

I imagine we could track the mutex owner separately in the audit
subsystem, but I'd much prefer to leverage an existing mechanism if
possible.

-- 
paul moore
www.paul-moore.com
