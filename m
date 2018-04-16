Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3972417-1523907074-2-5636765754782591005
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
    1523907074; b=U5gHjs+7bII8rW8b1JTX/KgZBaNbiIm2k+CFfQ2TK99k51NpnE
    xOxVAhJMt203egijh86G76d4qzqKUjp5+WWt57XIwT1L0RbNjbuIZ4U/9ZdBMUKP
    ub6B3vk2tOhRNhOTBFiXxBh5Cy9aW7M0m/PIdc8egUzIAONPpa8ziVvlNHL38SxO
    BwIH8RwhNF3WNk7Lio+312LAG3AQss6Uy7RhNofxJPJphr//5IUBfSsvh8nt6U4F
    AG36HyYo/N9A5h/DSABPYIyakOSezFLKW8bpHVX992samddKoDUTF9E94aYTlYvt
    4EZ5tedi4HWTfFimuVuJSou0GQPfpVgNdvUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523907074; bh=73Hnl82oWvW2vdiexoqosdmorgV7VOVOvM6uCKtxER
    U=; b=rLOnfKTwFTf1YQK58WxUfFCoYIAdegTkTZxJ1A7PkIbe7c/MADt9WVpgm0
    ykPu3bSIfcRUbNyUVDIGFEpBu+6X/Fgdkwij0pk6LXmAeFQZVsHE9LPaFR5EvR91
    M0/r73o9z5WOOU8aQGhntBfYYVX3/87M2i+AIbIj6ewLg5UtLvQNDccA1T8e6dwQ
    5m/E/wgAjjdVvI0VPBE5ACMvNrhnFuTdMKqPJQnk+KJwudvgo7PISCzoCYmzETk6
    Vsw9AKz2oKxmeY+ajSCy50xUxT0vZPQAfAZBsItzu3d73FybMXd3LY5cqmt3vkFD
    wQhbWSEOnc2djAnpYplaBPvJlMSA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XT6wZ5rv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=iGrrXY4z x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UDX6wA5I;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XT6wZ5rv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=iGrrXY4z x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UDX6wA5I;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCxPbNhXWAmMzMSp6FJZEwlmGDYqqNrRGX+3tsDsbG/I/qv9c8Ct/MDAGnFFdhrgFqghpEaoMKVuLJDyEO8zF8/Ok9dANcHzkFV2dr3a641FkEYQJ8IW
    V78d7XvisyQ1Hu3sT6cl5i7q1/TRDCDgDCEsiGga2dBuBQDy4QkDI/kI0WZlMYYBjcNcGa5/MYEUPP/Ho4D0XSlLK0UcUU2HlwS89gz0nbDL/dsPQ9QrHkU+
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Z4Rwk6OoAAAA:8 a=-LGbCGWv0SHtJnLQFIQA:9 a=QEXdDO2ut3YA:10
    a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753315AbeDPTbL (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 15:31:11 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38910 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753233AbeDPTbK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 15:31:10 -0400
X-Google-Smtp-Source: AIpwx49IO8Llz/q1W8yE0VvZ3zXbcYs8Aq+OGkK0090JyTvKV73zGfj3qXRVf90sP7W/ML7KqdlxCaNmJGPiGa/o5d8=
MIME-Version: 1.0
In-Reply-To: <CA+55aFwjSRZDT1f99QdY-Q5R4W_asb_1mZgM69YOqRR9-efmwA@mail.gmail.com>
References: <20180416153031.GA5039@amd> <20180416155031.GX2341@sasha-vm>
 <20180416160608.GA7071@amd> <20180416122019.1c175925@gandalf.local.home>
 <20180416162757.GB2341@sasha-vm> <20180416163952.GA8740@amd>
 <20180416164310.GF2341@sasha-vm> <20180416125307.0c4f6f28@gandalf.local.home>
 <20180416170936.GI2341@sasha-vm> <20180416133321.40a166a4@gandalf.local.home>
 <20180416174236.GL2341@sasha-vm> <20180416142653.0f017647@gandalf.local.home>
 <CA+55aFzggPvS2MwFnKfXs6yHUQrbrJH7uyY4=znwetcdEXmZrw@mail.gmail.com>
 <20180416144117.5757ee70@gandalf.local.home> <CA+55aFyyZ7KmXbEa151JP287vypJAkxugW17YC7Q1B9=TnyHkw@mail.gmail.com>
 <20180416152429.529e3cba@gandalf.local.home> <CA+55aFwjSRZDT1f99QdY-Q5R4W_asb_1mZgM69YOqRR9-efmwA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Apr 2018 12:31:09 -0700
X-Google-Sender-Auth: b8JzN7wv6vllAsBn314LsULavro
Message-ID: <CA+55aFxVg4FOhvxcrqi7Fs8ohsgSh8DURu3ESbovc_sBxxxpiQ@mail.gmail.com>
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

On Mon, Apr 16, 2018 at 12:28 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> If you know of the fix, fine. But clearly people DID NOT KNOW. So
> reverting was the right choice.

.. and this is obviously different in stable and in mainline.

For example, I start reverting very aggressively only at the end of a
release. If I get a bisected bug report in the last week, I generally
revert without much argument, unless the author of the patch has an
immediate fix.

In contrast, during the merge window and the early rc's, I'm perfectly
happy to say "ok, let's see if somebody can fix this" and not really
consider a revert.

But the -stable tree?

Seriously, what do you expect them to do if they get a report that a
commit they added to the stable tree regresses?

"Revert first, ask questions later" is definitely a very sane model there.

                  Linus
