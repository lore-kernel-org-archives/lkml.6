Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-79580-1518402488-2-1509244300571040655
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518402488; b=YQZTPzmqBMHZPMLXyh3wjpQSMSuUplA25mz5zd234C1hADe
    r/9itPNA0QKDlnbO4nJBH6BKjj3g38/mC3WnfGkkXfUCZgqc57+OPntmzspdy+f6
    fk7HX/lXZEWfc/efQ0Jq5UN3XCWQEp2Hc7rkw88yn+/ildZDWXlkFiJjC+o1KnW5
    Br0PlHplQs+B6frenTJRvQpYWNeI/yiWrShWyUemduKedyYJ3q203UW3tL+PY7B/
    zs7mXKHSY7vQNB5iluumljzMr3ulo3JCpbTn6NpC+YRnIu4uKPua2d/cUmeLh77I
    rK7YB00029hraPE1QK5795E/AwxLoRjh6MMboUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518402488; bh=DmXNpxSi+tncN3EXIjFNPHuxbi
    /zmE2u4A/UA1/RwAs=; b=uX5CGToW6FYhFsBWNE5bAA3Hi5ydLIdtJdZOtX6tbp
    TXh9NDMlp4qZaArxdwsMks5U4Cn3BwUf/2RTjqR7V6yzIrRjGGGyg+i2RwNYg7TJ
    Ja030647W4wAFvGfvUe5z2qqsr/kuAHpc1Kt3P19eBHzf3UqLD95mbusYoY2Uz6x
    W1BxskXWZ1zGNnB0yrKPQXnBJewsMy3JryA1xAjbuuGpWgTT6vfnF6JkqX+NDex5
    I9/NEuR9PyJiedKZ/TGrZcWgbWjiMVOY83AjfL79AU7PX83C/T2bPUWea+g8XBtR
    Q+NqOSEB42fRMPHOv2Pko3AvVGJ0PjA9ee0GojW4hZ7A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=taDtz+Au x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kgLs/eo1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=taDtz+Au x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kgLs/eo1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932261AbeBLC2H (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 21:28:07 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42124 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932243AbeBLC2G (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Feb 2018 21:28:06 -0500
X-Google-Smtp-Source: AH8x225dXI9AfVVx4RCM4hg5R4ykg+wXLK8Q7jN1CDc9KlisTpff/Yxho5FXZI9JHWXsOJk803Ekmw==
Date: Mon, 12 Feb 2018 11:28:00 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Huang Ying <huang.ying.caritas@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Seth Jennings <sjenning@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Shaohua Li <shli@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Shakeel Butt <shakeelb@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, stable@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH -mm -v3] mm, swap, frontswap: Fix THP swap if frontswap
 enabled
Message-ID: <20180212022800.GA458@jagdpanzerIV>
References: <20180209084947.22749-1-ying.huang@intel.com>
 <20180209130339.e91c8709e9c46e5b3f941a29@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209130339.e91c8709e9c46e5b3f941a29@linux-foundation.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

On (02/09/18 13:03), Andrew Morton wrote:
[..]
> > Frontswap has multiple backends, to make it easy for one backend to
> > enable THP support, the THP checking is put in backend frontswap store
> > functions instead of the general interfaces.
> > 
> > Fixes: bd4c82c22c367e068 ("mm, THP, swap: delay splitting THP after swapped out")
> > Reported-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > Tested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> 
> I don't think Sergey has tested this version and I suspect this is a
> holdover from the earlier patch, so I'll remove this line.

Just tested it (v3) with FRONTSWAP enabled (didn't test XEN tmem).
Works fine.

FWIW
Tested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com> # frontswap

	-ss
