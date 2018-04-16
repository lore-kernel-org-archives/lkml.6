Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3972417-1523906906-2-1165842232647553306
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523906906; b=BOJ2w6PNxVKpKuH4C6+M/xiIugD+VqbowYAcX96lcln3MXRUMD
    Y2nlNmYVE9mmX4r0mFiR3oPsXM7awdNzcCguoWyBWypY0ZZFDQX3+5f6bDMH21Lr
    c5GFLfNY+ppzZGjUHGcquVBKCN9nFNIZi3gOEPlvI7IokOVkHAeMSu9TJmlefXHb
    j1PKEknk/k9kF4c8OOTNAV7beyEmGvXnTe2jkTe9/ECgNL+A9h0FA0W7J28XcrwA
    eoc0sjBmzHeYBcU58tebTZ3LJ4xwxeN3LT9HT9ofZ4eZ6fjbrwGdT7GXChdlQLzx
    b6dYLJi6msnNM3Hps5KTA5hyd2cGbHwA6hlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523906906; bh=IkngF/nK8ODgPSO9QCRUIfvNzPINjI5Ex1lirpPoDv
    E=; b=gCEqjQZyw+YcedIBUghN9JTJPEAbZ5h3oTlUucHSKq+2hK+W4eoekm6Qql
    9vDlIS6LTBbNAKzwPdounNIR0uUJ35W0p4ERCV/AvwfAPVAWn6dI+Ux4DJ0J98U6
    ha4xuEGEBUH91ZomcxM3+b4HGxCY2VV0dCPw8ZH24ZDul6CPYUmECz9AUi6dQWlA
    78e5F0Ij3fJ2Sz6rHGVxyvijZgRbOiYfdsLZ360tFWvAlMkgVVM68sMT712eCsSZ
    hHC4i31606JKBf0PNnG5Nu2OPcZSfycTT+myBNjTHjErq1FjDimy0UsT4N+gYMVS
    7/2qfDz6uiZAyBaRAe7V8rniNmhw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LBoJAcV5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=S9OqB+cu x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eE4zxFH/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LBoJAcV5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=S9OqB+cu x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eE4zxFH/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHspK7EioIY+IZumBAn/RoH9lRubNmb8JTSDn3L6XEMPiEr4CnPQi82bnM5m0xdrpxIXh5YON28u0gF29M3C/lpHCCUfC03QC0x7SmIdiy/CY84lcIKn
    plR6L0dP89jy2oBjZHI2dXSVtgcG/lJlrhJBVKHIKL9w/+IKEuhC/GqYAe/YX3ArNrVBPVIuAu9POWQCQuxrpV7tWif2JwFUnZN0O69pMaKbSWseSSUcDrKz
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=meVymXHHAAAA:8 a=w0Zb7foLU276fqbAJGsA:9 a=QEXdDO2ut3YA:10
    a=2JgSa4NbpEOStq-L5dxp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752934AbeDPT2X (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 15:28:23 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:51325 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752829AbeDPT2W (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 15:28:22 -0400
X-Google-Smtp-Source: AIpwx49LU0BM6ZTdA1SxTHTEADCBZpAhA/h47A+29b9RdF+ifZSdygqNlKOpd3c1EDf7TVRxkZhGQ7OGEoaJHZQ4Lbk=
MIME-Version: 1.0
In-Reply-To: <20180416152429.529e3cba@gandalf.local.home>
References: <20180416153031.GA5039@amd> <20180416155031.GX2341@sasha-vm>
 <20180416160608.GA7071@amd> <20180416122019.1c175925@gandalf.local.home>
 <20180416162757.GB2341@sasha-vm> <20180416163952.GA8740@amd>
 <20180416164310.GF2341@sasha-vm> <20180416125307.0c4f6f28@gandalf.local.home>
 <20180416170936.GI2341@sasha-vm> <20180416133321.40a166a4@gandalf.local.home>
 <20180416174236.GL2341@sasha-vm> <20180416142653.0f017647@gandalf.local.home>
 <CA+55aFzggPvS2MwFnKfXs6yHUQrbrJH7uyY4=znwetcdEXmZrw@mail.gmail.com>
 <20180416144117.5757ee70@gandalf.local.home> <CA+55aFyyZ7KmXbEa151JP287vypJAkxugW17YC7Q1B9=TnyHkw@mail.gmail.com>
 <20180416152429.529e3cba@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Apr 2018 12:28:21 -0700
X-Google-Sender-Auth: feswFIpLECUNf3q1gDJh1ebed24
Message-ID: <CA+55aFwjSRZDT1f99QdY-Q5R4W_asb_1mZgM69YOqRR9-efmwA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sasha Levin <Alexander.Levin@microsoft.com>,
        Pavel Machek <pavel@ucw.cz>, Petr Mladek <pmladek@suse.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Byungchul Park <byungchul.park@lge.com>,
        Tejun Heo <tj@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 12:24 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Right, but the fix to the API was also trivial. I don't understand why
> you are arguing with me. I agree with you. I'm talking about this
> specific instance. Where a bug was fixed, and the API breakage was
> another fix that needed to be backported.

Fair enough. Were you there when the report of breakage came in?

Because *my* argument is that reverting something that causes problems
is simply *never* the wrong answer.

If you know of the fix, fine. But clearly people DID NOT KNOW. So
reverting was the right choice.

                  Linus
