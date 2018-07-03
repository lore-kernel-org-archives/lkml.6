Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED3DC3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B9424C61
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PuM4TgB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B9424C61
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753866AbeGCCSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 22:18:52 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:56077 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753495AbeGCCSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 22:18:50 -0400
Received: by mail-it0-f66.google.com with SMTP id 16-v6so991263itl.5;
        Mon, 02 Jul 2018 19:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x4xZeRzIUXCIwk41rsBxf/Mu+TyZxUIn9ioB+2frsw0=;
        b=PuM4TgB9iW0nY/nzEbEwKXFUZuwJ7FQSwADPmiOxCc2mny0pWGM6WD3dM37AP37v+l
         ugqou2IErccn3doHouGRUoswLn46h/ef/4dBokbmeRG4uH7pW01ieMel5FQcpKPoVpb/
         hrMpf6DEy0PEumA39VeLz1WP65W/MAn85it7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x4xZeRzIUXCIwk41rsBxf/Mu+TyZxUIn9ioB+2frsw0=;
        b=XUzTU3REpGHcqMEKBjK+w6Z/1kq8gLjnhBpynlG2rimUK/3vAdl2tIxu7t/zOtDoIG
         zyJuPU7QiDhbGMg/wm7aBoHLRlj5Z7RZL9ilQhYCPV+Mk00QF8MZNS26Y3PtlBhxZSIM
         X5pCYpn0ZB01uW/Gs28LXCk5ZryMJJD5+XooAH5l2m0C9ABdNGZqbwjT4dnVue+D0Dll
         SpfqdhEiNAPammfII2nQ/eoEZ0iwm93YLJ0fM87sCPxCI76VlUhLqw2eSTRWZAgJ+8W/
         ZfBqZ+vidk02ul3/bp4dADZ5ccYtQzpLz6uzlJSRG0wp3zoVfy50cVeVgiLRT/mpNrK/
         ltmQ==
X-Gm-Message-State: APt69E2HZC4qbLtcIMDzHKlQF0j/S4WGsm6xA+Go9+up6bZl5VQzRDPg
        wvWYDBGerpNitrYOdmwVpM8S21NawnNhQMgfOiE=
X-Google-Smtp-Source: AAOMgpc+e3ek+s/E4KM4ixoTmi/C4667U2Gx95HGN3p+i1gy/1AEFqCkpEdfQYY6jOvVDscluVMmJrRQzHkYgbdIeXw=
X-Received: by 2002:a02:1bdc:: with SMTP id 89-v6mr22347283jas.72.1530584329442;
 Mon, 02 Jul 2018 19:18:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180702223143.4663-1-mathieu.desnoyers@efficios.com>
 <CA+55aFxrX+wRoe+5HDaTrRXg1K-Qpks4jJ9Buc_OevoG8hoGFw@mail.gmail.com>
 <415287289.10831.1530572418907.JavaMail.zimbra@efficios.com>
 <CA+55aFzZYOatOtjrm7fD7878_SzCAmEoEu74n0+pgd7faH-sTQ@mail.gmail.com>
 <825871008.10839.1530573419561.JavaMail.zimbra@efficios.com>
 <1959930320.10843.1530573742647.JavaMail.zimbra@efficios.com>
 <8B2E4CEB-3080-4602-8B62-774E400892EB@amacapital.net> <459661281.10865.1530580742205.JavaMail.zimbra@efficios.com>
 <858886246.10882.1530583291379.JavaMail.zimbra@efficios.com>
In-Reply-To: <858886246.10882.1530583291379.JavaMail.zimbra@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Jul 2018 19:18:38 -0700
Message-ID: <CA+55aFxWMjwx-4TGBHt0H6bh6FXC3NKMsjp=eKGw5cgA4wMBUA@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18] rseq: use __u64 for rseq_cs fields, validate
 user inputs
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>,
        Christoph Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 7:01 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> One thing to consider is how we will implement the load of that pointer
> on the kernel side.

Use "get_user()". It works for 64-bit objects too, and it will be
atomic in the 32-bit sub-parts on a 32-bit architecture.

Again: there is no point in trying to be atomic in the full 64 bits
(when you're running on 32-bit). The upper bits don't have to "match"
the lower bits. They just have to be zero. So doing it as two loads is
fine - the same way it's perfectly fine to do it as two stores (since
the store to the upper bits will always be zero).

            Linus
