Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4+GtLN5tgWfg5UTPEn24tRHOCpnqc+C8U02JLltsWNdlGXr81VWqC9u6RNjmDYZAwwyBRwa
ARC-Seal: i=1; a=rsa-sha256; t=1523539754; cv=none;
        d=google.com; s=arc-20160816;
        b=CV0bPWCbIh0t53pthth4IUP613qKdbQyHZ9mdhcFABii6NPvcsH238JNxX2dQfYigd
         GzFFQtwKOf+twBXIWi4iabNdkESPQv3tIM3PMyYQ8FMWmK/Pl+RXnELo9RIwvsKRZXms
         ty+WHUkU13yMqQ1KpKMxUuHrQiZm7DDKrbxs3qAoUIYkfP0xXIg8TbC0S2N+oybCrGRC
         YwFVEWjWkf+AfiHVSFliFUhhFrcWRqkCT930DPumSUGoHy0UJVdsu2q5fypO9yC1Kmcu
         8UGo+zXpvgMNXThBbG2wKHav0jp/MvGEBS7WFhbUm9Di8C5iPog/RwPvmFY8Uh+aYZBl
         ujCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:mime-version:user-agent:references
         :message-id:in-reply-to:subject:cc:to:from:date
         :arc-authentication-results;
        bh=M2DB7Xxf5z9A7qlnw5ttLvjXVd/LzHB5cugdPg66tVI=;
        b=yF9idnemBC3lHzJZ0kgpv1ijMNE5gxBQM90zxGS9rr3uM4zhefvm2vFhxoxdwVOzuX
         ccXBvyka/IXRJX/wM20eYYnxTNcBDXlgrEm/vglLl4shNfBHG8sEwCkLjUjFId/kjBnz
         IrvDVGYDUH00Zb2ErHYTbzXzBFd6E6RJCAjnGw5/TsoEOV/Tj7zL8r9yIX6eAlsKelTF
         kmdFNyhd5N7IOKOIxz9wdXKzPDDltMYk1JTOfoNrQltIBx56hRBpqEm8GMKLw7ygwqC2
         qFVg9Pn0HKwdT7vs5bbg/HjcDLL2ULIjXxgb8329FRrReYLiIpmXAgUkGyvk98qyIumy
         aedA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752664AbeDLN3C (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 12 Apr 2018 09:29:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:34802 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752317AbeDLN3B (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Apr 2018 09:29:01 -0400
Date: Thu, 12 Apr 2018 15:28:59 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Joe Lawrence <joe.lawrence@redhat.com>
cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        =?ISO-8859-2?Q?Libor_Pech=E1=E8ek?= <lpechacek@suse.com>,
        Nicolai Stange <nstange@suse.de>,
        Artem Savkov <asavkov@redhat.com>
Subject: Re: [PATCH v2] Add livepatch kselftests
In-Reply-To: <1523373354-10801-1-git-send-email-joe.lawrence@redhat.com>
Message-ID: <alpine.LSU.2.21.1804121526110.4758@pobox.suse.cz>
References: <1523373354-10801-1-git-send-email-joe.lawrence@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597372746598481553?=
X-GMAIL-MSGID: =?utf-8?q?1597547221469153290?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> Questions for v3:
> 
>   - Should we split off the atomic replace and shadow variable update
>     tests so that the this patchset could be merged before the ones
>     listed above?

What Josh said. If we merge it almost together, there is no need to split 
it.
 
>   - I didn't remove any of the sample modules.  If anyone thinks any of
>     them should go, let me know.  They serve as nice, simple examples so
>     I thought they should all stay.

Ok

>   - Module naming convention: to make the test script easier to grep
>     module names and filenames, I broke with livepatch convention and
>     used underscores instead of dashes.  I didn't think it worth the
>     regex foo to flip back and forth in the test script.

Ok

Miroslav
