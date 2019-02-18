Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48763C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13BF42173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Kn1qrOOd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389074AbfBRRtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:49:31 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36996 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729511AbfBRRtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:49:31 -0500
Received: by mail-lf1-f66.google.com with SMTP id n23so12940731lfl.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 09:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UfqKKNX4jN/aRSohz1SOHma6K7OwncVwSxNccpgL5yA=;
        b=Kn1qrOOdPrjt4KDeZKYjZZpY2v/t8J/p8RM7CyIWB6cW+KFqLZ1itY4D8lsjomP9qI
         OlqiKZglbZTlWv4h17rMEaoX8g9cZiQLoZKPyU9JW64fv6E9a56WDikxHvfrN2LEXffH
         yqC+Ofs2faYVOyj/34aL4QH4A4suylOXra8pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UfqKKNX4jN/aRSohz1SOHma6K7OwncVwSxNccpgL5yA=;
        b=fNnn0OOryCeAQ1f6bST06fYi6uHJhwj81HgCFmO6qUe9cxf5mgnJ7o3Gw+6nEYyk++
         w5IzyVhZPFqXIDiH3n4c3YW8f4dQGZC4OPkRbcxfW5qYgkMfXG4qiyhYWo8lbM4uSWBh
         v7xUD+hUc9BTyHsC0PTAkZyj/UaDBt5nIHjyzpfusqLw3VOlKVwUQIb+t6q5Zg7stx00
         +CR/zk4d7nuh+elRTrgpzBWzV5H+VoN1lMbT1mUiTC5MGy4ei2xZtWTWNcd0g9zJCFce
         H962i5Z/NAY381hkhrwX/yiaOs23P6NtJKS/O/C2cI9MGCLJZIGbyEmxETAIb1Tq6d5Z
         dOgQ==
X-Gm-Message-State: AHQUAubpRBbeNzVtSdnYSbWJFzS8b54Zei0PdPdtGY1xy7DTpXSIvFCq
        p4sfrJ15XLqGjodJJr4tGOzLnwDpiIY=
X-Google-Smtp-Source: AHgI3IaKptwZRvXAZMCrQlZ7kTty5L/wGAs7sSVpHnvPK0pdCbbthbDgpwAnrGNL12h1loFAvdFAWQ==
X-Received: by 2002:ac2:50c8:: with SMTP id h8mr15493018lfm.35.1550512168682;
        Mon, 18 Feb 2019 09:49:28 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id m18sm3718593lfh.43.2019.02.18.09.49.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 09:49:27 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id j1so12922462lfb.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 09:49:27 -0800 (PST)
X-Received: by 2002:a19:24d5:: with SMTP id k204mr14287042lfk.88.1550512166692;
 Mon, 18 Feb 2019 09:49:26 -0800 (PST)
MIME-Version: 1.0
References: <20190218165620.383905466@infradead.org>
In-Reply-To: <20190218165620.383905466@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Feb 2019 09:49:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh32Zgp+bN7G1KH7SuCiY1YSJ41Y-_eWpfWubGjqq2_dw@mail.gmail.com>
Message-ID: <CAHk-=wh32Zgp+bN7G1KH7SuCiY1YSJ41Y-_eWpfWubGjqq2_dw@mail.gmail.com>
Subject: Re: [RFC][PATCH 00/16] sched: Core scheduling
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        subhra.mazumdar@oracle.com,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>, kerrnel@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 9:40 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> However; whichever way around you turn this cookie; it is expensive and nasty.

Do you (or anybody else) have numbers for real loads?

Because performance is all that matters. If performance is bad, then
it's pointless, since just turning off SMT is the answer.

                  Linus
