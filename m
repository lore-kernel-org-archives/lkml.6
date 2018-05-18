Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3399165-1526625507-2-1511392024916420440
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526625507; b=IC1/LFwEPVtCCwFiPaTlNmtZ4TYo9+thzAZoIxSXnrNmNNAA65
    IOnT0g/3VVmftSqBdv2hMxL+yqR7U0XeEWbEKfFJWLrx50EG0EkL1ZZvDrr9V+3h
    +B0U3iNQzehTjdiy6jz990eB/+l++35Q4mrFYNp1CSt6I1o+jgvyOif2iSVnrCfU
    5muJF2AaIjUEKXphT/edPCxOFCxEGMC/QbwwbmlZre8dYnC85rEip7WLnLjgPzFB
    H1G0CWxZrO0NguinNN1+cOSpb3bLNmWmZ7WcHH4Mwnr4BKl1sSFpugVZz0E1hvuT
    5txuh6xbVzHguOaovk8ar8l6o4gW2Frgd8Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526625507; bh=sPxk8ad+7/Fd8NSt9iGruJ/y24LJwE
    qxgZogkRg93Mg=; b=eVig8JXZo570DPkHrPjF5twDRCcbhfldgvNSFI1/4KjYs7
    3PJsSwhPrK8RadCAABZYMm0QzU/7/e+cAb19CqgiOR3xTsJrgMUA0DcuMfcBOGym
    H5RMgS78ZjNUfqQsTPBquHHcwHs82WZDzPNujlfY+iWaLFe5T65z68bi7DpT2jO1
    WZI8g+/eOZ25ovheMuSmOPeaJiBrrFuLMx+EKjSur3UeKONMVSu5toVnn5vusCCp
    8ifv7baqPV1LqSICu8wuvQt16J2T5hueqeR0d1yUY226CFVPym0lzaz5lLyED1uI
    10NT3Ba/fY9/F90SOkX63vynBguLfyIYxXIeZ5Lg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=S1pUB2xu x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=CvgmkrsH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-85 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=S1pUB2xu x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=CvgmkrsH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-85 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKNja07b+mov8Qkdy73MBN5GsS+rmVB7ptp78SaSxZSzp6zt5R25PBXkoHTOPy1JbAaN5B++5r14KYOrmJ/mz8gGRcnE/yXTWyMqsdCZPVA7oNPyEU6k
    ZXJf0iQMpodzvOtvJTiViTBdkz9oKcl5uCV6vfwpxmMCgyP3r4+qd8PSdqNb3zxhIRIn3cKN4pSxRdVr0H7Q57yS4vpH2HSft8AJTRxL8iLPbpAYg0fhChal
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=_cTQiL8xM1sA:10 a=VUJBJC2UJ8kA:10 a=JMeKj0A-FjpNQDL__pwA:9
    a=DcSgj6W29Kz2PKby:21 a=Nh-2Odm_7ph4n8_t:21 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751452AbeERGiZ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 02:38:25 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44940 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751221AbeERGiZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 18 May 2018 02:38:25 -0400
X-Google-Smtp-Source: AB8JxZo3/KON+VqW9lg3jAQOyyeVBH5XudSQwd3TiKUF+pq6tNo5KzqgoQCtXKc7F68JYCyvWQ39mQ==
Date: Fri, 18 May 2018 15:38:20 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-kernel@vger.kernel.org, "4 . 13+" <stable@vger.kernel.org>
Subject: Re: [PATCH] printk/nmi: Prevent deadlock when serializing NMI
 backtraces
Message-ID: <20180518063820.GA1504@jagdpanzerIV>
References: <20180517143903.19339-1-pmladek@suse.com>
 <20180518020705.GB1160@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518020705.GB1160@jagdpanzerIV>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On (05/18/18 11:07), Sergey Senozhatsky wrote:
> 
> if (this_cpu_read(printk_context) & PRINTK_SAFE_CONTEXT_MASK) ||
> 	raw_spin_is_locked(&logbuf_lock)
> 
> just to check per-CPU `printk_context' first and only afterwards
> access the global `logbuf_lock'. printk_nmi_enter() happens on
> every CPU, so maybe we can avoid some overhead by checking the
> local per-CPU data first.

Nah, may be it won't. This, probably, would have been the case if we
had continue to call console drivers from printk_safe section [at least].
CPUs don't spend that much time in printk_safe sections.

	-ss
